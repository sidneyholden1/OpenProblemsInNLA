import NLA.PF02.Structural

/- Complete PF-02 solution exports, independent of Challenge. -/
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical
namespace NLA.PF02

/-- Nonempty minimum semantics for every admissible nonnegative matrix. -/
theorem psd_rank_semantics {p q : ℕ} (hp : 1 ≤ p) (hq : 1 ≤ q)
    (M : Rect p q) (hM : EntrywiseNonnegative M) :
    (feasibleSizes M).Nonempty ∧ IsLeast (feasibleSizes M) (psdRank M) := psd_rank_semantics_proved hp hq M hM

/-- The invertible congruences give exactly the quotient relation and topology. -/
theorem congruence_quotient_semantics {p q k : ℕ} (M : Rect p q) :
    Equivalence (@Congruent p q k M) ∧
    (∀ F G : Factorization M k, orbitClass F = orbitClass G ↔ Congruent F G) ∧
    Topology.IsQuotientMap (@orbitClass p q k M) := congruence_quotient_semantics_proved M

/-- Every scalar and matrix witness fact is a conclusion, never a premise. -/
theorem witness_exact_data :
    (∀ i j, 0 < witnessM i j) ∧ witnessM.det = 8192 ∧ witnessM.rank = 6 ∧
    (∀ i, (witnessFactors i).PosDef ∧ (reflectedFactors i).PosDef) ∧
    IsPSDFactorization witnessM witnessTuple ∧
    IsPSDFactorization witnessM reflectedTuple ∧
    (rowCoordinates witnessFactors).det = 32 ∧
    (rowCoordinates reflectedFactors).det = -32 ∧
    IsLeast (feasibleSizes witnessM) 3 ∧ psdRank witnessM = 3 := witness_exact_data_proved

/-- Full trace pairing in six symmetric coordinates, for arbitrary factors. -/
theorem trace_coordinate_bridge (A B : Fin 6 → Mat 3)
    (hA : ∀ i, (A i).IsSymm) (hB : ∀ j, (B j).IsSymm) :
    (fun i j => (A i * B j).trace) =
      rowCoordinates A * traceMetric * (rowCoordinates B).transpose := trace_coordinate_bridge_proved A B hA hB

/-- Fixed-dimensional polynomial identity for every real S, even singular S.
It yields orientation preservation for all invertible S, not only orthogonal S. -/
theorem congruence_coordinate_identity (S : Mat 3) :
    (∀ A : Fin 6 → Mat 3, (∀ i, (A i).IsSymm) →
      rowCoordinates (fun i => S.transpose * A i * S) =
        rowCoordinates A * congruenceCoordinates S) ∧
    (congruenceCoordinates S).det = S.det ^ 4 := ⟨fun A hA => congruence_coordinate_action S A hA, congruence_coordinate_det S⟩

/-- Every actual factorization has nonzero determinant. None is removed. -/
theorem orientation_invariant :
    (∀ F : Factorization witnessM 3, (rowCoordinates F.val.1).det ≠ 0) ∧
    Continuous (fun F : Factorization witnessM 3 => rowOrientation F.val.1) ∧
    (∀ F G : Factorization witnessM 3, Congruent F G →
      rowOrientation F.val.1 = rowOrientation G.val.1) := orientation_invariant_proved

/-- Actual continuous descent to the entire orbit space, with both signs attained. -/
theorem quotient_orientation :
    ∃ orientation : OrbitSpace witnessM 3 → ℝ,
      Continuous orientation ∧
      (∀ F : Factorization witnessM 3, orientation (orbitClass F) = rowOrientation F.val.1) ∧
      Set.range orientation = {(-1 : ℝ), 1} := quotient_orientation_proved

/-- An admissible original instance has a nonempty disconnected quotient. -/
theorem disconnected_counterexample :
    EntrywiseNonnegative witnessM ∧ witnessM.rank = 3 * (3 + 1) / 2 ∧
    psdRank witnessM = 3 ∧ Nonempty (OrbitSpace witnessM 3) ∧
    ¬ IsPreconnected (Set.univ : Set (OrbitSpace witnessM 3)) := disconnected_counterexample_proved

/-- Complete original universal conjecture, negated by the actual k=3 witness. -/
theorem not_connectedOrbitConjecture : ¬ ConnectedOrbitConjecture := not_connectedOrbitConjecture_proved

set_option leancert.trust "kernel"
#assert_trust kernel NLA.PF02.psd_rank_semantics
#print axioms NLA.PF02.psd_rank_semantics
#assert_trust kernel NLA.PF02.congruence_quotient_semantics
#print axioms NLA.PF02.congruence_quotient_semantics
#assert_trust kernel NLA.PF02.witness_exact_data
#print axioms NLA.PF02.witness_exact_data
#assert_trust kernel NLA.PF02.trace_coordinate_bridge
#print axioms NLA.PF02.trace_coordinate_bridge
#assert_trust kernel NLA.PF02.congruence_coordinate_identity
#print axioms NLA.PF02.congruence_coordinate_identity
#assert_trust kernel NLA.PF02.orientation_invariant
#print axioms NLA.PF02.orientation_invariant
#assert_trust kernel NLA.PF02.quotient_orientation
#print axioms NLA.PF02.quotient_orientation
#assert_trust kernel NLA.PF02.disconnected_counterexample
#print axioms NLA.PF02.disconnected_counterexample
#assert_trust kernel NLA.PF02.not_connectedOrbitConjecture
#print axioms NLA.PF02.not_connectedOrbitConjecture

end NLA.PF02
