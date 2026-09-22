/- Entrywise bounds adapted from the IE-05 formalization by Sidney Holden with Codex.
Rook-pivoting mathematical resolution: George Stepaniants. Apache-2.0. -/
import NLA.IE15.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

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

lemma growth_nonneg {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) : 0 ≤ growth A S :=
  div_nonneg (NNReal.coe_nonneg _) (entryMax_nonneg A)

lemma growth_le_of_entry_bounds {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (c : ℝ) (hc : 0 ≤ c)
    (ha : 0 < entryMax A)
    (h : ∀ k i j : Fin n, |S k.val i j| ≤ c * entryMax A) : growth A S ≤ c := by
  have hn : (Finset.univ.sup fun kij : Fin n × Fin n × Fin n =>
      ‖S kij.1.val kij.2.1 kij.2.2‖₊) ≤ (⟨c*entryMax A,mul_nonneg hc ha.le⟩ : ℝ≥0) := by
    apply Finset.sup_le
    intro kij _
    exact_mod_cast h kij.1 kij.2.1 kij.2.2
  apply (div_le_iff₀ ha).mpr
  exact_mod_cast hn

lemma growth_ge_entry {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (ha : 0 < entryMax A) (k i j : Fin n) :
    |S k.val i j| / entryMax A ≤ growth A S := by
  apply (div_le_div_iff_of_pos_right ha).mpr
  have h := Finset.le_sup (f := fun kij : Fin n × Fin n × Fin n =>
    ‖S kij.1.val kij.2.1 kij.2.2‖₊) (Finset.mem_univ (k,i,j))
  exact_mod_cast h

end NLA.IE15
