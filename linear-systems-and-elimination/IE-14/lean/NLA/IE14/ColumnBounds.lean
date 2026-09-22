/- Columnwise Fibonacci envelopes. Only the source's two exceptional final
columns accumulate the travelling front; every other column stays bounded by 2. -/
import NLA.IE14.PairBounds
set_option autoImplicit false
set_option maxHeartbeats 4000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

def fibR (k : ℕ) : ℝ := Nat.fib k
lemma fibR_nonneg (k : ℕ) : 0 ≤ fibR k := Nat.cast_nonneg _
lemma fibR_mono {a b : ℕ} (h : a ≤ b) : fibR a ≤ fibR b := by unfold fibR; exact_mod_cast Nat.fib_mono h
lemma fibR_one_le {k : ℕ} (h : 1 ≤ k) : 1 ≤ fibR k := by simpa [fibR] using fibR_mono h
lemma fibR_rec (k : ℕ) : fibR (k+2) = fibR k + fibR (k+1) := by simp [fibR,Nat.fib_add_two]

lemma cyclic_above_zero {n : ℕ} (A : Mat n) (hA : IsCyclic A)
    (i j : Fin n) (hij : i.val+1 < j.val) (hi : 0 < i.val ∨ j.val+1 < n) : A i j = 0 := by
  apply hA.1 i j
  simp only [not_or,not_and]
  constructor; · omega
  constructor <;> omega

lemma last_front {n : ℕ} (hn : 4 ≤ n) (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r) :
    ∀ (k : ℕ) (hk : k+2 ≤ n),
    ‖S k ⟨k,by omega⟩ ⟨n-1,by omega⟩‖ ≤ fibR (k+2)*entryMax A ∧
    ‖S k ⟨n-1,by omega⟩ ⟨n-1,by omega⟩‖ ≤ fibR (k+2)*entryMax A ∧
    ‖S k ⟨k,by omega⟩ ⟨n-1,by omega⟩‖ + ‖S k ⟨n-1,by omega⟩ ⟨n-1,by omega⟩‖ ≤
      (fibR (k+3)+(if k+2=n then 1 else 0))*entryMax A := by
  intro k
  induction k with
  | zero =>
    intro hk
    rw [hp.1]
    have e0 := entry_le A ⟨0,by omega⟩ ⟨n-1,by omega⟩
    have el := entry_le A ⟨n-1,by omega⟩ ⟨n-1,by omega⟩
    have hh : ¬(0+2=n) := by omega
    norm_num [fibR,hh] at *
    exact ⟨e0,el,by linarith⟩
  | succ k ih =>
    intro hk
    obtain ⟨h0,hl,hs⟩ := ih (by omega)
    have hb := entryMax_nonneg A
    have hbefore : k+2 ≠ n := by omega
    simp only [hbefore,if_false,add_zero] at hs
    have hrec := fibR_rec (k+2)
    simp only [Nat.add_assoc] at hrec
    have hrec1 := fibR_rec (k+1)
    simp only [Nat.add_assoc] at hrec1
    have hmono := fibR_mono (show k+2 ≤ k+3 by omega)
    by_cases he : k+3=n
    · have h1 := fibR_one_le (show 1 ≤ k+1 by omega)
      have hc := entry_le A ⟨k+1,by omega⟩ ⟨n-1,by omega⟩
      have ht := front_update A hA S r hp k (by omega) ⟨n-1,by omega⟩ (by dsimp; omega)
        (fibR (k+2)*entryMax A) (fibR (k+3)*entryMax A) (entryMax A)
        (fibR (k+3)*entryMax A) ((fibR (k+4)+1)*entryMax A)
        h0 hl hs hc (le_refl _) (by nlinarith) (by nlinarith) (by nlinarith [fibR_one_le (show 1 ≤ k+2 by omega)])
      simpa only [Nat.add_assoc,he,if_true] using ht
    · have hz : A ⟨k+1,by omega⟩ ⟨n-1,by omega⟩ = 0 :=
        cyclic_above_zero A hA _ _ (by dsimp; omega) (Or.inl (by dsimp; omega))
      have hc : ‖A ⟨k+1,by omega⟩ ⟨n-1,by omega⟩‖ ≤ 0 := by rw [hz,norm_zero]
      have ht := front_update A hA S r hp k (by omega) ⟨n-1,by omega⟩ (by dsimp; omega)
        (fibR (k+2)*entryMax A) (fibR (k+3)*entryMax A) 0
        (fibR (k+3)*entryMax A) (fibR (k+4)*entryMax A)
        h0 hl hs hc (le_refl _) (by nlinarith) (by nlinarith) (by nlinarith [fibR_nonneg (k+2)])
      simpa only [Nat.add_assoc,he,if_false,add_zero] using ht

/-- Every ordinary column has at most two arrivals. -/
lemma ordinary_front {n : ℕ} (hn : 4 ≤ n) (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (j : Fin n) (hj : j.val+2 < n) :
    ∀ (k : ℕ) (hk : k ≤ j.val),
    ‖S k ⟨k,by omega⟩ j‖ ≤ (if k+1 < j.val then 0 else if k < j.val then 1 else 2)*entryMax A ∧
    ‖S k ⟨n-1,by omega⟩ j‖ ≤ (if k+1 < j.val then 0 else if k < j.val then 1 else 2)*entryMax A ∧
    ‖S k ⟨k,by omega⟩ j‖ + ‖S k ⟨n-1,by omega⟩ j‖ ≤
      2*(if k+1 < j.val then 0 else if k < j.val then 1 else 2)*entryMax A := by
  intro k
  induction k with
  | zero =>
    intro hk
    rw [hp.1]
    have h0 := entry_le A ⟨0,by omega⟩ j
    have hl := entry_le A ⟨n-1,by omega⟩ j
    have hb := entryMax_nonneg A
    by_cases hfar : 1 < j.val
    · have z0 := cyclic_above_zero A hA (⟨0,by omega⟩ : Fin n) j hfar (Or.inr (by omega))
      have zl : A ⟨n-1,by omega⟩ j = 0 := by
        apply hA.1; simp only [not_or,not_and]; constructor; · omega
        constructor <;> omega
      simp [hfar,z0,zl]
    · simp only [Nat.zero_add,hfar,if_false]
      by_cases hj0 : 0 < j.val
      · simp only [hj0,if_true,one_mul,mul_one]; exact ⟨h0,hl,by linarith⟩
      · simp only [hj0,if_false]; exact ⟨by linarith,by linarith,by linarith⟩
  | succ k ih =>
    intro hk
    obtain ⟨h0,hl,hs⟩ := ih (by omega)
    have hb := entryMax_nonneg A
    by_cases hfar : k+2 < j.val
    · have hold : k+1 < j.val := by omega
      simp only [hold,if_true,zero_mul,mul_zero] at h0 hl hs
      have hz := cyclic_above_zero A hA (⟨k+1,by omega⟩ : Fin n) j hfar (Or.inl (by dsimp; omega))
      have hc : ‖A ⟨k+1,by omega⟩ j‖ ≤ 0 := by rw [hz,norm_zero]
      have ht := front_update A hA S r hp k (by omega) j (by omega)
        0 0 0 0 0 h0 hl hs hc (by norm_num) (by norm_num) (by norm_num) (by norm_num)
      simpa only [Nat.add_assoc,hfar,if_true,zero_mul,mul_zero] using ht
    · by_cases hedge : k+2=j.val
      · have hold : k+1 < j.val := by omega
        have hnext : k+1 < j.val := hold
        simp only [hold,if_true,zero_mul,mul_zero] at h0 hl hs
        have ht := front_update A hA S r hp k (by omega) j (by omega)
          0 0 (entryMax A) (entryMax A) (2*entryMax A) h0 hl hs (entry_le A _ _)
          hb (by linarith) (by linarith) (by linarith)
        simpa only [Nat.add_assoc,hfar,if_false,hnext,if_true,one_mul,mul_one] using ht
      · have hnear : k+1=j.val := by omega
        have hold : ¬ k+1 < j.val := by omega
        have hold2 : k < j.val := by omega
        have hnext : ¬ k+1 < j.val := hold
        simp only [hold,if_false,hold2,if_true,one_mul,mul_one] at h0 hl hs
        have ht := front_update A hA S r hp k (by omega) j (by omega)
          (entryMax A) (2*entryMax A) (entryMax A) (2*entryMax A) (4*entryMax A)
          h0 hl hs (entry_le A _ _) (le_refl _) (by linarith) (by linarith) (by linarith)
        simpa only [Nat.add_assoc,hfar,if_false,hnext,show (2:ℝ)*2=4 by norm_num] using ht

/-- The penultimate column has two late arrivals and a single initial front entry. -/
lemma penultimate_front {n : ℕ} (hn : 4 ≤ n) (A : Mat n) (hA : IsCyclic A)
    (S : ℕ → Mat n) (r : Fin n → Fin n) (hp : isPath A S r)
    (j : Fin n) (hj : j.val+2=n) :
    ∀ (k : ℕ) (hk : k ≤ j.val),
    ‖S k ⟨k,by omega⟩ j‖ ≤ (fibR (k+1)+(k+2-j.val : ℕ))*entryMax A ∧
    ‖S k ⟨n-1,by omega⟩ j‖ ≤ (fibR (k+1)+(k+2-j.val : ℕ))*entryMax A ∧
    ‖S k ⟨k,by omega⟩ j‖ + ‖S k ⟨n-1,by omega⟩ j‖ ≤
      (fibR (k+2)+2*(k+2-j.val : ℕ))*entryMax A := by
  intro k
  induction k with
  | zero =>
    intro hk
    rw [hp.1]
    have hz := cyclic_above_zero A hA (⟨0,by omega⟩ : Fin n) j (by dsimp; omega) (Or.inr (by omega))
    have hl := entry_le A ⟨n-1,by omega⟩ j
    have hb := entryMax_nonneg A
    have hsub : 0+2-j.val=0 := by omega
    simpa [fibR,hsub,hz] using (show 0 ≤ entryMax A ∧ ‖A ⟨n-1,by omega⟩ j‖ ≤ entryMax A ∧ ‖A ⟨n-1,by omega⟩ j‖ ≤ entryMax A from ⟨hb,hl,hl⟩)
  | succ k ih =>
    intro hk
    obtain ⟨h0,hl,hs⟩ := ih (by omega)
    have hb := entryMax_nonneg A
    have hm := fibR_mono (show k+1 ≤ k+2 by omega)
    have hr := fibR_rec (k+1)
    simp only [Nat.add_assoc] at hr
    have hp1 := fibR_one_le (show 1 ≤ k+1 by omega)
    by_cases hfar : k+2 < j.val
    · have e0 : k+2-j.val=0 := by omega
      have e1 : k+1+2-j.val=0 := by omega
      simp only [e0,Nat.cast_zero,mul_zero,add_zero] at h0 hl hs
      have hz := cyclic_above_zero A hA (⟨k+1,by omega⟩ : Fin n) j hfar (Or.inl (by dsimp; omega))
      have hc : ‖A ⟨k+1,by omega⟩ j‖ ≤ 0 := by rw [hz,norm_zero]
      have ht := front_update A hA S r hp k (by omega) j (by omega)
        (fibR (k+1)*entryMax A) (fibR (k+2)*entryMax A) 0
        (fibR (k+2)*entryMax A) (fibR (k+3)*entryMax A)
        h0 hl hs hc (le_refl _) (by nlinarith) (by nlinarith) (by nlinarith)
      simpa only [e1,Nat.cast_zero,mul_zero,add_zero,Nat.add_assoc] using ht
    · by_cases hedge : k+2=j.val
      · have e0 : k+2-j.val=0 := by omega
        have e1 : k+1+2-j.val=1 := by omega
        simp only [e0,Nat.cast_zero,mul_zero,add_zero] at h0 hl hs
        have ht := front_update A hA S r hp k (by omega) j (by omega)
          (fibR (k+1)*entryMax A) (fibR (k+2)*entryMax A) (entryMax A)
          ((fibR (k+2)+1)*entryMax A) ((fibR (k+3)+2)*entryMax A)
          h0 hl hs (entry_le A _ _) (by nlinarith) (by nlinarith) (by nlinarith) (by nlinarith)
        simpa only [e1,Nat.cast_one,mul_one,Nat.add_assoc] using ht
      · have e0 : k+2-j.val=1 := by omega
        have e1 : k+1+2-j.val=2 := by omega
        simp only [e0,Nat.cast_one,mul_one] at h0 hl hs
        have ht := front_update A hA S r hp k (by omega) j (by omega)
          ((fibR (k+1)+1)*entryMax A) ((fibR (k+2)+2)*entryMax A) (entryMax A)
          ((fibR (k+2)+2)*entryMax A) ((fibR (k+3)+4)*entryMax A)
          h0 hl hs (entry_le A _ _) (le_refl _) (by nlinarith) (by nlinarith) (by nlinarith)
        simpa only [e1,Nat.cast_ofNat,Nat.add_assoc,show (2:ℝ)*2=4 by norm_num] using ht

end NLA.IE14
