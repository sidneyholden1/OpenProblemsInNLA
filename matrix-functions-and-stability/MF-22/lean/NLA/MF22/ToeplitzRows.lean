/- Literal finite Toeplitz rows, with zero extension and no boundary correction.
Source: George Stepaniants. Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.Transfer
set_option autoImplicit false
set_option maxHeartbeats 800000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22

def extendVec {n : ℕ} (x : Ix n → ℂ) (k : ℤ) (a : Fin 2) : ℂ :=
  ∑ i : Fin n, if (i.val : ℤ) = k then x (i,a) else 0

lemma extendVec_at {n : ℕ} (x : Ix n → ℂ) (j : Fin n) (a : Fin 2) :
    extendVec x j.val a = x (j,a) := by
  classical
  unfold extendVec
  rw [Finset.sum_eq_single j]
  · simp
  · intro b _ hb
    have h : (b.val : ℤ) ≠ j.val := by exact_mod_cast (Fin.val_ne_iff.mpr hb)
    simp [h]
  · simp

lemma extendVec_out {n : ℕ} (x : Ix n → ℂ) (k : ℤ) (a : Fin 2)
    (hk : k < 0 ∨ (n : ℤ) ≤ k) : extendVec x k a = 0 := by
  apply Finset.sum_eq_zero
  intro i _
  have h : (i.val : ℤ) ≠ k := by omega
  simp [h]

lemma sum_shift {n : ℕ} (x : Ix n → ℂ) (j k : ℤ) (a : Fin 2) (c : ℂ) :
    (∑ i : Fin n, if j-(i.val : ℤ)=k then c*x (i,a) else 0) =
      c*extendVec x (j-k) a := by
  rw [extendVec,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  have he : j-(i.val : ℤ)=k ↔ (i.val : ℤ)=j-k := by omega
  by_cases h : (i.val : ℤ)=j-k <;> simp [he,h]

lemma scaled_row_zero (r : ℝ) (k : ℤ) (u v : ℂ) :
    80*((Complex.I*B k 0 0-(r:ℂ)*C k 0 0)*u+
      (Complex.I*B k 0 1-(r:ℂ)*C k 0 1)*v) =
    (if k = -1 then sA r*u else 0) +
    (if k = 0 then (-24*(r:ℂ))*u+sB r*v else 0) +
    (if k = 1 then sF r*u+96*Complex.I*v else 0) +
    (if k = 2 then sC r*v else 0) := by
  by_cases h1 : k = -1
  · subst k; norm_num [B,C,sA,sB,sC,sF,Matrix.smul_apply]; ring
  by_cases h0 : k = 0
  · subst k; norm_num [B,C,sA,sB,sC,sF,Matrix.smul_apply]; ring
  by_cases h2 : k = 1
  · subst k; norm_num [B,C,sA,sB,sC,sF,Matrix.smul_apply]; ring
  by_cases h3 : k = 2
  · subst k; norm_num [B,C,sA,sB,sC,sF,Matrix.smul_apply]; ring
  simp [B,C,h1,h0,h2,h3]

lemma scaled_row_one (r : ℝ) (k : ℤ) (u v : ℂ) :
    80*((Complex.I*B k 1 0-(r:ℂ)*C k 1 0)*u+
      (Complex.I*B k 1 1-(r:ℂ)*C k 1 1)*v) =
    (if k = -1 then sB r*u else 0) +
    (if k = 0 then 96*Complex.I*u+sD r*v else 0) +
    (if k = 1 then sC r*u+24*(r:ℂ)*v else 0) +
    (if k = 2 then sE r*v else 0) := by
  by_cases h1 : k = -1
  · subst k; norm_num [B,C,sB,sC,sD,sE,Matrix.smul_apply]; ring
  by_cases h0 : k = 0
  · subst k; norm_num [B,C,sB,sC,sD,sE,Matrix.smul_apply]; ring
  by_cases h2 : k = 1
  · subst k; norm_num [B,C,sB,sC,sD,sE,Matrix.smul_apply]; ring
  by_cases h3 : k = 2
  · subst k; norm_num [B,C,sB,sC,sD,sE,Matrix.smul_apply]; ring
  simp [B,C,h1,h0,h2,h3]

lemma toeplitz_row_zero (r : ℝ) {n : ℕ} (x : Ix n → ℂ) (j : Fin n) :
    80*((H r n).mulVec x (j,0)) =
    sA r*extendVec x ((j.val:ℤ)+1) 0 -24*(r:ℂ)*extendVec x j.val 0 +
    sB r*extendVec x j.val 1+sF r*extendVec x ((j.val:ℤ)-1) 0+
    96*Complex.I*extendVec x ((j.val:ℤ)-1) 1+sC r*extendVec x ((j.val:ℤ)-2) 1 := by
  classical
  simp only [Matrix.mulVec,dotProduct,Fintype.sum_prod_type,Fin.sum_univ_two,H]
  rw [Finset.mul_sum]
  simp_rw [scaled_row_zero]
  have hi (p : Prop) [Decidable p] (a b : ℂ) : (if p then a+b else 0) = (if p then a else 0)+(if p then b else 0) := by split_ifs <;> simp
  simp only [hi,Finset.sum_add_distrib]
  simp_rw [sum_shift]
  simp only [sub_neg_eq_add,sub_zero]
  ring

lemma toeplitz_row_one (r : ℝ) {n : ℕ} (x : Ix n → ℂ) (j : Fin n) :
    80*((H r n).mulVec x (j,1)) =
    sB r*extendVec x ((j.val:ℤ)+1) 0+96*Complex.I*extendVec x j.val 0+
    sD r*extendVec x j.val 1+sC r*extendVec x ((j.val:ℤ)-1) 0+
    24*(r:ℂ)*extendVec x ((j.val:ℤ)-1) 1+sE r*extendVec x ((j.val:ℤ)-2) 1 := by
  classical
  simp only [Matrix.mulVec,dotProduct,Fintype.sum_prod_type,Fin.sum_univ_two,H]
  rw [Finset.mul_sum]
  simp_rw [scaled_row_one]
  have hi (p : Prop) [Decidable p] (a b : ℂ) : (if p then a+b else 0) = (if p then a else 0)+(if p then b else 0) := by split_ifs <;> simp
  simp only [hi,Finset.sum_add_distrib]
  simp_rw [sum_shift]
  simp only [sub_neg_eq_add,sub_zero]
  ring
end NLA.MF22
