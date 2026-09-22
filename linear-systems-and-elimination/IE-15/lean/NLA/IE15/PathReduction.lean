/- Permutation reduction for actual all-choice rook paths. Apache-2.0.
Mathematical reduction: George Stepaniants; formalization: Sidney Holden/Codex. -/
import NLA.IE15.Bounds
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

def futurePerm {n : ℕ} (r : Fin n → Fin n) (k : ℕ) : ℕ → Equiv.Perm (Fin n)
  | 0 => Equiv.refl _
  | m+1 => if h : k < n then
      (futurePerm r (k+1) m).trans (Equiv.swap ⟨k,h⟩ (r ⟨k,h⟩))
    else Equiv.refl _

lemma futurePerm_fixes {n : ℕ} (r : Fin n → Fin n) (hr : ∀ k, k ≤ r k)
    (k m : ℕ) (i : Fin n) (hi : i.val < k) : futurePerm r k m i = i := by
  induction m generalizing k with
  | zero => rfl
  | succ m ih =>
    simp only [futurePerm]
    split_ifs with hk
    · change Equiv.swap ⟨k,hk⟩ (r ⟨k,hk⟩) (futurePerm r (k+1) m i) = i
      rw [ih (k+1) (by omega)]
      apply Equiv.swap_apply_of_ne_of_ne
      · intro h; have := congrArg Fin.val h; simp at this; omega
      · intro h; have hh := hr ⟨k,hk⟩; rw [← h] at hh; exact (not_le_of_gt hi) hh
    · rfl

def pathPerm {n : ℕ} (r : Fin n → Fin n) (k : ℕ) := futurePerm r k (n-k)

lemma pathPerm_step {n : ℕ} (r : Fin n → Fin n) (k : Fin n) :
    pathPerm r k.val = (pathPerm r (k.val+1)).trans (Equiv.swap k (r k)) := by
  unfold pathPerm
  have he : n-k.val = (n-(k.val+1))+1 := by omega
  rw [he, futurePerm]
  simp [k.isLt]

lemma pathPerm_fixes {n : ℕ} (r : Fin n → Fin n) (hr : ∀ k, k ≤ r k)
    (k : ℕ) (i : Fin n) (hi : i.val < k) : pathPerm r k i = i :=
  futurePerm_fixes r hr k (n-k) i hi

lemma pathPerm_pivot {n : ℕ} (r : Fin n → Fin n) (hr : ∀ k, k ≤ r k)
    (k : Fin n) : pathPerm r k.val k = r k := by
  rw [pathPerm_step]
  change Equiv.swap k (r k) (pathPerm r (k.val+1) k) = r k
  rw [pathPerm_fixes r hr _ k (by omega)]
  simp

lemma perm_preserves_active {n : ℕ} (e : Equiv.Perm (Fin n)) (k : ℕ)
    (he : ∀ i : Fin n, i.val < k → e i = i) (i : Fin n) :
    k ≤ (e i).val ↔ k ≤ i.val := by
  constructor
  · intro h
    by_contra hi
    have hei := he i (by omega)
    rw [hei] at h
    omega
  · intro h
    by_contra hi
    have hh := he (e i) (by omega)
    have hfix : e i = i := e.injective hh
    rw [hfix] at hi
    omega

lemma reindex_entryMax {n : ℕ} (A : Mat n) (e f : Equiv.Perm (Fin n)) :
    entryMax (fun i j => A (e i) (f j)) = entryMax A := by
  apply le_antisymm
  · exact entryMax_le _ _ (entryMax_nonneg A) (fun i j => entry_le A _ _)
  · apply entryMax_le _ _ (entryMax_nonneg _)
    intro i j
    simpa using entry_le (fun i j => A (e i) (f j)) (e.symm i) (f.symm j)

lemma reindex_schur {n : ℕ} (A : Mat n) (k r c : Fin n)
    (e f : Equiv.Perm (Fin n))
    (he : ∀ i : Fin n, i.val < k.val+1 → e i = i)
    (hf : ∀ i : Fin n, i.val < k.val+1 → f i = i) :
    schurStep (fun i j => A (Equiv.swap k r (e i)) (Equiv.swap k c (f j))) k k k =
      fun i j => schurStep A k r c (e i) (f j) := by
  funext i j
  have hi : k < e i ↔ k < i := by
    simpa only [Fin.lt_def, Nat.succ_le_iff] using perm_preserves_active e (k.val+1) he i
  have hj : k < f j ↔ k < j := by
    simpa only [Fin.lt_def, Nat.succ_le_iff] using perm_preserves_active f (k.val+1) hf j
  have hek := he k (by omega)
  have hfk := hf k (by omega)
  simp [schurStep, hi, hj, hek, hfk]

/-- Reorder each actual active state by the remaining pivot swaps. -/
def diagonalized {n : ℕ} (S : ℕ → Mat n) (r c : Fin n → Fin n) (k : ℕ) : Mat n :=
  fun i j => S k (pathPerm r k i) (pathPerm c k j)

lemma diagonalized_path {n : ℕ} (A : Mat n) (S : ℕ → Mat n)
    (r c : Fin n → Fin n) (h : isPath A S r c) :
    isPath (diagonalized S r c 0) (diagonalized S r c) id id := by
  have hr : ∀ k, k ≤ r k := fun k => (h.2 k).1
  have hc : ∀ k, k ≤ c k := fun k => (h.2 k).2.1
  constructor
  · rfl
  intro k
  have hh := h.2 k
  refine ⟨le_rfl, le_rfl, ?_, ?_, ?_, ?_⟩
  · simpa [diagonalized, pathPerm_pivot r hr, pathPerm_pivot c hc] using hh.2.2.1
  · intro i hi
    have hri : k ≤ pathPerm r k.val i := by
      exact (perm_preserves_active _ k.val (pathPerm_fixes r hr k.val) i).mpr hi
    simpa [diagonalized, pathPerm_pivot r hr, pathPerm_pivot c hc] using hh.2.2.2.1 _ hri
  · intro j hj
    have hcj : k ≤ pathPerm c k.val j := by
      exact (perm_preserves_active _ k.val (pathPerm_fixes c hc k.val) j).mpr hj
    simpa [diagonalized, pathPerm_pivot r hr, pathPerm_pivot c hc] using hh.2.2.2.2.1 _ hcj
  · intro hk
    unfold diagonalized
    rw [hh.2.2.2.2.2 hk]
    rw [pathPerm_step r k, pathPerm_step c k]
    exact (reindex_schur (S k.val) k (r k) (c k)
      (pathPerm r (k.val+1)) (pathPerm c (k.val+1))
      (pathPerm_fixes r hr _) (pathPerm_fixes c hc _)).symm

end NLA.IE15
