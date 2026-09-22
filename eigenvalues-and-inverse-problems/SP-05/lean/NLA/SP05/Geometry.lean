/- Actual column vectorization, commutation and quadratic-form identities.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden/Codex. -/
import NLA.SP05.Definitions
import Mathlib.Analysis.Matrix.Order
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Kronecker
noncomputable section
namespace NLA.SP05

def vecM {n : ℕ} {𝕜 : Type*} (X : Matrix (Fin n) (Fin n) 𝕜) : (Fin n × Fin n) → 𝕜 :=
  fun ij => X ij.2 ij.1

def unvecM {n : ℕ} {𝕜 : Type*} (v : (Fin n × Fin n) → 𝕜) : Matrix (Fin n) (Fin n) 𝕜 :=
  fun i j => v (j,i)

@[simp] lemma vecM_unvecM {n : ℕ} {𝕜 : Type*} (v : (Fin n × Fin n) → 𝕜) : vecM (unvecM v) = v := rfl
@[simp] lemma unvecM_vecM {n : ℕ} {𝕜 : Type*} (X : Matrix (Fin n) (Fin n) 𝕜) : unvecM (vecM X) = X := rfl

lemma vecM_injective {n : ℕ} {𝕜 : Type*} : Function.Injective (vecM (n:=n) (𝕜:=𝕜)) := by
  intro X Y h
  exact congrArg unvecM h

lemma kronecker_vecM {n : ℕ} {𝕜 : Type*} [CommRing 𝕜]
    (A B X : Matrix (Fin n) (Fin n) 𝕜) :
    (A ⊗ₖ B).mulVec (vecM X) = vecM (B*X*A.transpose) := by
  funext ij
  rcases ij with ⟨c,r⟩
  simp only [Matrix.mulVec, dotProduct, Matrix.kroneckerMap, Matrix.of_apply, vecM,
    Fintype.sum_prod_type, Matrix.mul_apply, Matrix.transpose_apply, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i _
  apply Finset.sum_congr rfl
  intro j _
  ring

lemma commutation_mulVec {n : ℕ} (v : Vec n) (ij : Fin n × Fin n) :
    (commutation n).mulVec v ij = v (ij.2,ij.1) := by
  unfold Matrix.mulVec dotProduct
  rw [Finset.sum_eq_single (ij.2,ij.1)]
  · simp [commutation]
  · intro kl _ hkl
    have hne : ij ≠ (kl.2,kl.1) := by
      intro he
      apply hkl
      simpa only [Prod.swap, Prod.mk.eta] using congrArg Prod.swap he.symm
    simp [commutation,hne]
  · simp

lemma vectorization_proved {n : ℕ} (A B X : Mat n)
    (hA : A.IsHermitian) (hB : B.IsHermitian) :
    (commutation n).mulVec (columnVec X) = columnVec X.transpose ∧
    (jordan A B).mulVec (columnVec X) = columnVec (jordanMap A B X) := by
  constructor
  · funext ij; exact commutation_mulVec _ _
  · have ha : A.transpose = A := Matrix.isHermitian_iff_isSymm.mp hA
    have hb : B.transpose = B := Matrix.isHermitian_iff_isSymm.mp hB
    change ((A ⊗ₖ B)+(B ⊗ₖ A)).mulVec (vecM X) = vecM (A*X*B+B*X*A)
    rw [Matrix.add_mulVec, kronecker_vecM, kronecker_vecM, ha, hb]
    funext ij
    simp [vecM,add_comm]

lemma columnVec_ne_zero {n : ℕ} (X : Mat n) : columnVec X ≠ 0 ↔ X ≠ 0 := by
  constructor
  · contrapose!; intro h; subst X; rfl
  · intro h hv
    apply h
    exact vecM_injective hv

lemma denominator_pos {n : ℕ} (v : Vec n) (hv : v ≠ 0) : 0 < ∑ i, v i*v i := by
  apply Finset.sum_pos'
  · intro i _; exact mul_self_nonneg _
  · have hex : ∃ i, v i ≠ 0 := by contrapose! hv; ext i; exact hv i
    obtain ⟨i,hi⟩ := hex
    exact ⟨i,Finset.mem_univ i,mul_self_pos.mpr hi⟩

#assert_trust kernel vectorization_proved
end NLA.SP05
