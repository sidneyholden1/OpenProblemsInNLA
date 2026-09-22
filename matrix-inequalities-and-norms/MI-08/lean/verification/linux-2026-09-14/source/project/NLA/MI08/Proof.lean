/- Exact MI-08 fixed pinching minimum in dimensions nine through twelve.
Mathematical partial result: Matthew J. Colbrook. Formalization: Sidney Holden
with OpenAI Codex assistance. Apache-2.0. -/
import NLA.MI08.Correspondence
import NLA.MI08.Designs
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MI08

theorem finite_minimums (d : ℕ) (hlo : 9 ≤ d) (hhi : d ≤ 12) :
    (pinchingLengths d).Nonempty ∧ IsLeast (pinchingLengths d) 12 ∧ phi d = 12 := by
  let f : Fin d → Fin 12 := Fin.castLE hhi
  have hf : Function.Injective f := Fin.castLE_injective hhi
  have hH := restrict_design hadamard_twelve.1 f hf
  have h12 : 12 ∈ pinchingLengths d :=
    design_to_fixed (by exact_mod_cast hadamard_twelve.2) hH
  have hleast : IsLeast (pinchingLengths d) 12 := by
    refine ⟨h12, ?_⟩
    intro q hq
    obtain ⟨U,hU⟩ := hq
    obtain ⟨H,hH⟩ := fixed_to_design hU
    obtain ⟨hrank,hdiv⟩ := design_obstructions d q hU.1 H hH
    have hfour := hdiv (by omega)
    obtain ⟨k,rfl⟩ := hfour
    omega
  exact ⟨⟨12,h12⟩,hleast,hleast.csInf_eq⟩
end NLA.MI08
