/- Every-length logarithmic-gap lower estimate from Colbrook's MF-12.
A rational Bernoulli bound replaces the source exponential constant. -/
import NLA.MF12.ScalarBudget
import Mathlib.Data.Nat.Log
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF12

lemma geometric_budget (u : ℝ) (hu : 0≤u) (hu1 : u≤1) (k : ℕ) :
    (1-u)^k*(1+(k:ℝ)*u) ≤ 1 := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hp : 0≤(1-u)^k := pow_nonneg (by linarith) _
    have hk : (0:ℝ)≤k := Nat.cast_nonneg _
    have he : (1-u)^k*(1+(k:ℝ)*u) -
        (1-u)^(k+1)*(1+((k+1:ℕ):ℝ)*u) =
        (1-u)^k*((k:ℝ)+1)*u^2 := by rw [pow_succ]; push_cast; ring
    have hn : 0≤(1-u)^k*((k:ℝ)+1)*u^2 := by positivity
    linarith

lemma geometric_gain (u : ℝ) (hu : 0≤u) (hu1 : u≤1) (k : ℕ)
    (hk : (1/4:ℝ)≤(k:ℝ)*u) : (1/5:ℝ)≤1-(1-u)^k := by
  have hb := geometric_budget u hu hu1 k
  have hp : 0≤(1-u)^k := pow_nonneg (by linarith) _
  nlinarith

lemma four_pow_linear (q : ℕ) (hq : 1≤q) : 2*(q+1)≤4^q := by
  induction q,hq using Nat.le_induction with
  | base => norm_num
  | succ q hq ih => rw [pow_succ]; nlinarith

lemma logarithmic_budget (n : ℕ) (hn : 4≤n) :
    let q := Nat.log 4 n
    1≤q ∧ (1/4:ℝ)≤((n/(q+1):ℕ):ℝ)*ell q ∧ (n:ℝ)/4≤(4:ℝ)^q := by
  dsimp only
  let q := Nat.log 4 n
  have hq : 1≤q := Nat.le_log_of_pow_le (by norm_num) (by simpa using hn)
  have hp : 4^q≤n := Nat.pow_log_le_self 4 (by omega)
  have hpnext : n<4^(q+1) := Nat.lt_pow_succ_log_self (by norm_num : 1<4) n
  have hlinear : 2*(q+1)≤n := (four_pow_linear q hq).trans hp
  let k := n/(q+1)
  have hk : 1≤k := Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt (Nat.div_pos (by omega) (by omega)))
  have hrem := Nat.mod_lt n (by omega : 0<q+1)
  have hdiv := Nat.mod_add_div n (q+1)
  have hfloor : n≤2*k*(q+1) := by dsimp [k]; nlinarith
  have hkp : 4^q≤4*k*q := by nlinarith
  have hkpR : (4:ℝ)^q≤4*(k:ℝ)*(q:ℝ) := by exact_mod_cast hkp
  have hpR : (0:ℝ)<4^q := by positivity
  have hell : ell q = (q:ℝ)/(4:ℝ)^q := by simp [ell,div_pow]; ring
  refine ⟨hq,?_,?_⟩
  · change (1/4:ℝ)≤(k:ℝ)*ell q
    rw [hell,← mul_div_assoc]
    apply (le_div_iff₀ hpR).mpr
    nlinarith
  · have hR : (n:ℝ)<(4:ℝ)^(q+1) := by exact_mod_cast hpnext
    rw [pow_succ] at hR
    linarith

lemma compressed_power (α : ℝ) (q : ℕ) (hq : 1≤q) (k : ℕ) :
    (compressed α q)^k = !![(1-ell q)^k,
      ((q:ℝ)*(fractionalParameter α)^q/ell q)*(1-(1-ell q)^k);0,1] := by
  have he : ell q ≠ 0 := by unfold ell; exact mul_ne_zero (by exact_mod_cast (by omega : q≠0)) (pow_ne_zero _ (by norm_num))
  induction k with
  | zero => ext i j; fin_cases i <;> fin_cases j <;> simp
  | succ k ih =>
    rw [pow_succ,ih]
    ext i j; fin_cases i <;> fin_cases j <;> simp [compressed,Matrix.mul_apply,Fin.sum_univ_two,pow_succ]
    field_simp; ring

lemma compressed_ratio (α : ℝ) (q : ℕ) (hq : 1≤q) :
    (q:ℝ)*(fractionalParameter α)^q/ell q = ((4:ℝ)^q)^α := by
  have hq0 : (q:ℝ)≠0 := by exact_mod_cast (by omega : q≠0)
  have hx : (0:ℝ)<(1/4:ℝ)^q := by positivity
  rw [ell,mul_div_mul_left _ _ hq0,fractional_power]
  calc
    ((1/4:ℝ)^q)^(1-α) / (1/4:ℝ)^q = ((1/4:ℝ)^q)^((1-α)-1) := by
      rw [Real.rpow_sub hx (1-α) 1,Real.rpow_one]
    _ = ((4:ℝ)^q)^α := by
      have he : (1-α)-1 = -α := by ring
      rw [he,Real.rpow_neg_eq_inv_rpow]
      congr 1
      simp [div_pow]

/-- The actual compressed off-diagonal at the prescribed every-length gaps. -/
theorem compressed_every_length_lower (α : ℝ) (ha : 0<α) (ha1 : α<1)
    (n : ℕ) (hn : 4≤n) :
    (1/5:ℝ)*((n:ℝ)/4)^α ≤
      ((compressed α (Nat.log 4 n))^(n/(Nat.log 4 n+1))) 0 1 := by
  obtain ⟨hq,hbudget,hscale⟩ := logarithmic_budget n hn
  have hell := ell_bounds (Nat.log 4 n)
  have hgain := geometric_gain _ hell.1 hell.2 _ hbudget
  rw [compressed_power α _ hq,compressed_ratio α _ hq]
  change (1/5:ℝ)*((n:ℝ)/4)^α ≤
    ((4:ℝ)^(Nat.log 4 n))^α*(1-(1-ell (Nat.log 4 n))^(n/(Nat.log 4 n+1)))
  have hr := Real.rpow_le_rpow (by positivity : 0≤(n:ℝ)/4) hscale ha.le
  have hp := Real.rpow_nonneg (by positivity : (0:ℝ)≤4^(Nat.log 4 n)) α
  nlinarith

#assert_trust kernel compressed_every_length_lower
end NLA.MF12
