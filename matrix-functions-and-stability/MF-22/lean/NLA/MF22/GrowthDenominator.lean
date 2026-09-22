/- Elementary exponential dominance and ratio estimates used by the finite Green matrix.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.Decomposition
import Mathlib.Analysis.SpecificLimits.Basic
set_option autoImplicit false
noncomputable section
namespace NLA.MF22

lemma dominant_denominator (lam gamma : ℂ) (hL : 1<‖lam‖) (hg : gamma ≠ 0)
    (B : ℝ) (hB : 0<B) (b : ℕ → ℂ) (hb : ∀ n, ‖b n‖ ≤ B) :
    ∃ N : ℕ, 1≤N ∧ ∀ n, N≤n →
      gamma*lam^n+b n ≠ 0 ∧ ‖gamma‖*‖lam‖^n/2 ≤ ‖gamma*lam^n+b n‖ := by
  have hgp : 0<‖gamma‖ := norm_pos_iff.mpr hg
  obtain ⟨N,hN⟩ := Filter.eventually_atTop.mp ((tendsto_pow_atTop_atTop_of_one_lt hL).eventually (Filter.eventually_gt_atTop (2*B/‖gamma‖)))
  refine ⟨max N 1,le_max_right _ _,?_⟩
  intro n hn
  have hp : ‖lam‖^N ≤ ‖lam‖^n := pow_le_pow_right₀ (le_of_lt hL) (le_trans (le_max_left _ _) hn)
  have hlarge : 2*B < ‖gamma‖*‖lam‖^n := by
    have hh : 2*B/‖gamma‖ < ‖lam‖^n := (hN N le_rfl).trans_le hp
    exact (div_lt_iff₀ hgp).mp hh |>.trans_eq (mul_comm _ _)
  have ht : ‖gamma*lam^n‖ ≤ ‖gamma*lam^n+b n‖+‖b n‖ := by
    simpa using norm_sub_le (gamma*lam^n+b n) (b n)
  rw [norm_mul,norm_pow] at ht
  have hlower : ‖gamma‖*‖lam‖^n/2 ≤ ‖gamma*lam^n+b n‖ := by nlinarith [hb n]
  refine ⟨?_,hlower⟩
  apply norm_pos_iff.mp
  exact lt_of_lt_of_le (by positivity) hlower

lemma normalized_power_bound (lam gamma d x : ℂ) (n k : ℕ)
    (hL : 1≤‖lam‖) (hg : gamma ≠ 0)
    (hd : ‖gamma‖*‖lam‖^n/2 ≤ ‖d‖) (hk : k≤n) :
    ‖lam^k*x/d‖ ≤ 2*‖x‖/‖gamma‖ := by
  have hgp : 0<‖gamma‖ := norm_pos_iff.mpr hg
  have hLp : 0<‖lam‖ := lt_of_lt_of_le zero_lt_one hL
  have hdp : 0<‖d‖ := lt_of_lt_of_le (by positivity) hd
  rw [norm_div,norm_mul,norm_pow]
  apply (div_le_iff₀ hdp).mpr
  have hp : ‖lam‖^k ≤ ‖lam‖^n := pow_le_pow_right₀ hL hk
  have hmul := mul_le_mul_of_nonneg_left hd (show 0≤2*‖x‖/‖gamma‖ by positivity)
  have he : (2*‖x‖/‖gamma‖)*(‖gamma‖*‖lam‖^n/2)=‖lam‖^n*‖x‖ := by field_simp
  rw [he] at hmul
  exact (mul_le_mul_of_nonneg_right hp (norm_nonneg _)).trans hmul
end NLA.MF22
