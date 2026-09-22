/- Quantitative two-row front bounds for all actual partial-pivot choices. -/
import NLA.IE14.Front
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

lemma front_update {n : ℕ} (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (k : ℕ) (hk : k+2  <  n) (j : Fin n) (hj : k  <  j.val)
    (M T c M' T' : ℝ)
    (h0 : ‖S k ⟨k,by omega⟩ j‖  ≤  M)
    (hl : ‖S k ⟨n-1,by omega⟩ j‖  ≤  M)
    (hs : ‖S k ⟨k,by omega⟩ j‖ + ‖S k ⟨n-1,by omega⟩ j‖  ≤  T)
    (hf : ‖A ⟨k+1,by omega⟩ j‖  ≤  c)
    (hm1 : T  ≤  M') (hm2 : M+c  ≤  M')
    (ht1 : T+M+c  ≤  T') (ht2 : T+2*c  ≤  T') :
    ‖S (k+1) ⟨k+1,by omega⟩ j‖  ≤  M' ∧
    ‖S (k+1) ⟨n-1,by omega⟩ j‖  ≤  M' ∧
    ‖S (k+1) ⟨k+1,by omega⟩ j‖ + ‖S (k+1) ⟨n-1,by omega⟩ j‖  ≤  T' := by
  let p : Fin n := ⟨k,by omega⟩
  let f : Fin n := ⟨k+1,by omega⟩
  let l : Fin n := ⟨n-1,by omega⟩
  have hpf : p  <  f := by simp [p,f]
  have hpl : p  <  l := by simp only [Fin.lt_def]; dsimp [p,l]; omega
  have hfl : f  ≠  l := by intro he; have := congrArg Fin.val he; dsimp [f,l] at this; omega
  have hpj : p  <  j := hj
  have hfr : S k f j  =  A f j := path_untouched A hA S r hp k (by omega) f j (by simp [f]) (by dsimp [f]; omega) (by omega)
  have ef := step_entry_bound A S r hp p f j hpf hpj
  have el := step_entry_bound A S r hp p l j hpl hpj
  have he := (hp.2 p).2.2.2 (by dsimp [p]; omega)
  change S (k+1)  =  _ at he
  rw [← he] at ef el
  change ‖S k p j‖  ≤  M at h0
  change ‖S k l j‖  ≤  M at hl
  change ‖S k p j‖ + ‖S k l j‖  ≤  T at hs
  change ‖A f j‖  ≤  c at hf
  change ‖S (k+1) f j‖  ≤  M' ∧ ‖S (k+1) l j‖  ≤  M' ∧ _
  rcases path_front_pivot A hA S r hp p with hr | hr | hr
  · simp only [hr,Equiv.swap_self,Equiv.refl_apply] at ef el
    rw [hfr] at ef
    constructor; · linarith
    constructor  <;> linarith
  · have hr' : r p  =  f := Fin.ext hr
    rw [hr'] at ef el
    simp only [Equiv.swap_apply_right,Equiv.swap_apply_of_ne_of_ne hpl.ne' hfl.symm] at ef el
    rw [hfr] at ef el
    constructor; · linarith
    constructor  <;> linarith
  · have hr' : r p  =  l := by apply Fin.ext; dsimp [l]; omega
    rw [hr'] at ef el
    simp only [Equiv.swap_apply_right,Equiv.swap_apply_of_ne_of_ne hpf.ne' hfl] at ef el
    rw [hfr] at ef
    constructor; · linarith
    constructor  <;> linarith

end NLA.IE14
