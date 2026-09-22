/- The zero-lower-bandwidth endpoint is witnessed by the literal identity input.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.WitnessBounds
import NLA.IE13.WitnessOrder
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma witness_zero_identity (q : ℕ) : witness 0 q=1 := by
  ext i j
  by_cases he : i=j <;> simp [witness,witnessQ,Matrix.one_apply,he]

lemma factorRow_zero (q : ℕ) (i : Fin (witnessSize 0 q)) : factorRow 0 q i=i := by
  apply Fin.ext
  by_cases hi : i.val=0
  · simp [factorRow,hi]
  · simp [factorRow,hi]

lemma witness_zero_path (q : ℕ) :
    isPath (witness 0 q) (witnessStates 0 q) (witnessPivot 0 q) := by
  apply witness_isPath_of_lu 0 q 1 1
  · have hf : factorRow 0 q=id := funext (factorRow_zero q)
    rw [witness_zero_identity,one_mul,hf]
    rfl
  · intro a b hab; simp [ne_of_lt hab]
  · intro a; simp
  · intro a b hba; simp [ne_of_gt hba]
  · intro a; simp
  · intro a b hba
    by_cases he : a=b <;> simp [Matrix.one_apply,he]

theorem witness_data_zero (q : ℕ) :
    1+max 0 q ≤ witnessSize 0 q ∧
    IsBanded 0 q (witness 0 q) ∧ entryMax (witness 0 q)=1 ∧
    isPath (witness 0 q) (witnessStates 0 q) (witnessPivot 0 q) ∧
    sharpGrowth 0 q ≤ growth (witness 0 q) (witnessStates 0 q) := by
  have hA : IsBanded 0 q (witness 0 q) := by
    refine ⟨witness_pattern 0 q,?_⟩
    simp [witness_zero_identity]
  refine ⟨witnessSize_admissible 0 q,hA,witness_entryMax 0 q,witness_zero_path q,?_⟩
  let z : Fin (witnessSize 0 q) := ⟨0,by unfold witnessSize; omega⟩
  have hg := growth_ge_entry (witness 0 q) (witnessStates 0 q)
    (by rw [witness_entryMax]; norm_num) z z z
  rw [witness_entryMax,div_one] at hg
  change ‖witness 0 q z z‖ ≤ _ at hg
  have he : ‖witness 0 q z z‖=1 := by rw [witness_zero_identity]; simp
  rw [he] at hg
  simpa [sharpGrowth] using hg

end NLA.IE13
