/- Scalar-sum reflection of actual PSD blocks. -/
import NLA.MI04.Preservation
set_option autoImplicit false
set_option maxHeartbeats 800000
open scoped ComplexOrder MatrixOrder Matrix.Norms.L2Operator
open Matrix
noncomputable section
namespace NLA.MI04

def swapUnitary (n : ℕ) : unitary (Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) :=
  ⟨fromBlocks 0 1 1 0, by
    change star _ * _ = 1 ∧ _ * star _ = 1
    constructor <;> simp [star_eq_conjTranspose, fromBlocks_conjTranspose,
      fromBlocks_multiply, fromBlocks_one]⟩

lemma swap_conjugate {n : ℕ} (A B C D : Mat n) :
    (star (swapUnitary n) : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) * fromBlocks A B C D *
      (swapUnitary n : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) = fromBlocks D C B A := by
  simp [swapUnitary, star_eq_conjTranspose, fromBlocks_conjTranspose, fromBlocks_multiply]

lemma universal_adjoint {n : ℕ} {X : Mat n} (hX : UniversalBlockNorm X) :
    UniversalBlockNorm Xᴴ := by
  intro A B hA hB hP
  have hp := hP.conjTranspose_mul_mul_same (swapUnitary n : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ)
  change ((star (swapUnitary n) : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) *
    fromBlocks A Xᴴ Xᴴᴴ B *
    (swapUnitary n : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ)).PosSemidef at hp
  rw [swap_conjugate, conjTranspose_conjTranspose] at hp
  have h := hX B A hB hA hp
  have hn := norm_unitary_conjugate (swapUnitary n) (fromBlocks A Xᴴ X B)
  rw [swap_conjugate] at hn
  simpa only [conjTranspose_conjTranspose, add_comm] using hn.symm.trans_le h

lemma scalar_sum_reflection {n : ℕ} [NeZero n] {X A B : Mat n}
    (hX : UniversalBlockNorm X) (hA : A.IsHermitian) (hB : B.IsHermitian)
    (hP : (fromBlocks A X Xᴴ B).PosSemidef)
    (hs : A+B=(2:ℝ) • (1:Mat n)) :
    (fromBlocks A Xᴴ X B).PosSemidef := by
  have hn : ‖fromBlocks A X Xᴴ B‖ ≤ 2 := by
    have h := hX A B hA hB hP
    simpa [hs,norm_smul] using h
  have hlo := (CStarAlgebra.norm_le_iff_le_algebraMap _ (by norm_num : (0:ℝ)≤2) hP.nonneg).mp hn
  have hp : ((2:ℝ) • (1:Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) -
      fromBlocks A X Xᴴ B).PosSemidef := by
    simpa only [Algebra.algebraMap_eq_smul_one] using (sub_nonneg.mpr hlo).posSemidef
  let S : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ := fromBlocks 0 1 (-1) 0
  have ht := hp.conjTranspose_mul_mul_same S
  have hAA : (2:ℝ) • (1:Mat n)-B=A := by rw [←hs]; abel
  have hBB : (2:ℝ) • (1:Mat n)-A=B := by rw [←hs]; abel
  have he : (2:ℝ) • (1:Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) -
      fromBlocks A X Xᴴ B =
      fromBlocks ((2:ℝ) • (1:Mat n)-A) (-X) (-Xᴴ) ((2:ℝ) • (1:Mat n)-B) := by
    ext i j; cases i <;> cases j <;> simp [Matrix.one_apply]
  rw [he] at ht
  simpa [S,fromBlocks_conjTranspose,fromBlocks_multiply,hAA,hBB] using ht

end NLA.MI04
