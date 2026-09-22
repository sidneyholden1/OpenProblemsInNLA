/- Attainment by the exact original-order band matrix for positive lower bandwidth.
Mathematics: Matthew J. Colbrook. Formalization: Sidney Holden with OpenAI Codex.
Apache-2.0. -/
import NLA.IE13.WitnessProduct
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2500000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

lemma fullLowerC_above (p q : ℕ) (i j : Fin (witnessSize p q)) (h : i < j) :
    fullLowerC p q i j = 0 := by
  simp only [fullLowerC,fullLowerQ_above p q i j h,Rat.cast_zero]

lemma fullLowerC_diag (p q : ℕ) (i : Fin (witnessSize p q)) : fullLowerC p q i i = 1 := by
  simp [fullLowerC,fullLowerQ_diag]

lemma fullUpperC_below (p q : ℕ) (i j : Fin (witnessSize p q)) (h : j < i) :
    fullUpperC p q i j = 0 := by
  simp only [fullUpperC,fullUpperQ_below p q i j h,Rat.cast_zero]

lemma fullUpperC_diag_ne (p q : ℕ) (i : Fin (witnessSize p q)) : fullUpperC p q i i ≠ 0 := by
  unfold fullUpperC
  exact_mod_cast (ne_of_gt (fullUpperQ_diag_pos p q i))

lemma fullLowerC_norm (p q : ℕ) (hp : 0<p) (i j : Fin (witnessSize p q)) :
    ‖fullLowerC p q i j‖ ≤ 1 := by
  rw [fullLowerC,Complex.norm_ratCast]
  exact_mod_cast fullLowerQ_abs_le_one p q hp i j

lemma witness_path_positive (p q : ℕ) (hp : 0<p) :
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) := by
  exact witness_isPath_of_lu p q (fullLowerC p q) (fullUpperC p q)
    (witness_full_product p q hp) (fullLowerC_above p q) (fullLowerC_diag p q)
    (fullUpperC_below p q) (fullUpperC_diag_ne p q)
    (fun i j _ => fullLowerC_norm p q hp i j)

lemma witness_det_positive (p q : ℕ) (hp : 0<p) : (witness p q).det ≠ 0 := by
  rw [witness_full_product p q hp]
  exact factor_lu_det_ne_zero (fullLowerC p q) (fullUpperC p q) (factorEquiv p q)
    (fullLowerC_above p q) (fullLowerC_diag p q) (fullUpperC_below p q) (fullUpperC_diag_ne p q)

lemma witness_target_pivot_positive (p q : ℕ) (hp : 0<p) :
    witnessStates p q (p+q) (witnessPivot p q ⟨p+q,by unfold witnessSize; omega⟩)
      ⟨p+q,by unfold witnessSize; omega⟩ = (bandRec p (p+q) : ℂ) := by
  let t : Fin (witnessSize p q) := ⟨p+q,by unfold witnessSize; omega⟩
  change witnessStates p q t.val (witnessPivot p q t) t = _
  rw [witnessStates_eq_luStage p q (fullLowerC p q) (fullUpperC p q)
    (witness_full_product p q hp) (fullLowerC_above p q) (fullLowerC_diag p q)
    (fullUpperC_below p q) (fullUpperC_diag_ne p q) t.val t.isLt]
  rw [luStage_pivot_row (fullLowerC p q) (fullUpperC p q) (witnessLabel p q)
    (fullLowerC_above p q) (fullLowerC_diag p q) t (witnessPivot p q t) t
    (witnessPivot_active p q t) le_rfl (witnessLabel_pivot p q t)]
  simp [fullUpperC,fullUpperQ,t,targetRec,show p ≠ 0 by omega]

theorem witness_data_positive (p q : ℕ) (hp : 0<p) :
    1+max p q ≤ witnessSize p q ∧
    IsBanded p q (witness p q) ∧ entryMax (witness p q)=1 ∧
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) ∧
    sharpGrowth p q ≤ growth (witness p q) (witnessStates p q) := by
  refine ⟨witnessSize_admissible p q,⟨witness_pattern p q,witness_det_positive p q hp⟩,
    witness_entryMax p q,witness_path_positive p q hp,?_⟩
  have h := growth_ge_entry (witness p q) (witnessStates p q)
    (by rw [witness_entryMax p q]; norm_num)
    ⟨p+q,by unfold witnessSize; omega⟩
    (witnessPivot p q ⟨p+q,by unfold witnessSize; omega⟩)
    ⟨p+q,by unfold witnessSize; omega⟩
  rw [witness_entryMax p q,div_one,witness_target_pivot_positive p q hp] at h
  simpa [sharpGrowth,show p ≠ 0 by omega] using h

#assert_trust kernel witness_data_positive
end NLA.IE13
