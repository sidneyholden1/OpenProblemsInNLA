import NLA.SP05.Definitions
set_option autoImplicit false
open scoped BigOperators Matrix Kronecker
noncomputable section
namespace NLA.SP05

/-- Both the actual commutation matrix and column-vectorized Jordan operator. -/
theorem vectorization {n : ℕ} (A B X : Mat n)
    (hA : A.IsHermitian) (hB : B.IsHermitian) :
    (commutation n).mulVec (columnVec X) = columnVec X.transpose ∧
    (jordan A B).mulVec (columnVec X) = columnVec (jordanMap A B X) := by sorry

/-- A genuine positive-semidefinite eigenmatrix at the global least Rayleigh
value of the Jordan matrix, with no spectral simplicity or commutativity premise. -/
theorem psd_minimizer {n : ℕ} (hn : 2 ≤ n) (A B : Mat n)
    (hA : A.PosDef) (hB : B.PosDef) :
    ∃ (μ : ℝ) (X : Mat n), 0 < μ ∧ X.PosSemidef ∧ X ≠ 0 ∧
      (jordan A B).mulVec (columnVec X) = μ • columnVec X ∧
      rayleigh (jordan A B) (columnVec X) = μ ∧
      ∀ v : Vec n, v ≠ 0 → μ ≤ rayleigh (jordan A B) v := by sorry

/-- Both genuine minima exist and are attained by nonzero vectors. Explicit
nonempty/bounded conditions rule out conditional-complete-lattice fallback values. -/
theorem sector_minima_attained {n : ℕ} (hn : 2 ≤ n) (A B : Mat n)
    (hA : A.PosDef) (hB : B.PosDef) :
    (sectorValues A B 1).Nonempty ∧ BddBelow (sectorValues A B 1) ∧
    (sectorValues A B (-1)).Nonempty ∧ BddBelow (sectorValues A B (-1)) ∧
    ∃ u w : Vec n, u ≠ 0 ∧ w ≠ 0 ∧
      (commutation n).mulVec u = u ∧ (commutation n).mulVec w = -w ∧
      rayleigh (A ⊗ₖ B) u = sInf (sectorValues A B 1) ∧
      rayleigh (A ⊗ₖ B) w = sInf (sectorValues A B (-1)) := by sorry

/-- The full displayed original SP-05 inequality, for arbitrary real SPD pairs. -/
theorem symmetric_skew_minimum {n : ℕ} (hn : 2 ≤ n) (A B : Mat n)
    (hA : A.PosDef) (hB : B.PosDef) :
    sInf (sectorValues A B 1) ≤ sInf (sectorValues A B (-1)) := by sorry
end NLA.SP05
