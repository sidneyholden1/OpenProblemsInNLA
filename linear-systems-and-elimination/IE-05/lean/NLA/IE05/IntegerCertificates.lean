/- Exact integer certificates; no floating point or unchecked computation.
Stepaniants's matrices, formalized by Sidney Holden with Codex assistance. Apache 2.0. -/
import NLA.IE05.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 8000000
set_option maxRecDepth 100000
open scoped BigOperators Matrix NNReal
noncomputable section
namespace NLA.IE05

def intH (b : Bool) := if b then witnessH else candidateH
def intT (b : Bool) := if b then witnessT else candidateT
def intD (b : Bool) := if b then witnessD else candidateD
def intL (b : Bool) : Matrix (Fin 8) (Fin 8) ℤ := fun i j =>
  if b = true ∧ i = 7 ∧ j = 1 then 0 else
  if i = j then 1 else if j < i then -1 else 0

def intState (b : Bool) (k : ℕ) : Matrix (Fin 8) (Fin 8) ℤ := fun i j =>
  if k ≤ i.val ∧ k ≤ j.val then
    ∑ ell : Fin 8, if k ≤ ell.val then intL b i ell * intT b ell j else 0
  else 0

lemma int_diag_pos : ∀ b : Bool, ∀ i : Fin 8, 0 < intD b i ∧ 0 < intT b i i := by decide +kernel
lemma int_gram : ∀ b : Bool, ∀ i j : Fin 8,
    (∑ k : Fin 8, intH b k i * intH b k j) = if i = j then intD b i else 0 := by decide +kernel
lemma int_qr_upper : ∀ b : Bool, ∀ i j : Fin 8, j < i →
    (∑ k : Fin 8, intH b k i * intL b k j) = 0 := by decide +kernel
lemma int_qr_pos : ∀ b : Bool, ∀ i : Fin 8,
    0 < ∑ k : Fin 8, intH b k i * intL b k i := by decide +kernel
lemma int_lower_bound : ∀ b : Bool, ∀ i j : Fin 8, |intL b i j| ≤ 1 := by decide +kernel
lemma int_lower_diag : ∀ b : Bool, ∀ i : Fin 8, intL b i i = 1 := by decide +kernel
lemma int_state_initial : ∀ b : Bool, ∀ i j : Fin 8, intState b 0 i j = intH b i j := by
  intro b i j; cases b <;> fin_cases i <;> fin_cases j <;> decide +kernel
lemma int_state_pivot : ∀ b : Bool, ∀ k i : Fin 8, k ≤ i →
    intState b k.val i k = intL b i k * intT b k k := by decide +kernel
lemma int_state_recurrence : ∀ b : Bool, ∀ k : Fin 7, ∀ i j : Fin 8,
    intState b (k.val+1) i j =
      if k.castSucc < i ∧ k.castSucc < j then
        intState b k.val i j - intL b i k.castSucc * intState b k.val k.castSucc j
      else 0 := by
  intro b k i j; cases b <;> fin_cases k <;> fin_cases i <;> fin_cases j <;> decide +kernel
lemma int_candidate_bound : ∀ k i j : Fin 8,
    (intState false k.val i j)^2 ≤ 5462 * intD false j := by decide +kernel
lemma int_witness_input_bound : ∀ i j : Fin 8,
    5272 * (intH true i j)^2 ≤ 3969 * intD true j := by decide +kernel
lemma int_candidate_entry : intH false 2 2 = 51 ∧ intD false 2 = 3286 := by decide +kernel
lemma int_witness_final : intState true 7 7 7 = 5272 ∧ intD true 7 = 5272 := by decide +kernel

#assert_trust kernel int_gram
#assert_trust kernel int_state_recurrence
#assert_trust kernel int_candidate_bound
end NLA.IE05
