import NLA.MF02.ErrorEstimates
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Polynomial
noncomputable section
namespace NLA.MF02

lemma computable_mono {m k : ℕ} {p : ℝ[X]} (hm : m ≤ k) (hp : computable m p) :
    computable k p := by
  obtain ⟨j,hj,ps,hps,hmem⟩ := hp
  exact ⟨j,hj.trans hm,ps,hps,hmem⟩

lemma linear_computable (m : ℕ) (a : ℝ) : computable m (C a*X) := by
  refine ⟨0,Nat.zero_le _,[1,X],RegisterRun.initial,?_⟩
  rw [← Polynomial.smul_eq_C_mul]
  exact Submodule.smul_mem _ a (Submodule.subset_span (by simp))

lemma unrestricted_upper (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) (m : ℕ) :
    unrestrictedError m δ ≤ gapRatio δ := by
  let p : ℝ[X] := C (2/(1+δ))*X
  have hp : computable m p := linear_computable m _
  have he : uniformError δ p ≤ gapRatio δ := by
    apply error_le_positive δ hδ hδ1 p (by intro x; simp [p]) _
    intro x hx
    have h := centered_interval δ x hδ hδ1 hx.1 hx.2
    simpa [p,div_mul_eq_mul_div] using h
  exact (csInf_le ((error_sets_valid_proved δ hδ hδ1).2.1 m).2 ⟨p,hp,rfl⟩).trans he

lemma unrestricted_le_cubic (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (m T : ℕ) (hcost : 2*T ≤ m) : unrestrictedError m δ ≤ cubicError T δ := by
  apply le_csInf ((error_sets_valid_proved δ hδ hδ1).2.2 T).1
  rintro e ⟨cs,hcs,rfl⟩
  apply csInf_le ((error_sets_valid_proved δ hδ hδ1).2.1 m).2
  refine ⟨composeCubics cs,computable_mono ?_ (stages_computable_proved cs),rfl⟩
  simpa [hcs] using hcost

lemma feasible_zero_budget (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) : 1 ∈ feasibleStages 0 δ := by
  have hr := gapRatio_props δ hδ hδ1
  change cubicError 1 δ ≤ unrestrictedError 0 δ
  have hc := cubic_upper δ hδ hδ1 hd 1 (by decide)
  have he := unrestricted_lower δ hδ hδ1 hd 0
  norm_num at hc he
  exact hc.trans ((show gapRatio δ^2 ≤ gapRatio δ by nlinarith).trans he)

lemma feasible_own_budget (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (m : ℕ) (hm : 1 ≤ m) : m ∈ feasibleStages m δ :=
  (cubic_upper δ hδ hδ1 hd m hm).trans (unrestricted_lower δ hδ hδ1 hd m)

lemma feasible_nonempty (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) (m : ℕ) : (feasibleStages m δ).Nonempty := by
  by_cases hm : m=0
  · subst m; exact ⟨1,feasible_zero_budget δ hδ hδ1 hd⟩
  · exact ⟨m,feasible_own_budget δ hδ hδ1 hd m (by omega)⟩

lemma genuine_stage_minimum_from_degree (m : ℕ) (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) :
    (feasibleStages m δ).Nonempty ∧ minimumStages m δ ∈ feasibleStages m δ ∧
    ∀ T ∈ feasibleStages m δ, minimumStages m δ ≤ T := by
  have hn := feasible_nonempty δ hδ hδ1 hd m
  exact ⟨hn,Nat.sInf_mem hn,fun T hT => Nat.sInf_le hT⟩

lemma stage_positive (m : ℕ) (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) : 1 ≤ minimumStages m δ := by
  have hmin := (genuine_stage_minimum_from_degree m δ hδ hδ1 hd).2.1
  have hrlt : gapRatio δ < 1-δ := by
    unfold gapRatio
    apply (div_lt_iff₀ (by linarith : 0 < 1+δ)).mpr
    nlinarith
  by_contra! hbad
  have hz : minimumStages m δ = 0 := by omega
  change cubicError (minimumStages m δ) δ ≤ unrestrictedError m δ at hmin
  rw [hz,cubic_zero δ hδ hδ1] at hmin
  exact (not_lt_of_ge (hmin.trans (unrestricted_upper δ hδ hδ1 m))) hrlt

lemma stage_upper (m : ℕ) (hm : 1 ≤ m) (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) : minimumStages m δ ≤ m :=
  Nat.sInf_le (feasible_own_budget δ hδ hδ1 hd m hm)

lemma stage_lower (m : ℕ) (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) : m/2 ≤ minimumStages m δ := by
  have hmin := (genuine_stage_minimum_from_degree m δ hδ hδ1 hd).2.1
  change cubicError (minimumStages m δ) δ ≤ unrestrictedError m δ at hmin
  have hcost : 2*(m/2) ≤ m := by omega
  have he := unrestricted_le_cubic δ hδ hδ1 m (m/2) hcost
  by_contra! hbad
  exact (not_lt_of_ge (hmin.trans he)) ((cubic_strict δ hδ hδ1 hd) hbad)

lemma stage_bounds_from_degree (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (hd : DegreeBound δ) :
    minimumStages 0 δ = 1 ∧ minimumStages 1 δ = 1 ∧
    (∀ m : ℕ, 2 ≤ m → m/2 ≤ minimumStages m δ ∧ minimumStages m δ ≤ m) ∧
    (∀ m : ℕ, ((m : ℝ)+1)/4 ≤ (minimumStages m δ : ℝ) ∧
      (minimumStages m δ : ℝ) ≤ (m : ℝ)+1) := by
  have hzero : minimumStages 0 δ = 1 :=
    le_antisymm (Nat.sInf_le (feasible_zero_budget δ hδ hδ1 hd)) (stage_positive 0 δ hδ hδ1 hd)
  have hone : minimumStages 1 δ = 1 :=
    le_antisymm (stage_upper 1 (by decide) δ hδ hδ1 hd) (stage_positive 1 δ hδ hδ1 hd)
  refine ⟨hzero,hone,fun m hm => ⟨stage_lower m δ hδ hδ1 hd,
    stage_upper m (by omega) δ hδ hδ1 hd⟩,?_⟩
  intro m
  have hl := stage_lower m δ hδ hδ1 hd
  have hp := stage_positive m δ hδ hδ1 hd
  have hn : m+1 ≤ 4*minimumStages m δ := by omega
  have hnreal : (m:ℝ)+1 ≤ 4*(minimumStages m δ:ℝ) := by exact_mod_cast hn
  constructor
  · linarith
  · by_cases hm : m=0
    · subst m; rw [hzero]; norm_num
    · have hu := stage_upper m (by omega) δ hδ hδ1 hd
      have hu' : (minimumStages m δ:ℝ) ≤ (m:ℝ) := by exact_mod_cast hu
      linarith

end NLA.MF02
