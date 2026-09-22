/- Exact order-four classification at the witness spectrum.
Formalization: Sidney Holden with Codex. Mathematical counterexample:
Matthew J. Colbrook. Apache 2.0. -/
import NLA.IS02.Support
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 4000000
open scoped Matrix
noncomputable section
namespace NLA.IS02

def perm0 : Equiv.Perm (Fin 4) :=
  Equiv.ofBijective ![0,1,2,3] (by decide +kernel)
def perm1 : Equiv.Perm (Fin 4) :=
  Equiv.ofBijective ![2,3,0,1] (by decide +kernel)
def perm2 : Equiv.Perm (Fin 4) :=
  Equiv.ofBijective ![0,2,1,3] (by decide +kernel)
def perm3 : Equiv.Perm (Fin 4) :=
  Equiv.ofBijective ![2,0,3,1] (by decide +kernel)
def perm4 : Equiv.Perm (Fin 4) :=
  Equiv.ofBijective ![0,2,3,1] (by decide +kernel)
def perm5 : Equiv.Perm (Fin 4) :=
  Equiv.ofBijective ![2,0,1,3] (by decide +kernel)

lemma model_unique (a b c d e f : ℝ)
    (h : model a b c d e f ∈ stochasticSet 4)
    (hc : (model a b c d e f).charpoly =
      Polynomial.X*(Polynomial.X-1)^2*(Polynomial.X+1)) :
    permSimilar witness (model a b c d e f) := by
  obtain ⟨hs,hp,ht⟩ := model_spectral_constraints a b c d e f hc
  have h0 : 0 ≤ 1-a-b-c := h.2.1 0 0
  have h1 : 0 ≤ 1-a-d-e := h.2.1 1 1
  have h2 : 0 ≤ 1-b-d-f := h.2.1 2 2
  have h3 : 0 ≤ 1-c-e-f := h.2.1 3 3
  have hshape := support_shape a b c d e f (h.2.1 0 1) (h.2.1 0 2)
    (h.2.1 0 3) (h.2.1 1 2) (h.2.1 1 3) (h.2.1 2 3) ht
  dsimp [edgeSum,pairSum] at hs hp
  rcases hshape with hz | hz | hz | hz | hz | hz | hz
  · rcases hz with ⟨rfl,rfl,rfl⟩
    have zd : d = 1/2 := by linarith
    have ze : e = 1/2 := by linarith
    have zf : f = 1/2 := by linarith
    subst d
    subst e
    subst f
    norm_num at hp
  · rcases hz with ⟨rfl,rfl,rfl⟩
    have zb : b = 1/2 := by linarith
    have zc : c = 1/2 := by linarith
    have zf : f = 1/2 := by linarith
    subst b
    subst c
    subst f
    norm_num at hp
  · rcases hz with ⟨rfl,rfl,rfl⟩
    have za : a = 1/2 := by linarith
    have zc : c = 1/2 := by linarith
    have ze : e = 1/2 := by linarith
    subst a
    subst c
    subst e
    norm_num at hp
  · rcases hz with ⟨rfl,rfl,rfl⟩
    have za : a = 1/2 := by linarith
    have zb : b = 1/2 := by linarith
    have zd : d = 1/2 := by linarith
    subst a
    subst b
    subst d
    norm_num at hp
  · rcases hz with ⟨rfl,rfl,rfl,rfl⟩
    have hprod : (a-1)*(a-1/2)=0 := by nlinarith
    rcases mul_eq_zero.mp hprod with z | z
    · have za : a = 1 := by linarith
      have zf : f = 1/2 := by linarith
      subst a; subst f
      refine ⟨perm0, ?_⟩
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [model,witness,perm0,Matrix.submatrix_apply,Matrix.cons_val_two,Matrix.cons_val_three]
    · have za : a = 1/2 := by linarith
      have zf : f = 1 := by linarith
      subst a; subst f
      refine ⟨perm1, ?_⟩
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [model,witness,perm1,Matrix.submatrix_apply,Matrix.cons_val_two,Matrix.cons_val_three]
  · rcases hz with ⟨rfl,rfl,rfl,rfl⟩
    have hprod : (b-1)*(b-1/2)=0 := by nlinarith
    rcases mul_eq_zero.mp hprod with z | z
    · have zb : b = 1 := by linarith
      have ze : e = 1/2 := by linarith
      subst b; subst e
      refine ⟨perm2, ?_⟩
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [model,witness,perm2,Matrix.submatrix_apply,Matrix.cons_val_two,Matrix.cons_val_three]
    · have zb : b = 1/2 := by linarith
      have ze : e = 1 := by linarith
      subst b; subst e
      refine ⟨perm3, ?_⟩
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [model,witness,perm3,Matrix.submatrix_apply,Matrix.cons_val_two,Matrix.cons_val_three]
  · rcases hz with ⟨rfl,rfl,rfl,rfl⟩
    have hprod : (c-1)*(c-1/2)=0 := by nlinarith
    rcases mul_eq_zero.mp hprod with z | z
    · have zc : c = 1 := by linarith
      have zd : d = 1/2 := by linarith
      subst c; subst d
      refine ⟨perm4, ?_⟩
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [model,witness,perm4,Matrix.submatrix_apply,Matrix.cons_val_two,Matrix.cons_val_three]
    · have zc : c = 1/2 := by linarith
      have zd : d = 1 := by linarith
      subst c; subst d
      refine ⟨perm5, ?_⟩
      ext i j; fin_cases i <;> fin_cases j <;> norm_num [model,witness,perm5,Matrix.submatrix_apply,Matrix.cons_val_two,Matrix.cons_val_three]

#assert_trust kernel model_unique
end NLA.IS02
