/- The source's exact rational LU witness in the original cyclic row order. -/
import NLA.IE14.Base
import Mathlib.LinearAlgebra.Matrix.Block
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE14

lemma sum_shift {n : ℕ} (i : Fin n) (d : ℕ) (v : Fin n → ℚ) :
    (∑ t : Fin n, if t.val+d=i.val then v t else 0) =
      if h : d ≤ i.val then v ⟨i.val-d,by have := i.isLt; omega⟩ else 0 := by
  split_ifs with h
  · let p : Fin n := ⟨i.val-d,by have := i.isLt; omega⟩
    rw [Finset.sum_eq_single p]
    · simp [p,Nat.sub_add_cancel h]
    · intro b hb hbp
      have hh : ¬b.val+d=i.val := by intro hh; apply hbp; apply Fin.ext; dsimp [p]; omega
      simp [hh]
    · simp
  · apply Finset.sum_eq_zero
    intro b hb
    have hh : ¬b.val+d=i.val := by omega
    simp [hh]

lemma lowerQ_mul_entry {n : ℕ} (i j : Fin n) (V : Matrix (Fin n) (Fin n) ℚ) :
    (lowerQ n * V) i j = V i j -
      (if h : 1 ≤ i.val then V ⟨i.val-1,by have := i.isLt; omega⟩ j else 0) -
      (if h : 2 ≤ i.val then V ⟨i.val-2,by have := i.isLt; omega⟩ j else 0) := by
  have hL : ∀t : Fin n, lowerQ n i t =
      (if t=i then 1 else 0) - (if t.val+1=i.val then 1 else 0) - (if t.val+2=i.val then 1 else 0) := by
    intro t
    by_cases he : t=i
    · subst t; simp [lowerQ]
    · have hv : t.val ≠ i.val := fun h => he (Fin.ext h)
      simp only [lowerQ,Ne.symm he,if_false,he]
      split_ifs <;> norm_num at * <;> omega
  simp only [Matrix.mul_apply,hL,sub_mul,Finset.sum_sub_distrib,ite_mul,one_mul,zero_mul]
  rw [Finset.sum_ite_eq',sum_shift i 1 (fun t => V t j),sum_shift i 2 (fun t => V t j)]
  simp

lemma factorRow_bijective {n : ℕ} (hn : 4 ≤ n) : Function.Bijective (@factorRow n) := by
  let g : Fin n → Fin n := fun t =>
    if t.val=0 then t else if t.val=1 then ⟨n-1,by omega⟩ else ⟨t.val-1,by have := t.isLt; omega⟩
  have hleft : Function.LeftInverse g factorRow := by
    intro i; have hi := i.isLt; apply Fin.ext
    simp only [factorRow,g]
    split_ifs <;> simp_all <;> omega
  have hright : Function.RightInverse g factorRow := by
    intro i
    have hi := i.isLt
    apply Fin.ext
    by_cases h0 : i.val=0
    · simp [g,h0,factorRow]
    by_cases h1 : i.val=1
    · have hn0 : n-1 ≠ 0 := by omega
      have hnn : ¬ n-1+1 < n := by omega
      simp [g,h1,factorRow,hn0,hnn,show 1 < n by omega]
    · have hpred : i.val-1 ≠ 0 := by omega
      have hsucc : i.val-1+1 < n := by omega
      simp [g,h0,h1,factorRow,hpred,hsucc]
      omega
  exact ⟨hleft.injective,hright.surjective⟩

def factorEquiv {n : ℕ} (hn : 4 ≤ n) : Equiv.Perm (Fin n) :=
  Equiv.ofBijective factorRow (factorRow_bijective hn)

lemma lowerQ_det (n : ℕ) : (lowerQ n).det = 1 := by
  rw [Matrix.det_of_isLowerTriangular]
  · simp [lowerQ]
  · intro i j hij
    change i < j at hij
    have hne : i ≠ j := hij.ne
    have hh : ¬(j.val+1=i.val ∨ j.val+2=i.val) := by simp only [Fin.lt_def] at hij; omega
    simp [lowerQ,hne,hh]

lemma upperQ_det_ne_zero (n : ℕ) : (upperQ n).det ≠ 0 := by
  have htri : (upperQ n).IsUpperTriangular := by
    intro i j hij
    change j < i at hij
    have hi := i.isLt
    have hj := j.isLt
    have hlast : j.val+1 ≠ n := by simp only [Fin.lt_def] at hij; omega
    have hhalf : ¬((i.val=0 ∧ j.val=1) ∨ (i.val=1 ∧ j.val=1)) := by simp only [Fin.lt_def] at hij; omega
    simp [upperQ,hlast,hhalf,hij.ne']
  rw [Matrix.det_of_isUpperTriangular htri]
  apply Finset.prod_ne_zero_iff.mpr
  intro i hi
  unfold upperQ
  split_ifs <;> norm_num at * <;> positivity

lemma witness_det_ne_zero {n : ℕ} (hn : 4 ≤ n) : (witness n).det ≠ 0 := by
  have hw : witnessQ n = (lowerQ n * upperQ n).submatrix (factorEquiv hn) id := rfl
  have hq : (witnessQ n).det ≠ 0 := by
    rw [hw,Matrix.det_permute,Matrix.det_mul,lowerQ_det,one_mul]
    exact mul_ne_zero (by exact_mod_cast (Equiv.Perm.sign (factorEquiv hn)).ne_zero) (upperQ_det_ne_zero n)
  have he : (witness n).det = ((witnessQ n).det : ℂ) := by
    symm; exact Rat.cast_det _
  rw [he]
  exact_mod_cast hq

lemma factor_product_nonlast {n : ℕ} (_hn : 4 ≤ n) (i j : Fin n)
    (hlast : j.val+1 ≠ n) (hj : j.val ≠ 1) :
    (lowerQ n * upperQ n) i j = lowerQ n i j := by
  have hu : ∀t : Fin n, upperQ n t j = if t=j then 1 else 0 := by
    intro t
    simp [upperQ,hlast,hj]
  simp [Matrix.mul_apply,hu]

lemma factor_product_second {n : ℕ} (hn : 4 ≤ n) (i j : Fin n) (hj : j.val=1) :
    (lowerQ n * upperQ n) i j =
      if i.val=0 then 1/2 else if i.val=2 then -1 else if i.val=3 then -1/2 else 0 := by
  have hlast : j.val+1 ≠ n := by omega
  rw [lowerQ_mul_entry]
  simp only [upperQ,hj,show 2 ≠ n by omega,if_false,Fin.ext_iff]
  by_cases h0 : i.val=0
  · norm_num [h0]
  by_cases h1 : i.val=1
  · norm_num [h1]
  by_cases h2 : i.val=2
  · norm_num [h2]
  by_cases h3 : i.val=3
  · norm_num [h3]
  have hi : 4 ≤ i.val := by omega
  have hi1 : 1 ≤ i.val := by omega
  have hi2 : 2 ≤ i.val := by omega
  simp [h0,h1,h2,h3,hi1,hi2,show i.val-1 ≠ 0 by omega,show i.val-1 ≠ 1 by omega,show i.val-2 ≠ 0 by omega,show i.val-2 ≠ 1 by omega]

lemma factor_product_last {n : ℕ} (hn : 4 ≤ n) (i j : Fin n) (hj : j.val+1=n) :
    (lowerQ n * upperQ n) i j = if i.val=0 ∨ i.val=1 ∨ i.val+1=n then 1 else 0 := by
  rw [lowerQ_mul_entry]
  simp only [upperQ,hj,if_true]
  by_cases h0 : i.val=0
  · simp [h0,Nat.fib_add_two,show 1 ≠ n by omega]
  by_cases h1 : i.val=1
  · norm_num [h1,Nat.fib_add_two,show 1 ≠ n by omega,show 2 ≠ n by omega]
  have hi := i.isLt
  have hi1 : 1 ≤ i.val := by omega
  have hi2 : 2 ≤ i.val := by omega
  have hm1 : i.val-1+1 ≠ n := by omega
  have hm2 : i.val-2+1 ≠ n := by omega
  have e1 : i.val-1+2=i.val+1 := by omega
  have e2 : i.val-2+2=i.val := by omega
  simp only [hi1,hi2,hm1,hm2,if_false,e1,e2,h0,h1,false_or]
  rw [Nat.fib_add_two,Nat.cast_add]
  split_ifs <;> ring

lemma factorRow_val {n : ℕ} (hn : 4 ≤ n) (i : Fin n) :
    (factorRow i).val = if i.val=0 then 0 else if i.val+1 < n then i.val+1 else 1 := by
  simp only [factorRow]
  split_ifs <;> simp_all <;> omega

lemma witnessQ_pattern {n : ℕ} (hn : 4 ≤ n) (i j : Fin n)
    (h : ¬((i.val ≤ j.val+1 ∧ j.val ≤ i.val+1) ∨
      (i.val=0 ∧ j.val+1=n) ∨ (j.val=0 ∧ i.val+1=n))) : witnessQ n i j = 0 := by
  unfold witnessQ
  have hv := factorRow_val hn i
  have hi := i.isLt
  have hj := j.isLt
  have hfcase : (i.val=0 ∧ (factorRow i).val=0) ∨
      (0 < i.val ∧ i.val+1 < n ∧ (factorRow i).val=i.val+1) ∨
      (i.val+1=n ∧ (factorRow i).val=1) := by
    by_cases h0 : i.val=0
    · left; simpa [h0] using (show i.val=0 ∧ (factorRow i).val=0 from ⟨h0,by simpa [h0] using hv⟩)
    by_cases hh : i.val+1 < n
    · right; left; exact ⟨by omega,hh,by simpa [h0,hh] using hv⟩
    · right; right; exact ⟨by omega,by simpa [h0,hh] using hv⟩
  by_cases hl : j.val+1=n
  · rw [factor_product_last hn _ _ hl]
    have hh : ¬((factorRow i).val=0 ∨ (factorRow i).val=1 ∨ (factorRow i).val+1=n) := by
      rcases hfcase with ⟨_,_⟩ | ⟨_,_,_⟩ | ⟨_,_⟩ <;> omega
    simp [hh]
  by_cases h1 : j.val=1
  · rw [factor_product_second hn _ _ h1]
    have hh0 : (factorRow i).val ≠ 0 := by rcases hfcase with ⟨_,_⟩ | ⟨_,_,_⟩ | ⟨_,_⟩ <;> omega
    have hh2 : (factorRow i).val ≠ 2 := by rcases hfcase with ⟨_,_⟩ | ⟨_,_,_⟩ | ⟨_,_⟩ <;> omega
    have hh3 : (factorRow i).val ≠ 3 := by rcases hfcase with ⟨_,_⟩ | ⟨_,_,_⟩ | ⟨_,_⟩ <;> omega
    simp [hh0,hh2,hh3]
  · rw [factor_product_nonlast hn _ _ hl h1]
    have he : factorRow i ≠ j := by
      intro he; have hev := congrArg Fin.val he
      rcases hfcase with ⟨_,_⟩ | ⟨_,_,_⟩ | ⟨_,_⟩ <;> omega
    have hh : ¬(j.val+1=(factorRow i).val ∨ j.val+2=(factorRow i).val) := by
      rcases hfcase with ⟨_,_⟩ | ⟨_,_,_⟩ | ⟨_,_⟩ <;> omega
    simp [lowerQ,he,hh]

lemma witness_entry_le_one {n : ℕ} (hn : 4 ≤ n) (i j : Fin n) : ‖witness n i j‖ ≤ 1 := by
  unfold witness witnessQ
  by_cases hl : j.val+1=n
  · rw [factor_product_last hn _ _ hl]
    split_ifs <;> norm_num
  by_cases h1 : j.val=1
  · rw [factor_product_second hn _ _ h1]
    split_ifs <;> norm_num [Complex.norm_ratCast]
  · rw [factor_product_nonlast hn _ _ hl h1]
    unfold lowerQ
    split_ifs <;> norm_num

lemma witness_corners {n : ℕ} (hn : 4 ≤ n) :
    witness n ⟨0,by omega⟩ ⟨n-1,by omega⟩ = 1 ∧
    witness n ⟨n-1,by omega⟩ ⟨0,by omega⟩ = -1 := by
  constructor
  · unfold witness witnessQ
    rw [factor_product_last hn _ _ (by dsimp; omega)]
    simp [factorRow]
  · unfold witness witnessQ
    rw [factor_product_nonlast hn _ _ (by dsimp; omega) (by norm_num)]
    have h0 : n-1 ≠ 0 := by omega
    have hl : ¬n-1+1 < n := by omega
    simp [factorRow,h0,hl,show 1 < n by omega,lowerQ,Fin.ext_iff]

lemma witness_cyclic {n : ℕ} (hn : 4 ≤ n) : IsCyclic (witness n) := by
  refine ⟨?_,?_,witness_det_ne_zero hn⟩
  · intro i j h
    unfold witness
    rw [witnessQ_pattern hn i j h]
    norm_num
  · refine ⟨⟨0,by omega⟩,⟨n-1,by omega⟩,rfl,by dsimp; omega,?_,?_⟩
    · rw [(witness_corners hn).1]; norm_num
    · rw [(witness_corners hn).2]; norm_num

lemma witness_entryMax {n : ℕ} (hn : 4 ≤ n) : entryMax (witness n) = 1 := by
  apply le_antisymm
  · exact entryMax_le _ 1 (by norm_num) (witness_entry_le_one hn)
  · have he := entry_le (witness n) ⟨0,by omega⟩ ⟨n-1,by omega⟩
    rw [(witness_corners hn).1,norm_one] at he
    exact he

#assert_trust kernel witness_cyclic
#assert_trust kernel witness_entryMax
end NLA.IE14
