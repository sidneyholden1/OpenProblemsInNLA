/- Subset-sum formulation of the sorted finite-front envelope.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.Profiles
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical
namespace NLA.IE13

/-- Every subset is bounded by the corresponding prefix of the envelope. -/
def HasBudget (F : Finset ℕ) (x : ℕ → ℝ) (p t : ℕ) (B : ℝ) : Prop :=
  ∀ s ⊆ F, ∑ i ∈ s, x i ≤ (profileSum p t s.card : ℝ)*B

lemma budget_singleton {F : Finset ℕ} {x : ℕ → ℝ} {p t : ℕ} {B : ℝ}
    (h : HasBudget F x p t B) {i : ℕ} (hi : i∈F) :
    x i ≤ (profile p t 0 : ℝ)*B := by
  simpa using h {i} (Finset.singleton_subset_iff.mpr hi)

lemma budget_survivors {F u : Finset ℕ} {x y : ℕ → ℝ} {p t r : ℕ} {B : ℝ}
    (_hB : 0≤B) (h : HasBudget F x p t B) (hr : r∈F)
    (hu : u.card≤p) (f : ℕ → ℕ) (hf : Set.InjOn f u)
    (hF : ∀i∈u, f i∈F) (hne : ∀i∈u, f i≠r)
    (hy : ∀i∈u, y i≤x (f i)+x r) :
    ∑i∈u, y i ≤ (profileSum p (t+1) u.card : ℝ)*B := by
  by_cases hu0 : u=∅
  · subst u; simp
  have hm : 0<u.card := Finset.card_pos.mpr (Finset.nonempty_iff_ne_empty.mpr hu0)
  let v := u.image f
  have hvcard : v.card=u.card := Finset.card_image_of_injOn hf
  have hrv : r∉v := by
    intro hh
    obtain ⟨i,hi,he⟩ := Finset.mem_image.mp hh
    exact hne i hi he
  have hvF : insert r v ⊆ F := by
    intro a ha
    rcases Finset.mem_insert.mp ha with he | he
    · simpa [he] using hr
    · obtain ⟨i,hi,rfl⟩ := Finset.mem_image.mp he
      exact hF i hi
  have hb := h (insert r v) hvF
  rw [Finset.card_insert_of_notMem hrv,hvcard,Finset.sum_insert hrv] at hb
  have hs : (∑i∈u, x (f i))=∑i∈v,x i := by
    symm
    exact Finset.sum_image (fun a ha b hb he => hf ha hb he)
  have hx := budget_singleton h hr
  have hmreal : (u.card : ℝ) = (u.card-1 : ℕ)+1 := by exact_mod_cast (show u.card=u.card-1+1 by omega)
  have hn : (0 : ℝ)≤(u.card-1 : ℕ) := Nat.cast_nonneg _
  have hpref := profileSum_update p t u.card hm hu
  have hprefR : (profileSum p (t+1) u.card : ℝ) =
      (u.card-1 : ℕ)*(profile p t 0 : ℝ)+(profileSum p t (u.card+1) : ℝ) := by
    exact_mod_cast hpref
  calc
    ∑i∈u,y i ≤ ∑i∈u,(x (f i)+x r) := Finset.sum_le_sum hy
    _ = (∑i∈v,x i)+(u.card : ℝ)*x r := by
      rw [Finset.sum_add_distrib,hs]
      simp
    _ ≤ ((profileSum p t (u.card+1) : ℝ)+
        (u.card-1 : ℕ)*(profile p t 0 : ℝ))*B := by
      have hh := mul_le_mul_of_nonneg_left hx hn
      rw [hmreal]
      nlinarith
    _ = _ := by rw [hprefR]; ring

lemma budget_next {F U : Finset ℕ} {x y : ℕ → ℝ} {p t r fresh : ℕ} {B : ℝ}
    (hB : 0≤B) (h : HasBudget F x p t B) (hr : r∈F)
    (hU : U.card≤p) (_hfu : fresh∉U) (f : ℕ → ℕ)
    (hf : Set.InjOn f U) (hF : ∀i∈U,f i∈F) (hne : ∀i∈U,f i≠r)
    (hy : ∀i∈U,y i≤x (f i)+x r) (hfresh : y fresh≤B) :
    HasBudget (insert fresh U) y p (t+1) B := by
  intro s hs
  let u := s.erase fresh
  have huU : u⊆U := by
    intro i hi
    have hh := Finset.mem_erase.mp hi
    rcases Finset.mem_insert.mp (hs hh.2) with he | he
    · exact False.elim (hh.1 he)
    · exact he
  have hu : u.card≤p := (Finset.card_le_card huU).trans hU
  have hb := budget_survivors hB h hr hu f (hf.mono huU)
    (fun i hi => hF i (huU hi)) (fun i hi => hne i (huU hi))
    (fun i hi => hy i (huU hi))
  by_cases hfs : fresh∈s
  · have he : insert fresh u=s := Finset.insert_erase hfs
    have hnf : fresh∉u := Finset.notMem_erase fresh s
    rw [←he,Finset.sum_insert hnf,Finset.card_insert_of_notMem hnf]
    have hp := profile_succ_pos p t u.card
    have hpR : (1 : ℝ)≤profile p (t+1) u.card := by exact_mod_cast hp
    rw [profileSum_succ,Nat.cast_add]
    have hh := mul_le_mul_of_nonneg_right hpR hB
    linarith
  · have he : u=s := Finset.erase_eq_of_notMem hfs
    simpa [he] using hb

end NLA.IE13
