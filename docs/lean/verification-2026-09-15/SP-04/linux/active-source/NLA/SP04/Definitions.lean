import Mathlib

/- Statements-only draft. Mathematical source: Matthew J. Colbrook's SP-04
manuscript at repository commit deb549fa9ddd6b119e6c59016f268237e645dfa2.
Formalization draft: Sidney Holden, with AI assistance. No proof is asserted. -/

set_option autoImplicit false
open scoped BigOperators
namespace NLA.SP04
noncomputable section

abbrev Mat (n : ℕ) := Matrix (Fin n) (Fin n) ℝ

def Feasible {n : ℕ} (X : Mat n) : Prop := |X.det| = 1

def Stationary {n : ℕ} (U X : Mat n) (c : ℝ) : Prop :=
  Feasible X ∧ X.transpose * (U - X) = c • (1 : Mat n)

/-- Squared Frobenius distance; its order agrees with Frobenius distance. -/
def distanceSq {n : ℕ} (U X : Mat n) : ℝ :=
  ∑ i, ∑ j, (U i j - X i j) ^ 2

def Nearest {n : ℕ} (U X : Mat n) : Prop :=
  Feasible X ∧ ∀ Y : Mat n, Feasible Y → distanceSq U X ≤ distanceSq U Y

/-- Unique pair minimizing absolute multiplier, among every real stationary pair. -/
def UniqueLeast {n : ℕ} (U X : Mat n) (c : ℝ) : Prop :=
  Stationary U X c ∧ ∀ Y : Mat n, ∀ d : ℝ,
    Stationary U Y d →
      |c| ≤ |d| ∧ (|d| = |c| → Y = X ∧ d = c)

def Failure {n : ℕ} (U : Mat n) : Prop :=
  ∃ X : Mat n, ∃ c : ℝ, UniqueLeast U X c ∧ ¬ Nearest U X

def SingularInterval (s : Fin 3 → ℝ) : Prop :=
  (∀ i, (7 : ℝ) / 4 < s i ∧ s i < (44 : ℝ) / 25) ∧
    s 0 < s 1 ∧ s 1 < s 2

def positiveRoot (s c : ℝ) : ℝ := (s + Real.sqrt (s ^ 2 - 4 * c)) / 2

def largeNegativeMultiplierRoot (s t : ℝ) : ℝ :=
  (s + Real.sqrt (s ^ 2 + 4 * t)) / 2

def selectedProduct (s : Fin 3 → ℝ) (t : ℝ) : ℝ :=
  t / largeNegativeMultiplierRoot (s 0) t *
    largeNegativeMultiplierRoot (s 1) t * largeNegativeMultiplierRoot (s 2) t

def Orthogonal (P : Mat 3) : Prop := P.transpose * P = 1 ∧ P * P.transpose = 1

/-- All left/right orthogonal transforms of the entire strict singular-value interval. -/
def counterexampleFamily : Set (Mat 3) :=
  {U | ∃ P Q : Mat 3, ∃ s : Fin 3 → ℝ,
    Orthogonal P ∧ Orthogonal Q ∧ SingularInterval s ∧
      U = P * Matrix.diagonal s * Q.transpose}

def evalData {n : ℕ} (p : MvPolynomial (Fin n × Fin n) ℝ) (U : Mat n) : ℝ :=
  MvPolynomial.eval (fun ij => U ij.1 ij.2) p

/-- Algebraic-generic rule, allowing a separate proper algebraic exception in each
dimension. Any proper real algebraic set lies in the zero set of a nonzero polynomial.
The rule is restricted to unique least choices, as explicitly allowed by SP-04. -/
def GenericSmallestMultiplierConjecture : Prop :=
  ∀ n : ℕ, 2 ≤ n → ∃ p : MvPolynomial (Fin n × Fin n) ℝ,
    p ≠ 0 ∧ ∀ U X : Mat n, ∀ c : ℝ,
      evalData p U ≠ 0 → UniqueLeast U X c → Nearest U X

end
end NLA.SP04
