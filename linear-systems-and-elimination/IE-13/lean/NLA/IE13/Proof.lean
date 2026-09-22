/- Exact rational attainment and the genuine sharp supremum for the full IE-13 target.
Source mathematics attributed to Matthew J. Colbrook. -/
import NLA.IE13.Upper
import NLA.IE13.Witness
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

theorem rational_attainment_proved (p q : ℕ) :
    1 + max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q) = 1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    growth (witness p q) (witnessStates p q) = sharpGrowth p q := by
  obtain ⟨hn,hA,hm,hpath,hg⟩ := witness_data p q
  exact ⟨hn,hA,hm,hpath,le_antisymm
    (upper_bound_proved p q (witnessSize p q) hn _ _ _ hA hpath) hg⟩

theorem sharp_maximum_proved (p q : ℕ) :
    IsGreatest (bandGrowths p q) (sharpGrowth p q) := by
  obtain ⟨hn,hA,hm,hpath,hg⟩ := rational_attainment_proved p q
  constructor
  · exact ⟨witnessSize p q,hn,witness p q,witnessStates p q,witnessPivot p q,hA,hpath,hg.symm⟩
  · intro t ht
    obtain ⟨n,hn,A,S,r,hA,hpath,rfl⟩ := ht
    exact upper_bound_proved p q n hn A S r hA hpath

theorem original_target_proved (p q : ℕ) :
    (bandGrowths p q).Nonempty ∧ BddAbove (bandGrowths p q) ∧
    sSup (bandGrowths p q) =
      (if p = 0 then 1 else (bandRec p (p + q) : ℝ)) := by
  have h := sharp_maximum_proved p q
  exact ⟨⟨_,h.1⟩,⟨_,h.2⟩,h.csSup_eq⟩
end NLA.IE13
