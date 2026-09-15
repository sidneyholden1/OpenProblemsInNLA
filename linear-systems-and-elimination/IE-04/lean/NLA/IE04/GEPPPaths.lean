import NLA.IE04.GEPPKernel

/-! Existence and genuine finite-maximum semantics of all-tie GEPP paths.
Formalization: Sidney Holden with Codex assistance. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped BigOperators Classical NNReal
namespace NLA.IE04

lemma exists_first_max {n : ℕ} (A : Mat n) (k : Fin n) :
    ∃ r : Fin n, k ≤ r ∧ (∀ i, k ≤ i → |A i k| ≤ |A r k|) ∧
      ∀ i, k ≤ i → |A i k| = |A r k| → r ≤ i := by
  let s := Finset.univ.filter fun i : Fin n => k ≤ i
  have hs : s.Nonempty := ⟨k, by simp [s]⟩
  obtain ⟨r, hr, hmax⟩ := s.exists_max_image (fun i => |A i k|) hs
  let t := s.filter fun i => |A i k| = |A r k|
  have ht : t.Nonempty := ⟨r, by simp [t, hr]⟩
  obtain ⟨q, hq, hmin⟩ := t.exists_min_image id ht
  have hq' := Finset.mem_filter.mp hq
  refine ⟨q, (Finset.mem_filter.mp hq'.1).2, ?_, ?_⟩
  · intro i hi
    rw [hq'.2]
    exact hmax i (by simp [s, hi])
  · intro i hi he
    exact hmin i (by simp [t, s, hi, he, hq'.2])

def firstPivot {n : ℕ} (A : Mat n) (k : Fin n) : Fin n :=
  (exists_first_max A k).choose

lemma firstPivot_spec {n : ℕ} (A : Mat n) (k : Fin n) :
    k ≤ firstPivot A k ∧ (∀ i, k ≤ i → |A i k| ≤ |A (firstPivot A k) k|) ∧
      ∀ i, k ≤ i → |A i k| = |A (firstPivot A k) k| → firstPivot A k ≤ i :=
  (exists_first_max A k).choose_spec

lemma firstPivot_nonzero {n : ℕ} (A : Mat n) (k : Fin n)
    (hA : ActiveInjective A k.val) : A (firstPivot A k) k ≠ 0 := by
  obtain ⟨r, hr, hn⟩ := active_column_nonzero A k hA
  have hm := (firstPivot_spec A k).2.1 r hr
  exact abs_pos.mp ((abs_pos.mpr hn).trans_le hm)

def greedyStates {n : ℕ} (A : Mat n) : ℕ → Mat n
  | 0 => A
  | k+1 => if h : k < n then
      schurStep (greedyStates A k) ⟨k,h⟩ (firstPivot (greedyStates A k) ⟨k,h⟩) else 0

def greedySchedule {n : ℕ} (A : Mat n) : Schedule n :=
  fun k => firstPivot (greedyStates A k.val) k

lemma states_greedy {n : ℕ} (A : Mat n) (k : ℕ) :
    states A (greedySchedule A) k = greedyStates A k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    simp only [states, greedyStates]
    split_ifs with hk
    · simp [ih, greedySchedule]
    · rfl

lemma greedy_active {n : ℕ} (A : Mat n) (hA : A.det ≠ 0) :
    ∀ k : ℕ, k ≤ n → ActiveInjective (greedyStates A k) k := by
  intro k
  induction k with
  | zero => intro _; exact (active_zero_iff A).mpr hA
  | succ k ih =>
    intro hk
    have hkn : k < n := by omega
    have ha := ih (by omega)
    rw [greedyStates, dif_pos hkn]
    exact (active_schur_iff _ ⟨k,hkn⟩ _ (firstPivot_spec _ _).1
      (firstPivot_nonzero _ _ ha)).mpr ha

lemma greedy_first_legal {n : ℕ} (A : Mat n) (hA : A.det ≠ 0) :
    IsFirstLegal A (greedySchedule A) := by
  constructor
  · intro k
    rw [states_greedy]
    exact ⟨(firstPivot_spec _ _).1,
      firstPivot_nonzero _ _ (greedy_active A hA k.val k.isLt.le),
      (firstPivot_spec _ _).2.1⟩
  · intro k i hi he
    rw [states_greedy] at he
    exact (firstPivot_spec _ _).2.2 i hi he

lemma states_congr_prefix {n : ℕ} (A : Mat n) (π τ : Schedule n) (k : ℕ)
    (h : ∀ j : Fin n, j.val < k → π j = τ j) : states A π k = states A τ k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    have hh : states A π k = states A τ k := ih (fun j hj => h j (by omega))
    simp only [states]
    split_ifs with hk
    · rw [hh, h ⟨k,hk⟩ (by simp)]
    · rfl

lemma first_legal_unique {n : ℕ} (A : Mat n) (π τ : Schedule n)
    (hp : IsFirstLegal A π) (ht : IsFirstLegal A τ) : π = τ := by
  have he : ∀ k : ℕ, ∀ j : Fin n, j.val < k → π j = τ j := by
    intro k
    induction k with
    | zero => intro j hj; omega
    | succ k ih =>
      intro j hj
      by_cases hjk : j.val < k
      · exact ih j hjk
      have hjk : j.val = k := by omega
      have hs : states A π j.val = states A τ j.val :=
        states_congr_prefix A π τ j.val (fun i hi => ih i (by omega))
      have hpm := (hp.1 j).2.2 (τ j) (ht.1 j).1
      have htm := (ht.1 j).2.2 (π j) (hp.1 j).1
      rw [← hs] at htm
      have hab := le_antisymm hpm htm
      have hpt := hp.2 j (τ j) (ht.1 j).1 hab
      have htp := ht.2 j (π j) (hp.1 j).1 (by simpa [← hs] using hab.symm)
      exact le_antisymm hpt htp
  funext j
  exact he n j j.isLt

lemma existsUnique_first_legal {n : ℕ} (A : Mat n) (hA : A.det ≠ 0) :
    ∃! π : Schedule n, IsFirstLegal A π := by
  exact ⟨greedySchedule A, greedy_first_legal A hA,
    fun π hp => first_legal_unique A π _ hp (greedy_first_legal A hA)⟩

lemma det_ne_zero_of_pivots {n : ℕ} (A : Mat n) (π : Schedule n)
    (hp : ∀ k : Fin n, k ≤ π k ∧ states A π k.val (π k) k ≠ 0) : A.det ≠ 0 := by
  apply (active_zero_iff A).mp
  have ha : ActiveInjective (states A π 0) 0 := by
    apply Nat.decreasingInduction' (n := n) (m := 0)
      (P := fun k => ActiveInjective (states A π k) k) ?_ (Nat.zero_le n)
      (active_end _)
    intro k hk _ ih
    have h := hp ⟨k,hk⟩
    rw [states, dif_pos hk] at ih
    exact (active_schur_iff _ ⟨k,hk⟩ _ h.1 h.2).mp ih
  exact ha

lemma strict_legal_unique {n : ℕ} (A : Mat n) (τ : Schedule n)
    (ht : IsLegal A τ)
    (hstrict : ∀ k i : Fin n, k ≤ i → i ≠ τ k →
      |states A τ k.val i k| < |states A τ k.val (τ k) k|)
    (π : Schedule n) (hp : IsLegal A π) : π = τ := by
  have he : ∀ k : ℕ, ∀ j : Fin n, j.val < k → π j = τ j := by
    intro k
    induction k with
    | zero => intro j hj; omega
    | succ k ih =>
      intro j hj
      by_cases hjk : j.val < k
      · exact ih j hjk
      have hjk : j.val = k := by omega
      have hs : states A π j.val = states A τ j.val :=
        states_congr_prefix A π τ j.val (fun i hi => ih i (by omega))
      by_contra hn
      have hl := hstrict j (π j) (hp j).1 hn
      have hm := (hp j).2.2 (τ j) (ht j).1
      rw [hs] at hm
      exact (not_lt_of_ge hm) hl
  funext j
  exact he n j j.isLt

end NLA.IE04
