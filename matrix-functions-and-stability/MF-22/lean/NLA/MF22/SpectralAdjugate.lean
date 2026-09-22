/- Exact finite change-of-basis adjugate identities; no resolvent pole assumptions.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.SpectralBasis
set_option autoImplicit false
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF22
abbrev FourMat := Matrix (Fin 4) (Fin 4) ℂ

def basisColumns (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) : FourMat :=
  (Pi.basisFun ℂ (Fin 4)).toMatrix b
def basisRows (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) : FourMat :=
  b.toMatrix (Pi.basisFun ℂ (Fin 4))
lemma basisColumns_apply (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) (i j : Fin 4) :
    basisColumns b i j=b j i := by simp [basisColumns,Module.Basis.toMatrix_apply]
lemma basisRows_apply (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) (i j : Fin 4) :
    basisRows b i j=b.repr (Pi.single j 1) i := by simp [basisRows,Module.Basis.toMatrix_apply,Pi.basisFun_apply]
lemma basisColumns_rows (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) :
    basisColumns b*basisRows b=1 := Module.Basis.toMatrix_mul_toMatrix_flip _ _
lemma basisRows_columns (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) :
    basisRows b*basisColumns b=1 := Module.Basis.toMatrix_mul_toMatrix_flip _ _

lemma adjugate_similarity (M D A : FourMat) (hMD : M*D=1) (hDM : D*M=1) :
    (M*A*D).adjugate=M*A.adjugate*D := by
  have hdet : M.det*D.det=1 := by rw [← Matrix.det_mul,hMD,Matrix.det_one]
  have hM : M.adjugate=M.det • D := by
    calc
      M.adjugate = M.adjugate*(M*D) := by rw [hMD,Matrix.mul_one]
      _ = M.det • D := by rw [← Matrix.mul_assoc,Matrix.adjugate_mul,Matrix.smul_mul,Matrix.one_mul]
  have hD : D.adjugate=D.det • M := by
    calc
      D.adjugate = D.adjugate*(D*M) := by rw [hDM,Matrix.mul_one]
      _ = D.det • M := by rw [← Matrix.mul_assoc,Matrix.adjugate_mul,Matrix.smul_mul,Matrix.one_mul]
  rw [Matrix.adjugate_mul_distrib,Matrix.adjugate_mul_distrib,hM,hD]
  simp only [Matrix.smul_mul,Matrix.mul_smul,smul_smul,hdet,one_smul,Matrix.mul_assoc]

lemma basis_diagonalization (T : FourMat) (ev : Fin 4 → ℂ)
    (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ))
    (he : ∀ i, T *ᵥ b i=ev i • b i) :
    T=basisColumns b*Matrix.diagonal ev*basisRows b := by
  have hm : T*basisColumns b=basisColumns b*Matrix.diagonal ev := by
    ext i j
    rw [Matrix.mul_diagonal]
    simp only [Matrix.mul_apply,basisColumns_apply]
    have hh := congrFun (he j) i
    simpa [Matrix.mulVec,dotProduct,Pi.smul_apply,smul_eq_mul,mul_comm] using hh
  calc
    T=T*(basisColumns b*basisRows b) := by rw [basisColumns_rows,Matrix.mul_one]
    _ = _ := by rw [← Matrix.mul_assoc,hm]

lemma basis_resolvent (T : FourMat) (ev : Fin 4 → ℂ)
    (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ))
    (he : ∀ i, T *ᵥ b i=ev i • b i) (z : ℂ) :
    1-z • T=basisColumns b*Matrix.diagonal (fun i => 1-z*ev i)*basisRows b := by
  have hd : Matrix.diagonal (fun i => 1-z*ev i)=(1:FourMat)-z • Matrix.diagonal ev := by
    ext i j
    by_cases hij : i=j <;> simp [Matrix.diagonal_apply,Matrix.one_apply,hij]
  rw [hd,Matrix.mul_sub,Matrix.sub_mul,Matrix.mul_smul,Matrix.smul_mul,
    Matrix.mul_one,basisColumns_rows,← basis_diagonalization T ev b he]

lemma basis_adjugate_entries (T : FourMat) (ev : Fin 4 → ℂ)
    (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ))
    (he : ∀ i, T *ᵥ b i=ev i • b i) (z : ℂ) (i j : Fin 4) :
    (1-z • T).adjugate i j=
      ∑ a, (∏ k ∈ Finset.univ.erase a, (1-z*ev k))*basisProjector b a i j := by
  rw [basis_resolvent T ev b he z,
    adjugate_similarity _ _ _ (basisColumns_rows b) (basisRows_columns b),Matrix.adjugate_diagonal]
  rw [Matrix.mul_apply]
  simp only [Matrix.mul_diagonal,basisColumns_apply,basisRows_apply,basisProjector]
  apply Finset.sum_congr rfl
  intro a _
  ring

lemma basis_adjugate_at_root (T : FourMat) (ev : Fin 4 → ℂ)
    (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ))
    (he : ∀ i, T *ᵥ b i=ev i • b i) (hn : ev 0 ≠ 0) (i j : Fin 4) :
    (1-(ev 0)⁻¹ • T).adjugate i j=
      (∏ k ∈ Finset.univ.erase 0, (1-(ev 0)⁻¹*ev k))*basisProjector b 0 i j := by
  rw [basis_adjugate_entries T ev b he]
  apply Finset.sum_eq_single 0
  · intro a _ ha
    have hp : (∏ k ∈ Finset.univ.erase a, (1-(ev 0)⁻¹*ev k))=0 := by
      apply Finset.prod_eq_zero (Finset.mem_erase.mpr ⟨Ne.symm ha,Finset.mem_univ _⟩)
      simp [hn]
    rw [hp,zero_mul]
  · simp
end NLA.MF22
