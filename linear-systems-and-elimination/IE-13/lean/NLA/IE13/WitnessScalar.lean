/- Exact scalar identities used by Colbrook's attaining band matrix.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.Recurrence
import NLA.IE13.WitnessOrder
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma earlyColumnQ_zero_above (p k i : ℕ) (h : k < i) : earlyColumnQ p k i = 0 := by
  have hi : i ≠ 0 := by omega
  have hik : i ≠ k := by omega
  simp [earlyColumnQ,hi,hik,show ¬i ≤ k by omega]

lemma earlyColumnQ_nonneg (p k i : ℕ) : 0 ≤ earlyColumnQ p k i := by
  unfold earlyColumnQ
  split_ifs <;> positivity

lemma earlyColumnQ_early (p k i : ℕ) (hk : k ≤ p) :
    earlyColumnQ p k i = if i ≤ k then (targetRec p i : ℚ) else 0 := by
  by_cases hi : i ≤ k
  · by_cases h0 : i = 0
    · simp [earlyColumnQ,h0,hk,targetRec]
    · have hip : i ≤ p+1 := by omega
      rw [if_pos hi]
      simp [earlyColumnQ,h0,hk,hi,show 1 ≤ i by omega,targetRec,
        bandRec_early p i (by omega) hip]
  · rw [if_neg hi]
    exact earlyColumnQ_zero_above p k i (by omega)

lemma earlyColumnQ_late (p k i : ℕ) (hk : p < k) :
    earlyColumnQ p k i = if i = k then 1 else 0 := by
  simp [earlyColumnQ,show ¬k ≤ p by omega,show p+1 ≤ k by omega]

lemma earlyColumnQ_diag_pos (p k : ℕ) : 0 < earlyColumnQ p k k := by
  unfold earlyColumnQ
  by_cases h0 : k=0
  · simp [h0]
  by_cases hk : k ≤ p
  · simp [h0,hk,show 1 ≤ k by omega]
  · simp [h0,hk,show p+1 ≤ k by omega]

lemma targetRec_nonzero (p i : ℕ) : 0 < targetRec p i := by
  by_cases hi : i=0
  · simp [targetRec,hi]
  · simpa [targetRec,hi] using (bandRec_pos (p:=p) (t:=i) (by omega))

lemma targetRec_prefix (p k : ℕ) (hk : k ≤ p) :
    (∑ a ∈ Finset.range (k+1), targetRec p a) = 2^k := by
  induction k with
  | zero => simp [targetRec]
  | succ k ih =>
    rw [Finset.sum_range_succ,ih (by omega)]
    have he := bandRec_early p (k+1) (by omega) (by omega)
    simp only [targetRec,show k+1 ≠ 0 by omega,if_false] at *
    rw [he]
    simp [pow_succ]
    omega

/-- The residual target entry after the first t pivots, in a later factor row. -/
def targetTail (p t i : ℕ) : ℕ :=
  (if i=0 ∨ p < i then 1 else 0) +
    ∑ a ∈ Finset.range t, if i ≤ a+p then targetRec p a else 0

lemma targetTail_pos (p t i : ℕ) (ht : p ≤ t) (hi : t < i) :
    0 < targetTail p t i := by
  unfold targetTail
  rw [if_pos (Or.inr (show p < i by omega))]
  omega

lemma targetTail_le (p t i : ℕ) (hp : 0 < p) (ht : p ≤ t) (hi : t < i) :
    targetTail p t i ≤ bandRec p t := by
  rw [bandRec_eq_filtered p t (by omega)]
  unfold targetTail
  rw [if_pos (Or.inr (show p < i by omega))]
  apply Nat.add_le_add_left
  apply Finset.sum_le_sum
  intro a ha
  by_cases hia : i ≤ a+p
  · have ha0 : a ≠ 0 := by omega
    simp [hia,show t ≤ a+p by omega,targetRec,ha0]
  · simp [hia]

lemma witnessSize_admissible (p q : ℕ) : 1+max p q ≤ witnessSize p q := by
  unfold witnessSize
  omega

end NLA.IE13
