/- Fixed orthogonal pinching is exactly a rectangular sign design.
Mathematical source: Matthew J. Colbrook. Formalization: Sidney Holden with
OpenAI Codex assistance. Apache-2.0. -/
import NLA.MI08.Definitions
import Mathlib.Data.Matrix.Basis
import Mathlib.Tactic
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MI08

lemma conjugate_unit {d : ℕ} (U : Mat d) (a b i j : Fin d) :
    (U * (Matrix.single a b 1 : Mat d) * U.transpose) i j = U i a * U j b := by
  simp [Matrix.mul_apply, Matrix.single, ite_and, mul_ite, ite_mul]

lemma factors_diagonal {q d : ℕ} {U : Fin q → Mat d} (hU : FixedPinching U) :
    ∀ r i j, i ≠ j → U r i j = 0 := by
  intro r i j hij
  have h := congr_fun (congr_fun (hU.2.2 (Matrix.single j j 1)) i) i
  have hs : (1 / (q : ℝ)) * ∑ r, U r i j * U r i j = 0 := by
    simpa [pinching,Matrix.single_apply,Matrix.sum_apply,conjugate_unit,hij.symm] using h.symm
  have hq : (q : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hU.1)
  have hz : ∑ r, U r i j * U r i j = 0 := (mul_eq_zero.mp hs).resolve_left (one_div_ne_zero hq)
  exact (Finset.sum_mul_self_eq_zero_iff _ _).mp hz r (Finset.mem_univ r)

lemma factor_signs {q d : ℕ} {U : Fin q → Mat d} (hU : FixedPinching U) :
    ∀ r j, U r j j = 1 ∨ U r j j = -1 := by
  intro r j
  have h := congr_fun (congr_fun (hU.2.1 r) j) j
  have hs : U r j j * U r j j = 1 := by
    have hsum : ∑ k, U r k j * U r k j = U r j j * U r j j := by
      apply Finset.sum_eq_single j
      · intro k _ hkj; rw [factors_diagonal hU r k j hkj]; simp
      · simp
    simpa [Matrix.mul_apply, hsum] using h
  rcases (mul_self_eq_one_iff).mp hs with h | h
  · exact Or.inl h
  · exact Or.inr h

lemma design_to_fixed {q d : ℕ} (hq : 0 < q)
    {H : Matrix (Fin q) (Fin d) ℤ} (hH : SignDesign H) :
    ∃ U : Fin q → Mat d, FixedPinching U := by
  let U : Fin q → Mat d := fun r => Matrix.diagonal fun j => (H r j : ℝ)
  have hgram (i j : Fin d) : ∑ r, (H r i : ℝ) * (H r j : ℝ) =
      (q : ℝ) * (if i = j then 1 else 0) := by
    have h := congr_fun (congr_fun hH.2 i) j
    simp only [Matrix.mul_apply,Matrix.transpose_apply,Matrix.smul_apply,smul_eq_mul,
      Matrix.one_apply] at h
    exact_mod_cast h
  have hq0 : (q : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hq)
  refine ⟨U,hq,?_,?_⟩
  · intro r
    ext i j
    simp only [U,Matrix.diagonal_transpose,Matrix.diagonal_mul_diagonal,Matrix.diagonal_apply,
      Matrix.one_apply]
    split_ifs with hij
    · subst j
      obtain hi | hi := hH.1 r i <;> simp [hi]
    · rfl
  · intro X
    ext i j
    simp only [U,Matrix.diagonal_transpose,Matrix.smul_apply,smul_eq_mul,Matrix.sum_apply,
      Matrix.mul_diagonal,Matrix.diagonal_mul]
    calc pinching X i j = (if i = j then 1 else 0) * X i j := by
           by_cases h : i = j <;> simp [pinching,h]
         _ = (1 / (q : ℝ)) * ((∑ r, (H r i : ℝ) * (H r j : ℝ)) * X i j) := by
           rw [hgram]; field_simp
         _ = (1 / (q : ℝ)) * ∑ r, ((H r i : ℝ) * X i j) * (H r j : ℝ) := by
           rw [Finset.sum_mul]; congr 1; apply Finset.sum_congr rfl; intro r _; ring

lemma fixed_to_design {q d : ℕ} {U : Fin q → Mat d} (hU : FixedPinching U) :
    ∃ H : Matrix (Fin q) (Fin d) ℤ, SignDesign H := by
  classical
  let H : Matrix (Fin q) (Fin d) ℤ := fun r j => if U r j j = 1 then 1 else -1
  have hc (r : Fin q) (j : Fin d) : (H r j : ℝ) = U r j j := by
    obtain h | h := factor_signs hU r j <;> norm_num [H,h]
  refine ⟨H,?_,?_⟩
  · intro r j; dsimp [H]; split_ifs <;> simp
  · ext i j
    have h := congr_fun (congr_fun (hU.2.2 (Matrix.single i j 1)) i) j
    have hs : (if i = j then (1 : ℝ) else 0) =
        (1 / (q : ℝ)) * ∑ r, U r i i * U r j j := by
      by_cases hij : i = j
      · subst j; simpa [pinching,Matrix.single_apply,Matrix.sum_apply,conjugate_unit] using h
      · simpa [pinching,Matrix.diagonal_apply,Matrix.single_apply,Matrix.sum_apply,conjugate_unit,hij] using h
    have hq : (q : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hU.1)
    have he : ∑ r, (H r i : ℝ) * (H r j : ℝ) = (q : ℝ) * (if i = j then 1 else 0) := by
      simp_rw [hc]
      calc _ = (q : ℝ) * ((1 / (q : ℝ)) * ∑ r, U r i i * U r j j) := by field_simp
           _ = _ := by rw [← hs]
    simp only [Matrix.mul_apply,Matrix.transpose_apply,Matrix.smul_apply,smul_eq_mul,Matrix.one_apply]
    exact_mod_cast he

theorem fixed_sign_equivalence (d q : ℕ) (_hd : 0 < d) (hq : 0 < q) :
    (∃ U : Fin q → Mat d, FixedPinching U) ↔
    ∃ H : Matrix (Fin q) (Fin d) ℤ, SignDesign H := by
  exact ⟨fun ⟨_,hU⟩ => fixed_to_design hU, fun ⟨_,hH⟩ => design_to_fixed hq hH⟩
end NLA.MI08
