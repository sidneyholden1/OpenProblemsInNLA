/- The actual PSD limit proves weighted row/column comparison. No eigenvalue
perturbation theorem or differentiability assumption is used. -/
import NLA.MI04.Rescaling
set_option autoImplicit false
open scoped ComplexOrder MatrixOrder Matrix.Norms.L2Operator Topology
open Matrix Filter Set
noncomputable section
namespace NLA.MI04

lemma weighted_threshold {n : ℕ} [NeZero n] {X : Mat n}
    (hX : UniversalBlockNorm X) (i : Fin n) (e : Fin n → ℝ) (s : ℝ)
    (hi : e i=2) (he : ∀ j, 0<e j) (he2 : ∀ j, j≠i → e j<2)
    (hs : 0<s) (hsmall : s^2*rowWeight X i e<1) :
    s^2*rowWeight Xᴴ i e ≤ 1 := by
  have hzero := arrow_zero_posDef X i e s hi he he2 hsmall
  have hpos : ∀ᶠ t in 𝓝 (0:ℝ), (arrowMatrix X i e s t).PosSemidef :=
    eventually_posSemidef (arrow_continuous X i e s).continuousAt
      (arrow_hermitian X i e s) hzero
  have hreflect : ∀ᶠ t in 𝓝[>] (0:ℝ),
      0 ≤ arrowMatrix Xᴴ i e s t := by
    filter_upwards [hpos.filter_mono nhdsWithin_le_nhds,
      self_mem_nhdsWithin] with t ht htp
    exact (arrow_reflect hX i e s t hs htp ht).nonneg
  have hlim : Tendsto (arrowMatrix Xᴴ i e s) (𝓝[>] (0:ℝ))
      (𝓝 (arrowMatrix Xᴴ i e s 0)) :=
    (arrow_continuous Xᴴ i e s).continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  have hnonneg : 0 ≤ arrowMatrix Xᴴ i e s 0 :=
    isClosed_Ici.mem_of_tendsto hlim hreflect
  exact arrow_zero_bound Xᴴ i e s hi he hnonneg.posSemidef

end NLA.MI04
