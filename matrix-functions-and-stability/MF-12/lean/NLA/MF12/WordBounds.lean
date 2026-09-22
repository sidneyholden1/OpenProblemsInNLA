/- Bounds for arbitrary words in the exact six-dimensional pair. -/
import NLA.MF12.Words
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Topology.Order.LiminfLimsup
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12

lemma parameter_bounds (α : ℝ) (ha : 0<α) (ha1 : α<1) :
    0 < fractionalParameter α ∧ fractionalParameter α < 1 := by
  constructor
  · exact Real.rpow_pos_of_pos (by norm_num) _
  · exact Real.rpow_lt_one_of_one_lt_of_neg (by norm_num) (by linarith)

lemma seed_norm_bounded (α : ℝ) (ha : 0<α) (ha1 : α<1) :
    ∃ H : ℝ, 0<H ∧ ∀ q : ℕ, ‖seed (fractionalParameter α)^q‖ ≤ H := by
  obtain ⟨hμ0,hμ1⟩ := parameter_bounds α ha ha1
  obtain ⟨b,hb⟩ := (tendsto_self_mul_const_pow_of_lt_one hμ0.le hμ1).bddAbove_range
  let b' : ℝ := max 1 b
  have hb' : 1 ≤ b' := le_max_left _ _
  have hqb (q : ℕ) : (q:ℝ)*(fractionalParameter α)^q ≤ b' :=
    (hb (Set.mem_range_self q)).trans (le_max_right _ _)
  let H := entryConstant (m:=Fin 6) (n:=Fin 6) * b'
  refine ⟨H,mul_pos entryConstant_pos (by dsimp [b']; positivity),fun q => ?_⟩
  rw [seed_pow]
  apply norm_le_entry_bound _ b' (by linarith)
  have hpow : (fractionalParameter α)^q ≤ 1 := pow_le_one₀ hμ0.le hμ1.le
  have hlambda : (1/4:ℝ)^q ≤ 1 := pow_le_one₀ (by norm_num) (by norm_num)
  have hlambda' : (4^q : ℝ)⁻¹≤1 := by simpa using hlambda
  have hell := (ell_bounds q).2
  have hp0 : 0≤(fractionalParameter α)^q := pow_nonneg hμ0.le _
  have hqp0 : 0≤(q:ℝ)*(fractionalParameter α)^q := by positivity
  have hl0 : 0≤(q:ℝ)*(1/4:ℝ)^q := by positivity
  intro i j
  fin_cases i <;> fin_cases j <;>
    simp [seedPower,abs_of_nonneg hp0,abs_of_nonneg hqp0,abs_of_nonneg hl0,
      abs_of_nonneg (pow_nonneg (by norm_num : (0:ℝ)≤1/4) q)] <;>
    first | exact hqb q | simpa [ell] using hell.trans hb' | linarith


lemma compressed_norm_bound (α : ℝ) (ha : 0<α) (ha1 : α<1) (qs : List ℕ)
    (n : ℕ) (hn : 1≤n) (hqn : qs.sum≤n) :
    ‖(qs.map (compressed α)).prod‖ ≤ entryConstant (m:=Fin 2) (n:=Fin 2) * (n:ℝ)^α := by
  obtain ⟨a,z,he,ha0,ha1',hz0,hz⟩ := compressed_product_budget α ha ha1 qs
  rw [he]
  have hn1 : 1≤(n:ℝ)^α := Real.one_le_rpow (by exact_mod_cast hn) ha.le
  have hzn : z≤(n:ℝ)^α := hz.trans (Real.rpow_le_rpow (by positivity) (by exact_mod_cast hqn) ha.le)
  apply norm_le_entry_bound _ _ (by positivity)
  intro i j; fin_cases i <;> fin_cases j <;> simp [abs_of_nonneg ha0,abs_of_nonneg hz0] <;> linarith

lemma fractional_upper (α : ℝ) (ha : 0<α) (ha1 : α<1) :
    ∃ C : ℝ, 0<C ∧ ∀ w : List Bool, 1≤w.length →
      ‖binaryProduct (seed (fractionalParameter α)) reset w‖ ≤ C*(w.length:ℝ)^α := by
  obtain ⟨H,hH,hbound⟩ := seed_norm_bounded α ha ha1
  let K := entryConstant (m:=Fin 2) (n:=Fin 2)
  have hK : 0<K := entryConstant_pos
  let D := H*‖embedV‖*K*‖compressU‖*H
  have hD : 0≤D := by dsimp [D]; positivity
  refine ⟨H+D,hH.trans_le (by linarith),?_⟩
  intro w hw
  have hp : 1≤(w.length:ℝ)^α := Real.one_le_rpow (by exact_mod_cast hw) ha.le
  rcases word_factorization α w with he | ⟨a,b,qs,he,hlen⟩
  · rw [he]
    calc
      _ ≤ H := hbound _
      _ ≤ H*(w.length:ℝ)^α := le_mul_of_one_le_right hH.le hp
      _ ≤ (H+D)*(w.length:ℝ)^α := by gcongr; linarith
  · rw [he]
    have ht := compressed_norm_bound α ha ha1 qs w.length hw (by omega)
    calc
      _ ≤ ‖seed (fractionalParameter α)^a‖*‖embedV‖*‖(qs.map (compressed α)).prod‖*
          ‖compressU‖*‖seed (fractionalParameter α)^b‖ := by
        exact (Matrix.l2_opNorm_mul _ _).trans (mul_le_mul_of_nonneg_right
          ((Matrix.l2_opNorm_mul _ _).trans (mul_le_mul_of_nonneg_right
            ((Matrix.l2_opNorm_mul _ _).trans (mul_le_mul_of_nonneg_right
              (Matrix.l2_opNorm_mul _ _) (norm_nonneg _))) (norm_nonneg _))) (norm_nonneg _))
      _ ≤ H*‖embedV‖*(K*(w.length:ℝ)^α)*‖compressU‖*H := by gcongr <;> first | exact hbound _ | exact ht | positivity
      _ = D*(w.length:ℝ)^α := by dsimp [D]; ring
      _ ≤ (H+D)*(w.length:ℝ)^α := by gcongr; linarith

end NLA.MF12
