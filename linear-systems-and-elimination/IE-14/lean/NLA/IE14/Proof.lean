/- Exact attainment and genuine sharp supremum for the full IE-14 target.
Source mathematics attributed to Matthew J. Colbrook. -/
import NLA.IE14.Upper
import NLA.IE14.WitnessInput
import NLA.IE14.WitnessPath
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

theorem rational_attainment_proved (n : ℕ) (hn : 4 ≤ n) :
    IsCyclic (witness n) ∧ entryMax (witness n) = 1 ∧
    isPath (witness n) (witnessStates n) witnessPivot ∧
    growth (witness n) (witnessStates n) = sharpGrowth n := by
  refine ⟨witness_cyclic hn,witness_entryMax hn,witness_path hn,?_⟩
  apply le_antisymm
  · exact upper_bound_proved n hn _ _ _ (witness_cyclic hn) (witness_path hn)
  · have he := growth_ge_entry (witness n) (witnessStates n)
      (by rw [witness_entryMax hn]; norm_num)
      ⟨n-1,by omega⟩ ⟨n-1,by omega⟩ ⟨n-1,by omega⟩
    rw [witness_entryMax hn,div_one,witness_final_pivot hn] at he
    have hm : ‖(Nat.fib (n+1):ℂ)+1‖ = (Nat.fib (n+1):ℝ)+1 := by
      norm_cast
    rw [hm] at he
    exact he

theorem sharp_maximum_proved (n : ℕ) (hn : 4 ≤ n) :
    IsGreatest (cyclicGrowths n) (sharpGrowth n) := by
  obtain ⟨hc,hm,hp,hg⟩ := rational_attainment_proved n hn
  constructor
  · exact ⟨witness n,witnessStates n,witnessPivot,hc,hp,hg.symm⟩
  · intro t ht
    obtain ⟨A,S,r,hA,hpath,rfl⟩ := ht
    exact upper_bound_proved n hn A S r hA hpath

theorem original_target_proved (n : ℕ) (hn : 4 ≤ n) :
    (cyclicGrowths n).Nonempty ∧ BddAbove (cyclicGrowths n) ∧
    sSup (cyclicGrowths n) = (Nat.fib (n+1):ℝ)+1 := by
  have h := sharp_maximum_proved n hn
  exact ⟨⟨_,h.1⟩,⟨_,h.2⟩,h.csSup_eq⟩
end NLA.IE14
