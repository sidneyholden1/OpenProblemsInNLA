/- Exact full LU identity for the source's original-order IE-13 matrix.
Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.WitnessFactors
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma full_product_target_before (p q : ℕ) (i j : Fin (witnessSize p q))
    (hj : j.val=p+q) (hi : i≤j) :
    (fullLowerQ p q * fullUpperQ p q) i j =
      if i.val=0 ∨ p < i.val then 1 else 0 := by
  have he : (fullLowerQ p q * fullUpperQ p q) i j =
      ∑ a : Fin (witnessSize p q), lowerQ p q i a * (targetRec p a.val : ℚ) := by
    rw [Matrix.mul_apply]
    apply Finset.sum_congr rfl
    intro a _
    by_cases ha : a<j
    · rw [fullLowerQ_early p q i a (by have hh : a.val < j.val := ha; omega)]
      simp [fullUpperQ,hj,ha.le]
    · by_cases heq : a=j
      · subst a
        by_cases hie : i=j
        · subst i; simp [fullLowerQ,fullUpperQ,lowerQ,hj]
        · have hil : i<j := lt_of_le_of_ne hi hie
          have hnot : ¬j.val < i.val := not_lt_of_ge hi
          simp [fullLowerQ_above p q i j hil,lowerQ,hie,hnot]
      · have hja : j<a := lt_of_le_of_ne (le_of_not_gt ha) (Ne.symm heq)
        have hia : i<a := lt_of_le_of_lt hi hja
        have hne : i ≠ a := hia.ne
        have hnot : ¬a.val < i.val := not_lt_of_ge hia.le
        simp [fullUpperQ,hj,show ¬a≤j from not_le_of_gt hja,lowerQ,hne,hnot]
  rw [he,lowerQ_sum p q i (fun a => (targetRec p a : ℚ))]
  have hh : (targetRec p i.val : ℚ) =
      (if i.val=0 ∨ p < i.val then 1 else 0) +
      ∑ a ∈ Finset.range i.val, if i.val ≤ a+p then (targetRec p a : ℚ) else 0 := by
    exact_mod_cast targetRec_forward p i.val
  linarith

lemma full_product_target_after (p q : ℕ) (i j : Fin (witnessSize p q))
    (hj : j.val=p+q) (hi : j < i) :
    (fullLowerQ p q * fullUpperQ p q) i j =
      if i.val=0 ∨ p < i.val then 1 else 0 := by
  have he : ∀ a : Fin (witnessSize p q),
      fullLowerQ p q i a * fullUpperQ p q a j =
      (if a=j then (targetTail p (p+q) i.val : ℚ) else 0) -
      (if a.val < p+q then (if i.val ≤ a.val+p then (targetRec p a.val : ℚ) else 0) else 0) := by
    intro a
    by_cases hae : a=j
    · subst a
      have hn : (targetRec p (p+q) : ℚ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt (targetRec_nonzero p (p+q)))
      simp [fullLowerQ,fullUpperQ,hi.ne',hi,hj]
      field_simp [hn]
    · by_cases ha : a.val < p+q
      · have haj : a<j := by change a.val < j.val; omega
        have hai : a < i := lt_trans haj hi
        rw [fullLowerQ_early p q i a ha]
        simp only [fullUpperQ,hj,lt_self_iff_false,if_false,eq_self_iff_true,if_true,
          haj.le,lowerQ,hai.ne',hae,ha]
        have hlt : a.val < i.val := hai
        simp only [hlt,true_and]
        split_ifs <;> ring
      · have hja : j<a := by
          have hne : a.val ≠ j.val := fun h => hae (Fin.ext h)
          change j.val < a.val; omega
        simp [fullUpperQ,hj,not_le_of_gt hja,hae,ha]
  simp only [Matrix.mul_apply,he,Finset.sum_sub_distrib]
  rw [Finset.sum_ite_eq']
  simp only [Finset.mem_univ,if_true]
  rw [fin_sum_below (witnessSize p q) (p+q) (by unfold witnessSize; omega)
    (fun a => if i.val ≤ a+p then (targetRec p a : ℚ) else 0)]
  have hh : (targetTail p (p+q) i.val : ℚ) =
      (if i.val=0 ∨ p < i.val then 1 else 0) +
      ∑ a ∈ Finset.range (p+q), if i.val ≤ a+p then (targetRec p a : ℚ) else 0 := by
    simp [targetTail]
  linarith

lemma full_product_target (p q : ℕ) (i j : Fin (witnessSize p q)) (hj : j.val=p+q) :
    (fullLowerQ p q * fullUpperQ p q) i j =
      if i.val=0 ∨ p < i.val then 1 else 0 := by
  by_cases hi : i≤j
  · exact full_product_target_before p q i j hj hi
  · exact full_product_target_after p q i j hj (lt_of_not_ge hi)

lemma factorRow_target_mask (p q : ℕ) (i : Fin (witnessSize p q)) :
    ((factorRow p q i).val=0 ∨ p < (factorRow p q i).val) ↔ p ≤ i.val := by
  simp only [factorRow_val]
  by_cases he : i.val=p
  · simp [he]
  by_cases hi : i.val < p
  · simp [he,hi,show i.val+1 ≠ 0 by omega,show ¬p < i.val+1 by omega,
      show ¬p ≤ i.val by omega]
  · simp [he,hi,show p < i.val by omega,show p ≤ i.val by omega]

lemma witnessQ_full_product (p q : ℕ) (hp : 0<p) :
    witnessQ p q = (fullLowerQ p q * fullUpperQ p q).submatrix (factorRow p q) id := by
  ext i j
  rw [witnessQ_of_ne_zero p q (by omega)]
  change (if j.val < p+q then _ else _) = (fullLowerQ p q * fullUpperQ p q) (factorRow p q i) j
  by_cases hj : j.val < p+q
  · rw [if_pos hj,full_product_early p q _ j hj]
  · rw [if_neg hj]
    by_cases ht : j.val=p+q
    · rw [if_pos ht,full_product_target p q _ j ht]
      simp only [factorRow_target_mask]
    · rw [if_neg ht,full_product_late p q _ j (by omega)]
      have hfj : factorRow p q j = j := by
        simp [factorRow,show j.val ≠ p by omega,show ¬j.val < p by omega]
      have he : factorRow p q i = j ↔ i=j := by
        constructor
        · intro hh
          exact factorRow_injective p q (hh.trans hfj.symm)
        · intro hh; subst i; exact hfj
      simp [he]

def fullLowerC (p q : ℕ) : Mat (witnessSize p q) := fun i j => (fullLowerQ p q i j : ℂ)
def fullUpperC (p q : ℕ) : Mat (witnessSize p q) := fun i j => (fullUpperQ p q i j : ℂ)

lemma witness_full_product (p q : ℕ) (hp : 0<p) :
    witness p q = (fullLowerC p q * fullUpperC p q).submatrix (factorRow p q) id := by
  ext i j
  have hq := congrArg (fun M : Matrix (Fin (witnessSize p q)) (Fin (witnessSize p q)) ℚ => M i j)
    (witnessQ_full_product p q hp)
  have hc := congrArg (fun x : ℚ => (x:ℂ)) hq
  simpa [witness,fullLowerC,fullUpperC,Matrix.mul_apply] using hc

end NLA.IE13
