/- Fixed two-dimensional Jordan tensor lift. Entry norm comparisons suffice;
no unproved multiplicativity of the spectral tensor norm is required. -/
import NLA.MF12.Geometry
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator Kronecker
noncomputable section
namespace NLA.MF12

def jordanTwo : Mat 2 := !![1,1;0,1]
def liftTensor {d : ℕ} (X : Mat d) (Y : Mat 2) : Mat (d*2) :=
  Matrix.reindexRingEquiv ℝ finProdFinEquiv (X ⊗ₖ Y)
def integerLift {d : ℕ} (X : Mat d) : Mat (d*2) := liftTensor X jordanTwo

lemma liftTensor_entry {d : ℕ} (X : Mat d) (Y : Mat 2) (i j : Fin d) (a b : Fin 2) :
    liftTensor X Y (finProdFinEquiv (i,a)) (finProdFinEquiv (j,b)) = X i j*Y a b := by
  simp [liftTensor,Matrix.coe_reindexRingEquiv,Matrix.reindex_apply,Matrix.submatrix_apply]

lemma liftTensor_mul {d : ℕ} (X Y : Mat d) (U V : Mat 2) :
    liftTensor X U*liftTensor Y V = liftTensor (X*Y) (U*V) := by
  unfold liftTensor
  rw [← map_mul,← Matrix.mul_kronecker_mul]

lemma liftTensor_one (d : ℕ) : liftTensor (1 : Mat d) 1 = 1 := by
  simp [liftTensor,Matrix.one_kronecker_one]

lemma jordanTwo_power (k : ℕ) : jordanTwo^k = !![1,(k:ℝ);0,1] := by
  induction k with
  | zero => ext i j; fin_cases i <;> fin_cases j <;> simp
  | succ k ih =>
    rw [pow_succ,ih]
    ext i j; fin_cases i <;> fin_cases j <;> simp [jordanTwo,Matrix.mul_apply,Fin.sum_univ_two,Nat.cast_add] <;> ring

lemma integerLift_word {d : ℕ} (A B : Mat d) (w : List Bool) :
    (w.map (fun b => if b then integerLift A else integerLift B)).prod =
      liftTensor ((w.map (fun b => if b then A else B)).prod) (jordanTwo^w.length) := by
  induction w with
  | nil => simp [liftTensor_one]
  | cons b w ih =>
    simp only [List.map_cons,List.prod_cons,List.length_cons,ih,pow_succ']
    cases b <;> simp only [Bool.false_eq_true,if_false,if_true,integerLift,liftTensor_mul]

lemma entryConstant_one_le {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n] :
    1≤entryConstant (m:=m) (n:=n) := by unfold entryConstant; exact le_add_of_nonneg_right (by positivity)

lemma liftTensor_norm_upper {d : ℕ} (X : Mat d) (k : ℕ) (hk : 1≤k) :
    ‖liftTensor X (jordanTwo^k)‖ ≤ entryConstant (m:=Fin (d*2)) (n:=Fin (d*2))*(k:ℝ)*‖X‖ := by
  have hkR : (1:ℝ)≤k := by exact_mod_cast hk
  have hentry : ∀ i j, |liftTensor X (jordanTwo^k) i j| ≤ (k:ℝ)*‖X‖ := by
    intro i j
    obtain ⟨⟨r,a⟩,rfl⟩ := finProdFinEquiv.surjective i
    obtain ⟨⟨s,b⟩,rfl⟩ := finProdFinEquiv.surjective j
    rw [liftTensor_entry,jordanTwo_power,abs_mul]
    have hX := abs_entry_le_norm X r s
    have hnn := norm_nonneg X
    fin_cases a <;> fin_cases b <;> simp <;> nlinarith
  have h := norm_le_entry_bound _ ((k:ℝ)*‖X‖) (by positivity) hentry
  simpa only [mul_assoc] using h

lemma liftTensor_norm_lower {d : ℕ} (X : Mat d) (k : ℕ) (hk : 1≤k) :
    (k:ℝ)*‖X‖ ≤ entryConstant (m:=Fin d) (n:=Fin d)*‖liftTensor X (jordanTwo^k)‖ := by
  have hkR : (0:ℝ)<k := by exact_mod_cast (by omega : 0<k)
  have hentry : ∀ i j, |X i j| ≤ ‖liftTensor X (jordanTwo^k)‖/(k:ℝ) := by
    intro i j
    have h := abs_entry_le_norm (liftTensor X (jordanTwo^k))
      (finProdFinEquiv (i,0)) (finProdFinEquiv (j,1))
    rw [liftTensor_entry,jordanTwo_power] at h
    change |X i j*(k:ℝ)| ≤ _ at h
    rw [abs_mul,abs_of_pos hkR] at h
    apply (le_div_iff₀ hkR).mpr
    simpa only [jordanTwo_power] using h
  have hb := norm_le_entry_bound X _ (by positivity) hentry
  have hm := mul_le_mul_of_nonneg_left hb hkR.le
  field_simp at hm
  nlinarith

lemma integerLift_injective {d : ℕ} : Function.Injective (integerLift (d:=d)) := by
  intro X Y h
  ext i j
  have hh := congrArg (fun M : Mat (d*2) => M (finProdFinEquiv (i,0)) (finProdFinEquiv (j,0))) h
  simpa [integerLift,liftTensor_entry,jordanTwo] using hh
end NLA.MF12
