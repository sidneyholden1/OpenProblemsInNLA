/- The two surviving front positions are derived from the actual complex GEPP path.
Source argument: Colbrook's IE-14 manuscript. No front hypothesis is assumed. -/
import NLA.IE14.Base
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

lemma cyclic_below_zero {n : ℕ} (A : Mat n) (hA : IsCyclic A)
    (i j : Fin n) (hij : j.val+1  <  i.val) (hi : i.val+1 < n) : A i j = 0 := by
  apply hA.1 i j
  simp only [not_or,not_and]
  constructor
  · omega
  constructor  <;> omega

/-- All future nonfinal original rows stay literally untouched until arrival.
Earlier row swaps cannot select one of their zero pivot-column entries. -/
lemma path_untouched {n : ℕ} (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) :
    ∀ k : ℕ, k < n → ∀ i j : Fin n,
      k < i.val → i.val+1 < n → k ≤ j.val → S k i j = A i j := by
  intro k
  induction k with
  | zero => intro hk i j hi hil hj; rw [hp.1]
  | succ k ih =>
    intro hk i j hi hil hj
    let f : Fin n := ⟨k,by omega⟩
    have hik : k < i.val := by omega
    have hzero : S k i f = 0 := by
      rw [ih (by omega) i f hik hil (by simp [f])]
      exact cyclic_below_zero A hA i f (by dsimp [f]; omega) hil
    have hir : i ≠ r f := by
      intro he
      rw [he] at hzero
      exact (hp.2 f).2.1 hzero
    have hif : i ≠ f := by intro he; have := congrArg Fin.val he; dsimp [f] at this; omega
    have he := (hp.2 f).2.2.2 hk
    change S (k+1) = _ at he
    rw [he]
    have hfi : f < i := by simp only [Fin.lt_def]; dsimp [f]; omega
    have hfj : f < j := by simp only [Fin.lt_def]; dsimp [f]; omega
    rw [schurStep, if_pos (show f < i ∧ f < j from ⟨hfi,hfj⟩),
      Equiv.swap_apply_of_ne_of_ne hif hir]
    change S k i j - S k i f / _ * _ = _
    rw [hzero, zero_div, zero_mul, sub_zero]
    exact ih (by omega) i j hik hil (by omega)

/-- Every early pivot is one of the two old positions or the fresh row. -/
lemma path_front_pivot {n : ℕ} (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (k : Fin n) : r k = k ∨ (r k).val = k.val+1 ∨ (r k).val+1 = n := by
  by_cases h0 : r k = k
  · exact Or.inl h0
  by_cases h1 : (r k).val = k.val+1
  · exact Or.inr (Or.inl h1)
  right; right
  by_contra hh
  have hr : k.val+1 < (r k).val := by
    have hle := (hp.2 k).1
    have hne : (r k).val ≠ k.val := by exact fun he => h0 (Fin.ext he)
    simp only [Fin.le_def] at hle
    omega
  have hlast : (r k).val+1 < n := by have := (r k).isLt; omega
  have he : S k.val (r k) k = 0 := by
    rw [path_untouched A hA S r hp k.val k.isLt (r k) k (by omega) hlast (by omega)]
    exact cyclic_below_zero A hA (r k) k hr hlast
  exact (hp.2 k).2.1 he

end NLA.IE14
