/- Return the actual complex PSD minimizer to the original real matrix problem. -/
import NLA.SP05.ComplexMinimum
import NLA.SP05.Realification
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Kronecker ComplexOrder MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.SP05

lemma real_jordan_complex {n : ℕ} (A B : Mat n)
    (hA : A.IsHermitian) (hB : B.IsHermitian) :
    cJordan (A.map Complex.ofReal) (B.map Complex.ofReal) = (jordan A B).map Complex.ofReal := by
  have ha : A.transpose = A := Matrix.isHermitian_iff_isSymm.mp hA
  have hb : B.transpose = B := Matrix.isHermitian_iff_isSymm.mp hB
  ext ij kl
  rcases ij with ⟨i,j⟩; rcases kl with ⟨k,l⟩
  have hai : A k i = A i k := congrFun (congrFun ha i) k
  have hbi : B k i = B i k := congrFun (congrFun hb i) k
  simp [cJordan,jordan,Matrix.kroneckerMap,Matrix.map_apply,Matrix.transpose_apply,hai,hbi]

lemma rayleigh_of_eigen {n : ℕ} (K : BigMat n) (v : Vec n) (μ : ℝ)
    (hv : v ≠ 0) (he : K.mulVec v = μ • v) : rayleigh K v = μ := by
  unfold rayleigh
  rw [he]
  simp only [Pi.smul_apply,smul_eq_mul]
  have hn : (∑i,v i*(μ*v i)) = μ*(∑i,v i*v i) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [hn,mul_div_cancel_right₀ _ (denominator_pos v hv).ne']

lemma lower_rayleigh_of_psd {n : ℕ} (K : BigMat n) (μ : ℝ)
    (h : (K-μ • (1 : BigMat n)).PosSemidef) (v : Vec n) (hv : v ≠ 0) :
    μ ≤ rayleigh K v := by
  have hh := h.dotProduct_mulVec_nonneg v
  simp only [Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,
    dotProduct_sub,dotProduct_smul,star_trivial] at hh
  apply (le_div_iff₀ (denominator_pos v hv)).mpr
  change μ*(∑ i,v i*v i) ≤ ∑i,v i*(K.mulVec v) i
  simpa only [dotProduct,smul_eq_mul] using sub_nonneg.mp hh

theorem psd_minimizer_proved {n : ℕ} (hn : 2 ≤ n) (A B : Mat n)
    (hA : A.PosDef) (hB : B.PosDef) :
    ∃ (μ : ℝ) (X : Mat n), 0 < μ ∧ X.PosSemidef ∧ X ≠ 0 ∧
      (jordan A B).mulVec (columnVec X) = μ • columnVec X ∧
      rayleigh (jordan A B) (columnVec X) = μ ∧
      ∀ v : Vec n, v ≠ 0 → μ ≤ rayleigh (jordan A B) v := by
  obtain ⟨μ,X,hμ,hX,hX0,he,hcap⟩ := complex_psd_minimum (by omega)
    (A.map Complex.ofReal) (B.map Complex.ofReal)
    (real_posDef_complex A hA) (real_posDef_complex B hB)
  rw [real_jordan_complex A B hA.isHermitian hB.isHermitian] at he hcap
  have hrX := complex_posSemidef_real X hX
  have hnX := complex_psd_real_ne_zero X hX hX0
  have heReal := real_eigen_transport (jordan A B) X μ he
  have hcapReal : (jordan A B-μ • (1 : BigMat n)).PosSemidef := by
    have hh := complex_posSemidef_real _ hcap
    convert hh using 1
    ext i j
    by_cases hij : i = j <;> simp [Matrix.map_apply,Complex.sub_re,Matrix.one_apply,hij]
  refine ⟨μ,X.map Complex.re,hμ,hrX,hnX,heReal,?_,?_⟩
  · exact rayleigh_of_eigen _ _ _ ((columnVec_ne_zero _).mpr hnX) heReal
  · exact lower_rayleigh_of_psd _ _ hcapReal

#assert_trust kernel psd_minimizer_proved
end NLA.SP05
