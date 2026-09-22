import NLA.MF02.Registers
import Mathlib.Topology.Order.Compact
set_option autoImplicit false
open Polynomial
noncomputable section
namespace NLA.MF02

lemma pointErrors_split (δ : ℝ) (hδ : 0 < δ) (p : ℝ[X]) :
    pointErrors δ p = (fun x => |p.eval x+1|) '' Set.Icc (-1) (-δ) ∪
      (fun x => |p.eval x-1|) '' Set.Icc δ 1 := by
  ext e
  constructor
  · rintro ⟨x,hx,rfl⟩
    rcases hx with hx | hx
    · left; refine ⟨x,hx,?_⟩
      simp [targetSign,show x < 0 by linarith [hx.2]]
    · right; refine ⟨x,hx,?_⟩
      simp [targetSign,show ¬x < 0 by linarith [hx.1]]
  · rintro (⟨x,hx,rfl⟩ | ⟨x,hx,rfl⟩)
    · refine ⟨x,Or.inl hx,?_⟩
      simp [targetSign,show x < 0 by linarith [hx.2]]
    · refine ⟨x,Or.inr hx,?_⟩
      simp [targetSign,show ¬x < 0 by linarith [hx.1]]

lemma pointErrors_compact (δ : ℝ) (hδ : 0 < δ) (p : ℝ[X]) :
    IsCompact (pointErrors δ p) := by
  rw [pointErrors_split δ hδ p]
  exact (isCompact_Icc.image (p.continuous.add continuous_const).abs).union
    (isCompact_Icc.image (p.continuous.sub continuous_const).abs)

lemma pointErrors_nonempty (δ : ℝ) (hδ1 : δ < 1) (p : ℝ[X]) :
    (pointErrors δ p).Nonempty :=
  ⟨_,⟨δ,Or.inr ⟨le_rfl,hδ1.le⟩,rfl⟩⟩

lemma error_attained (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) (p : ℝ[X]) :
    uniformError δ p ∈ pointErrors δ p :=
  (pointErrors_compact δ hδ p).sSup_mem (pointErrors_nonempty δ hδ1 p)

lemma error_nonneg (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) (p : ℝ[X]) :
    0 ≤ uniformError δ p := by
  obtain ⟨x,hx,he⟩ := error_attained δ hδ hδ1 p
  rw [← he]; exact abs_nonneg _

lemma point_error_le (δ : ℝ) (hδ : 0 < δ) (p : ℝ[X]) (x : ℝ)
    (hx : x ∈ gapDomain δ) : |p.eval x-targetSign x| ≤ uniformError δ p :=
  le_csSup (pointErrors_compact δ hδ p).bddAbove ⟨x,hx,rfl⟩

lemma error_le (δ : ℝ) (hδ1 : δ < 1) (p : ℝ[X]) (e : ℝ)
    (h : ∀ x ∈ gapDomain δ, |p.eval x-targetSign x| ≤ e) : uniformError δ p ≤ e := by
  apply csSup_le (pointErrors_nonempty δ hδ1 p)
  rintro y ⟨x,hx,rfl⟩; exact h x hx

lemma zero_computable (m : ℕ) : computable m 0 :=
  ⟨0,Nat.zero_le m,[1,X],RegisterRun.initial,Submodule.zero_mem _⟩

theorem error_sets_valid_proved (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (∀ p : ℝ[X], (pointErrors δ p).Nonempty ∧ BddAbove (pointErrors δ p) ∧
      uniformError δ p ∈ pointErrors δ p) ∧
    (∀ m, (unrestrictedErrors m δ).Nonempty ∧ BddBelow (unrestrictedErrors m δ)) ∧
    (∀ T, (cubicErrors T δ).Nonempty ∧ BddBelow (cubicErrors T δ)) := by
  refine ⟨fun p => ⟨pointErrors_nonempty δ hδ1 p,(pointErrors_compact δ hδ p).bddAbove,
    error_attained δ hδ hδ1 p⟩,?_,?_⟩
  · intro m
    refine ⟨⟨_,0,zero_computable m,rfl⟩,⟨0,?_⟩⟩
    rintro e ⟨p,hp,rfl⟩; exact error_nonneg δ hδ hδ1 p
  · intro T
    refine ⟨⟨_,List.replicate T (0,0),by simp,rfl⟩,⟨0,?_⟩⟩
    rintro e ⟨cs,hcs,rfl⟩; exact error_nonneg δ hδ hδ1 _

end NLA.MF02
