/- Exact sharp-bound recurrence from Colbrook's IE-13 manuscript.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical
namespace NLA.IE13

@[simp] lemma bandRec_zero (p : ℕ) : bandRec p 0 = 0 := by rw [bandRec]
lemma bandRec_succ (p k : ℕ) :
    bandRec p (k+1) = 1 + ∑ r ∈ Finset.range p, bandRec p (k-r) := by rw [bandRec]
@[simp] lemma bandRec_one (p : ℕ) : bandRec p 1 = 1 := by simp [bandRec_succ]
lemma bandRec_pos {p t : ℕ} (ht : 0 < t) : 0 < bandRec p t := by
  obtain ⟨k,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : t ≠ 0)
  rw [bandRec_succ]; omega
lemma bandRec_one_le {p t : ℕ} (ht : 1 ≤ t) : 1 ≤ bandRec p t := bandRec_pos ht

lemma bandRec_le_succ (p k : ℕ) : bandRec p k ≤ bandRec p (k+1) := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    cases k with
    | zero => simp
    | succ k =>
      rw [bandRec_succ p (k+1), bandRec_succ p k]
      apply Nat.add_le_add_left
      apply Finset.sum_le_sum
      intro r hr
      by_cases h : r ≤ k
      · have he : k+1-r=(k-r)+1 := by omega
        rw [he]
        exact ih (k-r) (by omega)
      · have h0 : k-r=0 := by omega
        have h1 : k+1-r=0 := by omega
        simp [h0,h1]

lemma bandRec_mono (p : ℕ) : Monotone (bandRec p) :=
  monotone_nat_of_le_succ (bandRec_le_succ p)

/-- Sliding-window recurrence, kept without truncated subtraction on values. -/
lemma bandRec_window (p t : ℕ) (hp : 0 < p) (ht : 0 < t) :
    bandRec p (t+1) + bandRec p (t-p) = 2 * bandRec p t := by
  obtain ⟨s,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : p ≠ 0)
  obtain ⟨k,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : t ≠ 0)
  rw [bandRec_succ (s+1) (k+1), bandRec_succ (s+1) k]
  rw [Finset.sum_range_succ']
  have he : (∑ x ∈ Finset.range s, bandRec (s+1) (k+1-(x+1))) =
      ∑ x ∈ Finset.range s, bandRec (s+1) (k-x) := by
    apply Finset.sum_congr rfl
    intro x hx
    congr 1
    omega
  rw [he,Finset.sum_range_succ]
  have hs : k+1-(s+1)=k-s := by omega
  rw [hs]
  have hh := bandRec_succ (s+1) k
  rw [Finset.sum_range_succ] at hh
  simp only [Nat.sub_zero, Nat.succ_eq_add_one] at *
  omega

lemma bandRec_double {p t : ℕ} (hp : 0 < p) (ht : 1 ≤ t) (htp : t ≤ p) :
    bandRec p (t+1) = 2 * bandRec p t := by
  have h := bandRec_window p t hp ht
  simpa [Nat.sub_eq_zero_of_le htp] using h

lemma bandRec_early (p t : ℕ) (ht : 1 ≤ t) (htp : t ≤ p+1) :
    bandRec p t = 2^(t-1) := by
  induction t with
  | zero => omega
  | succ t ih =>
    by_cases h0 : t=0
    · subst t; simp
    · have ht1 : 1 ≤ t := by omega
      rw [bandRec_double (by omega : 0 < p) ht1 (by omega), ih ht1 (by omega)]
      have he : t-1+1=t := by omega
      rw [← pow_succ',he]
      simp

/-- Reflection of a truncated backwards window; repeated zero indices contribute zero. -/
lemma sum_backwards_window (f : ℕ → ℕ) (hf : f 0 = 0) (p k : ℕ) :
    (∑ r ∈ Finset.range p, f (k-r)) =
      ∑ a ∈ Finset.Ico (k+1-p) (k+1), f a := by
  have hs : Finset.range (min p (k+1)) ⊆ Finset.range p :=
    Finset.range_mono (min_le_left _ _)
  have he : (∑ r ∈ Finset.range p, f (k-r)) =
      ∑ r ∈ Finset.range (min p (k+1)), f (k-r) := by
    symm
    apply Finset.sum_subset hs
    intro r hr hn
    have hrp := Finset.mem_range.mp hr
    have hrm : min p (k+1) ≤ r := Nat.le_of_not_gt (fun h => hn (Finset.mem_range.mpr h))
    have hz : k-r=0 := by omega
    simp [hz,hf]
  rw [he]
  have hh := Finset.sum_Ico_reflect f 0 (min_le_right p (k+1))
  simp only [Nat.Ico_zero_eq_range,Nat.sub_zero] at hh
  rw [hh]
  congr 2
  omega

lemma bandRec_eq_window (p t : ℕ) (ht : 0 < t) :
    bandRec p t = 1 + ∑ a ∈ Finset.Ico (t-p) t, bandRec p a := by
  obtain ⟨k,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : t ≠ 0)
  rw [bandRec_succ, sum_backwards_window _ (bandRec_zero p)]

lemma bandRec_eq_filtered (p t : ℕ) (ht : 0 < t) :
    bandRec p t = 1 + ∑ a ∈ Finset.range t,
      if t ≤ a+p then bandRec p a else 0 := by
  rw [bandRec_eq_window p t ht, ← Finset.sum_filter]
  congr 2
  ext a
  simp only [Finset.mem_Ico,Finset.mem_filter,Finset.mem_range]
  omega

/-- Forward-substitution values in the source attaining target column. -/
def targetRec (p i : ℕ) : ℕ := if i=0 then 1 else bandRec p i

lemma targetRec_eq (p i : ℕ) : targetRec p i =
    bandRec p i + (if i=0 then 1 else 0) := by
  by_cases hi : i=0 <;> simp [targetRec,hi]

lemma targetRec_forward (p i : ℕ) :
    targetRec p i = (if i=0 ∨ p < i then 1 else 0) +
      ∑ a ∈ Finset.range i, if i ≤ a+p then targetRec p a else 0 := by
  by_cases hi : i=0
  · subst i; simp [targetRec]
  have hh := bandRec_eq_filtered p i (by omega)
  have he : (∑ a ∈ Finset.range i, if i ≤ a+p then targetRec p a else 0) =
      (∑ a ∈ Finset.range i, if i ≤ a+p then bandRec p a else 0) +
        (if i ≤ p then 1 else 0) := by
    have heach : ∀ a, (if i ≤ a+p then targetRec p a else 0) =
        (if i ≤ a+p then bandRec p a else 0) +
          (if a=0 ∧ i≤p then 1 else 0) := by
      intro a
      rw [targetRec_eq]
      by_cases ha : a=0 <;> by_cases hb : i≤p <;>
        by_cases hc : i≤a+p <;> simp_all
    simp_rw [heach]
    rw [Finset.sum_add_distrib]
    congr 1
    by_cases hp : i≤p
    · simp [hp,Finset.sum_ite_eq',Finset.mem_range,show 0 < i by omega]
    · simp [hp]
  rw [he]
  simp only [targetRec,hi,if_false,false_or]
  by_cases hp : p < i
  · have hp' : ¬ i≤p := by omega
    simp [hp,hp']; omega
  · have hp' : i≤p := by omega
    simp [hp,hp']; omega

end NLA.IE13
