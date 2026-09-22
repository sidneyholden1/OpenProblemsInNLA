/- Actual finite matrix congruences for the singular rescaling argument. -/
import NLA.MI04.Arrow
import NLA.MI04.Reflection
set_option autoImplicit false
set_option maxHeartbeats 800000
open scoped ComplexOrder MatrixOrder Matrix.Norms.L2Operator BigOperators
open Matrix Complex
noncomputable section
namespace NLA.MI04
variable {n : ℕ}

def scaleDiagonal (i : Fin n) (t : ℝ) : Mat n :=
  diagonal (fun j => if j=i then (t:ℂ) else 1)
def scaleBlock (i : Fin n) (t : ℝ) : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ :=
  fromBlocks (scaleDiagonal i t) 0 0 1
def scaledTop (i : Fin n) (e : Fin n → ℝ) (t : ℝ) : Mat n :=
  diagonal (fun j => if j=i then ((t^2:ℝ):ℂ) else ((2-e j:ℝ):ℂ))

def unscaledBlock (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s t : ℝ) :
    Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ :=
  fromBlocks (scaledTop i e t) ((t*s) • X) ((t*s) • X)ᴴ (arrowBottom i e t)

lemma scaleDiagonal_hermitian (i : Fin n) (t : ℝ) : (scaleDiagonal i t).IsHermitian := by
  rw [scaleDiagonal,isHermitian_diagonal_iff]
  intro j; split_ifs <;> simp [IsSelfAdjoint]

lemma scale_cross (X : Mat n) (i : Fin n) (s t : ℝ) :
    scaleDiagonal i t * arrowCross X i s t = (t*s) • X := by
  ext j k
  simp only [scaleDiagonal,diagonal_mul,arrowCross,Matrix.smul_apply]
  by_cases h : j=i <;> simp [h,Complex.real_smul] <;> push_cast <;> ring

lemma scale_top (i : Fin n) (e : Fin n → ℝ) (t : ℝ) :
    scaleDiagonal i t * arrowTop i e * scaleDiagonal i t = scaledTop i e t := by
  simp only [scaleDiagonal,arrowTop,scaledTop,diagonal_mul_diagonal]
  congr 1; funext j
  by_cases h : j=i <;> simp [h,pow_two]

lemma rescale_identity (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s t : ℝ) :
    (scaleBlock i t)ᴴ * arrowMatrix X i e s t * scaleBlock i t =
      unscaledBlock X i e s t := by
  have hc := congrArg Matrix.conjTranspose (scale_cross X i s t)
  rw [conjTranspose_mul,(scaleDiagonal_hermitian i t).eq] at hc
  simp only [scaleBlock,arrowMatrix,unscaledBlock,fromBlocks_conjTranspose,
    conjTranspose_zero,conjTranspose_one,fromBlocks_multiply,
    (scaleDiagonal_hermitian i t).eq,mul_zero,zero_mul,add_zero,zero_add,
    mul_one,one_mul,scale_top,scale_cross,hc]

lemma scaleBlock_isUnit (i : Fin n) (t : ℝ) (ht : t≠0) : IsUnit (scaleBlock i t) := by
  apply (Matrix.isUnit_iff_isUnit_det _).mpr
  rw [scaleBlock,det_fromBlocks_zero₂₁,det_one,mul_one,scaleDiagonal,det_diagonal]
  apply isUnit_iff_ne_zero.mpr
  apply Finset.prod_ne_zero_iff.mpr
  intro j _
  split_ifs
  · exact Complex.ofReal_ne_zero.mpr ht
  · exact one_ne_zero

lemma unscaled_psd_iff (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s t : ℝ)
    (ht : t≠0) : (unscaledBlock X i e s t).PosSemidef ↔
      (arrowMatrix X i e s t).PosSemidef := by
  rw [←rescale_identity]
  exact (scaleBlock_isUnit i t ht).posSemidef_star_left_conjugate_iff

lemma scaled_diagonal_sum (i : Fin n) (e : Fin n → ℝ) (t : ℝ) :
    scaledTop i e t + arrowBottom i e t = (2:ℝ) • (1:Mat n) := by
  ext j k
  by_cases hjk : j=k
  · subst k
    by_cases hji : j=i <;>
      simp [scaledTop,arrowBottom,Matrix.diagonal_apply,Matrix.one_apply,hji,
        Complex.real_smul] <;> push_cast <;> ring
  · simp [scaledTop,arrowBottom,Matrix.diagonal_apply,Matrix.one_apply,hjk]

lemma scaledTop_hermitian (i : Fin n) (e : Fin n → ℝ) (t : ℝ) :
    (scaledTop i e t).IsHermitian := by
  rw [scaledTop,isHermitian_diagonal_iff]
  intro j; split_ifs <;> simp [IsSelfAdjoint]
lemma arrowBottom_hermitian (i : Fin n) (e : Fin n → ℝ) (t : ℝ) :
    (arrowBottom i e t).IsHermitian := by
  rw [arrowBottom,isHermitian_diagonal_iff]
  intro j; split_ifs <;> simp [IsSelfAdjoint]

lemma arrow_reflect {n : ℕ} [NeZero n] {X : Mat n} (hX : UniversalBlockNorm X)
    (i : Fin n) (e : Fin n → ℝ) (s t : ℝ) (hs : 0<s) (ht : 0<t)
    (hQ : (arrowMatrix X i e s t).PosSemidef) :
    (arrowMatrix Xᴴ i e s t).PosSemidef := by
  have hp := (unscaled_psd_iff X i e s t ht.ne').mpr hQ
  have hr := scalar_sum_reflection (universal_smul hX (t*s) (mul_pos ht hs))
    (scaledTop_hermitian i e t) (arrowBottom_hermitian i e t) hp
    (scaled_diagonal_sum i e t)
  apply (unscaled_psd_iff Xᴴ i e s t ht.ne').mp
  simpa only [unscaledBlock,conjTranspose_smul,star_trivial,conjTranspose_conjTranspose] using hr

end NLA.MI04
