/- Entrywise bound patterns studied in the IE-15 formalization by Sidney Holden with Codex.
Cyclic GEPP mathematical resolution attributed to Matthew J. Colbrook. Apache-2.0. -/
import NLA.IE14.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

lemma entryMax_nonneg {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : 0 ≤ entryMax A :=
  NNReal.coe_nonneg _

lemma entry_le {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (i j : Fin n) :
    ‖A i j‖ ≤ entryMax A := by
  have h := Finset.le_sup (f := fun ij : Fin n × Fin n => ‖A ij.1 ij.2‖₊)
    (Finset.mem_univ (i,j))
  exact_mod_cast h

lemma entryMax_le {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (r : ℝ) (hr : 0 ≤ r)
    (h : ∀ i j, ‖A i j‖ ≤ r) : entryMax A ≤ r := by
  have hn : ∀ ij : Fin n × Fin n, ‖A ij.1 ij.2‖₊ ≤ (⟨r,hr⟩ : ℝ≥0) := by
    intro ij
    exact_mod_cast h ij.1 ij.2
  exact_mod_cast Finset.sup_le (fun ij (_ : ij ∈ Finset.univ) => hn ij)

lemma growth_nonneg {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℂ) : 0 ≤ growth A S :=
  div_nonneg (NNReal.coe_nonneg _) (entryMax_nonneg A)

lemma growth_le_of_entry_bounds {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℂ) (c : ℝ) (hc : 0 ≤ c)
    (ha : 0 < entryMax A)
    (h : ∀ k i j : Fin n, ‖S k.val i j‖ ≤ c * entryMax A) : growth A S ≤ c := by
  have hn : (Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
      ‖S kij.1.val kij.2.1 kij.2.2‖₊) ≤ (⟨c*entryMax A,mul_nonneg hc ha.le⟩ : ℝ≥0) := by
    apply Finset.sup_le
    intro kij _
    exact_mod_cast h kij.1 kij.2.1 kij.2.2
  apply (div_le_iff₀ ha).mpr
  exact_mod_cast hn

lemma growth_ge_entry {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℂ) (ha : 0 < entryMax A) (k i j : Fin n) :
    ‖S k.val i j‖ / entryMax A ≤ growth A S := by
  apply (div_le_div_iff_of_pos_right ha).mpr
  have h := Finset.le_sup (f := fun kij : Fin n × Fin n × Fin n =>
    ‖S kij.1.val kij.2.1 kij.2.2‖₊) (Finset.mem_univ (k,i,j))
  exact_mod_cast h

lemma cyclic_entryMax_pos {n : ℕ} (A : Mat n) (hA : IsCyclic A) :
    0 < entryMax A := by
  obtain ⟨i,j,_,_,hij,_⟩ := hA.2.1
  exact (norm_pos_iff.mpr hij).trans_le (entry_le A i j)

lemma path_zero_padding {n : ℕ} (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hp : isPath A S r) (k i j : Fin n)
    (hi : i < k ∨ j < k) : S k.val i j = 0 := by
  cases hk : k.val with
  | zero => rcases hi with hi | hj <;> simp [Fin.lt_def,hk] at *
  | succ m =>
    let p : Fin n := ⟨m,by omega⟩
    have he := (hp.2 p).2.2.2 (by dsimp [p]; omega)
    change S (m+1) = _ at he
    rw [he]
    have hh : ¬(p < i ∧ p < j) := by
      dsimp [p]
      rcases hi with hi | hj <;> simp only [Fin.lt_def] at * <;> omega
    simp [schurStep,hh]

lemma path_multiplier {n : ℕ} (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hp : isPath A S r) (k i : Fin n) (hi : k ≤ i) :
    ‖S k.val i k / S k.val (r k) k‖ ≤ 1 := by
  rw [norm_div]
  exact (div_le_one (norm_pos_iff.mpr (hp.2 k).2.1)).mpr ((hp.2 k).2.2.1 i hi)

lemma step_entry_bound {n : ℕ} (A : Mat n) (S : ℕ → Mat n)
    (r : Fin n → Fin n) (hp : isPath A S r) (k i j : Fin n)
    (hi : k < i) (hj : k < j) :
    ‖schurStep (S k.val) k (r k) i j‖ ≤
      ‖S k.val (Equiv.swap k (r k) i) j‖ + ‖S k.val (r k) j‖ := by
  rw [schurStep,if_pos ⟨hi,hj⟩]
  have hswap : k ≤ Equiv.swap k (r k) i := by
    by_cases hr : i = r k
    · subst i; simp
    · rw [Equiv.swap_apply_of_ne_of_ne hi.ne' hr]
      exact hi.le
  calc
    _ ≤ ‖S k.val (Equiv.swap k (r k) i) j‖ +
        ‖S k.val (Equiv.swap k (r k) i) k / S k.val (r k) k‖ * ‖S k.val (r k) j‖ := by
      simpa only [norm_mul] using norm_sub_le
        (S k.val (Equiv.swap k (r k) i) j)
        (S k.val (Equiv.swap k (r k) i) k / S k.val (r k) k * S k.val (r k) j)
    _ ≤ _ := by
      exact add_le_add_right (mul_le_of_le_one_left (norm_nonneg (S k.val (r k) j))
        (path_multiplier A S r hp k _ hswap)) _

end NLA.IE14
