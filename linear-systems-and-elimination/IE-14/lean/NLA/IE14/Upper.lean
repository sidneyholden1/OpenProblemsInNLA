/- Full all-path complex GEPP upper bound, assembled from literal front evolution. -/
import NLA.IE14.ColumnBounds
set_option autoImplicit false
set_option maxHeartbeats 3000000
set_option leancert.trust "kernel"
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

lemma sharpGrowth_one_le {n : ℕ} (hn : 4 ≤ n) : 2 ≤ sharpGrowth n := by
  have hh := fibR_one_le (show 1 ≤ n+1 by omega)
  change 2 ≤ fibR (n+1)+1
  linarith

lemma front_entry_bound {n : ℕ} (hn : 4 ≤ n) (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (k : ℕ) (hk : k+2 ≤ n) (j : Fin n) (hj : k ≤ j.val) :
    ‖S k ⟨k,by omega⟩ j‖ ≤ sharpGrowth n*entryMax A ∧
    ‖S k ⟨n-1,by omega⟩ j‖ ≤ sharpGrowth n*entryMax A := by
  have hb := entryMax_nonneg A
  have hc := sharpGrowth_one_le hn
  by_cases hjlast : j.val+1=n
  · have ej : j = ⟨n-1,by omega⟩ := Fin.ext (by dsimp; omega)
    simp only [ej]
    obtain ⟨h0,hl,hs⟩ := last_front hn A hA S r hp k hk
    have hf := fibR_mono (show k+2 ≤ n+1 by omega)
    have he : fibR (k+2)*entryMax A ≤ sharpGrowth n*entryMax A := by
      change _ ≤ (fibR (n+1)+1)*entryMax A
      nlinarith
    exact ⟨h0.trans he,hl.trans he⟩
  · by_cases hjpen : j.val+2=n
    · obtain ⟨h0,hl,hs⟩ := penultimate_front hn A hA S r hp j hjpen k hj
      have hf := fibR_mono (show k+1 ≤ n-1 by omega)
      have hs2 : k+2-j.val ≤ 2 := by omega
      have hs2r : ((k+2-j.val : ℕ):ℝ) ≤ 2 := by exact_mod_cast hs2
      have hrec := fibR_rec (n-1)
      have en : n-1+2=n+1 := by omega
      have en' : n-1+1=n := by omega
      rw [en,en'] at hrec
      have hf1 := fibR_one_le (show 1 ≤ n by omega)
      have he : (fibR (k+1)+(k+2-j.val : ℕ))*entryMax A ≤ sharpGrowth n*entryMax A := by
        change _ ≤ (fibR (n+1)+1)*entryMax A
        nlinarith
      exact ⟨h0.trans he,hl.trans he⟩
    · have hjord : j.val+2 < n := by have := j.isLt; omega
      obtain ⟨h0,hl,hs⟩ := ordinary_front hn A hA S r hp j hjord k hj
      have he : (if k+1 < j.val then (0:ℝ) else if k < j.val then 1 else 2)*entryMax A ≤ sharpGrowth n*entryMax A := by
        split_ifs <;> nlinarith
      exact ⟨h0.trans he,hl.trans he⟩

lemma final_entry_bound {n : ℕ} (hn : 4 ≤ n) (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) :
    ‖S (n-1) ⟨n-1,by omega⟩ ⟨n-1,by omega⟩‖ ≤ sharpGrowth n*entryMax A := by
  let p : Fin n := ⟨n-2,by omega⟩
  let l : Fin n := ⟨n-1,by omega⟩
  have hpl : p < l := by simp only [Fin.lt_def]; dsimp [p,l]; omega
  have he := step_entry_bound A S r hp p l l hpl hpl
  have hr := (hp.2 p).2.2.2 (by dsimp [p]; omega)
  have en : n-2+1=n-1 := by omega
  change S (n-2+1) = _ at hr
  rw [en] at hr
  rw [← hr] at he
  obtain ⟨h0,hl,hs⟩ := last_front hn A hA S r hp (n-2) (by omega)
  have en2 : n-2+2=n := by omega
  have en3 : n-2+3=n+1 := by omega
  simp only [en2,en3,if_true] at hs
  change ‖S (n-2) p l‖ + ‖S (n-2) l l‖ ≤ sharpGrowth n*entryMax A at hs
  change ‖S (n-1) l l‖ ≤ _
  by_cases hpr : r p = p
  · simpa only [hpr,Equiv.swap_self,Equiv.refl_apply,add_comm] using he.trans (by simpa only [hpr,Equiv.swap_self,Equiv.refl_apply,add_comm] using hs)
  · have hrl : r p = l := by
      apply Fin.ext
      have hrge := (hp.2 p).1
      have hrlt := (r p).isLt
      have hrne : (r p).val ≠ n-2 := by exact fun e => hpr (Fin.ext e)
      simp only [Fin.le_def] at hrge
      dsimp [p,l] at *
      omega
    simp only [hrl,Equiv.swap_apply_right] at he
    exact he.trans hs

lemma path_all_entries_bound {n : ℕ} (hn : 4 ≤ n) (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (k i j : Fin n) : ‖S k.val i j‖ ≤ sharpGrowth n*entryMax A := by
  have hb := entryMax_nonneg A
  have hc := sharpGrowth_one_le hn
  by_cases hzero : i < k ∨ j < k
  · rw [path_zero_padding A S r hp k i j hzero,norm_zero]
    positivity
  have hi : k.val ≤ i.val := by simp only [Fin.lt_def] at hzero; omega
  have hj : k.val ≤ j.val := by simp only [Fin.lt_def] at hzero; omega
  by_cases hfinal : k.val+1=n
  · have ek : k.val=n-1 := by omega
    have ei : i = ⟨n-1,by omega⟩ := Fin.ext (by dsimp; have := i.isLt; omega)
    have ej : j = ⟨n-1,by omega⟩ := Fin.ext (by dsimp; have := j.isLt; omega)
    simpa only [ek,ei,ej] using final_entry_bound hn A hA S r hp
  have hk : k.val+2 ≤ n := by have := k.isLt; omega
  obtain ⟨h0,hl⟩ := front_entry_bound hn A hA S r hp k.val hk j hj
  by_cases hik : i = k
  · subst i; exact h0
  by_cases hil : i.val+1=n
  · have ei : i = ⟨n-1,by omega⟩ := Fin.ext (by dsimp; omega)
    simpa only [ei] using hl
  have hki : k.val < i.val := by
    have hh : i.val ≠ k.val := fun e => hik (Fin.ext e)
    omega
  have hil' : i.val+1 < n := by have := i.isLt; omega
  rw [path_untouched A hA S r hp k.val k.isLt i j hki hil' hj]
  have he := entry_le A i j
  nlinarith

theorem upper_bound_proved (n : ℕ) (hn : 4 ≤ n) (A : Mat n)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hA : IsCyclic A) (hp : isPath A S r) :
    growth A S ≤ sharpGrowth n := by
  apply growth_le_of_entry_bounds A S (sharpGrowth n) (by have := sharpGrowth_one_le hn; linarith)
    (cyclic_entryMax_pos A hA)
  exact path_all_entries_bound hn A hA S r hp

#assert_trust kernel upper_bound_proved
end NLA.IE14
