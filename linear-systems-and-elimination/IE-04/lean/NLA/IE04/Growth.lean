import NLA.IE04.GEPPPaths

/-! Actual finite entry maxima and all-schedule suprema. The elementary entry
bounds are adapted from the prior IE-05 proof (Sidney Holden, Codex assistance).
Original IE-04 mathematics: George Stepaniants. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped BigOperators Classical NNReal
namespace NLA.IE04

lemma entryMax_nonneg {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : 0 ≤ entryMax A :=
  NNReal.coe_nonneg _

lemma entry_le {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) :
    |A i j| ≤ entryMax A := by
  have h := Finset.le_sup (f := fun ij : Fin n × Fin n => ‖A ij.1 ij.2‖₊)
    (Finset.mem_univ (i,j))
  exact_mod_cast h

lemma entryMax_le {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (r : ℝ) (hr : 0 ≤ r)
    (h : ∀ i j, |A i j| ≤ r) : entryMax A ≤ r := by
  have hn : ∀ ij : Fin n × Fin n, ‖A ij.1 ij.2‖₊ ≤ (⟨r,hr⟩ : ℝ≥0) := by
    intro ij
    exact_mod_cast h ij.1 ij.2
  exact_mod_cast Finset.sup_le (fun ij (_ : ij ∈ Finset.univ) => hn ij)

lemma path_input_pos {n : ℕ} (hn : 0 < n) (A : Mat n)
    (π : Schedule n) (h : IsLegal A π) : 0 < entryMax A := by
  let k : Fin n := ⟨0,hn⟩
  have hp := (h k).2.1
  change A (π k) k ≠ 0 at hp
  exact (abs_pos.mpr hp).trans_le (entry_le A _ _)

lemma pathGrowth_ge_entry {n : ℕ} (A : Mat n) (π : Schedule n)
    (ha : 0 < entryMax A) (k i j : Fin n) :
    |states A π k.val i j| / entryMax A ≤ pathGrowth A π := by
  apply (div_le_div_iff_of_pos_right ha).mpr
  have h := Finset.le_sup (f := fun kij : Fin n × Fin n × Fin n =>
    ‖states A π kij.1.val kij.2.1 kij.2.2‖₊) (Finset.mem_univ (k,i,j))
  exact_mod_cast h

lemma pathGrowth_ge_one {n : ℕ} (hn : 0 < n) (A : Mat n)
    (π : Schedule n) (ha : 0 < entryMax A) : 1 ≤ pathGrowth A π := by
  have hm : entryMax A ≤
      (((Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
        ‖states A π kij.1.val kij.2.1 kij.2.2‖₊) : ℝ≥0) : ℝ) := by
    apply entryMax_le _ _ (NNReal.coe_nonneg _)
    intro i j
    have h := Finset.le_sup (f := fun kij : Fin n × Fin n × Fin n =>
      ‖states A π kij.1.val kij.2.1 kij.2.2‖₊) (Finset.mem_univ (⟨0,hn⟩,i,j))
    exact_mod_cast h
  exact (le_div_iff₀ ha).mpr (by simpa using hm)

lemma growthValues_finite {n : ℕ} (A : Mat n) : (growthValues A).Finite := by
  have he : growthValues A = pathGrowth A '' {π : Schedule n | IsLegal A π} := by
    ext g
    simp only [growthValues, Set.mem_ofPred_eq, Set.mem_image]
    constructor
    · rintro ⟨π,hp,hg⟩; exact ⟨π,hp,hg.symm⟩
    · rintro ⟨π,hp,hg⟩; exact ⟨π,hp,hg.symm⟩
  rw [he]
  exact (Set.toFinite _).image _

lemma growthValues_nonempty {n : ℕ} (A : Mat n) (π : Schedule n)
    (hp : IsLegal A π) : (growthValues A).Nonempty :=
  ⟨pathGrowth A π, π, hp, rfl⟩

lemma ppGrowth_greatest {n : ℕ} (A : Mat n) (h : (growthValues A).Nonempty) :
    IsGreatest (growthValues A) (ppGrowth A) :=
  ⟨h.csSup_mem (growthValues_finite A),
    fun _ hg => le_csSup (growthValues_finite A).bddAbove hg⟩

lemma ppGrowth_eq_of_unique {n : ℕ} (A : Mat n) (π : Schedule n)
    (hp : IsLegal A π) (hu : ∀ τ, IsLegal A τ → τ = π) :
    ppGrowth A = pathGrowth A π := by
  have he : growthValues A = {pathGrowth A π} := by
    ext g
    constructor
    · rintro ⟨τ,hτ,rfl⟩
      simp [hu τ hτ]
    · intro hg
      exact ⟨π,hp,Set.mem_singleton_iff.mp hg⟩
  simp [ppGrowth, he]

lemma growth_semantics_proved {n : ℕ} (hn : 1 ≤ n) (A : Mat n) (hA : A.det ≠ 0) :
    0 < entryMax A ∧ (growthValues A).Nonempty ∧ (growthValues A).Finite ∧
    BddAbove (growthValues A) ∧ IsGreatest (growthValues A) (ppGrowth A) ∧
    1 ≤ ppGrowth A ∧ (∃! π : Schedule n, IsFirstLegal A π) ∧
    (∀ t : ℝ, t < ppGrowth A ↔ ∃ π : Schedule n, IsLegal A π ∧ t < pathGrowth A π) := by
  obtain ⟨π,hπ,hu⟩ := existsUnique_first_legal A hA
  have ha := path_input_pos hn A π hπ.1
  have hne := growthValues_nonempty A π hπ.1
  have hg := ppGrowth_greatest A hne
  refine ⟨ha,hne,growthValues_finite A,(growthValues_finite A).bddAbove,hg,
    (pathGrowth_ge_one hn A π ha).trans (hg.2 ⟨π,hπ.1,rfl⟩),⟨π,hπ,hu⟩,?_⟩
  intro t
  constructor
  · intro ht
    obtain ⟨τ,hτ,he⟩ := hg.1
    exact ⟨τ,hτ,by simpa [he] using ht⟩
  · rintro ⟨τ,hτ,ht⟩
    exact ht.trans_le (hg.2 ⟨τ,hτ,rfl⟩)

end NLA.IE04
