/- Finite front envelopes for the full banded GEPP bound.
The recurrence encodes Colbrook's sorted-front argument without choosing a sorting permutation.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.Recurrence
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical
namespace NLA.IE13

def profile (p : ℕ) : ℕ → ℕ → ℕ
  | 0, i => if i=0 then 1 else 0
  | t+1, i => if i<p then profile p t 0 + profile p t (i+1) else 1

def profileSum (p t m : ℕ) : ℕ := ∑ i ∈ Finset.range m, profile p t i

@[simp] lemma profile_zero (p i : ℕ) : profile p 0 i = if i=0 then 1 else 0 := rfl
lemma profile_succ (p t i : ℕ) : profile p (t+1) i =
    if i<p then profile p t 0 + profile p t (i+1) else 1 := rfl
@[simp] lemma profileSum_zero (p t : ℕ) : profileSum p t 0=0 := by simp [profileSum]
@[simp] lemma profileSum_one (p t : ℕ) : profileSum p t 1=profile p t 0 := by simp [profileSum]
lemma profileSum_succ (p t m : ℕ) : profileSum p t (m+1)=profileSum p t m+profile p t m :=
  Finset.sum_range_succ _ _

lemma profile_head_pos (p t : ℕ) : 1≤profile p t 0 := by
  induction t with
  | zero => simp
  | succ t ih => rw [profile_succ]; split <;> omega
lemma profile_succ_pos (p t i : ℕ) : 1≤profile p (t+1) i := by
  rw [profile_succ]; split
  · have := profile_head_pos p t; omega
  · omega
@[simp] lemma profile_one (p i : ℕ) : profile p 1 i=1 := by
  simp [profile_succ]
@[simp] lemma profile_no_lower (t : ℕ) : profile 0 t 0=1 := by
  cases t <;> simp [profile_succ]
lemma profileSum_initial (p m : ℕ) (hm : 0<m) : profileSum p 0 m=1 := by
  simp [profileSum,Finset.sum_ite_eq',Finset.mem_range,hm]
lemma profileSum_first (p m : ℕ) : profileSum p 1 m=m := by simp [profileSum]
lemma profileSum_mono (p t : ℕ) : Monotone (profileSum p t) := by
  apply monotone_nat_of_le_succ
  intro m
  rw [profileSum_succ]
  omega

lemma profileSum_update (p t m : ℕ) (hm : 0<m) (hmp : m≤p) :
    profileSum p (t+1) m = (m-1)*profile p t 0 + profileSum p t (m+1) := by
  have he : profileSum p (t+1) m = m*profile p t 0 +
      ∑ i ∈ Finset.range m, profile p t (i+1) := by
    unfold profileSum
    simp_rw [profile_succ]
    rw [Finset.sum_congr rfl (fun i hi => if_pos (lt_of_lt_of_le (Finset.mem_range.mp hi) hmp))]
    simp [Finset.sum_add_distrib,Finset.sum_const,smul_eq_mul]
  rw [he]
  unfold profileSum
  rw [Finset.sum_range_succ']
  have hm' : m-1+1=m := by omega
  nlinarith

/-- Exact closed form after the first envelope update. -/
lemma profile_formula (p t i : ℕ) :
    profile p (t+1) i = 1 + ∑ r ∈ Finset.range (p-i), bandRec p (t-r) := by
  induction t generalizing i with
  | zero => simp
  | succ t ih =>
    rw [profile_succ]
    by_cases hi : i<p
    · rw [if_pos hi,ih,ih]
      have he : p-i=(p-(i+1))+1 := by omega
      rw [he,Finset.sum_range_succ']
      have hh : (∑ x ∈ Finset.range (p-(i+1)), bandRec p (t+1-(x+1))) =
          ∑ x ∈ Finset.range (p-(i+1)), bandRec p (t-x) := by
        apply Finset.sum_congr rfl
        intro x hx
        congr 1
        omega
      rw [hh]
      have hr := bandRec_succ p t
      simp only [Nat.sub_zero] at *
      omega
    · have he : p-i=0 := by omega
      simp [hi,he]

lemma profile_head (p t : ℕ) (ht : 0<t) (_hp : 0<p) :
    profile p t 0=bandRec p t := by
  obtain ⟨s,rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : t≠0)
  rw [profile_formula,bandRec_succ]
  simp

lemma profile_head_bound (p q t : ℕ) (ht : t≤p+q) :
    (profile p t 0 : ℝ) ≤ sharpGrowth p q := by
  by_cases hp : p=0
  · subst p; simp [sharpGrowth]
  · simp only [sharpGrowth,hp,if_false]
    have hp' : 0<p := by omega
    by_cases h0 : t=0
    · subst t
      exact_mod_cast bandRec_one_le (p:=p) (by omega : 1≤p+q)
    · rw [profile_head p t (by omega) hp']
      exact_mod_cast bandRec_mono p ht

end NLA.IE13
