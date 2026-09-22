/- Copyright (c) 2026 Sidney Holden. Released under Apache 2.0.
AI-assisted formalization of Matthew J. Colbrook's PF-02 counterexample.
Generic factorization, minimum, and congruence quotient facts. -/
import NLA.PF02.Definitions
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Logic.Relation
import Mathlib.Data.Quot
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Tactic

/-! Structural foundations for Colbrook's PF-02 counterexample: actual minimum,
actual congruence equivalence, and a rank bound for the full trace pairing.
AI-assisted formalization. No reference Challenge is imported. -/
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical
namespace NLA.PF02

theorem diagonal_factorization {p q : ℕ} (M : Rect p q)
    (hM : EntrywiseNonnegative M) : Nonempty (Factorization M q) := by
  let A : Fin p → Mat q := fun i => Matrix.diagonal (M i)
  let B : Fin q → Mat q := fun j => Matrix.diagonal (Pi.single j 1)
  refine ⟨⟨(A, B), ?_, ?_, ?_⟩⟩
  · intro i
    exact Matrix.PosSemidef.diagonal (hM i)
  · intro j
    apply Matrix.PosSemidef.diagonal
    intro i
    simp only [Pi.single_apply]
    split_ifs <;> norm_num
  · intro i j
    simp [A, B, Matrix.diagonal_mul_diagonal, Pi.single_apply]

theorem psd_rank_semantics_proved {p q : ℕ} (_hp : 1 ≤ p) (hq : 1 ≤ q)
    (M : Rect p q) (hM : EntrywiseNonnegative M) :
    (feasibleSizes M).Nonempty ∧ IsLeast (feasibleSizes M) (psdRank M) := by
  have hn : (feasibleSizes M).Nonempty := ⟨q, hq, diagonal_factorization M hM⟩
  exact ⟨hn, isLeast_csInf hn⟩

theorem congruent_equivalence {p q k : ℕ} (M : Rect p q) :
    Equivalence (@Congruent p q k M) := by
  constructor
  · intro F
    refine ⟨1, ?_, ?_⟩ <;> intro i <;> simp
  · intro F G h
    obtain ⟨S, hA, hB⟩ := h
    refine ⟨S⁻¹, ?_, ?_⟩
    · intro i
      rw [hA i]
      simp only [← mul_assoc, ← Matrix.transpose_mul, Units.mul_inv,
        Matrix.transpose_one, one_mul]
      simp [mul_assoc]
    · intro j
      rw [hB j]
      simp only [inv_inv, ← mul_assoc, Units.mul_inv, one_mul]
      rw [mul_assoc, ← Matrix.transpose_mul]
      simp
  · intro F G H hFG hGH
    obtain ⟨S, hSA, hSB⟩ := hFG
    obtain ⟨T, hTA, hTB⟩ := hGH
    refine ⟨S * T, ?_, ?_⟩
    · intro i
      rw [hTA i, hSA i]
      simp only [Units.val_mul, Matrix.transpose_mul, mul_assoc]
    · intro j
      rw [hTB j, hSB j]
      simp only [mul_inv_rev, Units.val_mul, Matrix.transpose_mul, mul_assoc]

theorem congruence_quotient_semantics_proved {p q k : ℕ} (M : Rect p q) :
    Equivalence (@Congruent p q k M) ∧
    (∀ F G : Factorization M k, orbitClass F = orbitClass G ↔ Congruent F G) ∧
    Topology.IsQuotientMap (@orbitClass p q k M) := by
  refine ⟨congruent_equivalence M, ?_, isQuotientMap_quot_mk⟩
  intro F G
  exact Quot.eq.trans (congruent_equivalence M).eqvGen_iff

/-- Flatten every matrix entry; no symmetry or PSD strengthening is needed. -/
theorem rank_le_factor_size_sq {p q k : ℕ} {M : Rect p q}
    (F : Factorization M k) : M.rank ≤ k * k := by
  let A : Matrix (Fin p) (Fin k × Fin k) ℝ := fun i ab => F.val.1 i ab.1 ab.2
  let B : Matrix (Fin k × Fin k) (Fin q) ℝ := fun ab j => F.val.2 j ab.2 ab.1
  have he : M = A * B := by
    ext i j
    rw [← F.property.2.2 i j]
    change (∑ a, ∑ b, F.val.1 i a b * F.val.2 j b a) =
      ∑ ab : Fin k × Fin k, F.val.1 i ab.1 ab.2 * F.val.2 j ab.2 ab.1
    rw [Fintype.sum_prod_type]
  rw [he]
  simpa only [Fintype.card_prod, Fintype.card_fin] using
    (Matrix.rank_mul_le_left A B).trans (Matrix.rank_le_card_width A)

end NLA.PF02
