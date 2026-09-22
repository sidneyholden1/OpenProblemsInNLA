import NLA.MF02.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
open Polynomial
noncomputable section
namespace NLA.MF02

lemma span_degree_bound (ps : List ℝ[X]) (D : ℕ)
    (h : ∀ p ∈ ps, p.natDegree ≤ D) {p : ℝ[X]} (hp : p ∈ registerSpan ps) :
    p.natDegree ≤ D := by
  induction hp using Submodule.span_induction with
  | mem x hx => exact h x hx
  | zero => simp
  | add x y hx hy ihx ihy => exact (natDegree_add_le x y).trans (max_le ihx ihy)
  | smul a x hx ih => exact (natDegree_smul_le a x).trans ih

lemma run_degree_bound {m : ℕ} {ps : List ℝ[X]} (h : RegisterRun m ps) :
    ∀ p ∈ ps, p.natDegree ≤ 2^m := by
  induction h with
  | initial => intro p hp; simp at hp
               rcases hp with rfl | rfl <;> simp
  | @multiply m ps p q h hp hq ih =>
    have htwo : (2 : ℕ)^m ≤ 2^(m+1) := Nat.pow_le_pow_right (by decide) (Nat.le_succ m)
    intro r hr
    rcases List.mem_cons.mp hr with rfl | hr
    · calc
        (p*q).natDegree ≤ p.natDegree+q.natDegree := natDegree_mul_le
        _ ≤ 2^m+2^m := add_le_add (span_degree_bound ps _ ih hp) (span_degree_bound ps _ ih hq)
        _ = 2^(m+1) := by ring
    · exact (ih r hr).trans htwo

theorem register_degree_bound_proved (m : ℕ) (p : ℝ[X]) (hp : computable m p) :
    p.natDegree ≤ 2^m := by
  obtain ⟨k,hk,ps,hrun,hp⟩ := hp
  exact (span_degree_bound ps _ (run_degree_bound hrun) hp).trans (Nat.pow_le_pow_right (by decide) hk)

end NLA.MF02
