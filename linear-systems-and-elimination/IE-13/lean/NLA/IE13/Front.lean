/- The finite front is derived from the original band and every actual GEPP path.
Adapted general path arguments from the IE-14 formalization; no front assumption is added.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden with Codex. -/
import NLA.IE13.Base
import NLA.IE13.Budgets
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma path_untouched {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) :
    ∀k : ℕ, k < n → ∀i j : Fin n, k+p ≤ i.val → k ≤ j.val → S k i j=A i j := by
  intro k
  induction k with
  | zero => intro hk i j hi hj; rw [hp.1]
  | succ k ih =>
    intro hk i j hi hj
    let f : Fin n := ⟨k,by omega⟩
    have hzero : S k i f=0 := by
      rw [ih (by omega) i f (by omega) (by simp [f])]
      exact hA.1 i f (Or.inl (by dsimp [f]; omega))
    have hir : i ≠ r f := by
      intro he; rw [he] at hzero
      exact (hp.2 f).2.1 hzero
    have hif : i ≠ f := by intro he; have := congrArg Fin.val he; dsimp [f] at this; omega
    have he := (hp.2 f).2.2.2 hk
    change S (k+1)=_ at he
    rw [he]
    have hfi : f < i := by simp only [Fin.lt_def]; dsimp [f]; omega
    have hfj : f < j := by simp only [Fin.lt_def]; dsimp [f]; omega
    rw [schurStep,if_pos ⟨hfi,hfj⟩,Equiv.swap_apply_of_ne_of_ne hif hir]
    change S k i j-S k i f/_*_= _
    rw [hzero,zero_div,zero_mul,sub_zero]
    exact ih (by omega) i j (by omega) (by omega)

lemma path_front_pivot {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) (k : Fin n) :
    (r k).val ≤ k.val+p := by
  by_contra hh
  have hr : k.val+p < (r k).val := by omega
  have hz : S k.val (r k) k=0 := by
    rw [path_untouched A hA S r hp k.val k.isLt (r k) k (by omega) (by omega)]
    exact hA.1 (r k) k (Or.inl hr)
  exact (hp.2 k).2.1 hz

/-- A distant column stays zero in every row before its original upper-band arrival. -/
lemma path_far_column_zero {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) :
    ∀k : ℕ, k < n → ∀i j : Fin n, k+p+q ≤ j.val → i.val+q < j.val → S k i j=0 := by
  intro k
  induction k with
  | zero => intro hk i j hj hi; rw [hp.1]; exact hA.1 i j (Or.inr hi)
  | succ k ih =>
    intro hk i j hj hi
    let f : Fin n := ⟨k,by omega⟩
    have hr := path_front_pivot A hA S r hp f
    have hrj : (r f).val+q < j.val := by change (r f).val ≤ k+p at hr; omega
    have hpzero := ih (by omega) (r f) j (by omega) hrj
    have he := (hp.2 f).2.2.2 hk
    change S (k+1)=_ at he
    rw [he]
    by_cases hactive : f < i ∧ f < j
    · rw [schurStep,if_pos hactive]
      have hswap : (Equiv.swap f (r f) i).val+q < j.val := by
        by_cases hif : i=f
        · simpa [hif] using hrj
        by_cases hir : i=r f
        · rw [hir,Equiv.swap_apply_right]; dsimp [f]; omega
        · rw [Equiv.swap_apply_of_ne_of_ne hif hir]; exact hi
      rw [ih (by omega) _ j (by omega) hswap,hpzero,mul_zero,sub_zero]
    · simp [schurStep,hactive]

end NLA.IE13
