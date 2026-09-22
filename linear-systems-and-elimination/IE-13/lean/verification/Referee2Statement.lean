import NLA.IE13.Definitions
import Mathlib.Tactic
open scoped BigOperators Classical Matrix NNReal
open NLA.IE13
#check Complex.norm_def
#check Finset.sup_le
#check Finset.le_sup
#check IsGreatest
#check IsGreatest.csSup_eq
#print NLA.IE13.bandGrowths
#print NLA.IE13.isPath
example {n : ℕ} (p q : ℕ) (A : Mat n) : IsBanded p q A ↔
 (∀ i j : Fin n, j.val+p < i.val ∨ i.val+q < j.val → A i j=0) ∧ A.det≠0 := Iff.rfl
example : bandRec 2 5 = 12 := by norm_num [bandRec,Finset.sum_range_succ]
example : sharpGrowth 0 7 = 1 := by norm_num [sharpGrowth]
example {n : ℕ} (A : Mat n) (k r i j : Fin n) (hi : i ≤ k) : schurStep A k r i j=0 := by
 simp [schurStep,not_lt.mpr hi]
