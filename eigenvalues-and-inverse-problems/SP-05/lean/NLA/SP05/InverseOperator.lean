/- The actual inverse Jordan operator, not an assumed positive map. -/
import NLA.SP05.Geometry
import NLA.SP05.InversePositive
import Mathlib.Analysis.Matrix.Order
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Kronecker ComplexOrder
noncomputable section
namespace NLA.SP05
abbrev CMat (n : ℕ) := Matrix (Fin n) (Fin n) ℂ
abbrev CVec (n : ℕ) := (Fin n × Fin n) → ℂ

def cJordan {n : ℕ} (A B : CMat n) := A.transpose ⊗ₖ B + B.transpose ⊗ₖ A

def cMap {n : ℕ} (A B X : CMat n) : CMat n := A*X*B+B*X*A

def inverseMap {n : ℕ} (A B Y : CMat n) : CMat n :=
  unvecM ((cJordan A B)⁻¹.mulVec (vecM Y))

lemma cJordan_vec {n : ℕ} (A B X : CMat n) :
    (cJordan A B).mulVec (vecM X) = vecM (cMap A B X) := by
  rw [cJordan,Matrix.add_mulVec,kronecker_vecM,kronecker_vecM,
    Matrix.transpose_transpose,Matrix.transpose_transpose]
  funext ij
  simp [vecM,cMap,add_comm]

lemma cJordan_posDef {n : ℕ} (A B : CMat n) (hA : A.PosDef) (hB : B.PosDef) :
    (cJordan A B).PosDef := (hA.transpose.kronecker hB).add (hB.transpose.kronecker hA)

lemma cMap_injective {n : ℕ} (A B : CMat n) (hA : A.PosDef) (hB : B.PosDef) :
    Function.Injective (cMap A B) := by
  intro X Y h
  apply vecM_injective
  apply (Matrix.mulVec_injective_iff_isUnit.mpr (cJordan_posDef A B hA hB).isUnit)
  rw [cJordan_vec,cJordan_vec,h]

lemma inverseMap_right {n : ℕ} (A B Y : CMat n) (hA : A.PosDef) (hB : B.PosDef) :
    cMap A B (inverseMap A B Y) = Y := by
  apply vecM_injective
  rw [← cJordan_vec]
  simp only [inverseMap,vecM_unvecM,Matrix.mulVec_mulVec]
  rw [Matrix.mul_nonsing_inv _ ((cJordan A B).isUnit_iff_isUnit_det.mp (cJordan_posDef A B hA hB).isUnit),Matrix.one_mulVec]

lemma inverseMap_left {n : ℕ} (A B X : CMat n) (hA : A.PosDef) (hB : B.PosDef) :
    inverseMap A B (cMap A B X) = X := by
  apply cMap_injective A B hA hB
  exact inverseMap_right A B _ hA hB

lemma cMap_conjTranspose {n : ℕ} (A B X : CMat n) (hA : A.IsHermitian) (hB : B.IsHermitian) :
    cMap A B X.conjTranspose = (cMap A B X).conjTranspose := by
  simp only [cMap,Matrix.conjTranspose_add,Matrix.conjTranspose_mul,hA.eq,hB.eq]
  simp only [Matrix.mul_assoc,add_comm]

lemma inverseMap_conjTranspose {n : ℕ} (A B Y : CMat n) (hA : A.PosDef) (hB : B.PosDef) :
    inverseMap A B Y.conjTranspose = (inverseMap A B Y).conjTranspose := by
  apply cMap_injective A B hA hB
  rw [inverseMap_right A B _ hA hB,cMap_conjTranspose A B _ hA.isHermitian hB.isHermitian,
    inverseMap_right A B _ hA hB]

lemma inverseMap_isHermitian {n : ℕ} (A B Y : CMat n)
    (hA : A.PosDef) (hB : B.PosDef) (hY : Y.IsHermitian) : (inverseMap A B Y).IsHermitian := by
  change (inverseMap A B Y).conjTranspose = inverseMap A B Y
  rw [← inverseMap_conjTranspose A B Y hA hB,hY.eq]

lemma inverseMap_add {n : ℕ} (A B X Y : CMat n) :
    inverseMap A B (X+Y) = inverseMap A B X + inverseMap A B Y := by
  unfold inverseMap
  have he : vecM (X+Y) = vecM X+vecM Y := rfl
  rw [he,Matrix.mulVec_add]
  rfl

lemma inverseMap_smul {n : ℕ} (A B X : CMat n) (c : ℂ) :
    inverseMap A B (c • X) = c • inverseMap A B X := by
  unfold inverseMap
  have he : vecM (c • X) = c • vecM X := rfl
  rw [he,Matrix.mulVec_smul]
  rfl

lemma inverseMap_posSemidef {n : ℕ} (A B Y : CMat n)
    (hA : A.PosDef) (hB : B.PosDef) (hY : Y.PosSemidef) : (inverseMap A B Y).PosSemidef := by
  apply jordanMap_posSemidef_inverse A B (inverseMap A B Y) hA hB
    (inverseMap_isHermitian A B Y hA hB hY.isHermitian)
  change (cMap A B (inverseMap A B Y)).PosSemidef
  rw [inverseMap_right A B Y hA hB]
  exact hY

#assert_trust kernel inverseMap_posSemidef
#assert_trust kernel inverseMap_right
#assert_trust kernel inverseMap_isHermitian
end NLA.SP05
