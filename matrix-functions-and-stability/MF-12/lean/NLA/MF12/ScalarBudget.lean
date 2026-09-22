/- The all-word compressed triangular budget from Colbrook's MF-12 proof.
Exact finite Hölder and telescoping estimates; no interval computation.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.MF12.Definitions
import Mathlib.Analysis.MeanInequalities
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF12

lemma holder_budget {ι : Type*} (s : Finset ι) (x y : ι → ℝ) (α : ℝ)
    (ha : 0 < α) (ha1 : α < 1) (hx : ∀ i∈s,0≤x i) (hy : ∀ i∈s,0≤y i) :
    ∑ i∈s, (x i)^α*(y i)^(1-α) ≤
      (∑ i∈s,x i)^α*(∑ i∈s,y i)^(1-α) := by
  have hc := Real.HolderConjugate.inv_one_sub_inv ha ha1
  have h := Real.inner_le_Lp_mul_Lq_of_nonneg s hc
    (fun i hi => Real.rpow_nonneg (hx i hi) α)
    (fun i hi => Real.rpow_nonneg (hy i hi) (1-α))
  have hp : ∀ i∈s, ((x i)^α)^(α⁻¹) = x i := by
    intro i hi; rw [← Real.rpow_mul (hx i hi),mul_inv_cancel₀ ha.ne',Real.rpow_one]
  have hq : ∀ i∈s, ((y i)^(1-α))^((1-α)⁻¹) = y i := by
    intro i hi; rw [← Real.rpow_mul (hy i hi),mul_inv_cancel₀ (by linarith : 1-α≠0),Real.rpow_one]
  have hpS : (∑ i∈s, ((x i)^α)^(α⁻¹)) = ∑ i∈s,x i := Finset.sum_congr rfl hp
  have hqS : (∑ i∈s, ((y i)^(1-α))^((1-α)⁻¹)) = ∑ i∈s,y i := Finset.sum_congr rfl hq
  simpa only [hpS,hqS,one_div,inv_inv] using h

lemma holder_two (x y u v α : ℝ) (ha : 0<α) (ha1 : α<1)
    (hx : 0≤x) (hy : 0≤y) (hu : 0≤u) (hv : 0≤v) :
    x^α*y^(1-α)+u^α*v^(1-α) ≤ (x+u)^α*(y+v)^(1-α) := by
  simpa [Fin.sum_univ_two] using holder_budget Finset.univ ![x,u] ![y,v] α ha ha1
    (by intro i _; fin_cases i <;> assumption) (by intro i _; fin_cases i <;> assumption)

/-- Exact telescoping identity for every ordered finite set of gaps. -/
lemma telescope_budget {ι : Type*} [LinearOrder ι] (s : Finset ι) (ell : ι → ℝ) :
    ∑ i ∈ s, ell i * (∏ j ∈ s with j < i, (1 - ell j)) =
      1 - ∏ i ∈ s, (1 - ell i) := by
  have h := Finset.prod_one_sub_ordered s ell
  linarith


lemma weighted_scale (c x y α : ℝ) (hc : 0≤c) (hx : 0≤x) (hy : 0≤y)
    (ha : 0<α) (ha1 : α<1) :
    (c*x)^α*(c*y)^(1-α) = c*(x^α*y^(1-α)) := by
  by_cases hz : c=0
  · subst c; simp [Real.zero_rpow ha.ne',Real.zero_rpow (by linarith : 1-α≠0)]
  · rw [Real.mul_rpow hc hx,Real.mul_rpow hc hy]
    calc
      c^α*x^α*(c^(1-α)*y^(1-α)) = (c^α*c^(1-α))*(x^α*y^(1-α)) := by ring
      _ = c*(x^α*y^(1-α)) := by rw [← Real.rpow_add (lt_of_le_of_ne hc (Ne.symm hz)),add_sub_cancel,Real.rpow_one]

def budgetTri (α : ℝ) (qe : ℝ×ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-qe.2,qe.1^α*qe.2^(1-α);0,1]

lemma triangular_budget_strong (α : ℝ) (ha : 0<α) (ha1 : α<1)
    (qs : List (ℝ×ℝ)) (hqs : ∀ qe∈qs, 0≤qe.1 ∧ 0≤qe.2 ∧ qe.2≤1) :
    ∃ a z : ℝ, (qs.map (budgetTri α)).prod = !![a,z;0,1] ∧
      0≤a ∧ a≤1 ∧ 0≤z ∧ z ≤ ((qs.map Prod.fst).sum)^α*(1-a)^(1-α) := by
  induction qs with
  | nil =>
    refine ⟨1,0,?_,by norm_num,by norm_num,by norm_num,?_⟩
    · ext i j; fin_cases i <;> fin_cases j <;> norm_num
    · simp [Real.zero_rpow ha.ne']
  | cons qe qs ih =>
    have he := hqs qe (by simp)
    obtain ⟨a,z,hprod,ha0,haone,hz0,hz⟩ := ih (by intro x hx; exact hqs x (by simp [hx]))
    let Q := (qs.map Prod.fst).sum
    have hQ : 0≤Q := List.sum_nonneg (by intro x hx; obtain ⟨q,hq,rfl⟩ := List.mem_map.mp hx; exact (hqs q (by simp [hq])).1)
    have hc : 0≤1-qe.2 := by linarith
    have hb : 0≤qe.1^α*qe.2^(1-α) := mul_nonneg (Real.rpow_nonneg he.1 _) (Real.rpow_nonneg he.2.1 _)
    refine ⟨(1-qe.2)*a,qe.1^α*qe.2^(1-α)+(1-qe.2)*z,?_,
      mul_nonneg hc ha0,?_,add_nonneg hb (mul_nonneg hc hz0),?_⟩
    · simp only [List.map_cons,List.prod_cons,hprod,budgetTri]
      ext i j; fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply,Fin.sum_univ_two,add_comm]
    · nlinarith
    · have hscaled : (1-qe.2)*z ≤ ((1-qe.2)*Q)^α*((1-qe.2)*(1-a))^(1-α) := by
        rw [weighted_scale _ _ _ _ hc hQ (by linarith) ha ha1]
        exact mul_le_mul_of_nonneg_left hz hc
      have hh := holder_two qe.1 qe.2 ((1-qe.2)*Q) ((1-qe.2)*(1-a)) α ha ha1
        he.1 he.2.1 (mul_nonneg hc hQ) (mul_nonneg hc (by linarith))
      have hfirst : qe.1+(1-qe.2)*Q ≤ qe.1+Q := by nlinarith
      have hsecond : qe.2+(1-qe.2)*(1-a) = 1-(1-qe.2)*a := by ring
      rw [hsecond] at hh
      have hr := Real.rpow_le_rpow (add_nonneg he.1 (mul_nonneg hc hQ)) hfirst ha.le
      have ht := mul_le_mul_of_nonneg_right hr (Real.rpow_nonneg (by nlinarith : 0≤1-(1-qe.2)*a) (1-α))
      simpa only [List.map_cons,List.sum_cons] using (add_le_add (le_refl _) hscaled).trans (hh.trans ht)


def ell (q : ℕ) : ℝ := (q:ℝ)*(1/4:ℝ)^q
def compressed (α : ℝ) (q : ℕ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-ell q,(q:ℝ)*(fractionalParameter α)^q;0,1]

lemma ell_bounds (q : ℕ) : 0≤ell q ∧ ell q≤1 := by
  constructor
  · unfold ell; positivity
  · induction q with
    | zero => norm_num [ell]
    | succ q ih =>
      have hp : (1/4:ℝ)^q ≤ 1 := pow_le_one₀ (by norm_num) (by norm_num)
      simp only [ell,Nat.cast_add,Nat.cast_one,pow_succ] at *
      nlinarith

lemma fractional_power (α : ℝ) (q : ℕ) :
    (fractionalParameter α)^q = ((1/4:ℝ)^q)^(1-α) := by
  unfold fractionalParameter
  rw [← Real.rpow_mul_natCast (by norm_num : (0:ℝ)≤4),
    ← Real.rpow_natCast_mul (by norm_num : (0:ℝ)≤1/4)]
  have hb : (1/4:ℝ) = (4:ℝ)^(-1:ℝ) := by norm_num [Real.rpow_neg_one]
  rw [hb,← Real.rpow_mul (by norm_num : (0:ℝ)≤4)]
  congr 1; ring

lemma compressed_budgetTri (α : ℝ) (ha : 0<α) (ha1 : α<1) (q : ℕ) :
    compressed α q = budgetTri α ((q:ℝ),ell q) := by
  have he : (q:ℝ)*(fractionalParameter α)^q = (q:ℝ)^α*(ell q)^(1-α) := by
    rw [fractional_power,ell,Real.mul_rpow (by positivity) (by positivity)]
    by_cases hq : q=0
    · subst q; simp [Real.zero_rpow ha.ne']
    · have hq0 : (0:ℝ)<q := by exact_mod_cast Nat.pos_of_ne_zero hq
      rw [← mul_assoc,← Real.rpow_add hq0,add_sub_cancel,Real.rpow_one]
  simp only [compressed,budgetTri,he]

theorem compressed_product_budget (α : ℝ) (ha : 0<α) (ha1 : α<1) (qs : List ℕ) :
    ∃ a z : ℝ, (qs.map (compressed α)).prod = !![a,z;0,1] ∧
      0≤a ∧ a≤1 ∧ 0≤z ∧ z≤(qs.sum:ℝ)^α := by
  obtain ⟨a,z,hprod,ha0,haone,hz0,hz⟩ := triangular_budget_strong α ha ha1
    (qs.map (fun q : ℕ => ((q:ℝ),ell q))) (by
      intro qe hqe; obtain ⟨q,hq,rfl⟩ := List.mem_map.mp hqe
      exact ⟨Nat.cast_nonneg _,ell_bounds q⟩)
  refine ⟨a,z,?_,ha0,haone,hz0,?_⟩
  · simpa only [List.map_map,Function.comp_def,← compressed_budgetTri α ha ha1] using hprod
  · have hq : (0:ℝ)≤qs.sum := Nat.cast_nonneg _
    have hpow : (1-a)^(1-α) ≤ 1 := by
      simpa using Real.rpow_le_rpow (by linarith : 0≤1-a) (by linarith : 1-a≤1) (by linarith : 0≤1-α)
    have hs : ((qs.map (fun q : ℕ => ((q:ℝ),ell q))).map Prod.fst).sum = (qs.sum:ℝ) := by simp [Function.comp_def]
    rw [hs] at hz
    exact hz.trans (by nlinarith [Real.rpow_nonneg hq α])

#assert_trust kernel compressed_product_budget
end NLA.MF12
