import NLA.IE04.GEPPPaths

/-! Reverse actual Schur steps to realize arbitrary trailing blocks. This supplies
nonvanishing witnesses for generic pivot and tie polynomials, rather than
assuming that a single diagonal matrix witnesses every off-diagonal comparison.
Formalization: Sidney Holden with Codex assistance. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped Classical
namespace NLA.IE04

def Padded {n : ℕ} (A : Mat n) (k : ℕ) : Prop :=
  ∀ i j, i.val < k ∨ j.val < k → A i j = 0

def restore {n : ℕ} (B : Mat n) (k r : Fin n) : Mat n := fun i j =>
  if Equiv.swap k r i = k then (if j=k then 1 else 0) else B (Equiv.swap k r i) j

lemma restore_pivot {n : ℕ} (B : Mat n) (k r : Fin n) : restore B k r r k = 1 := by
  simp [restore]

lemma restore_schur {n : ℕ} (B : Mat n) (k r : Fin n)
    (hB : Padded B (k.val+1)) : schurStep (restore B k r) k r = B := by
  ext i j
  by_cases hi : k < i
  · by_cases hj : k < j
    · have hik : i ≠ k := ne_of_gt hi
      have hjk : j ≠ k := ne_of_gt hj
      have hzero : B i k = 0 := hB i k (Or.inr (Nat.lt_succ_self _))
      simp [schurStep, hi, hj, restore, hik, hjk, hzero]
    · have hb : B i j = 0 := hB i j (Or.inr (by have hh : j.val ≤ k.val := le_of_not_gt hj; omega))
      simp [schurStep, hj, hb]
  · have hb : B i j = 0 := hB i j (Or.inl (by have hh : i.val ≤ k.val := le_of_not_gt hi; omega))
    simp [schurStep, hi, hb]

lemma restore_padded {n : ℕ} (B : Mat n) (k r : Fin n)
    (hr : k ≤ r) (hB : Padded B (k.val+1)) : Padded (restore B k r) k.val := by
  intro i j hij
  rcases hij with hi | hj
  · have hik : i ≠ k := by intro h; subst i; omega
    have hir : i ≠ r := by intro h; subst i; have : k.val ≤ r.val := hr; omega
    simp [restore, Equiv.swap_apply_of_ne_of_ne hik hir, hik,
      hB i j (Or.inl (by omega))]
  · have hjk : j ≠ k := by intro h; subst j; omega
    simp only [restore]
    split_ifs
    · simp
    · exact hB _ j (Or.inr (by omega))

def restorePrefix {n : ℕ} (π : Schedule n) (B : Mat n) : ℕ → Mat n
  | 0 => B
  | k+1 => if h : k < n then restorePrefix π (restore B ⟨k,h⟩ (π ⟨k,h⟩)) k else B

lemma restorePrefix_spec {n : ℕ} (π : Schedule n) (hπ : ∀ j, j ≤ π j)
    (k : ℕ) (hk : k ≤ n) (B : Mat n) (hB : Padded B k) :
    states (restorePrefix π B k) π k = B ∧
      ∀ j : Fin n, j.val < k → states (restorePrefix π B k) π j.val (π j) j = 1 := by
  induction k generalizing B with
  | zero => exact ⟨rfl, by intro j hj; omega⟩
  | succ k ih =>
    have hkn : k < n := by omega
    let f : Fin n := ⟨k,hkn⟩
    have hr := restore_padded B f (π f) (hπ f) hB
    have hi := ih (by omega) (restore B f (π f)) hr
    rw [restorePrefix, dif_pos hkn]
    constructor
    · rw [states, dif_pos hkn, hi.1]
      exact restore_schur B f (π f) hB
    · intro j hj
      by_cases hjk : j.val < k
      · exact hi.2 j hjk
      have hval : j.val = k := by omega
      have hjf : j = f := Fin.ext hval
      subst j
      rw [hi.1]
      exact restore_pivot B f (π f)

lemma exists_prefix_realization {n : ℕ} (π : Schedule n) (hπ : ∀ j, j ≤ π j)
    (k : ℕ) (hk : k ≤ n) (B : Mat n) (hB : Padded B k) :
    ∃ A : Mat n, states A π k = B ∧
      ∀ j : Fin n, j.val < k → states A π j.val (π j) j = 1 :=
  ⟨restorePrefix π B k, restorePrefix_spec π hπ k hk B hB⟩

end NLA.IE04
