/- Finite-dimensional spectral data for the actual matrix inverse. -/
import NLA.SP05.InverseOperator
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Kronecker ComplexOrder MatrixOrder
noncomputable section
namespace NLA.SP05

def matrixMap {n : ℕ} (K : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ) (X : CMat n) : CMat n :=
  unvecM (K.mulVec (vecM X))

lemma matrixMap_add {n : ℕ} (K : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ) (X Y : CMat n) :
    matrixMap K (X+Y) = matrixMap K X+matrixMap K Y := by
  unfold matrixMap
  change unvecM (K.mulVec (vecM X+vecM Y)) = _
  rw [Matrix.mulVec_add]; rfl
lemma matrixMap_smul {n : ℕ} (K : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ) (X : CMat n) (c : ℂ) :
    matrixMap K (c • X) = c • matrixMap K X := by
  unfold matrixMap
  change unvecM (K.mulVec (c • vecM X)) = _
  rw [Matrix.mulVec_smul]; rfl

lemma spectral_cap {ι : Type*} [Fintype ι] [DecidableEq ι]
    (K : Matrix ι ι ℂ) (hK : K.IsHermitian) (r : ℝ)
    (hr : ∀ i, hK.eigenvalues i ≤ r) : ((r:ℂ) • (1 : Matrix ι ι ℂ)-K).PosSemidef := by
  let U := hK.eigenvectorUnitary
  let D := Matrix.diagonal (fun i => ((r-hK.eigenvalues i : ℝ):ℂ))
  have hD : D.PosSemidef := Matrix.posSemidef_diagonal_iff.mpr (fun i => by
    change 0 ≤ ((r-hK.eigenvalues i : ℝ):ℂ)
    exact_mod_cast sub_nonneg.mpr (hr i))
  have hU : (U : Matrix ι ι ℂ)*(U : Matrix ι ι ℂ).conjTranspose = 1 := by
    simpa only [Unitary.coe_star, Matrix.star_eq_conjTranspose] using Unitary.coe_mul_star_self U
  have hd : D = (r:ℂ) • (1 : Matrix ι ι ℂ)-Matrix.diagonal (RCLike.ofReal ∘ hK.eigenvalues) := by
    ext i j
    by_cases hij : i=j
    · subst j; simp [D]
    · simp [D,Matrix.diagonal_apply,hij]
  have he : (U : Matrix ι ι ℂ)*D*(U : Matrix ι ι ℂ).conjTranspose = (r:ℂ) • (1 : Matrix ι ι ℂ)-K := by
    rw [hd,Matrix.mul_sub,Matrix.sub_mul]
    simp only [mul_smul_comm,smul_mul_assoc,mul_one,hU]
    have hspec := hK.spectral_theorem
    simpa only [Unitary.conjStarAlgAut_apply,Unitary.coe_star,Matrix.star_eq_conjTranspose,U] using congrArg (fun M => (r:ℂ) • (1 : Matrix ι ι ℂ)-M) hspec.symm
  rw [← he]
  exact hD.mul_mul_conjTranspose_same (U : Matrix ι ι ℂ)

lemma hermitian_add_star {n : ℕ} (Z : CMat n) : (Z+Z.conjTranspose).IsHermitian := by
  change (Z+Z.conjTranspose).conjTranspose = Z+Z.conjTranspose
  simp [add_comm]

/-- Actual top eigenvalue, its global spectral cap, and a nonzero Hermitian
maximizer. Adjoint preservation is required explicitly of this internal helper. -/
theorem hermitian_top_data {n : ℕ} (hn : 0 < n)
    (K : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ) (hK : K.PosDef)
    (hstar : ∀ X : CMat n, matrixMap K X.conjTranspose = (matrixMap K X).conjTranspose) :
    ∃ (r : ℝ) (H : CMat n), 0 < r ∧ H.IsHermitian ∧ H ≠ 0 ∧
      matrixMap K H = (r:ℂ) • H ∧ ((r:ℂ) • (1 : Matrix (Fin n×Fin n) (Fin n×Fin n) ℂ)-K).PosSemidef := by
  let z : Fin n×Fin n := (⟨0,hn⟩,⟨0,hn⟩)
  obtain ⟨i,_,hmax⟩ := Finset.exists_max_image Finset.univ hK.isHermitian.eigenvalues
    (show (Finset.univ : Finset (Fin n×Fin n)).Nonempty from ⟨z,Finset.mem_univ _⟩)
  let r := hK.isHermitian.eigenvalues i
  have hr : 0 < r := hK.eigenvalues_pos i
  have hcap := spectral_cap K hK.isHermitian r (fun j => hmax j (Finset.mem_univ _))
  let v : CVec n := hK.isHermitian.eigenvectorBasis i
  let Z := unvecM v
  have hv : v ≠ 0 :=
    (WithLp.ofLp_eq_zero 2).ne.mpr (hK.isHermitian.eigenvectorBasis.orthonormal.ne_zero i)
  have hZ : Z ≠ 0 := by
    intro he
    apply hv
    have hh := congrArg vecM he
    exact hh
  have heig : matrixMap K Z = (r:ℂ) • Z := by
    have h := hK.isHermitian.mulVec_eigenvectorBasis i
    change K.mulVec v = r • v at h
    change unvecM (K.mulVec v) = (r:ℂ) • unvecM v
    ext a b
    simpa [unvecM,Pi.smul_apply,Complex.real_smul] using congrFun h (b,a)
  have eigsum : ∀ Y : CMat n, matrixMap K Y = (r:ℂ) • Y →
      matrixMap K (Y+Y.conjTranspose) = (r:ℂ) • (Y+Y.conjTranspose) := by
    intro Y hY
    rw [matrixMap_add,hstar,hY]
    simp [smul_add]
  by_cases hh : Z+Z.conjTranspose ≠ 0
  · exact ⟨r,Z+Z.conjTranspose,hr,hermitian_add_star Z,hh,eigsum Z heig,hcap⟩
  · have hh0 : Z+Z.conjTranspose = 0 := by simpa using hh
    let Y := Complex.I • Z
    have hY : matrixMap K Y = (r:ℂ) • Y := by
      dsimp [Y]; rw [matrixMap_smul,heig]; exact smul_comm Complex.I (r:ℂ) Z
    have hnY : Y+Y.conjTranspose ≠ 0 := by
      intro hy
      have hZstar : Z.conjTranspose = -Z := eq_neg_of_add_eq_zero_right hh0
      have he : (2*Complex.I) • Z = 0 := by
        simpa [Y,Matrix.conjTranspose_smul,hZstar,← add_smul] using hy
      exact hZ ((smul_eq_zero.mp he).resolve_left (by norm_num))
    exact ⟨r,Y+Y.conjTranspose,hr,hermitian_add_star Y,hnY,eigsum Y hY,hcap⟩
end NLA.SP05
