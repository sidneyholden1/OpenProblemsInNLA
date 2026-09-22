/- Actual complex GEPP path for Colbrook's rational IE-14 witness.
Formalization: Sidney Holden with OpenAI Codex assistance. -/
import NLA.IE14.Base
set_option autoImplicit false
set_option maxHeartbeats 1600000
open scoped BigOperators Classical
noncomputable section
namespace NLA.IE14

def lowerC (n : ℕ) : Mat n := fun i j =>  (lowerQ n i j : ℂ)
def upperC (n : ℕ) : Mat n := fun i j =>  (upperQ n i j : ℂ)
def residual (n k : ℕ) : Mat n := fun i j => 
  ∑ t : Fin n, if k  ≤  t.val then lowerC n i t * upperC n t j else 0

lemma lowerC_diag (n : ℕ) (i : Fin n) : lowerC n i i = 1 := by
  simp [lowerC,lowerQ]
lemma lowerC_above {n : ℕ} (i j : Fin n) (h : i  <  j) : lowerC n i j = 0 := by
  have hn : i  ≠  j := ne_of_lt h
  have h1 : ¬ (j.val+1=i.val ∨ j.val+2=i.val) := by omega
  simp [lowerC,lowerQ,hn,h1]
lemma lowerC_norm (n : ℕ) (i j : Fin n) : ‖lowerC n i j‖  ≤  1 := by
  simp only [lowerC,lowerQ]
  split_ifs  <;>  norm_num
lemma upperC_below {n : ℕ} (i j : Fin n) (h : j  <  i) : upperC n i j = 0 := by
  have hj : j.val+1  ≠  n := by omega
  have hh : ¬ ((i.val=0  ∧  j.val=1) ∨ (i.val=1  ∧  j.val=1)) := by omega
  have hij : i  ≠  j := ne_of_gt h
  simp [upperC,upperQ,hj,hh,hij]
lemma upperC_diag_ne {n : ℕ} (hn : 4  ≤  n) (i : Fin n) : upperC n i i  ≠  0 := by
  simp only [upperC,upperQ]
  split_ifs with hlast hhalf
  · have hf : 0  <  Nat.fib (i.val+2) := Nat.fib_pos.mpr (by omega)
    push_cast
    have hh : (Nat.fib (i.val+2) : ℝ)+1  ≠  0 := by positivity
    exact_mod_cast hh
  · norm_num
  · norm_num

lemma residual_zero (n : ℕ) (i j : Fin n) :
    residual n 0 i j = (lowerQ n * upperQ n) i j := by
  simp [residual,Matrix.mul_apply,lowerC,upperC]

lemma residual_step {n : ℕ} (k : Fin n) (i j : Fin n) :
    residual n k.val i j = lowerC n i k * upperC n k j + residual n (k.val+1) i j := by
  have he (t : Fin n) : (if k.val  ≤  t.val then lowerC n i t * upperC n t j else 0) =
      (if t=k then lowerC n i k * upperC n k j else 0) +
      (if k.val+1  ≤  t.val then lowerC n i t * upperC n t j else 0) := by
    by_cases h : t=k
    · subst t; simp
    · have ht : t.val  ≠  k.val := fun hh =>  h (Fin.ext hh)
      split_ifs  <;>  simp_all  <;>  omega
  simp only [residual,he,Finset.sum_add_distrib]
  simp

lemma residual_pivot_row {n : ℕ} (k j : Fin n) : residual n k.val k j = upperC n k j := by
  unfold residual
  rw [Finset.sum_eq_single k]
  · simp [lowerC_diag]
  · intro t ht htk
    by_cases h : k.val  ≤  t.val
    · have hlt : k < t := by have hne : t.val  ≠  k.val := fun hh =>  htk (Fin.ext hh); omega
      simp [h,lowerC_above k t hlt]
    · simp [h]
  · simp
lemma residual_pivot_col {n : ℕ} (k i : Fin n) :
    residual n k.val i k = lowerC n i k * upperC n k k := by
  unfold residual
  rw [Finset.sum_eq_single k]
  · simp
  · intro t ht htk
    by_cases h : k.val  ≤  t.val
    · have hlt : k < t := by have hne : t.val  ≠  k.val := fun hh =>  htk (Fin.ext hh); omega
      simp [h,upperC_below t k hlt]
    · simp [h]
  · simp
lemma residual_schur {n : ℕ} (hn : 4 ≤ n) (k i j : Fin n) :
    residual n k.val i j - residual n k.val i k / residual n k.val k k *
      residual n k.val k j = residual n (k.val+1) i j := by
  rw [residual_pivot_col,residual_pivot_row,residual_pivot_row]
  have h := upperC_diag_ne hn k
  rw [mul_div_cancel_right₀ _ h,residual_step k i j]
  ring

def stageFactor {n : ℕ} (k i : Fin n) : Fin n :=
  if k.val=0 then factorRow i else
    if h : i.val+1 < n then ⟨i.val+1,h⟩ else k

lemma stageFactor_pivot {n : ℕ} (k : Fin n) : stageFactor k (witnessPivot k) = k := by
  by_cases hk : k.val=0
  · simp [stageFactor,witnessPivot,hk,factorRow]
  · have hn : ¬ n-1+1 < n := by omega
    simp [stageFactor,witnessPivot,hk,hn]

lemma stageFactor_next {n : ℕ} (hn : 4 ≤ n) (k i : Fin n)
    (hk : k.val+1 < n) (hi : k < i) :
    stageFactor k (Equiv.swap k (witnessPivot k) i) =
      stageFactor ⟨k.val+1,hk⟩ i := by
  by_cases hk0 : k.val=0
  · have hi0 : i.val ≠ 0 := by omega
    simp [witnessPivot,hk0,stageFactor,factorRow,hi0,show 1<n by omega]
  · have hki : i ≠ k := ne_of_gt hi
    have hkN : k ≠ (⟨n-1,by omega⟩:Fin n) := by intro he; have := congrArg Fin.val he; simp at this; omega
    by_cases hiN : i.val+1=n
    · have hie : i=(⟨n-1,by omega⟩:Fin n) := Fin.ext (by simp; omega)
      rw [hie]
      simp [witnessPivot,hk0,stageFactor,Equiv.swap_apply_right,hk,hkN,show ¬n-1+1<n by omega]
    · have hit : i.val+1 < n := by omega
      have hin : i ≠ (⟨n-1,by omega⟩:Fin n) := by intro he; have := congrArg Fin.val he; simp at this; omega
      simp [witnessPivot,hk0,Equiv.swap_apply_of_ne_of_ne hki hin,stageFactor,hit]

lemma witness_zero_residual (n : ℕ) (i j : Fin n) :
    witness n i j = residual n 0 (factorRow i) j := by
  rw [residual_zero]
  rfl

lemma witnessStates_formula {n : ℕ} (hn : 4 ≤ n) (k : Fin n) (i j : Fin n) :
    witnessStates n k.val i j =
      if k ≤ i  ∧  k ≤ j then residual n k.val (stageFactor k i) j else 0 := by
  induction hkv : k.val generalizing k i j with
  | zero => 
    simp [hkv,witnessStates,stageFactor,witness_zero_residual,show k ≤ i by omega,show k ≤ j by omega]
  | succ t ih => 
    have ht : t < n := by omega
    let l : Fin n := ⟨t,ht⟩
    have hl : l.val+1 < n := by dsimp [l]; omega
    have hke : k=⟨t+1,hl⟩ := Fin.ext hkv
    have hp : l ≤ witnessPivot l := by simp only [witnessPivot]; split_ifs  <;>  simp_all [l]  <;>  omega
    rw [witnessStates, dif_pos ht]
    simp only [schurStep]
    by_cases hij : l < i  ∧  l < j
    · have hsw : l ≤ Equiv.swap l (witnessPivot l) i := by
        by_cases hh : i=witnessPivot l
        · subst i; simp
        · have hin : i ≠ l := ne_of_gt hij.1
          simp [Equiv.swap_apply_of_ne_of_ne hin hh]; omega
      rw [if_pos hij,ih l _ _ rfl,ih l _ _ rfl,ih l _ _ rfl,ih l _ _ rfl]
      dsimp only [l] at hsw hp hij ⊢
      simp only [hsw,hp,le_rfl,le_of_lt hij.2,and_self,ite_true,stageFactor_pivot]
      rw [residual_schur hn (⟨t,ht⟩ : Fin n)]
      have hm := stageFactor_next hn l i hl hij.1
      have hkij : k ≤ i  ∧  k ≤ j := by
        have hi : t < i.val := hij.1
        have hj : t < j.val := hij.2
        constructor <;> apply Fin.le_iff_val_le_val.mpr <;> omega
      rw [if_pos hkij]
      have hm' : stageFactor (⟨t,ht⟩ : Fin n) (Equiv.swap ⟨t,ht⟩ (witnessPivot ⟨t,ht⟩) i) = stageFactor k i := by
        simpa only [l,hke] using hm
      exact congrArg (fun a : Fin n => residual n (t+1) a j) hm'
    · have hkij : ¬ (k ≤ i  ∧  k ≤ j) := by
        change ¬ (t < i.val ∧ t < j.val) at hij
        intro hh
        have hi : k.val ≤ i.val := hh.1
        have hj : k.val ≤ j.val := hh.2
        omega
      rw [if_neg hij,if_neg hkij]


lemma witness_path {n : ℕ} (hn : 4 ≤ n) :
    isPath (witness n) (witnessStates n) witnessPivot := by
  refine ⟨rfl,?_⟩
  intro k
  have hp : k ≤ witnessPivot k := by
    by_cases hk : k.val=0
    · simp [witnessPivot,hk]
    · simp only [witnessPivot,hk,if_false]
      change k.val ≤ n-1
      omega
  have hpiv : witnessStates n k.val (witnessPivot k) k = upperC n k k := by
    rw [witnessStates_formula hn]
    simp [hp,stageFactor_pivot,residual_pivot_row]
  refine ⟨hp,?_,?_,?_⟩
  · rw [hpiv]; exact upperC_diag_ne hn k
  · intro i hi
    rw [hpiv,witnessStates_formula hn]
    simp only [hi,le_rfl,and_self,ite_true,residual_pivot_col,norm_mul]
    exact mul_le_of_le_one_left (norm_nonneg _) (lowerC_norm n _ k)
  · intro hk
    simp [witnessStates,k.isLt]

lemma witness_final_pivot {n : ℕ} (hn : 4 ≤ n) :
    witnessStates n (n-1) ⟨n-1,by omega⟩ ⟨n-1,by omega⟩ =
      ((Nat.fib (n+1) : ℕ) : ℂ)+1 := by
  let k : Fin n := ⟨n-1,by omega⟩
  have hk : k.val ≠ 0 := by dsimp [k]; omega
  have hpn : witnessPivot k = k := by simp [witnessPivot,hk,k]
  have he : stageFactor k k = k := by simpa only [hpn] using stageFactor_pivot k
  change witnessStates n k.val k k = _
  rw [witnessStates_formula hn]
  simp only [le_refl,and_self,ite_true,he,residual_pivot_row]
  have hk1 : k.val+1=n := by dsimp [k]; omega
  have hk2 : k.val+2=n+1 := by omega
  simp [upperC,upperQ,hk1,hk2]

#assert_trust kernel witness_path
#assert_trust kernel witness_final_pivot
end NLA.IE14
