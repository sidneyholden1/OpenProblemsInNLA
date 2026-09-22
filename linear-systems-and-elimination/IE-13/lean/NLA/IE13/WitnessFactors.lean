/- Full triangular factors, including the target pivot and identity tail.
Colbrook's early-column factorization is extended here to certify every actual
pivot in the frozen witness path. Sidney Holden with OpenAI Codex. Apache-2.0. -/
import NLA.IE13.WitnessBounds
set_option autoImplicit false
set_option maxHeartbeats 2500000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

def fullLowerQ (p q : ℕ) : Matrix (Fin (witnessSize p q)) (Fin (witnessSize p q)) ℚ :=
  fun i j => if i=j then 1 else
    if j.val < p+q then lowerQ p q i j
    else if j.val=p+q ∧ j < i then (targetTail p (p+q) i.val : ℚ)/(targetRec p (p+q) : ℚ)
    else 0

def fullUpperQ (p q : ℕ) : Matrix (Fin (witnessSize p q)) (Fin (witnessSize p q)) ℚ :=
  fun i j => if j.val < p+q then (1/(2:ℚ)^p) * earlyColumnQ p j.val i.val
    else if j.val=p+q then (if i≤j then (targetRec p i.val : ℚ) else 0)
    else if i=j then 1 else 0

lemma fullLowerQ_diag (p q : ℕ) (i : Fin (witnessSize p q)) : fullLowerQ p q i i = 1 := by
  simp [fullLowerQ]

lemma fullLowerQ_early (p q : ℕ) (i j : Fin (witnessSize p q)) (hj : j.val < p+q) :
    fullLowerQ p q i j = lowerQ p q i j := by
  by_cases h : i=j
  · subst i; simp [fullLowerQ,lowerQ]
  · simp [fullLowerQ,h,hj]

lemma fullLowerQ_above (p q : ℕ) (i j : Fin (witnessSize p q)) (hij : i < j) :
    fullLowerQ p q i j = 0 := by
  have hne := hij.ne
  have hnot : ¬j < i := not_lt_of_ge hij.le
  simp [fullLowerQ,hne,hnot,lowerQ,show ¬j.val < i.val from not_lt_of_ge hij.le]

lemma fullUpperQ_below (p q : ℕ) (i j : Fin (witnessSize p q)) (hij : j < i) :
    fullUpperQ p q i j = 0 := by
  have hne := hij.ne'
  simp [fullUpperQ,earlyColumnQ_zero_above p j.val i.val hij,hne,show ¬i≤j from not_le_of_gt hij]

lemma fullUpperQ_diag_pos (p q : ℕ) (i : Fin (witnessSize p q)) :
    0 < fullUpperQ p q i i := by
  simp only [fullUpperQ,le_refl,ite_true,ite_self]
  split_ifs
  · exact mul_pos (by positivity) (earlyColumnQ_diag_pos p i.val)
  · exact_mod_cast targetRec_nonzero p i.val
  · norm_num

lemma fullLowerQ_abs_le_one (p q : ℕ) (hp : 0<p) (i j : Fin (witnessSize p q)) :
    |fullLowerQ p q i j| ≤ 1 := by
  unfold fullLowerQ
  split_ifs with he hj ht
  · norm_num
  · unfold lowerQ; split_ifs <;> norm_num
  · have hi : p+q < i.val := by have hh : j.val < i.val := ht.2; omega
    have hden : (0:ℚ) < targetRec p (p+q) := by exact_mod_cast targetRec_nonzero p (p+q)
    have hnum : (0:ℚ) ≤ targetTail p (p+q) i.val := by positivity
    rw [abs_of_nonneg (div_nonneg hnum hden.le)]
    apply (div_le_one hden).mpr
    have hb := targetTail_le p (p+q) i.val hp (by omega) hi
    have hz : p+q ≠ 0 := by omega
    simpa only [targetRec,hz,if_false] using (show (targetTail p (p+q) i.val : ℚ) ≤ (bandRec p (p+q) : ℚ) by exact_mod_cast hb)
  · norm_num

lemma fullLowerQ_late (p q : ℕ) (i j : Fin (witnessSize p q)) (hj : p+q < j.val) :
    fullLowerQ p q i j = if i=j then 1 else 0 := by
  simp [fullLowerQ,show ¬j.val < p+q by omega,show j.val ≠ p+q by omega]

lemma full_product_early (p q : ℕ) (i j : Fin (witnessSize p q)) (hj : j.val < p+q) :
    (fullLowerQ p q * fullUpperQ p q) i j =
      (1/(2:ℚ)^p) * ∑ a : Fin (witnessSize p q), lowerQ p q i a * earlyColumnQ p j.val a.val := by
  simp only [Matrix.mul_apply,fullUpperQ,hj,if_true,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro a _
  by_cases ha : a.val < p+q
  · rw [fullLowerQ_early p q i a ha]; ring
  · have haz : earlyColumnQ p j.val a.val = 0 := earlyColumnQ_zero_above p j.val a.val (by omega)
    simp [haz]

lemma full_product_late (p q : ℕ) (i j : Fin (witnessSize p q)) (hj : p+q < j.val) :
    (fullLowerQ p q * fullUpperQ p q) i j = if i=j then 1 else 0 := by
  simp only [Matrix.mul_apply,fullUpperQ,show ¬j.val < p+q by omega,show j.val ≠ p+q by omega,if_false]
  simp only [mul_ite,mul_one,mul_zero]
  rw [Finset.sum_ite_eq']
  simp only [Finset.mem_univ,if_true]
  exact fullLowerQ_late p q i j hj

end NLA.IE13
