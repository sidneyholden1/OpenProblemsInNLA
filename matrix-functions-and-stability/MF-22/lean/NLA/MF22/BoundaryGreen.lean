/- Exact forced-state recurrence and boundary values of the finite Green kernel.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.GreenBounds
set_option autoImplicit false
set_option maxHeartbeats 1500000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF22

def forwardEntry (T : FourMat) (j l : ℕ) (i s : Fin 4) : ℂ :=
  if l<j then (T^(j-1-l)) i s else 0

lemma forwardEntry_step (T : FourMat) (j l : ℕ) (i s : Fin 4) :
    forwardEntry T (j+1) l i s =
      (∑ a : Fin 4, T i a*forwardEntry T j l a s)+
        if j=l then (1:FourMat) i s else 0 := by
  by_cases hlj : l<j
  · have hn : l<j+1 := by omega
    have he : j+1-1-l=(j-1-l)+1 := by omega
    simp only [forwardEntry,if_pos hlj,if_pos hn,if_neg (show j ≠ l by omega),add_zero]
    rw [he,pow_succ',Matrix.mul_apply]
  · by_cases hje : j=l
    · subst l
      simp [forwardEntry]
    · have hn : ¬l<j+1 := by omega
      simp [forwardEntry,hlj,hje,hn]

lemma greenEntry_step (T : FourMat) (n j l : ℕ) (i s : Fin 4) :
    greenEntry T n (j+1) l i s =
      (∑ a : Fin 4, T i a*greenEntry T n j l a s)+
        if j=l then (1:FourMat) i s else 0 := by
  have hp : (T^(j+1)) i 0=∑ a : Fin 4, T i a*(T^j) a 0 := by
    rw [pow_succ',Matrix.mul_apply]
  have hf := forwardEntry_step T j l i s
  change forwardEntry T (j+1) l i s-_= _
  rw [hf,hp]
  simp only [greenEntry,forwardEntry, mul_sub,Finset.sum_sub_distrib]
  have hsum : (∑ a : Fin 4, T i a*(T^j) a 0)/(T^n) 0 0*(T^(n-1-l)) 0 s =
      ∑ a : Fin 4, T i a*((T^j) a 0/(T^n) 0 0*(T^(n-1-l)) 0 s) := by
    rw [Finset.sum_div,Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro a _
    ring
  rw [hsum]
  ring

lemma greenEntry_initial (T : FourMat) (n l : ℕ) (i s : Fin 4) (hi : i ≠ 0) :
    greenEntry T n 0 l i s=0 := by
  simp [greenEntry,Matrix.one_apply,hi]

lemma greenEntry_terminal (T : FourMat) (n l : ℕ) (hl : l<n) (s : Fin 4)
    (hd : (T^n) 0 0 ≠ 0) : greenEntry T n n l 0 s=0 := by
  simp [greenEntry,hl,hd]

def greenResponse (T : FourMat) (G : Matrix (Fin 4) (Fin 2) ℂ)
    (n j l : ℕ) (i : Fin 4) (b : Fin 2) : ℂ :=
  ∑ s : Fin 4, greenEntry T n j l i s*G s b

lemma response_step (T : FourMat) (G : Matrix (Fin 4) (Fin 2) ℂ)
    (n j l : ℕ) (i : Fin 4) (b : Fin 2) :
    greenResponse T G n (j+1) l i b =
      (∑ a : Fin 4, T i a*greenResponse T G n j l a b)+
        if j=l then G i b else 0 := by
  unfold greenResponse
  simp only [greenEntry_step,add_mul,Finset.sum_add_distrib,Finset.sum_mul,Finset.mul_sum]
  rw [Finset.sum_comm]
  congr 1
  · apply Finset.sum_congr rfl
    intro a _
    apply Finset.sum_congr rfl
    intro s _
    ring
  · by_cases h : j=l <;> simp [h,Matrix.one_apply]

lemma response_initial (T : FourMat) (G : Matrix (Fin 4) (Fin 2) ℂ)
    (n l : ℕ) (i : Fin 4) (b : Fin 2) (hi : i ≠ 0) :
    greenResponse T G n 0 l i b=0 := by
  simp [greenResponse,greenEntry_initial T n l i _ hi]

lemma response_terminal (T : FourMat) (G : Matrix (Fin 4) (Fin 2) ℂ)
    (n l : ℕ) (b : Fin 2) (hl : l<n) (hd : (T^n) 0 0 ≠ 0) :
    greenResponse T G n n l 0 b=0 := by
  simp [greenResponse,greenEntry_terminal T n l hl _ hd]

lemma response_norm_le (T : FourMat) (G : Matrix (Fin 4) (Fin 2) ℂ)
    (n j l : ℕ) (i : Fin 4) (b : Fin 2) (C : ℝ)
    (h : ∀ s, ‖greenEntry T n j l i s‖ ≤ C) :
    ‖greenResponse T G n j l i b‖ ≤ C * ∑ s : Fin 4, ‖G s b‖ := by
  unfold greenResponse
  calc
    _ ≤ ∑ s : Fin 4, ‖greenEntry T n j l i s * G s b‖ := norm_sum_le _ _
    _ ≤ ∑ s : Fin 4, C*‖G s b‖ := by
      apply Finset.sum_le_sum
      intro s _
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right (h s) (norm_nonneg _)
    _ = _ := (Finset.mul_sum _ _ _).symm

#assert_trust kernel response_step
#assert_trust kernel response_initial
#assert_trust kernel response_terminal
end NLA.MF22
