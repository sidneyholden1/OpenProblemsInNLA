/- Exact words of every length carrying the scalar lower certificate. -/
import NLA.MF12.Words
import NLA.MF12.ScalarLower
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12

lemma binary_append {d : ℕ} (A B : Mat d) (v w : List Bool) :
    binaryProduct A B (v++w)=binaryProduct A B v*binaryProduct A B w := by
  simp [binaryProduct,List.prod_append]
lemma binary_replicate {d : ℕ} (A B : Mat d) (n : ℕ) :
    binaryProduct A B (List.replicate n true)=A^n := by simp [binaryProduct]

lemma reset_power_compression (α : ℝ) (q k : ℕ) :
    (reset*seed (fractionalParameter α)^q)^k * embedV = embedV*(compressed α q)^k := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [pow_succ',Matrix.mul_assoc,ih,← Matrix.mul_assoc,← VU_reset]
    rw [pow_succ',← compression_eq]
    simp only [Matrix.mul_assoc]

lemma padded_witness (α : ℝ) (n q k : ℕ) (hk : k*(q+1)≤n) :
    ∃ w : List Bool, w.length=n ∧
      ((compressed α q)^k) 0 1 ≤ 2*‖binaryProduct (seed (fractionalParameter α)) reset w‖ := by
  let block := false :: List.replicate q true
  let tailword := (List.replicate k block).flatten
  let w := List.replicate (n-k*(q+1)) true ++ tailword
  have ht : binaryProduct (seed (fractionalParameter α)) reset tailword =
      (reset*seed (fractionalParameter α)^q)^k := by
    dsimp [tailword]
    clear hk w tailword
    induction k with
    | zero => simp [binaryProduct]
    | succ k ih =>
      simp only [List.replicate_succ,List.flatten_cons,binary_append,ih]
      simp only [block,binary_cons,Bool.false_eq_true,ite_false,binary_replicate,pow_succ']
  have hwlen : w.length=n := by
    simp [w,tailword,block,List.length_flatten,List.sum_replicate]
    omega
  have he : binaryProduct (seed (fractionalParameter α)) reset w * embedV =
      seed (fractionalParameter α)^(n-k*(q+1))*embedV*(compressed α q)^k := by
    dsimp [w]
    rw [binary_append,binary_replicate,ht,Matrix.mul_assoc,reset_power_compression,← Matrix.mul_assoc]
  have hv : (binaryProduct (seed (fractionalParameter α)) reset w * embedV) 0 1 =
      ((compressed α q)^k) 0 1 := by
    rw [he,seed_pow]
    simp [seedPower,embedV,Matrix.mul_apply,Fin.sum_univ_succ]
  have he' : ((compressed α q)^k) 0 1 =
      binaryProduct (seed (fractionalParameter α)) reset w 0 4 +
      binaryProduct (seed (fractionalParameter α)) reset w 0 5 := by
    rw [← hv]
    simp [embedV,Matrix.mul_apply,Fin.sum_univ_succ]
  refine ⟨w,hwlen,?_⟩
  rw [he']
  have h4 := abs_entry_le_norm (binaryProduct (seed (fractionalParameter α)) reset w) 0 4
  have h5 := abs_entry_le_norm (binaryProduct (seed (fractionalParameter α)) reset w) 0 5
  linarith [le_abs_self (binaryProduct (seed (fractionalParameter α)) reset w 0 4),
    le_abs_self (binaryProduct (seed (fractionalParameter α)) reset w 0 5)]

lemma fractional_lower (α : ℝ) (ha : 0<α) (ha1 : α<1) :
    ∃ c : ℝ, 0<c ∧ ∀ n : ℕ, 1≤n → ∃ w : List Bool, w.length=n ∧
      c*(n:ℝ)^α ≤ ‖binaryProduct (seed (fractionalParameter α)) reset w‖ := by
  let c : ℝ := (1/10) / (4:ℝ)^α
  refine ⟨c,by dsimp [c]; positivity,?_⟩
  intro n hn
  by_cases hn4 : 4≤n
  · let q := Nat.log 4 n
    let k := n/(q+1)
    have hk : k*(q+1)≤n := Nat.div_mul_le_self _ _
    obtain ⟨w,hw,hh⟩ := padded_witness α n q k hk
    have hl := compressed_every_length_lower α ha ha1 n hn4
    refine ⟨w,hw,?_⟩
    have h4 : (0:ℝ)<4^α := Real.rpow_pos_of_pos (by norm_num) _
    have hr : ((n:ℝ)/4)^α = (n:ℝ)^α/(4:ℝ)^α := Real.div_rpow (by positivity : 0≤(n:ℝ)) (by norm_num : (0:ℝ)≤4) α
    rw [hr] at hl
    dsimp [c]
    change (1/5:ℝ)*((n:ℝ)^α/4^α) ≤ ((compressed α q)^k) 0 1 at hl
    have hec : (1/10:ℝ)/4^α*(n:ℝ)^α = (1/10)*((n:ℝ)^α/4^α) := by ring
    rw [hec]
    linarith
  · refine ⟨List.replicate n true,by simp,?_⟩
    rw [binary_replicate]
    have hentry := abs_entry_le_norm (seed (fractionalParameter α)^n) 0 0
    rw [seed_pow] at hentry
    have hnorm : 1≤‖seed (fractionalParameter α)^n‖ := by
      rw [seed_pow]; simpa [seedPower] using hentry
    have hn4' : (n:ℝ)≤4 := by exact_mod_cast (show n≤4 by omega)
    have hp := Real.rpow_le_rpow (by positivity : 0≤(n:ℝ)) hn4' ha.le
    have h4 : (0:ℝ)<4^α := Real.rpow_pos_of_pos (by norm_num) _
    apply le_trans _ hnorm
    dsimp [c]
    rw [div_mul_eq_mul_div]
    apply (div_le_iff₀ h4).2
    nlinarith [Real.rpow_nonneg (by positivity : 0≤(n:ℝ)) α]

end NLA.MF12
