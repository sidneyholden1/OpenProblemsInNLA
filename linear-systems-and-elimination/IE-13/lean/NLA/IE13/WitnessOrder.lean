/- Actual current row positions in the IE-13 rational example.
Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.WitnessLU
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

/-- The factor row at an active position after the prescribed earlier swaps. -/
def witnessLabel (p q k : ℕ) (i : Fin (witnessSize p q)) : Fin (witnessSize p q) :=
  if hk : k ≤ p then
    if i.val = p then ⟨k,by unfold witnessSize; omega⟩
    else if hi : i.val < p then ⟨i.val+1,by unfold witnessSize; omega⟩ else i
  else i

lemma witnessLabel_zero (p q : ℕ) : witnessLabel p q 0 = factorRow p q := by
  funext i
  simp [witnessLabel,factorRow]

lemma witnessPivot_active (p q : ℕ) (k : Fin (witnessSize p q)) :
    k ≤ witnessPivot p q k := by
  unfold witnessPivot
  split_ifs with hk
  · exact hk
  · exact le_rfl

lemma witnessLabel_active (p q : ℕ) (k i : Fin (witnessSize p q)) (hi : k ≤ i) :
    k ≤ witnessLabel p q k.val i := by
  unfold witnessLabel
  split_ifs <;> simp only [Fin.le_def] at * <;> omega

lemma witnessLabel_pivot (p q : ℕ) (k : Fin (witnessSize p q)) :
    witnessLabel p q k.val (witnessPivot p q k) = k := by
  by_cases hk : k.val ≤ p
  · simp [witnessPivot,hk,witnessLabel]
  · simp [witnessPivot,hk,witnessLabel]

lemma witnessLabel_next (p q : ℕ) (k i : Fin (witnessSize p q)) (hi : k < i) :
    witnessLabel p q (k.val+1) i =
      witnessLabel p q k.val (Equiv.swap k (witnessPivot p q k) i) := by
  by_cases hk : k.val ≤ p
  · by_cases hp : k.val = p
    · have hkfin : k = (⟨p,by unfold witnessSize; omega⟩ : Fin (witnessSize p q)) := Fin.ext hp
      have hip : ¬i.val ≤ p := by simp only [Fin.lt_def] at hi; omega
      simp [witnessPivot,hk,←hkfin,witnessLabel,show ¬k.val+1 ≤ p by omega,
        show i.val ≠ p by omega,show ¬i.val < p by omega]
    · have hkp : k.val+1 ≤ p := by omega
      by_cases he : i = witnessPivot p q k
      · have hip : i.val = p := by simpa [witnessPivot,hk] using congrArg Fin.val he
        rw [he,Equiv.swap_apply_right]
        apply Fin.ext
        simp [witnessPivot,witnessLabel,hk,hkp,hp,show k.val < p by omega]
      · rw [Equiv.swap_apply_of_ne_of_ne hi.ne' he]
        have hip : i.val ≠ p := by
          intro hh; apply he; apply Fin.ext; simp [witnessPivot,hk,hh]
        simp [witnessLabel,hk,hkp,hip]
  · have hkp : ¬k.val+1 ≤ p := by omega
    simp [witnessPivot,hk,witnessLabel,hkp]

lemma factorRow_injective (p q : ℕ) : Function.Injective (factorRow p q) := by
  intro i j hij
  have hv := congrArg Fin.val hij
  simp only [factorRow] at hv
  split_ifs at hv <;> apply Fin.ext <;> simp_all only [Fin.val_mk] <;> omega

/-- The input row assignment is a bijection, not an allowed initial GEPP move. -/
def factorEquiv (p q : ℕ) : Equiv.Perm (Fin (witnessSize p q)) :=
  Equiv.ofBijective (factorRow p q) ((Finite.injective_iff_bijective).mp (factorRow_injective p q))

@[simp] lemma factorEquiv_apply (p q : ℕ) (i : Fin (witnessSize p q)) :
    factorEquiv p q i = factorRow p q i := rfl

lemma factor_lu_det_ne_zero {n : ℕ} (L U : Mat n) (e : Equiv.Perm (Fin n))
    (hl : ∀ a b : Fin n, a < b → L a b = 0)
    (hd : ∀ a : Fin n, L a a = 1)
    (hu : ∀ a b : Fin n, b < a → U a b = 0)
    (hz : ∀ a : Fin n, U a a ≠ 0) :
    ((L*U).submatrix e id).det ≠ 0 := by
  have hld : L.det = 1 := by
    rw [Matrix.det_of_isLowerTriangular L (by intro i j h; exact hl i j h)]
    simp [hd]
  have hud : U.det ≠ 0 := by
    rw [Matrix.det_of_isUpperTriangular (by intro i j h; exact hu i j h)]
    exact Finset.prod_ne_zero_iff.mpr (fun i _ => hz i)
  rw [Matrix.det_permute,Matrix.det_mul,hld,one_mul]
  apply mul_ne_zero _ hud
  exact_mod_cast (Units.ne_zero (Equiv.Perm.sign e))

lemma witnessStates_eq_luStage (p q : ℕ) (L U : Mat (witnessSize p q))
    (hinput : witness p q = (L*U).submatrix (factorRow p q) id)
    (hl : ∀ a b : Fin (witnessSize p q), a < b → L a b = 0)
    (hd : ∀ a : Fin (witnessSize p q), L a a = 1)
    (hu : ∀ a b : Fin (witnessSize p q), b < a → U a b = 0)
    (hz : ∀ a : Fin (witnessSize p q), U a a ≠ 0)
    (k : ℕ) (hk : k < witnessSize p q) :
    witnessStates p q k = luStage L U (witnessLabel p q) k := by
  induction k with
  | zero => simpa [witnessStates,luStage_zero,witnessLabel_zero] using hinput
  | succ k ih =>
    have hk' : k < witnessSize p q := by omega
    rw [witnessStates,dif_pos hk',ih hk']
    exact luStage_step L U (witnessLabel p q) hl hd hu hz ⟨k,hk'⟩
      (witnessPivot p q ⟨k,hk'⟩) (witnessPivot_active p q _)
      (witnessLabel_pivot p q _) (witnessLabel_next p q _)

lemma witness_isPath_of_lu (p q : ℕ) (L U : Mat (witnessSize p q))
    (hinput : witness p q = (L*U).submatrix (factorRow p q) id)
    (hl : ∀ a b : Fin (witnessSize p q), a < b → L a b = 0)
    (hd : ∀ a : Fin (witnessSize p q), L a a = 1)
    (hu : ∀ a b : Fin (witnessSize p q), b < a → U a b = 0)
    (hz : ∀ a : Fin (witnessSize p q), U a a ≠ 0)
    (hb : ∀ a b : Fin (witnessSize p q), b ≤ a → ‖L a b‖ ≤ 1) :
    isPath (witness p q) (witnessStates p q) (witnessPivot p q) := by
  have hp := luStage_isPath L U (witnessLabel p q) (witnessPivot p q) hl hd hu hz
    (fun k i hi => hb _ _ (witnessLabel_active p q k i hi))
    (witnessPivot_active p q) (witnessLabel_pivot p q) (witnessLabel_next p q)
  refine ⟨rfl,fun k => ⟨(hp.2 k).1,?_,?_,?_⟩⟩
  · rw [witnessStates_eq_luStage p q L U hinput hl hd hu hz k.val k.isLt]
    exact (hp.2 k).2.1
  · intro i hi
    rw [witnessStates_eq_luStage p q L U hinput hl hd hu hz k.val k.isLt]
    exact (hp.2 k).2.2.1 i hi
  · intro hk
    simp only [witnessStates,dif_pos k.isLt]

end NLA.IE13
