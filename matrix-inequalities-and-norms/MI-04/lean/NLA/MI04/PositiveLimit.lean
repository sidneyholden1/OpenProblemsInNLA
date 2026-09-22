/- Elementary Hermitian gap argument replacing a perturbation black box. -/
import NLA.MI04.Definitions
import Mathlib.Analysis.Matrix.Order
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Order
import Mathlib.Tactic
set_option autoImplicit false
open scoped ComplexOrder MatrixOrder Matrix.Norms.L2Operator Topology
open Matrix Filter
noncomputable section
namespace NLA.MI04

lemma eventually_posSemidef {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]
    {f : ℝ → Matrix ι ι ℂ} (hf : ContinuousAt f 0)
    (hH : ∀ t, (f t).IsHermitian) (h0 : (f 0).PosDef) :
    ∀ᶠ t in 𝓝 (0 : ℝ), (f t).PosSemidef := by
  obtain ⟨ε, hε, hgap⟩ := (CFC.exists_pos_algebraMap_le_iff h0.isHermitian).mpr
    (fun x hx => h0.isStrictlyPositive.spectrum_pos hx)
  have hsmall : ∀ᶠ t in 𝓝 (0 : ℝ), ‖f t - f 0‖ < ε :=
    (hf.sub continuousAt_const).norm.eventually (gt_mem_nhds (by simpa using hε))
  filter_upwards [hsmall] with t ht
  have hlo := IsSelfAdjoint.neg_algebraMap_norm_le_self
    (show IsSelfAdjoint (f t - f 0) from (hH t).sub h0.isHermitian)
  have hscalar : algebraMap ℝ (Matrix ι ι ℂ) ‖f t-f 0‖ ≤
      algebraMap ℝ (Matrix ι ι ℂ) ε := by
    rw [← sub_nonneg, ← map_sub, Algebra.algebraMap_eq_smul_one]
    exact (Matrix.PosSemidef.one.smul (sub_nonneg.mpr ht.le)).nonneg
  exact (show 0 ≤ f t from by
    have h := add_le_add (hscalar.trans hgap) hlo
    simpa using h).posSemidef

end NLA.MI04
