/- Full original IS-02 negation, preserving source credit to Matthew J.
Colbrook. Formalization: Sidney Holden with Codex assistance. Apache 2.0. -/
import NLA.IS02.Classification
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.IS02
attribute [local simp] Matrix.cons_val_two Matrix.cons_val_three Polynomial.C_ofNat

lemma witness_model : witness = model 1 0 0 0 0 (1/2) := by
  ext i j; fin_cases i <;> fin_cases j <;> norm_num [witness,model]

lemma witness_stochastic : witness ∈ stochasticSet 4 := by
  refine ⟨?_,?_,?_⟩
  · ext i j; fin_cases i <;> fin_cases j <;> norm_num [witness]
  · intro i j; fin_cases i <;> fin_cases j <;> norm_num [witness]
  · intro i; fin_cases i <;> norm_num [witness,Fin.sum_univ_four]
lemma witness_polynomial :
    witness.charpoly = Polynomial.X*(Polynomial.X-1)^2*(Polynomial.X+1) := by
  rw [witness_model,model_charpoly]
  norm_num [edgeSum,pairSum,treeSum]
  ring
lemma witness_trace : Matrix.trace witness = 1 := by
  norm_num [Matrix.trace,witness,Fin.sum_univ_four]

theorem witness_certificates :
    witness ∈ stochasticSet 4 ∧
    witness.charpoly = Polynomial.X * (Polynomial.X-1)^2 * (Polynomial.X+1) ∧
    Matrix.trace witness = 1 ∧ 0 < Matrix.trace witness := by
  refine ⟨witness_stochastic,witness_polynomial,witness_trace,?_⟩
  rw [witness_trace]
  interval_decide (trust := kernel)

theorem spectral_uniqueness : spectrallyUnique witness := by
  intro B hB hc
  rw [witness_polynomial] at hc
  have hm := stochastic_model B hB
  rw [hm] at hB hc ⊢
  exact model_unique _ _ _ _ _ _ hB hc

lemma endpoints_stochastic : endpointLeft ∈ stochasticSet 4 ∧ endpointRight ∈ stochasticSet 4 := by
  constructor
  all_goals refine ⟨?_,?_,?_⟩
  all_goals first
  | (ext i j; fin_cases i <;> fin_cases j <;> norm_num [endpointLeft,endpointRight])
  | (intro i j; fin_cases i <;> fin_cases j <;> norm_num [endpointLeft,endpointRight])
  | (intro i; fin_cases i <;> norm_num [endpointLeft,endpointRight,Fin.sum_univ_four])
lemma endpoints_ne : endpointLeft ≠ endpointRight := by
  intro h
  have hh := congrFun (congrFun h 2) 2
  norm_num [endpointLeft,endpointRight] at hh
lemma witness_midpoint :
    witness = (1/2 : ℝ) • endpointLeft + (1/2 : ℝ) • endpointRight := by
  ext i j; fin_cases i <;> fin_cases j <;> norm_num [witness,endpointLeft,endpointRight]
lemma witness_not_vertex : witness ∉ (stochasticSet 4).extremePoints ℝ := by
  intro h
  have hm : witness ∈ openSegment ℝ endpointLeft endpointRight :=
    ⟨1/2,1/2,by norm_num,by norm_num,by norm_num,witness_midpoint.symm⟩
  have hh := (mem_extremePoints_iff_left.mp h).2 endpointLeft endpoints_stochastic.1
    endpointRight endpoints_stochastic.2 hm
  have he := congrFun (congrFun hh 2) 2
  norm_num [witness,endpointLeft] at he

lemma witness_not_locus : witness ∉ proposedLocus 4 := by
  have h02 : (0 : Fin 4) ≠ 2 := by decide
  rintro (h | ⟨V,hV,h | h⟩)
  · obtain ⟨a,b,ha,hb,hab,heq⟩ := h
    have he02 := congrFun (congrFun heq 0) 2
    have he00 := congrFun (congrFun heq 0) 0
    norm_num [center,witness,h02,Matrix.one_apply] at he02 he00
    linarith
  · obtain ⟨a,b,ha,hb,hab,heq⟩ := h
    have he00 := congrFun (congrFun heq 0) 0
    norm_num [witness] at he00
    have hv : 0 ≤ V 0 0 := hV.1.2.1 0 0
    have ha0 : a=0 := by nlinarith [mul_nonneg hb hv]
    have hb1 : b=1 := by linarith
    have he : V=witness := by simpa [ha0,hb1] using heq
    exact witness_not_vertex (he ▸ hV)
  · obtain ⟨a,b,ha,hb,hab,heq⟩ := h
    have he02 := congrFun (congrFun heq 0) 2
    norm_num [center,witness,h02,Matrix.one_apply] at he02
    have hv : 0 ≤ V 0 2 := hV.1.2.1 0 2
    have ha0 : a=0 := by nlinarith [mul_nonneg hb hv]
    have hb1 : b=1 := by linarith
    have he : V=witness := by simpa [ha0,hb1] using heq
    exact witness_not_vertex (he ▸ hV)

theorem locus_exclusion :
    endpointLeft ∈ stochasticSet 4 ∧ endpointRight ∈ stochasticSet 4 ∧
    endpointLeft ≠ endpointRight ∧
    witness = (1/2 : ℝ) • endpointLeft + (1/2 : ℝ) • endpointRight ∧
    witness ∉ (stochasticSet 4).extremePoints ℝ ∧
    witness ∉ proposedLocus 4 :=
  ⟨endpoints_stochastic.1,endpoints_stochastic.2,endpoints_ne,witness_midpoint,
    witness_not_vertex,witness_not_locus⟩

theorem counterexample : ¬ LocusConjecture := by
  intro h
  exact witness_not_locus (h 4 (by norm_num) witness witness_stochastic spectral_uniqueness
    witness_certificates.2.2.2)

#assert_trust kernel witness_certificates
#assert_trust kernel spectral_uniqueness
#assert_trust kernel locus_exclusion
#assert_trust kernel counterexample
end NLA.IS02
