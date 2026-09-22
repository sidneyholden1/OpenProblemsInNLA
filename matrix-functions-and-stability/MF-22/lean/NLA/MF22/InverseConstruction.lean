/- The Green response gives a right inverse of the literal finite Toeplitz matrix.
No nonsingularity assumption is imposed: it follows from this construction. -/
import NLA.MF22.ActualGreen
import NLA.MF22.BoundaryGreen
import NLA.MF22.StateReconstruction
set_option autoImplicit false
set_option maxHeartbeats 1000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22

def responseState (r : ℝ) (n l : ℕ) (b : Fin 2) (j : ℕ) (i : Fin 4) : ℂ :=
  greenResponse (transfer r) (forcing r) n j l i b

def sourceImpulse (l : ℕ) (b : Fin 2) (j : ℕ) : Fin 2 → ℂ :=
  if j=l then Pi.single b 1 else 0

lemma responseState_step (r : ℝ) (n l j : ℕ) (b : Fin 2) :
    responseState r n l b (j+1) = (transfer r).mulVec (responseState r n l b j)+
      (forcing r).mulVec (sourceImpulse l b j) := by
  classical
  funext i
  rw [responseState,response_step]
  by_cases h : j=l
  · simp [sourceImpulse,h,Matrix.mulVec,dotProduct,responseState,Pi.single_apply]
  · simp [sourceImpulse,h,Matrix.mulVec,dotProduct,responseState]

def greenInverse (r : ℝ) (n : ℕ) : Mat n :=
  fun i k => 80*reconstruct n (responseState r n k.1.val k.2) i

lemma H_mul_greenInverse (r : ℝ) (hr : 0<r) (n : ℕ)
    (hd : ((transfer r)^n) 0 0 ≠ 0) : H r n * greenInverse r n = 1 := by
  classical
  ext i k
  have hh := reconstruct_equation r hr (responseState r n k.1.val k.2)
    (sourceImpulse k.1.val k.2)
    (fun a ha => response_initial _ _ _ _ _ _ ha)
    (response_terminal _ _ _ _ _ k.1.isLt hd)
    (fun j _ => responseState_step r n k.1.val j k.2) i
  have hf : sourceImpulse k.1.val k.2 i.1.val i.2=(1:Mat n) i k := by
    simp only [sourceImpulse,Matrix.one_apply,Pi.single_apply]
    have he : i=k ↔ i.1.val=k.1.val ∧ i.2=k.2 := by
      constructor
      · intro h; simp [h]
      · rintro ⟨h1,h2⟩; exact Prod.ext (Fin.ext h1) h2
    by_cases h1 : i.1.val=k.1.val <;> by_cases h2 : i.2=k.2 <;> simp_all [eq_comm]
  rw [hf] at hh
  rw [← hh,Matrix.mul_apply,Matrix.mulVec,dotProduct,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j _
  dsimp [greenInverse]
  ring

lemma actual_inverse_eq (r : ℝ) (hr : 0<r) (n : ℕ)
    (hd : ((transfer r)^n) 0 0 ≠ 0) :
    (H r n).det ≠ 0 ∧ (H r n)⁻¹=greenInverse r n := by
  have hh := H_mul_greenInverse r hr n hd
  exact ⟨Matrix.det_ne_zero_of_right_inverse hh,Matrix.inv_eq_right_inv hh⟩

def forcingBound (r : ℝ) : ℝ := 1+∑ b : Fin 2, ∑ s : Fin 4, ‖forcing r s b‖

lemma forcingBound_pos (r : ℝ) : 0<forcingBound r := by
  unfold forcingBound
  positivity
lemma forcingBound_column (r : ℝ) (b : Fin 2) :
    (∑ s : Fin 4, ‖forcing r s b‖) ≤ forcingBound r := by
  have h := Finset.single_le_sum (s:=Finset.univ)
    (f:=fun b : Fin 2 => ∑ s : Fin 4, ‖forcing r s b‖)
    (fun _ _ => Finset.sum_nonneg fun _ _ => norm_nonneg _) (Finset.mem_univ b)
  unfold forcingBound
  linarith

 theorem eventual_inverse_entry_bound_proved (r : ℝ) (hr : 0<r) :
    ∃ C : ℝ, 0<C ∧ ∃ N : ℕ, 1≤N ∧ ∀ n : ℕ, N≤n →
      (H r n).det ≠ 0 ∧ ∀ i j : Ix n, ‖(H r n)⁻¹ i j‖ ≤ C := by
  obtain ⟨C,hC,N,hN,h⟩ := transfer_green_bounded r hr
  refine ⟨80*C*forcingBound r,mul_pos (mul_pos (by norm_num) hC) (forcingBound_pos r),N,hN,?_⟩
  intro n hn
  obtain ⟨hd,hg⟩ := h n hn
  obtain ⟨hdet,hinv⟩ := actual_inverse_eq r hr n hd
  refine ⟨hdet,?_⟩
  intro i k
  have hb (j : ℕ) (hj : j≤n) (a : Fin 4) :
      ‖responseState r n k.1.val k.2 j a‖ ≤ C*forcingBound r := by
    exact (response_norm_le _ _ _ _ _ _ _ C (hg j hj k.1.val k.1.isLt a)).trans
      (mul_le_mul_of_nonneg_left (forcingBound_column r k.2) hC.le)
  rw [hinv,greenInverse,norm_mul]
  have h80 : ‖(80:ℂ)‖=(80:ℝ) := by norm_num
  rw [h80]
  have hh : ‖reconstruct n (responseState r n k.1.val k.2) i‖≤C*forcingBound r := by
    unfold reconstruct
    split_ifs
    · exact hb i.1.val (Nat.le_of_lt i.1.isLt) 0
    · exact hb (i.1.val+1) i.1.isLt 1
  nlinarith
#assert_trust kernel eventual_inverse_entry_bound_proved
#print axioms eventual_inverse_entry_bound_proved
end NLA.MF22
