/- Finite distinct-eigenvalue decomposition; no normality assumption. -/
import NLA.MF22.Definitions
import Mathlib.LinearAlgebra.Eigenspace.Charpoly
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.LinearAlgebra.Matrix.Basis
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22

lemma eigenbasis_exists (T : Matrix (Fin 4) (Fin 4) ℂ) (ev : Fin 4 → ℂ)
    (hi : Function.Injective ev) (he : ∀ i, T.charpoly.IsRoot (ev i)) :
    ∃ b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ), ∀ i, T *ᵥ b i = ev i • b i := by
  classical
  have hv (i : Fin 4) : Module.End.HasEigenvalue (T.toLin') (ev i) := by
    rw [Module.End.hasEigenvalue_iff_isRoot_charpoly, Matrix.charpoly_toLin']
    exact he i
  choose v hv using fun i => (hv i).exists_hasEigenvector
  have hli := Module.End.eigenvectors_linearIndependent' T.toLin' ev hi v hv
  let b := basisOfPiSpaceOfLinearIndependent hli
  refine ⟨b, ?_⟩
  intro i
  have hb : b i = v i := congrFun (coe_basisOfPiSpaceOfLinearIndependent hli) i
  rw [hb]
  exact (Module.End.mem_eigenspace_iff.mp (hv i).1)

/-- Rank-one coordinate projector in an arbitrary (possibly nonorthogonal) basis. -/
def basisProjector (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) (a : Fin 4) :
    Matrix (Fin 4) (Fin 4) ℂ := fun i j => b a i * b.repr (Pi.single j 1) a

lemma basis_power_entries (T : Matrix (Fin 4) (Fin 4) ℂ) (ev : Fin 4 → ℂ)
    (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) (he : ∀ a, T *ᵥ b a = ev a • b a)
    (k : ℕ) (i j : Fin 4) :
    (T^k) i j = ∑ a, ev a^k * basisProjector b a i j := by
  classical
  have hp (m : ℕ) (a : Fin 4) : (T^m) *ᵥ b a = ev a^m • b a := by
    induction m with
    | zero => simp
    | succ m ih =>
      rw [pow_succ',← Matrix.mulVec_mulVec,ih,Matrix.mulVec_smul,he a,smul_smul,pow_succ',mul_comm (ev a ^ m) (ev a)]
  have hs := b.sum_repr (Pi.single j (1 : ℂ))
  have ha := congrArg (fun v => ((T^k) *ᵥ v) i) hs
  simp only [Matrix.mulVec_sum,Matrix.mulVec_smul,hp,Finset.sum_apply,
    Pi.smul_apply,smul_eq_mul,Matrix.mulVec_single,mul_one] at ha
  simp only [MulOpposite.op_one,one_smul, Matrix.col_apply] at ha
  rw [← ha]
  apply Finset.sum_congr rfl
  intro a _
  simp [basisProjector]
  ring

lemma basis_projector_rank_one (b : Module.Basis (Fin 4) ℂ (Fin 4 → ℂ)) (a i j : Fin 4) :
    basisProjector b a i 0 * basisProjector b a 0 j =
      basisProjector b a 0 0 * basisProjector b a i j := by
  classical
  simp [basisProjector]
  ring

#assert_trust kernel eigenbasis_exists
end NLA.MF22
