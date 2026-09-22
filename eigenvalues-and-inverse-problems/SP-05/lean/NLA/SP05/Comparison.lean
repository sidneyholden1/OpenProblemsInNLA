/- The original sector comparison from the full PSD minimizer, with the
factor two established on the actual commutation eigenspaces. -/
import NLA.SP05.SectorMinima
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Matrix
open scoped BigOperators Matrix Kronecker
noncomputable section
namespace NLA.SP05

lemma sector_rayleigh_double {n : ℕ} (A B : Mat n) (v : Vec n) (s : ℝ)
    (hA : A.IsHermitian) (hB : B.IsHermitian)
    (hs : (commutation n).mulVec v = s • v) :
    rayleigh (jordan A B) v = 2*rayleigh (A ⊗ₖ B) v := by
  let X : Mat n := unvecM v
  have hv : vecM X = v := rfl
  have hx : X.transpose = s • X := by
    ext i j
    have hh := congrFun hs (j,i)
    rw [commutation_mulVec] at hh
    exact hh
  have ha : A.transpose = A := Matrix.isHermitian_iff_isSymm.mp hA
  have hb : B.transpose = B := Matrix.isHermitian_iff_isSymm.mp hB
  have htrace : (X.transpose*(A*X*B)).trace = (X.transpose*(B*X*A)).trace := by
    rw [hx]
    simp only [Matrix.smul_mul,Matrix.trace_smul]
    congr 1
    convert Matrix.trace_mul_comm (X*A) (X*B) using 1 <;> simp only [Matrix.mul_assoc]
  have hq : v ⬝ᵥ (B ⊗ₖ A).mulVec v = v ⬝ᵥ (A ⊗ₖ B).mulVec v := by
    rw [← hv,kronecker_vecM,kronecker_vecM,ha,hb]
    change (Matrix.vec X) ⬝ᵥ Matrix.vec (A*X*B) = (Matrix.vec X) ⬝ᵥ Matrix.vec (B*X*A)
    rw [Matrix.vec_dotProduct_vec,Matrix.vec_dotProduct_vec,htrace]
  unfold rayleigh
  change (v ⬝ᵥ (jordan A B).mulVec v)/(∑ i,v i*v i) =
    2*((v ⬝ᵥ (A ⊗ₖ B).mulVec v)/(∑ i,v i*v i))
  rw [jordan,Matrix.add_mulVec,dotProduct_add,hq]
  ring

lemma comparison_of_psd_minimizer {n : ℕ} (hn : 2 ≤ n) (A B : Mat n)
    (hA : A.PosDef) (hB : B.PosDef)
    (hmin : ∃ (μ : ℝ) (X : Mat n), 0 < μ ∧ X.PosSemidef ∧ X ≠ 0 ∧
      (jordan A B).mulVec (columnVec X) = μ • columnVec X ∧
      rayleigh (jordan A B) (columnVec X) = μ ∧
      ∀ v : Vec n, v ≠ 0 → μ ≤ rayleigh (jordan A B) v) :
    sInf (sectorValues A B 1) ≤ sInf (sectorValues A B (-1)) := by
  obtain ⟨μ,X,hμ,hX,hX0,he,hq,hglobal⟩ := hmin
  obtain ⟨hsne,hsbd,hane,habd,u,w,hu,hw,hus,hws,huq,hwq⟩ :=
    sector_minima_attained_proved hn A B hA hB
  have hv : columnVec X ≠ 0 := (columnVec_ne_zero X).mpr hX0
  have hXsym : X.transpose = X := Matrix.isHermitian_iff_isSymm.mp hX.isHermitian
  have hxs : (commutation n).mulVec (columnVec X) = (1:ℝ) • columnVec X := by
    rw [(vectorization_proved A B X hA.isHermitian hB.isHermitian).1,hXsym,one_smul]
  have hmem : rayleigh (A ⊗ₖ B) (columnVec X) ∈ sectorValues A B 1 := ⟨_,hv,hxs,rfl⟩
  have hle := csInf_le hsbd hmem
  have hdoubleX := sector_rayleigh_double A B (columnVec X) 1 hA.isHermitian hB.isHermitian hxs
  have hdoubleW := sector_rayleigh_double A B w (-1) hA.isHermitian hB.isHermitian (by simpa using hws)
  have hg := hglobal w hw
  rw [hq] at hdoubleX
  rw [hdoubleW,hwq] at hg
  linarith
end NLA.SP05
