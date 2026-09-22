/- MI-04: two exact admissible weights isolate each off-diagonal modulus.
Formalization: Sidney Holden with OpenAI Codex. Apache-2.0. -/
import NLA.MI04.Threshold
import NLA.MI04.WeightedComparison
import NLA.MI04.BasisTransport
set_option autoImplicit false
open scoped Matrix ComplexConjugate BigOperators
noncomputable section
namespace NLA.MI04

lemma weighted_row_eq {n : ℕ} [NeZero n] {X : Mat n} (hX : UniversalBlockNorm X)
    (i : Fin n) (e : Fin n → ℝ) (hi : e i=2) (he : ∀ j, 0<e j)
    (he2 : ∀ j, j≠i → e j<2) : rowWeight X i e = rowWeight Xᴴ i e := by
  have hle {Y : Mat n} (hY : UniversalBlockNorm Y) : rowWeight Yᴴ i e ≤ rowWeight Y i e :=
    threshold_compare _ _ (rowWeight_nonneg Y i e he) (rowWeight_nonneg Yᴴ i e he)
      (fun s hs hsmall => weighted_threshold hY i e s hi he he2 hs hsmall)
  exact le_antisymm (by simpa using hle (universal_adjoint hX)) (hle hX)

lemma universal_coordinate_symmetry {n : ℕ} [NeZero n] {X : Mat n}
    (hX : UniversalBlockNorm X) (i j : Fin n) (hij : i ≠ j) : ‖X i j‖ = ‖X j i‖ := by
  classical
  obtain ⟨hi,he,he2⟩ := baseWeights_admissible i
  obtain ⟨hi',he',he2'⟩ := changedWeights_admissible i j hij
  have h0 := weighted_row_eq hX i (baseWeights i) hi he he2
  have h1 := weighted_row_eq hX i (changedWeights i j) hi' he' he2'
  simp only [rowWeight,Matrix.conjTranspose_apply,norm_star] at h0 h1
  have hh := two_weight_equalities (fun k => ‖X i k‖^2) (fun k => ‖X k i‖^2)
    i j hij h0 h1
  nlinarith [norm_nonneg (X i j),norm_nonneg (X j i)]

theorem universal_pair_proved {n : ℕ} [NeZero n] {X : Mat n}
    (hX : UniversalBlockNorm X) : PairModulusSymmetry X := by
  apply coordinate_symmetry_to_pair X
  intro U hU i j hij
  let V : unitary (Mat n) := ⟨U,hU⟩
  exact universal_coordinate_symmetry (universal_unitary hX V) i j hij

#assert_trust kernel universal_pair_proved
#print axioms universal_pair_proved
end NLA.MI04
