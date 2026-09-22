/- MI-04: exact threshold and two-weight comparison, including zero row sums.
Formal-proof adaptation: Sidney Holden with OpenAI Codex. Apache-2.0. -/
import NLA.MI04.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
noncomputable section
open scoped BigOperators
namespace NLA.MI04

lemma threshold_compare (R C : ℝ) (hR : 0 ≤ R) (hC : 0 ≤ C)
    (h : ∀ s : ℝ, 0 < s → s^2*R < 1 → s^2*C ≤ 1) : C ≤ R := by
  by_contra hn
  have hlt : R < C := lt_of_not_ge hn
  have hd : 0 < R+C := by linarith
  let s := Real.sqrt (2/(R+C))
  have hs : 0 < s := Real.sqrt_pos.mpr (by positivity)
  have hs2 : s^2 = 2/(R+C) := Real.sq_sqrt (by positivity)
  have he : s^2*(R+C)=2 := by rw [hs2]; field_simp
  have hsmall : s^2*R < 1 := by nlinarith [sq_pos_of_pos hs]
  have hbound := h s hs hsmall
  nlinarith [sq_pos_of_pos hs]

def baseWeights {ι : Type*} [DecidableEq ι] (i : ι) (k : ι) : ℝ :=
  if k=i then 2 else 1
def changedWeights {ι : Type*} [DecidableEq ι] (i j : ι) (k : ι) : ℝ :=
  if k=j then 1/2 else baseWeights i k

lemma changed_sum {ι : Type*} [Fintype ι] [DecidableEq ι]
    (f : ι → ℝ) (i j : ι) (hij : i ≠ j) :
    (∑ k, f k / changedWeights i j k) = (∑ k, f k / baseWeights i k) + f j := by
  have hpoint (k : ι) : f k / changedWeights i j k =
      f k / baseWeights i k + if k=j then f j else 0 := by
    by_cases hk : k=j
    · subst k; simp [changedWeights,baseWeights,Ne.symm hij]; ring
    · simp [changedWeights,hk]
  simp_rw [hpoint,Finset.sum_add_distrib]
  simp

lemma two_weight_equalities {ι : Type*} [Fintype ι] [DecidableEq ι]
    (f g : ι → ℝ) (i j : ι) (hij : i ≠ j)
    (h0 : (∑ k, f k / baseWeights i k) = ∑ k, g k / baseWeights i k)
    (h1 : (∑ k, f k / changedWeights i j k) = ∑ k, g k / changedWeights i j k) :
    f j = g j := by
  rw [changed_sum f i j hij,changed_sum g i j hij,h0] at h1
  exact add_left_cancel h1

lemma baseWeights_admissible {ι : Type*} [DecidableEq ι] (i : ι) :
    baseWeights i i=2 ∧ (∀ k, 0<baseWeights i k) ∧
      ∀ k, k ≠ i → baseWeights i k < 2 := by
  refine ⟨by simp [baseWeights],?_,?_⟩
  · intro k; unfold baseWeights; split_ifs <;> norm_num
  · intro k hk; simp [baseWeights,hk]

lemma changedWeights_admissible {ι : Type*} [DecidableEq ι] (i j : ι) (hij : i ≠ j) :
    changedWeights i j i=2 ∧ (∀ k, 0<changedWeights i j k) ∧
      ∀ k, k ≠ i → changedWeights i j k < 2 := by
  refine ⟨by simp [changedWeights,baseWeights,hij],?_,?_⟩
  · intro k; unfold changedWeights baseWeights; split_ifs <;> norm_num
  · intro k hk; unfold changedWeights baseWeights; split_ifs <;> norm_num <;> contradiction

#assert_trust kernel threshold_compare
#assert_trust kernel two_weight_equalities
end NLA.MI04
