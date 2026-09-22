/- Identification of transfer states with the original finite Toeplitz unknowns. -/
import NLA.MF22.ToeplitzRows
import NLA.MF22.TransferEquations
set_option autoImplicit false
set_option maxHeartbeats 800000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF22

def reconstruct (n : ℕ) (w : ℕ → Fin 4 → ℂ) : Ix n → ℂ :=
  fun j => if j.2 = 0 then w j.1.val 0 else w (j.1.val+1) 1

lemma reconstruct_zero {n : ℕ} (w : ℕ → Fin 4 → ℂ) (j : Fin n) :
    extendVec (reconstruct n w) j.val 0 = w j.val 0 := by
  rw [extendVec_at]; simp [reconstruct]
lemma reconstruct_one {n : ℕ} (w : ℕ → Fin 4 → ℂ) (j : Fin n) :
    extendVec (reconstruct n w) j.val 1 = w (j.val+1) 1 := by
  rw [extendVec_at]; simp [reconstruct]

lemma reconstruct_next {n : ℕ} (w : ℕ → Fin 4 → ℂ) (ht : w n 0=0) (j : Fin n) :
    extendVec (reconstruct n w) ((j.val:ℤ)+1) 0 = w (j.val+1) 0 := by
  by_cases h : j.val+1<n
  · have he : (j.val:ℤ)+1 = ((⟨j.val+1,h⟩ : Fin n).val:ℤ) := by simp
    rw [he,reconstruct_zero]
  · have he : j.val+1=n := by omega
    rw [extendVec_out _ _ _ (Or.inr (by omega)),he,ht]

lemma reconstruct_previous_zero {n : ℕ} (w : ℕ → Fin 4 → ℂ)
    (h0 : w 0 2=0) (hs : ∀ j, j<n → w (j+1) 2=w j 0) (j : Fin n) :
    extendVec (reconstruct n w) ((j.val:ℤ)-1) 0 = w j.val 2 := by
  by_cases hz : j.val=0
  · rw [hz,extendVec_out _ _ _ (Or.inl (by norm_num)),h0]
  · have hp : j.val-1<n := by omega
    have he : (j.val:ℤ)-1 = ((⟨j.val-1,hp⟩ : Fin n).val:ℤ) := by simp; omega
    rw [he,reconstruct_zero,← hs (j.val-1) hp]
    congr 1; omega

lemma reconstruct_previous_one {n : ℕ} (w : ℕ → Fin 4 → ℂ)
    (h0 : w 0 1=0) (j : Fin n) :
    extendVec (reconstruct n w) ((j.val:ℤ)-1) 1 = w j.val 1 := by
  by_cases hz : j.val=0
  · rw [hz,extendVec_out _ _ _ (Or.inl (by norm_num)),h0]
  · have hp : j.val-1<n := by omega
    have he : (j.val:ℤ)-1 = ((⟨j.val-1,hp⟩ : Fin n).val:ℤ) := by simp; omega
    rw [he,reconstruct_one]
    congr 1; omega

lemma reconstruct_previous_two {n : ℕ} (w : ℕ → Fin 4 → ℂ)
    (h01 : w 0 1=0) (h03 : w 0 3=0)
    (hs : ∀ j, j<n → w (j+1) 3=w j 1) (j : Fin n) :
    extendVec (reconstruct n w) ((j.val:ℤ)-2) 1 = w j.val 3 := by
  by_cases hz : j.val=0
  · rw [hz,extendVec_out _ _ _ (Or.inl (by norm_num)),h03]
  have hp : j.val-1<n := by omega
  have he : (j.val:ℤ)-2 = (((⟨j.val-1,hp⟩ : Fin n).val:ℤ)-1) := by simp; omega
  rw [he,reconstruct_previous_one w h01,← hs (j.val-1) hp]
  congr 1; omega

lemma reconstruct_equation (r : ℝ) (hr : 0<r) {n : ℕ}
    (w : ℕ → Fin 4 → ℂ) (f : ℕ → Fin 2 → ℂ)
    (hi : ∀ i : Fin 4, i≠0 → w 0 i=0) (ht : w n 0=0)
    (hs : ∀ j, j<n → w (j+1)=(transfer r).mulVec (w j)+(forcing r).mulVec (f j)) :
    ∀ j : Ix n, 80*((H r n).mulVec (reconstruct n w) j)=f j.1.val j.2 := by
  have h2 : ∀ j, j<n → w (j+1) 2=w j 0 := by
    intro j hj; rw [hs j hj]; exact transfer_bottom_two r _ _
  have h3 : ∀ j, j<n → w (j+1) 3=w j 1 := by
    intro j hj; rw [hs j hj]; exact transfer_bottom_three r _ _
  rintro ⟨j,a⟩
  fin_cases a
  · change 80*((H r n).mulVec (reconstruct n w) (j,0))=f j.val 0
    rw [toeplitz_row_zero,reconstruct_next w ht,reconstruct_zero,reconstruct_one,
      reconstruct_previous_zero w (hi 2 (by decide)) h2,
      reconstruct_previous_one w (hi 1 (by decide)),
      reconstruct_previous_two w (hi 1 (by decide)) (hi 3 (by decide)) h3]
    have hh := transfer_top_zero r hr (w j.val) (f j.val)
    rw [← hs j.val j.isLt] at hh
    linear_combination hh
  · change 80*((H r n).mulVec (reconstruct n w) (j,1))=f j.val 1
    rw [toeplitz_row_one,reconstruct_next w ht,reconstruct_zero,reconstruct_one,
      reconstruct_previous_zero w (hi 2 (by decide)) h2,
      reconstruct_previous_one w (hi 1 (by decide)),
      reconstruct_previous_two w (hi 1 (by decide)) (hi 3 (by decide)) h3]
    have hh := transfer_top_one r hr (w j.val) (f j.val)
    rw [← hs j.val j.isLt] at hh
    linear_combination hh
end NLA.MF22
