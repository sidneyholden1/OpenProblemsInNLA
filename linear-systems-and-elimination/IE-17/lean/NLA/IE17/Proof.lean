/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance.
Mathematical counterexample: Matthew J. Colbrook. Original questions: Fong and Saunders.
-/
import NLA.IE17.Certificates
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.IE17

lemma vnorm_nonneg {ι : Type*} [Fintype ι] (x : ι → ℝ) : 0 ≤ vnorm x := norm_nonneg _
lemma vnorm_sq {ι : Type*} [Fintype ι] (x : ι → ℝ) :
    vnorm x ^ 2 = ∑ i, (x i)^2 := by
  exact EuclideanSpace.real_norm_sq_eq (WithLp.toLp 2 x)
lemma vnorm_mulVec {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ) (x : Fin n → ℝ) :
    vnorm (A *ᵥ x) ≤ ‖A‖ * vnorm x := A.l2_opNorm_mulVec (WithLp.toLp 2 x)

lemma vnorm_sq_dot {ι : Type*} [Fintype ι] (x : ι → ℝ) :
    vnorm x^2 = x ⬝ᵥ x := by rw [vnorm_sq]; simp [dotProduct, pow_two]
lemma vnorm_mulVec_sq {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ) (x : Fin n → ℝ) :
    vnorm (A *ᵥ x)^2 ≤ ‖A‖^2 * vnorm x^2 := by
  have h := vnorm_mulVec A x
  nlinarith [vnorm_nonneg (A *ᵥ x), mul_nonneg (norm_nonneg A) (vnorm_nonneg x)]
lemma vnorm_sub_sq {ι : Type*} [Fintype ι] (x y : ι → ℝ) :
    vnorm (x-y)^2 = vnorm x^2 + vnorm y^2 - 2*(x ⬝ᵥ y) := by
  simp [vnorm_sq_dot, dotProduct_sub, dotProduct_comm]
  ring
lemma vnorm_neg {ι : Type*} [Fintype ι] (x : ι → ℝ) : vnorm (-x) = vnorm x := by
  exact norm_neg (WithLp.toLp 2 x)
lemma vnorm_pos {ι : Type*} [Fintype ι] {x : ι → ℝ} (hx : x ≠ 0) : 0 < vnorm x := by
  exact norm_pos_iff.mpr (by simpa using hx)

lemma backward_attained {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℝ)
    (b : Fin m → ℝ) (x : Fin n → ℝ) :
    ∃ E, feasible A E b x ∧ backwardError A b x = ‖E‖ := by
  let S : Set (Matrix (Fin m) (Fin n) ℝ) := {E | feasible A E b x}
  have hn : S.Nonempty := ⟨-A, by simp [S, feasible]⟩
  have hc : IsClosed S := by
    apply isClosed_eq (g := fun _ => (0 : Fin n → ℝ)) ?_ continuous_const
    fun_prop
  obtain ⟨E, hE, he⟩ := hc.exists_infDist_eq_dist hn 0
  refine ⟨E, hE, ?_⟩
  have hi := Metric.isGLB_infDist (x := (0 : Matrix (Fin m) (Fin n) ℝ)) hn
  have hs : ((dist (0 : Matrix (Fin m) (Fin n) ℝ) ·) '' S) =
      {t : ℝ | ∃ E, feasible A E b x ∧ t = ‖E‖} := by
    ext t
    simp [S, dist_zero_left, eq_comm]
  rw [hs] at hi
  rw [backwardError, hi.csInf_eq ⟨‖-A‖, -A, by simp [feasible], rfl⟩, he, dist_zero_left]

lemma witness_injective : Function.Injective witnessA.mulVec := by
  intro x y h
  have h0 := congrFun h 0
  have h1 := congrFun h 1
  have h2 := congrFun h 2
  simp [witnessA, Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h0 h1 h2
  ext i; fin_cases i <;> simp_all

lemma krylov_one (y : Fin 3 → ℝ) : y ∈ krylovSpace witnessA witnessB 1 ↔
    ∃ t : ℝ, y = ![11*t,6*t,5*t] := by
  rw [krylovSpace, Submodule.mem_span_range_iff_exists_fun]
  constructor
  · rintro ⟨c, rfl⟩
    refine ⟨c 0, ?_⟩
    ext i; fin_cases i <;>
      simp [witnessA, witnessB, Matrix.mulVec, dotProduct, Fin.sum_univ_succ] <;> ring
  · rintro ⟨t, rfl⟩
    refine ⟨fun _ => t, ?_⟩
    ext i; fin_cases i <;>
      simp [witnessA, witnessB, Matrix.mulVec, dotProduct, Fin.sum_univ_succ] <;> ring

lemma krylov_two (y : Fin 3 → ℝ) : y ∈ krylovSpace witnessA witnessB 2 ↔
    ∃ t u : ℝ, y = ![11*t+11*u,6*t+216*u,5*t+125*u] := by
  rw [krylovSpace, Submodule.mem_span_range_iff_exists_fun]
  constructor
  · rintro ⟨c, rfl⟩
    refine ⟨c 0, c 1, ?_⟩
    ext i; fin_cases i <;>
      simp [witnessA, witnessB, Matrix.mulVec, Matrix.mul_apply, dotProduct,
        Fin.sum_univ_succ] <;> ring
  · rintro ⟨t,u,rfl⟩
    refine ⟨![t,u], ?_⟩
    ext i; fin_cases i <;>
      simp [witnessA, witnessB, Matrix.mulVec, Matrix.mul_apply, dotProduct,
        Fin.sum_univ_succ] <;> ring

lemma normal_sq (y : Fin 3 → ℝ) :
    vnorm (normalResidual witnessA witnessB y)^2 =
      (11-y 0)^2+(6-36*y 1)^2+(5-25*y 2)^2 := by
  simp [vnorm_sq, normalResidual, residual, witnessA, witnessB,
    Matrix.mulVec, dotProduct, Fin.sum_univ_succ]
  ring

lemma residual_gap_one (y : Fin 3 → ℝ) (hy : y ∈ krylovSpace witnessA witnessB 1) :
    vnorm (normalResidual witnessA witnessB y)^2 =
    vnorm (normalResidual witnessA witnessB x1)^2 +
      (y 0-x1 0)^2+(36*(y 1-x1 1))^2+(25*(y 2-x1 2))^2 := by
  rcases (krylov_one y).mp hy with ⟨t,rfl⟩
  norm_num [normal_sq, x1, Matrix.cons_val_two]
  ring

lemma residual_gap_two (y : Fin 3 → ℝ) (hy : y ∈ krylovSpace witnessA witnessB 2) :
    vnorm (normalResidual witnessA witnessB y)^2 =
    vnorm (normalResidual witnessA witnessB x2)^2 +
      (y 0-x2 0)^2+(36*(y 1-x2 1))^2+(25*(y 2-x2 2))^2 := by
  rcases (krylov_two y).mp hy with ⟨t,u,rfl⟩
  norm_num [normal_sq, x2, Matrix.cons_val_two]
  ring

lemma iterate_of_gap (k : ℕ) (x : Fin 3 → ℝ) (hx : x ∈ krylovSpace witnessA witnessB k)
    (hg : ∀ y ∈ krylovSpace witnessA witnessB k,
      vnorm (normalResidual witnessA witnessB y)^2 =
      vnorm (normalResidual witnessA witnessB x)^2 +
        (y 0-x 0)^2+(36*(y 1-x 1))^2+(25*(y 2-x 2))^2) :
    isLSMRIterate witnessA witnessB k x := by
  refine ⟨hx, ?_, ?_⟩
  · intro y hy
    have he := hg y hy
    nlinarith [vnorm_nonneg (normalResidual witnessA witnessB x),
      vnorm_nonneg (normalResidual witnessA witnessB y), sq_nonneg (y 0-x 0),
      sq_nonneg (36*(y 1-x 1)), sq_nonneg (25*(y 2-x 2))]
  · intro y hy heq
    have he := hg y hy
    rw [heq] at he
    have hz0 : y 0 = x 0 := by nlinarith [sq_nonneg (36*(y 1-x 1)), sq_nonneg (25*(y 2-x 2))]
    have hz1 : y 1 = x 1 := by nlinarith [sq_nonneg (y 0-x 0), sq_nonneg (25*(y 2-x 2))]
    have hz2 : y 2 = x 2 := by nlinarith [sq_nonneg (y 0-x 0), sq_nonneg (36*(y 1-x 1))]
    have hxy : y = x := by ext i; fin_cases i <;> assumption
    simp [hxy]

theorem iterates :
    Function.Injective witnessA.mulVec ∧
    isLSMRIterate witnessA witnessB 1 x1 ∧ isLSMRIterate witnessA witnessB 2 x2 ∧
    x1 ≠ 0 ∧ x2 ≠ 0 ∧ normalResidual witnessA witnessB x1 ≠ 0 ∧
    normalResidual witnessA witnessB x2 ≠ 0 := by
  refine ⟨witness_injective, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · apply iterate_of_gap 1 x1 _ residual_gap_one
    exact (krylov_one x1).mpr ⟨1021/31201, by ext i; fin_cases i <;> norm_num [x1]⟩
  · apply iterate_of_gap 2 x2 _ residual_gap_two
    exact (krylov_two x2).mpr ⟨16321/110438,-383/110438, by ext i; fin_cases i <;> norm_num [x2]⟩
  all_goals
    intro h
    have h0 := congrFun h 0
    norm_num [x1,x2,normalResidual,residual,witnessA,witnessB,
      Matrix.mulVec,dotProduct,Fin.sum_univ_succ] at h0

lemma residual_one : residual witnessA witnessB x1 =
    ![331980/31201,-5555/31201,5676/31201,1] := by
  ext i; fin_cases i <;> norm_num [residual,witnessA,witnessB,x1,Matrix.mulVec,dotProduct,Fin.sum_univ_succ]
lemma residual_two : residual witnessA witnessB x2 =
    ![519750/55219,9625/55219,-29106/55219,1] := by
  ext i; fin_cases i <;> norm_num [residual,witnessA,witnessB,x2,Matrix.mulVec,dotProduct,Fin.sum_univ_succ]

lemma lower_feasible_sq (E : Matrix (Fin 4) (Fin 3) ℝ)
    (hE : feasible witnessA E witnessB x2) : (99/100 : ℝ) ≤ ‖E‖^2 := by
  let r := residual witnessA witnessB x2
  let v := r - E *ᵥ x2
  have hs : 0 < vnorm x2^2 := by
    norm_num [vnorm_sq, x2, Fin.sum_univ_succ]
  have hv : v = -((witnessA+E) *ᵥ x2-witnessB) := by
    dsimp [v, r, residual]
    rw [Matrix.add_mulVec]
    abel
  have hf : (witnessA+E)ᵀ *ᵥ v = 0 := by
    rw [hv, Matrix.mulVec_neg]
    simpa using congrArg Neg.neg hE
  have hat : witnessAᵀ *ᵥ v = -(Eᵀ *ᵥ v) := by
    simpa [Matrix.transpose_add, Matrix.add_mulVec, eq_neg_iff_add_eq_zero] using hf
  have hEx : r-v = E *ᵥ x2 := by dsimp [v]; abel
  by_cases hz : v = 0
  · have heq : r = E *ᵥ x2 := by simpa [hz] using hEx
    have hb := vnorm_mulVec_sq E x2
    rw [← heq] at hb
    have hr : (99/100 : ℝ)*vnorm x2^2 ≤ vnorm r^2 := by
      dsimp [r]
      rw [residual_two]
      norm_num [vnorm_sq, x2, Fin.sum_univ_succ]
    nlinarith
  · have hvp : 0 < vnorm v^2 := sq_pos_of_pos (vnorm_pos hz)
    have hbv : v ⬝ᵥ witnessB = vnorm v^2 := by
      have ht := congrArg (fun y : Fin 3 → ℝ => x2 ⬝ᵥ y) hf
      rw [Matrix.dotProduct_transpose_mulVec] at ht
      have hA : (witnessA+E) *ᵥ x2 = witnessB-v := by rw [hv]; abel
      rw [hA, dotProduct_sub, dotProduct_zero, ← vnorm_sq_dot] at ht
      linarith
    have hzv : (witnessA *ᵥ x2) ⬝ᵥ v = vnorm v^2-r ⬝ᵥ v := by
      have hh : witnessA *ᵥ x2 = witnessB-r := by dsimp [r,residual]; abel
      rw [hh, sub_dotProduct, dotProduct_comm witnessB, hbv]
    have hd : vnorm r^2 * vnorm v^2 - (r ⬝ᵥ v)^2 +
        ((witnessA *ᵥ x2) ⬝ᵥ v)^2 = vnorm v^2 * vnorm (E *ᵥ x2)^2 := by
      have he := vnorm_sub_sq r v
      rw [hEx] at he
      rw [hzv, he]
      ring
    have hC : vnorm (witnessAᵀ *ᵥ v)^2 ≤ ‖E‖^2 * vnorm v^2 := by
      have hh := vnorm_mulVec_sq Eᵀ v
      have hn : ‖Eᵀ‖ = ‖E‖ := by simpa using Matrix.l2_opNorm_conjTranspose E
      simpa [hat, vnorm_neg, hn] using hh
    have hD := mul_le_mul_of_nonneg_left (vnorm_mulVec_sq E x2) (sq_nonneg (vnorm v))
    have hQ := lower_form v
    change (99/100 : ℝ)*(v ⬝ᵥ v) ≤
      (5/6 : ℝ)*((witnessAᵀ *ᵥ v) ⬝ᵥ (witnessAᵀ *ᵥ v)) +
      (1/6 : ℝ)/(x2 ⬝ᵥ x2)*((r ⬝ᵥ r)*(v ⬝ᵥ v)-(r ⬝ᵥ v)^2+
      ((witnessA *ᵥ x2) ⬝ᵥ v)^2) at hQ
    rw [← vnorm_sq_dot v, ← vnorm_sq_dot (witnessAᵀ *ᵥ v),
      ← vnorm_sq_dot x2, ← vnorm_sq_dot r, hd] at hQ
    have hDdiv : (vnorm v^2 * vnorm (E *ᵥ x2)^2)/vnorm x2^2 ≤ ‖E‖^2 * vnorm v^2 := by
      apply (div_le_iff₀ hs).mpr
      nlinarith only [hD]
    have hQeq : (1/6 : ℝ)/vnorm x2^2*(vnorm v^2*vnorm (E *ᵥ x2)^2) =
        (1/6 : ℝ)*((vnorm v^2*vnorm (E *ᵥ x2)^2)/vnorm x2^2) := by ring
    rw [hQeq] at hQ
    have hh : (99/100 : ℝ)*vnorm v^2 ≤ ‖E‖^2*vnorm v^2 := by linarith only [hQ,hC,hDdiv]
    exact (mul_le_mul_iff_left₀ hvp).mp hh

lemma backward_le_norm {m n : ℕ} (A E : Matrix (Fin m) (Fin n) ℝ)
    (b : Fin m → ℝ) (x : Fin n → ℝ) (h : feasible A E b x) :
    backwardError A b x ≤ ‖E‖ := by
  unfold backwardError
  refine csInf_le ?_ ?_
  · exact ⟨0, fun t ⟨F,hF,ht⟩ => ht ▸ norm_nonneg F⟩
  · exact ⟨E,h,rfl⟩

theorem backward_increase :
    (∃ E, feasible witnessA E witnessB x1 ∧ backwardError witnessA witnessB x1 = ‖E‖) ∧
    (∃ E, feasible witnessA E witnessB x2 ∧ backwardError witnessA witnessB x2 = ‖E‖) ∧
    backwardError witnessA witnessB x1 ≤ Real.sqrt (1979/2000) ∧
    Real.sqrt (99/100) ≤ backwardError witnessA witnessB x2 ∧
    backwardError witnessA witnessB x1 < backwardError witnessA witnessB x2 := by
  have h1 : backwardError witnessA witnessB x1 ≤ Real.sqrt (1979/2000) := by
    apply (backward_le_norm witnessA upperE witnessB x1 upper_feasible).trans
    have hh := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 1979/2000)
    nlinarith [upper_norm_sq, Real.sqrt_nonneg (1979/2000)]
  have h2 : Real.sqrt (99/100) ≤ backwardError witnessA witnessB x2 := by
    rcases backward_attained witnessA witnessB x2 with ⟨E,hE,he⟩
    rw [he]
    have hh := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 99/100)
    nlinarith [lower_feasible_sq E hE, norm_nonneg E, Real.sqrt_nonneg (99/100)]
  have hgap : Real.sqrt (1979/2000) < Real.sqrt (99/100) :=
    Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  exact ⟨backward_attained _ _ _, backward_attained _ _ _, h1,h2,h1.trans_lt (hgap.trans_le h2)⟩

#assert_trust kernel iterates
#assert_trust kernel backward_attained
#assert_trust kernel backward_increase
end NLA.IE17
