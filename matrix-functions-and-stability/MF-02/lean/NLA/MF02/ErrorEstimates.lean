import NLA.MF02.Constructive
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Polynomial
noncomputable section
namespace NLA.MF02

lemma cubic_degree (a b : ℝ) : (cubic a b).natDegree ≤ 3 := by
  apply (natDegree_add_le _ _).trans
  apply max_le
  · exact (natDegree_C_mul_le _ _).trans (by simp)
  · exact (natDegree_C_mul_le _ _).trans (by simp)

lemma compose_degree (cs : List (ℝ × ℝ)) : (composeCubics cs).natDegree ≤ 3^cs.length := by
  induction cs with
  | nil => simp [composeCubics]
  | cons ab cs ih =>
    change ((composeCubics cs).comp (cubic ab.1 ab.2)).natDegree ≤ 3^(cs.length+1)
    exact (natDegree_comp_le).trans (by
      rw [pow_succ]
      exact Nat.mul_le_mul ih (cubic_degree _ _))

/-- Intermediate assembly is parameterized by the separately proved polynomial
lower bound; Solution supplies that theorem, never an additional hypothesis. -/
def DegreeBound (δ : ℝ) : Prop := ∀ D : ℕ, 1 ≤ D → ∀ p : ℝ[X],
  p.natDegree ≤ D → gapRatio δ ^ D ≤ uniformError δ p

lemma polynomial_error_pos (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (p : ℝ[X]) : 0 < uniformError δ p := by
  exact (pow_pos (gapRatio_props δ hδ hδ1).1 (max 1 p.natDegree)).trans_le
    (hd _ (le_max_left _ _) p (le_max_right _ _))

lemma cubic_lower (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (T : ℕ) : gapRatio δ ^ (3^T) ≤ cubicError T δ := by
  apply le_csInf ((error_sets_valid_proved δ hδ hδ1).2.2 T).1
  rintro e ⟨cs,hcs,rfl⟩
  apply hd _ (Nat.one_le_pow _ _ (by decide))
  simpa [hcs] using compose_degree cs

lemma unrestricted_lower (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (m : ℕ) : gapRatio δ ^ (2^m) ≤ unrestrictedError m δ := by
  apply le_csInf ((error_sets_valid_proved δ hδ hδ1).2.1 m).1
  rintro e ⟨p,hp,rfl⟩
  exact hd _ (Nat.one_le_pow _ _ (by decide)) p (register_degree_bound_proved m p hp)

lemma stages_upper_exists (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (T : ℕ) (hT : 1 ≤ T) :
    ∃ cs : List (ℝ × ℝ), cs.length = T ∧
      uniformError δ (composeCubics cs) ≤ gapRatio δ ^ (2^T) := by
  have hr := gapRatio_props δ hδ hδ1
  induction T,hT using Nat.le_induction with
  | base => simpa using one_stage_exists δ hδ hδ1
  | succ T hT ih =>
    obtain ⟨cs,hcs,herr⟩ := ih
    have he0 := polynomial_error_pos δ hδ hδ1 hd (composeCubics cs)
    have he1 : uniformError δ (composeCubics cs) < 1 :=
      herr.trans_lt (pow_lt_one₀ hr.1.le hr.2 (by positivity))
    obtain ⟨ds,hds,himp⟩ := append_improves δ hδ hδ1 cs he0 he1
    refine ⟨ds,by simpa [hcs] using hds,himp.trans ?_⟩
    have hh := pow_le_pow_left₀ he0.le herr 2
    rw [← pow_mul] at hh
    simpa only [Nat.pow_succ] using hh

lemma cubic_upper (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (T : ℕ) (hT : 1 ≤ T) :
    cubicError T δ ≤ gapRatio δ ^ (2^T) := by
  obtain ⟨cs,hcs,herr⟩ := stages_upper_exists δ hδ hδ1 hd T hT
  exact (csInf_le ((error_sets_valid_proved δ hδ hδ1).2.2 T).2 ⟨cs,hcs,rfl⟩).trans herr

lemma cubic_zero (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) : cubicError 0 δ = 1-δ := by
  have herr : uniformError δ X = 1-δ := by
    apply le_antisymm
    · apply error_le_positive δ hδ hδ1 X (by simp) (1-δ)
      intro x hx
      simp only [eval_X,abs_of_nonpos (by linarith [hx.2] : x-1 ≤ 0)]
      linarith [hx.1]
    · have h := point_error_le δ hδ X δ (Or.inr ⟨le_rfl,hδ1.le⟩)
      simpa [targetSign,not_lt.mpr hδ.le,abs_of_nonpos (by linarith : δ-1 ≤ 0)] using h
  have hs : cubicErrors 0 δ = {uniformError δ X} := by
    ext e
    simp [cubicErrors,composeCubics]
  rw [cubicError,hs,csInf_singleton,herr]

lemma cubic_square (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (T : ℕ) (hT : 1 ≤ T) :
    cubicError (T+1) δ ≤ (cubicError T δ)^2 := by
  have hr := gapRatio_props δ hδ hδ1
  have hpos : 0 < cubicError T δ :=
    (pow_pos hr.1 _).trans_le (cubic_lower δ hδ hδ1 hd T)
  have hsmall : cubicError T δ < 1 :=
    (cubic_upper δ hδ hδ1 hd T hT).trans_lt (pow_lt_one₀ hr.1.le hr.2 (by positivity))
  by_contra! hbad
  have hnextpos : 0 < cubicError (T+1) δ := lt_of_le_of_lt (sq_nonneg _) hbad
  have hsqrt : cubicError T δ < Real.sqrt (cubicError (T+1) δ) := by
    nlinarith [Real.sq_sqrt hnextpos.le,Real.sqrt_nonneg (cubicError (T+1) δ)]
  have hlt : cubicError T δ < min 1 (Real.sqrt (cubicError (T+1) δ)) := lt_min hsmall hsqrt
  obtain ⟨e,he,helt⟩ := exists_lt_of_csInf_lt
    ((error_sets_valid_proved δ hδ hδ1).2.2 T).1 hlt
  obtain ⟨cs,hcs,rfl⟩ := he
  have he0 := polynomial_error_pos δ hδ hδ1 hd (composeCubics cs)
  obtain ⟨ds,hds,himp⟩ := append_improves δ hδ hδ1 cs he0 (helt.trans_le (min_le_left _ _))
  have hle : cubicError (T+1) δ ≤ (uniformError δ (composeCubics cs))^2 :=
    (csInf_le ((error_sets_valid_proved δ hδ hδ1).2.2 (T+1)).2
      ⟨ds,by simpa [hcs] using hds,rfl⟩).trans himp
  have hs := helt.trans_le (min_le_right _ _)
  nlinarith [Real.sq_sqrt hnextpos.le,Real.sqrt_nonneg (cubicError (T+1) δ)]

lemma cubic_strict (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) : StrictAnti (fun T => cubicError T δ) := by
  have hr := gapRatio_props δ hδ hδ1
  apply strictAnti_nat_of_succ_lt
  intro T
  by_cases hT : T = 0
  · subst T
    rw [cubic_zero δ hδ hδ1]
    have hu := cubic_upper δ hδ hδ1 hd 1 (by decide)
    have hrlt : gapRatio δ < 1-δ := by
      unfold gapRatio
      apply (div_lt_iff₀ (by linarith : 0 < 1+δ)).mpr
      nlinarith
    have hp : gapRatio δ ^ (2^1) < gapRatio δ := by norm_num; nlinarith
    exact hu.trans_lt (hp.trans hrlt)
  · have ht : 1 ≤ T := by omega
    have hpos : 0 < cubicError T δ :=
      (pow_pos hr.1 _).trans_le (cubic_lower δ hδ hδ1 hd T)
    have hsmall : cubicError T δ < 1 :=
      (cubic_upper δ hδ hδ1 hd T ht).trans_lt (pow_lt_one₀ hr.1.le hr.2 (by positivity))
    exact (cubic_square δ hδ hδ1 hd T ht).trans_lt (by nlinarith)

end NLA.MF02
