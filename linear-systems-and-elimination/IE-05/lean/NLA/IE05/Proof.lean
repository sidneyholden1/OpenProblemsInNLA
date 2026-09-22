/- Strict growth separation for Stepaniants's order-eight IE-05 counterexample.
Formalization: Sidney Holden with Codex assistance. Apache 2.0. -/
import NLA.IE05.RealCertificates
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE05

lemma normalized_square (a d : ℝ) (hd : 0 < d) :
    (a / Real.sqrt d)^2 = a^2/d := by rw [div_pow, Real.sq_sqrt hd.le]

lemma candidate_input_lower : (51 : ℝ)/Real.sqrt 3286 ≤ entryMax candidateQ := by
  have h := entry_le candidateQ 2 2
  have he : candidateQ 2 2 = (51 : ℝ)/Real.sqrt 3286 := rfl
  rw [he, abs_of_pos (div_pos (by norm_num) (Real.sqrt_pos.mpr (by norm_num)))] at h
  exact h
lemma candidate_input_pos : 0 < entryMax candidateQ :=
  (div_pos (by norm_num) (Real.sqrt_pos.mpr (by norm_num))).trans_le candidate_input_lower

lemma candidate_active_bound (k i j : Fin 8) :
    |candidateStates k.val i j| ≤ Real.sqrt 5462 := by
  change |realStates false k.val i j| ≤ _
  rw [realStates_cast]
  have hd : (0 : ℝ) < intD false j := by exact_mod_cast (int_diag_pos false j).1
  have hh : ((intState false k.val i j : ℝ))^2 ≤ 5462*(intD false j : ℝ) := by
    exact_mod_cast int_candidate_bound k i j
  have hs : ((intState false k.val i j : ℝ)/Real.sqrt (intD false j : ℝ))^2 ≤ 5462 := by
    rw [normalized_square _ _ hd]
    exact (div_le_iff₀ hd).mpr hh
  have hroot := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 5462)
  nlinarith [sq_abs ((intState false k.val i j : ℝ)/Real.sqrt (intD false j : ℝ)),
    Real.sqrt_nonneg 5462]

lemma candidate_growth_bound :
    growth candidateQ candidateStates ≤ Real.sqrt (17948132/2601) := by
  apply growth_le_of_entry_bounds _ _ _ (Real.sqrt_nonneg _) candidate_input_pos
  intro k i j
  have he : Real.sqrt (17948132/2601)*((51 : ℝ)/Real.sqrt 3286) = Real.sqrt 5462 := by
    have hs : (Real.sqrt (17948132/2601)*((51 : ℝ)/Real.sqrt 3286))^2 = 5462 := by
      rw [mul_pow, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 17948132/2601),
        Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3286)]
      norm_num
    have hp := mul_nonneg (Real.sqrt_nonneg (17948132/2601))
      (div_nonneg (by norm_num : (0 : ℝ) ≤ 51) (Real.sqrt_nonneg 3286))
    nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 5462), Real.sqrt_nonneg 5462]
  calc
    |candidateStates k.val i j| ≤ Real.sqrt 5462 := candidate_active_bound k i j
    _ = Real.sqrt (17948132/2601)*((51 : ℝ)/Real.sqrt 3286) := he.symm
    _ ≤ Real.sqrt (17948132/2601)*entryMax candidateQ :=
      mul_le_mul_of_nonneg_left candidate_input_lower (Real.sqrt_nonneg _)

lemma witness_input_upper : entryMax witnessQ ≤ (63 : ℝ)/Real.sqrt 5272 := by
  apply entryMax_le _ _ (div_nonneg (by norm_num) (Real.sqrt_nonneg _))
  intro i j
  change |(intH true i j : ℝ)/Real.sqrt (intD true j : ℝ)| ≤ _
  have hd : (0 : ℝ) < intD true j := by exact_mod_cast (int_diag_pos true j).1
  have hh : 5272*(intH true i j : ℝ)^2 ≤ 3969*(intD true j : ℝ) := by
    exact_mod_cast int_witness_input_bound i j
  have hs : ((intH true i j : ℝ)/Real.sqrt (intD true j : ℝ))^2 ≤ 3969/5272 := by
    rw [normalized_square _ _ hd]
    apply (div_le_iff₀ hd).mpr
    nlinarith
  have ht : ((63 : ℝ)/Real.sqrt 5272)^2 = 3969/5272 := by
    rw [normalized_square _ _ (by norm_num)]; norm_num
  have hp := div_nonneg (by norm_num : (0 : ℝ) ≤ 63) (Real.sqrt_nonneg 5272)
  nlinarith [sq_abs ((intH true i j : ℝ)/Real.sqrt (intD true j : ℝ))]

lemma witness_input_pos : 0 < entryMax witnessQ :=
  path_input_pos (by norm_num) _ _ _ pivot_certificates.2.1
lemma witness_final_entry : witnessStates 7 7 7 = (5272 : ℝ)/Real.sqrt 5272 := by
  change realStates true 7 7 7 = _
  rw [realStates_cast, int_witness_final.1, int_witness_final.2]
  norm_num

lemma witness_growth_bound : (5272/63 : ℝ) ≤ growth witnessQ witnessStates := by
  have he := growth_ge_entry witnessQ witnessStates witness_input_pos 7 7 7
  change |witnessStates 7 7 7| / entryMax witnessQ ≤ growth witnessQ witnessStates at he
  rw [witness_final_entry,
    abs_of_pos (div_pos (by norm_num) (Real.sqrt_pos.mpr (by norm_num)))] at he
  apply le_trans _ he
  apply (le_div_iff₀ witness_input_pos).mpr
  have hh := mul_le_mul_of_nonneg_left witness_input_upper (by norm_num : (0 : ℝ) ≤ 5272/63)
  convert hh using 1 <;> ring

lemma scalar_separation : Real.sqrt (17948132/2601) < (5272/63 : ℝ) := by
  have h1 : (17948132/2601 : ℝ) < (167/2 : ℝ)^2 := by interval_decide (trust := kernel)
  have h2 : (167/2 : ℝ)^2 < (5272/63 : ℝ)^2 := by interval_decide (trust := kernel)
  have hs := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 17948132/2601)
  nlinarith [Real.sqrt_nonneg (17948132/2601)]

theorem growth_separation :
    (orthogonalGrowths 8).Nonempty ∧ BddAbove (orthogonalGrowths 8) ∧
    growth candidateQ candidateStates ≤ Real.sqrt (17948132/2601) ∧
    (5272/63 : ℝ) ≤ growth witnessQ witnessStates ∧
    growth candidateQ candidateStates < growth witnessQ witnessStates ∧
    growth candidateQ candidateStates < sSup (orthogonalGrowths 8) := by
  have hw : growth witnessQ witnessStates ∈ orthogonalGrowths 8 :=
    ⟨witnessQ,witnessStates,(fun k => k),qr_certificates.2.1,pivot_certificates.2.1,rfl⟩
  have hb : BddAbove (orthogonalGrowths 8) := by
    refine ⟨2^8, ?_⟩
    rintro t ⟨Q,S,p,hQ,hp,rfl⟩
    exact path_growth_bound (by norm_num) Q S p hp
  have hg := candidate_growth_bound.trans_lt (scalar_separation.trans_le witness_growth_bound)
  exact ⟨⟨_,hw⟩,hb,candidate_growth_bound,witness_growth_bound,hg,hg.trans_le (le_csSup hb hw)⟩

theorem counterexample : ¬ ExtremizerConjecture := by
  intro h
  have bad := h 8 (by norm_num) candidateQ candidateR candidateStates (fun k => k)
    qr_certificates.1 pivot_certificates.1
  exact (ne_of_lt growth_separation.2.2.2.2.2) bad.symm

#assert_trust kernel growth_separation
#assert_trust kernel counterexample
end NLA.IE05
