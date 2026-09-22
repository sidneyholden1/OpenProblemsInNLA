/- Extending the fixed fractional family to every real exponent by repeated
fixed Jordan-two tensor lifts. Source: Colbrook MF-12; no dimension depends
on word length. Formalization: Sidney Holden with OpenAI Codex assistance. -/
import NLA.MF12.Growth
import NLA.MF12.IntegerGeometry
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator Kronecker
noncomputable section
namespace NLA.MF12

lemma pairBounds_integerLift {d : ℕ} (A B : Mat d) (γ : ℝ)
    (h : PairBounds A B γ) : PairBounds (integerLift A) (integerLift B) (γ+1) := by
  obtain ⟨c,C,hc,hcC,hu,hl⟩ := h
  let D := entryConstant (m:=Fin d) (n:=Fin d)
  let E := entryConstant (m:=Fin (d*2)) (n:=Fin (d*2))
  have hD : 0<D := entryConstant_pos
  have hE : 0<E := entryConstant_pos
  have hD1 : 1≤D := entryConstant_one_le
  have hE1 : 1≤E := entryConstant_one_le
  have hC : 0<C := hc.trans_le hcC
  refine ⟨c/D,E*C,div_pos hc hD,?_,?_,?_⟩
  · have hdiv : c/D≤c := (div_le_iff₀ hD).mpr (by nlinarith)
    exact hdiv.trans (hcC.trans (by nlinarith))
  · intro w hw
    have hwR : (0:ℝ)<w.length := by exact_mod_cast (by omega : 0<w.length)
    have hword : binaryProduct (integerLift A) (integerLift B) w =
        liftTensor (binaryProduct A B w) (jordanTwo^w.length) := integerLift_word A B w
    rw [hword]
    have hnorm := liftTensor_norm_upper (binaryProduct A B w) w.length hw
    have hb := mul_le_mul_of_nonneg_left (hu w hw) (mul_nonneg hE.le (Nat.cast_nonneg w.length))
    rw [Real.rpow_add hwR,Real.rpow_one]
    nlinarith [hnorm.trans hb]
  · intro k hk
    obtain ⟨w,hw,hlw⟩ := hl k hk
    refine ⟨w,hw,?_⟩
    have hkR : (0:ℝ)<k := by exact_mod_cast (by omega : 0<k)
    have hword : binaryProduct (integerLift A) (integerLift B) w =
        liftTensor (binaryProduct A B w) (jordanTwo^k) := by simpa [hw,binaryProduct] using integerLift_word A B w
    rw [hword,Real.rpow_add hkR,Real.rpow_one]
    have hn := liftTensor_norm_lower (binaryProduct A B w) k hk
    have hb := mul_le_mul_of_nonneg_left hlw hkR.le
    apply (mul_le_mul_iff_right₀ hD).mp
    have hdiv : D*(c/D*((k:ℝ)^γ*(k:ℝ))) = (k:ℝ)*(c*(k:ℝ)^γ) := by field_simp
    rw [hdiv]
    simpa [D,mul_comm] using hb.trans hn

lemma pairBounds_zero : PairBounds (1 : Mat 1) 0 0 := by
  have hu : ∀ w : List Bool, ‖binaryProduct (1 : Mat 1) 0 w‖≤1 := by
    intro w
    induction w with
    | nil => simp [binaryProduct]
    | cons b w ih =>
      cases b
      · simp [binaryProduct]
      · simpa [binaryProduct] using ih
  refine ⟨1,1,by norm_num,le_rfl,?_,?_⟩
  · intro w hw; simpa using hu w
  · intro k hk
    refine ⟨List.replicate k true,by simp,?_⟩
    simp [binaryProduct]

lemma pairBounds_add_nat (α : ℝ)
    (h : ∃ d : ℕ,1≤d ∧ ∃ A B : Mat d,A≠B ∧ PairBounds A B α) (m : ℕ) :
    ∃ d : ℕ,1≤d ∧ ∃ A B : Mat d,A≠B ∧ PairBounds A B (α+(m:ℝ)) := by
  induction m with
  | zero => simpa using h
  | succ m ih =>
    obtain ⟨d,hd,A,B,hAB,hb⟩ := ih
    refine ⟨d*2,by omega,integerLift A,integerLift B,?_,?_⟩
    · exact fun he => hAB (integerLift_injective he)
    · convert pairBounds_integerLift A B (α+(m:ℝ)) hb using 1 <;> push_cast <;> ring

lemma arbitrary_pair_from_fractional
    (hf : ∀ α : ℝ,0<α → α<1 → PairBounds (seed (fractionalParameter α)) reset α)
    (γ : ℝ) (hγ : 0≤γ) :
    ∃ d : ℕ,1≤d ∧ ∃ A B : Mat d,A≠B ∧ RealizesExponent ({A,B}:Set (Mat d)) γ := by
  let m : ℕ := ⌊γ⌋₊
  let α : ℝ := γ-(m:ℝ)
  have ha : 0≤α := sub_nonneg.mpr (Nat.floor_le hγ)
  have ha1 : α<1 := by have hh := Nat.lt_floor_add_one γ; dsimp [α,m]; linarith
  have hbase : ∃ d : ℕ,1≤d ∧ ∃ A B : Mat d,A≠B ∧ PairBounds A B α := by
    by_cases hzero : α=0
    · refine ⟨1,le_rfl,1,0,one_ne_zero,?_⟩
      simpa [hzero] using pairBounds_zero
    · refine ⟨6,by norm_num,seed (fractionalParameter α),reset,?_,hf α (lt_of_le_of_ne ha (Ne.symm hzero)) ha1⟩
      intro he
      have hh := congrArg (fun X : Mat 6 => X 1 1) he
      norm_num [seed,reset] at hh
  obtain ⟨d,hd,A,B,hAB,hb⟩ := pairBounds_add_nat α hbase m
  have he : α+(m:ℝ)=γ := by dsimp [α]; ring
  rw [he] at hb
  exact ⟨d,hd,A,B,hAB,realizes_of_pairBounds A B γ hb⟩

#assert_trust kernel pairBounds_integerLift
#assert_trust kernel arbitrary_pair_from_fractional
end NLA.MF12
