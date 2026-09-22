/- Generic actual GEPP growth bounds. Formalization: Sidney Holden with OpenAI
Codex assistance. Apache 2.0. Original counterexample: George Stepaniants. -/
import NLA.IE05.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE05

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

lemma schur_entry_bound {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (k p : Fin n)
    (hkp : k ≤ p) (hp : A p k ≠ 0)
    (hmax : ∀ i, k ≤ i → |A i k| ≤ |A p k|) (i j : Fin n) :
    |schurStep A k p i j| ≤ 2 * entryMax A := by
  unfold schurStep
  split_ifs with hij
  · have hswap : k ≤ Equiv.swap k p i := by
      by_cases hik : i = k
      · simpa [hik] using hkp
      · by_cases hip : i = p
        · simp [hip]
        · simpa [Equiv.swap_apply_of_ne_of_ne hik hip] using hij.1.le
    have hc : |A (Equiv.swap k p i) k / A p k| ≤ 1 := by
      rw [abs_div]
      exact (div_le_one (abs_pos.mpr hp)).mpr (hmax _ hswap)
    calc
      |A (Equiv.swap k p i) j - A (Equiv.swap k p i) k / A p k * A p j|
          ≤ |A (Equiv.swap k p i) j| + |A (Equiv.swap k p i) k / A p k * A p j| := abs_sub _ _
      _ = |A (Equiv.swap k p i) j| + |A (Equiv.swap k p i) k / A p k| * |A p j| := by rw [abs_mul]
      _ ≤ entryMax A + 1 * entryMax A := by
        exact add_le_add (entry_le A _ _)
          (mul_le_mul hc (entry_le A _ _) (abs_nonneg _) (by norm_num))
      _ = 2 * entryMax A := by ring
  · simpa using mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) (entryMax_nonneg A)

lemma path_input_pos {n : ℕ} (hn : 0 < n) (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (p : Fin n → Fin n) (h : isPath A S p) :
    0 < entryMax A := by
  let k : Fin n := ⟨0,hn⟩
  have hp := (h.2 k).2.1
  change S 0 (p k) k ≠ 0 at hp
  rw [h.1] at hp
  exact (abs_pos.mpr hp).trans_le (entry_le A _ _)

lemma path_stage_bound {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (p : Fin n → Fin n) (h : isPath A S p) :
    ∀ k : ℕ, k < n → entryMax (S k) ≤ 2^k * entryMax A := by
  intro k
  induction k with
  | zero => intro hk; simp [h.1]
  | succ k ih =>
    intro hk
    let f : Fin n := ⟨k,by omega⟩
    have hh := h.2 f
    rw [hh.2.2.2 hk]
    have hb := entryMax_le (schurStep (S k) f (p f)) (2*entryMax (S k))
      (mul_nonneg (by norm_num) (entryMax_nonneg _))
      (schur_entry_bound _ _ _ hh.1 hh.2.1 hh.2.2.1)
    have hi := ih (by omega)
    calc
      entryMax (schurStep (S k) f (p f)) ≤ 2 * entryMax (S k) := hb
      _ ≤ 2 * (2^k * entryMax A) := by gcongr
      _ = 2^(k+1) * entryMax A := by ring

lemma path_growth_bound {n : ℕ} (hn : 0 < n) (A : Matrix (Fin n) (Fin n) ℝ)
    (S : ℕ → Matrix (Fin n) (Fin n) ℝ) (p : Fin n → Fin n) (h : isPath A S p) :
    growth A S ≤ 2^n := by
  apply growth_le_of_entry_bounds A S _ (by positivity) (path_input_pos hn A S p h)
  intro k i j
  calc
    |S k.val i j| ≤ entryMax (S k.val) := entry_le _ _ _
    _ ≤ 2^k.val * entryMax A := path_stage_bound A S p h k.val k.isLt
    _ ≤ 2^n * entryMax A := by
      gcongr
      · exact entryMax_nonneg A
      · norm_num
      · exact k.isLt.le

#assert_trust kernel path_growth_bound
end NLA.IE05
