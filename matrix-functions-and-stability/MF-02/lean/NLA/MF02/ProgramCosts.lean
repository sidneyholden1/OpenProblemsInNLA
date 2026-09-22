import NLA.MF02.Registers
set_option autoImplicit false
open Polynomial
noncomputable section
namespace NLA.MF02

lemma span_mem_cons (ps : List ℝ[X]) (q : ℝ[X]) {p : ℝ[X]}
    (hp : p ∈ registerSpan ps) : p ∈ registerSpan (q::ps) := by
  apply Submodule.span_mono (show {p | p ∈ ps} ⊆ {p | p ∈ q::ps} by
    intro r hr; exact List.mem_cons_of_mem q hr) hp

lemma cubic_comp_run {m : ℕ} {ps : List ℝ[X]} (h : RegisterRun m ps)
    (p : ℝ[X]) (hp : p ∈ registerSpan ps) (a b : ℝ) :
    ∃ qs, RegisterRun (m+2) qs ∧ (cubic a b).comp p ∈ registerSpan qs := by
  have h2 := RegisterRun.multiply h hp hp
  have hp2 : p*p ∈ registerSpan (p*p::ps) := Submodule.subset_span (List.mem_cons_self)
  have hp' := span_mem_cons ps (p*p) hp
  have h3 := RegisterRun.multiply h2 hp' hp2
  have hp'' := span_mem_cons (p*p::ps) (p*(p*p)) hp'
  have hp3 : p*(p*p) ∈ registerSpan (p*(p*p)::p*p::ps) :=
    Submodule.subset_span (List.mem_cons_self)
  refine ⟨_,h3,?_⟩
  have he : (cubic a b).comp p = a • p + b • (p*(p*p)) := by
    simp [cubic,Polynomial.smul_eq_C_mul,pow_succ,mul_assoc]
  rw [he]
  exact Submodule.add_mem _ (Submodule.smul_mem _ a hp'') (Submodule.smul_mem _ b hp3)

lemma composition_run (cs : List (ℝ × ℝ)) {m : ℕ} {ps : List ℝ[X]}
    (h : RegisterRun m ps) (p : ℝ[X]) (hp : p ∈ registerSpan ps) :
    ∃ qs, RegisterRun (m+2*cs.length) qs ∧ (composeCubics cs).comp p ∈ registerSpan qs := by
  induction cs generalizing m ps p with
  | nil => simpa [composeCubics] using (show ∃ qs, RegisterRun m qs ∧ p ∈ registerSpan qs from ⟨ps,h,hp⟩)
  | cons ab cs ih =>
    obtain ⟨qs,hqs,hpqs⟩ := cubic_comp_run h p hp ab.1 ab.2
    obtain ⟨rs,hrs,hprs⟩ := ih hqs ((cubic ab.1 ab.2).comp p) hpqs
    refine ⟨rs,?_,?_⟩
    · simpa only [List.length_cons] using (show RegisterRun (m+2*(cs.length+1)) rs by
        convert hrs using 1 <;> omega)
    · simpa only [composeCubics,Polynomial.comp_assoc] using hprs

theorem stages_computable_proved (cs : List (ℝ × ℝ)) :
    computable (2*cs.length) (composeCubics cs) := by
  have hx : (X : ℝ[X]) ∈ registerSpan [1,X] := Submodule.subset_span (by simp)
  obtain ⟨qs,hqs,hp⟩ := composition_run cs RegisterRun.initial X hx
  refine ⟨2*cs.length,le_rfl,qs,?_,?_⟩
  · simpa using hqs
  · simpa using hp

end NLA.MF02
