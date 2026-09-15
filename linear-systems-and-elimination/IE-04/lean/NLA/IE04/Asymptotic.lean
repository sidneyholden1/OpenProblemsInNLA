import Mathlib
import NLA.IE04.Definitions
set_option autoImplicit false
set_option backward.isDefEq.respectTransparency false
noncomputable section
open Filter
namespace NLA.IE04

lemma exponentCost_bound (n : ℕ) (hn : 2 ≤ n) : exponentCost n ≤ 3*n^4 := by
  unfold exponentCost
  have : n + 5 ≤ 2*n^2 := by nlinarith
  nlinarith [Nat.mul_le_mul_left (n^2) this]

lemma escape_identity (n : ℕ) (hn : 2 ≤ n) (c : ℝ) :
    Real.exp (Real.log (3/2:ℝ) * n) / Real.rpow n (c+4) =
      3 * threshold n c / (n:ℝ)^4 := by
  have hn0 : (0:ℝ) < n := by exact_mod_cast (by omega : 0<n)
  have hpow : (3/2:ℝ)^n = (3/2:ℝ)^(n-1) * (3/2) := by
    conv_lhs => rw [show n = (n-1)+1 by omega]
    rw [pow_succ]
  simp only [Real.rpow_eq_pow]
  rw [mul_comm (Real.log (3/2:ℝ)) (n:ℝ), Real.exp_nat_mul,
    Real.exp_log (by norm_num : (0:ℝ)<3/2), Real.rpow_add hn0 c 4]
  norm_num only [Real.rpow_natCast, Real.rpow_ofNat]
  rw [hpow]
  simp only [threshold, highGrowth, Real.rpow_eq_pow]
  ring

lemma asymptotic_escape_proved (c₁ c₂ : ℝ) (_h₁ : 0 < c₁) (h₂ : 0 < c₂) :
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
      2 ≤ n ∧ 1 ≤ threshold n c₁ ∧ (exponentCost n : ℝ) < c₂ * threshold n c₁ := by
  have ht := (tendsto_exp_mul_div_rpow_atTop (c₁+4) (Real.log (3/2:ℝ))
    (Real.log_pos (by norm_num))).comp tendsto_natCast_atTop_atTop
  have hE : ∀ᶠ n : ℕ in atTop, 2 ≤ n ∧
      3 < Real.exp (Real.log (3/2:ℝ) * n) / Real.rpow n (c₁+4) ∧
      9/c₂ < Real.exp (Real.log (3/2:ℝ) * n) / Real.rpow n (c₁+4) := by
    filter_upwards [eventually_ge_atTop 2, ht.eventually_gt_atTop 3,
      ht.eventually_gt_atTop (9/c₂)] with n hn h1 h2
    exact ⟨hn,h1,h2⟩
  obtain ⟨N,hN⟩ := eventually_atTop.mp hE
  refine ⟨N,fun n hn => ?_⟩
  obtain ⟨hn2,h1,h2⟩ := hN n hn
  rw [escape_identity n hn2 c₁] at h1 h2
  have hn0 : (0:ℝ) < n := by exact_mod_cast (by omega : 0<n)
  have hn4 : (0:ℝ) < (n:ℝ)^4 := pow_pos hn0 _
  have hn41 : (1:ℝ) ≤ (n:ℝ)^4 := by
    exact one_le_pow₀ (by exact_mod_cast (by omega : 1≤n))
  have h1' := (lt_div_iff₀ hn4).mp h1
  have h2' := (div_lt_div_iff₀ h₂ hn4).mp h2
  have hc : (exponentCost n : ℝ) ≤ 3*(n:ℝ)^4 := by
    exact_mod_cast exponentCost_bound n hn2
  exact ⟨hn2,by nlinarith,by nlinarith⟩

end NLA.IE04
