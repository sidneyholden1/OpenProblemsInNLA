/- Transport of the finite envelope through the literal padded Schur recurrence. -/
import NLA.IE13.Front
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

def rowNorm {n : ℕ} (M : Mat n) (j : Fin n) (i : ℕ) : ℝ :=
  if hi : i < n then ‖M ⟨i,hi⟩ j‖ else 0
@[simp] lemma rowNorm_fin {n : ℕ} (M : Mat n) (j i : Fin n) :
    rowNorm M j i.val=‖M i j‖ := by simp [rowNorm]
lemma rowNorm_nonneg {n : ℕ} (M : Mat n) (j : Fin n) (i : ℕ) :
    0 ≤ rowNorm M j i := by unfold rowNorm; split <;> positivity
lemma rowNorm_entry_le {n : ℕ} (M : Mat n) (j : Fin n) (i : ℕ) :
    rowNorm M j i ≤ entryMax M := by
  unfold rowNorm
  split
  · exact entry_le M _ j
  · exact entryMax_nonneg M
lemma rowNorm_swap {n : ℕ} (M : Mat n) (j k r i : Fin n) :
    rowNorm M j (Equiv.swap k.val r.val i.val)=‖M (Equiv.swap k r i) j‖ := by
  by_cases hik : i=k
  · subst i; simp
  by_cases hir : i=r
  · subst i; simp
  have hikv : i.val ≠ k.val := fun he => hik (Fin.ext he)
  have hirv : i.val ≠ r.val := fun he => hir (Fin.ext he)
  rw [Equiv.swap_apply_of_ne_of_ne hikv hirv,Equiv.swap_apply_of_ne_of_ne hik hir]
  simp

def frontSet (p k : ℕ) : Finset ℕ := Finset.Ico k (k+p+1)

lemma path_budget_step {n p q : ℕ} (A : Mat n) (hA : IsBanded p q A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (j : Fin n) (k t : ℕ) (hk : k+1 < n) (hkj : k < j.val)
    (hb : HasBudget (frontSet p k) (rowNorm (S k) j) p t (entryMax A)) :
    HasBudget (frontSet p (k+1)) (rowNorm (S (k+1)) j) p (t+1) (entryMax A) := by
  let f : Fin n := ⟨k,by omega⟩
  let U := Finset.Ico (k+1) (k+p+1)
  have hr0 := (hp.2 f).1
  have hr1 := path_front_pivot A hA S r hp f
  have hr0' : k ≤ (r f).val := hr0
  have hr1' : (r f).val ≤ k+p := hr1
  have hrF : (r f).val∈frontSet p k := by simp [frontSet]; omega
  have hU : U.card ≤ p := by simp [U]
  have hfresh : k+p+1∉U := by simp [U]
  have hrewrite : frontSet p (k+1)=insert (k+p+1) U := by
    ext i
    simp only [frontSet,U,Finset.mem_Ico,Finset.mem_insert]
    omega
  rw [hrewrite]
  apply budget_next (entryMax_nonneg A) hb hrF hU hfresh (Equiv.swap k (r f).val)
  · exact (Equiv.swap k (r f).val).injective.injOn
  · intro i hi
    have hi' := Finset.mem_Ico.mp hi
    by_cases hir : i=(r f).val
    · subst i; simp [frontSet]
    · rw [Equiv.swap_apply_of_ne_of_ne (by omega) hir]
      simp only [frontSet,Finset.mem_Ico]
      omega
  · intro i hi
    have hi' := Finset.mem_Ico.mp hi
    intro he
    have hinj := (Equiv.swap k (r f).val).injective
      (he.trans (Equiv.swap_apply_left k (r f).val).symm)
    omega
  · intro i hi
    have hi' := Finset.mem_Ico.mp hi
    by_cases hin : i < n
    · let a : Fin n := ⟨i,hin⟩
      have he := (hp.2 f).2.2.2 hk
      change S (k+1)=_ at he
      have hh := step_entry_bound A S r hp f a j
        (by simp only [Fin.lt_def]; dsimp [f,a]; omega)
        (by exact hkj)
      have hs := rowNorm_swap (S k) j f (r f) a
      change rowNorm (S (k+1)) j a.val ≤ _
      rw [rowNorm_fin,he]
      change ‖schurStep (S k) f (r f) a j‖ ≤ _
      simpa only [f,Fin.val_mk,rowNorm_fin] using (hh.trans_eq (by rw [hs]))
    · have hz : rowNorm (S (k+1)) j i=0 := by simp [rowNorm,hin]
      rw [hz]
      exact add_nonneg (rowNorm_nonneg _ _ _) (rowNorm_nonneg _ _ _)
  · by_cases hin : k+p+1 < n
    · let a : Fin n := ⟨k+p+1,hin⟩
      change rowNorm (S (k+1)) j a.val ≤ _
      rw [rowNorm_fin,path_untouched A hA S r hp (k+1) hk a j
        (by dsimp [a]; omega) (by omega)]
      exact entry_le A a j
    · simp [rowNorm,hin,entryMax_nonneg]

end NLA.IE13
