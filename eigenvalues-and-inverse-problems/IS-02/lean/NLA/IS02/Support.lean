/- Exhaustive exact support reduction, with early closure of zero cuts or
positive spanning trees. Formalization: Sidney Holden with Codex. Apache 2.0. -/
import NLA.IS02.Algebra
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
noncomputable section
namespace NLA.IS02

lemma support_shape (a b c d e f : ℝ)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) (hf : 0 ≤ f)
    (ht : treeSum a b c d e f = 0) :
    (a=0 ∧ b=0 ∧ c=0) ∨ (a=0 ∧ d=0 ∧ e=0) ∨
    (b=0 ∧ d=0 ∧ f=0) ∨ (c=0 ∧ e=0 ∧ f=0) ∨
    (b=0 ∧ c=0 ∧ d=0 ∧ e=0) ∨ (a=0 ∧ c=0 ∧ d=0 ∧ f=0) ∨
    (a=0 ∧ b=0 ∧ e=0 ∧ f=0) := by
  rcases eq_or_lt_of_le ha with za | pa
  · rcases eq_or_lt_of_le hb with zb | pb
    · rcases eq_or_lt_of_le hc with zc | pc
      · exact Or.inl ⟨za.symm,zb.symm,zc.symm⟩
      · rcases eq_or_lt_of_le hd with zd | pd
        · rcases eq_or_lt_of_le he with ze | pe
          · exact Or.inr (Or.inl ⟨za.symm,zd.symm,ze.symm⟩)
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inl ⟨zb.symm,zd.symm,zf.symm⟩))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
        · rcases eq_or_lt_of_le he with ze | pe
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (⟨za.symm,zb.symm,ze.symm,zf.symm⟩))))))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
          · exfalso
            have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
            linarith
    · rcases eq_or_lt_of_le hc with zc | pc
      · rcases eq_or_lt_of_le hd with zd | pd
        · rcases eq_or_lt_of_le he with ze | pe
          · exact Or.inr (Or.inl ⟨za.symm,zd.symm,ze.symm⟩)
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨za.symm,zc.symm,zd.symm,zf.symm⟩)))))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
        · rcases eq_or_lt_of_le he with ze | pe
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨zc.symm,ze.symm,zf.symm⟩)))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
          · exfalso
            have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
            linarith
      · rcases eq_or_lt_of_le hd with zd | pd
        · rcases eq_or_lt_of_le he with ze | pe
          · exact Or.inr (Or.inl ⟨za.symm,zd.symm,ze.symm⟩)
          · exfalso
            have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
            linarith
        · exfalso
          have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
          linarith
  · rcases eq_or_lt_of_le hb with zb | pb
    · rcases eq_or_lt_of_le hc with zc | pc
      · rcases eq_or_lt_of_le hd with zd | pd
        · rcases eq_or_lt_of_le he with ze | pe
          · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨zb.symm,zc.symm,zd.symm,ze.symm⟩))))
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inl ⟨zb.symm,zd.symm,zf.symm⟩))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
        · rcases eq_or_lt_of_le he with ze | pe
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨zc.symm,ze.symm,zf.symm⟩)))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
          · exfalso
            have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
            linarith
      · rcases eq_or_lt_of_le hd with zd | pd
        · rcases eq_or_lt_of_le he with ze | pe
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inl ⟨zb.symm,zd.symm,zf.symm⟩))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inl ⟨zb.symm,zd.symm,zf.symm⟩))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
        · exfalso
          have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
          linarith
    · rcases eq_or_lt_of_le hc with zc | pc
      · rcases eq_or_lt_of_le hd with zd | pd
        · rcases eq_or_lt_of_le he with ze | pe
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨zc.symm,ze.symm,zf.symm⟩)))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
          · exfalso
            have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
            linarith
        · rcases eq_or_lt_of_le he with ze | pe
          · rcases eq_or_lt_of_le hf with zf | pf
            · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨zc.symm,ze.symm,zf.symm⟩)))
            · exfalso
              have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
              linarith
          · exfalso
            have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
            linarith
      · exfalso
        have hpos : 0 < treeSum a b c d e f := by unfold treeSum; positivity
        linarith

#assert_trust kernel support_shape
end NLA.IS02
