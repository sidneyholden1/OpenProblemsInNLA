/- Exact source witnesses for Stepaniants's IE-15 resolution. Apache-2.0.
Formalization by Sidney Holden with Codex assistance. -/
import NLA.IE15.Bounds
set_option autoImplicit false
set_option maxHeartbeats 4000000
set_option maxRecDepth 4096
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

lemma witnessThree_det : witnessThree.det = 3 := by
  norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, witnessThree, Matrix.det_fin_three]
lemma witnessFour_det : witnessFour.det = 70/9 := by
  have hsa : Fin.succAbove (2 : Fin 4) (2 : Fin 3) = 3 := rfl
  have hcs : Fin.castSucc (2 : Fin 3) = (2 : Fin 4) := rfl
  norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, witnessFour, Matrix.det_succ_row_zero, Fin.sum_univ_succ,
    Matrix.det_fin_three, Matrix.det_fin_two, hsa, hcs]

lemma witnessThree_path : isPath witnessThree (diagonalStates witnessThree) id id := by
  constructor
  · rfl
  intro k
  refine ⟨le_rfl, le_rfl, ?_, ?_, ?_, ?_⟩
  · fin_cases k <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessThree, Equiv.swap_self]
  · intro i hi
    fin_cases k <;> fin_cases i <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessThree, Equiv.swap_self] at *
  · intro j hj
    fin_cases k <;> fin_cases j <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessThree, Equiv.swap_self] at *
  · intro hk
    simp only [diagonalStates, dif_pos k.isLt, Fin.eta, id_eq]

lemma witnessFour_path : isPath witnessFour (diagonalStates witnessFour) id id := by
  constructor
  · rfl
  intro k
  refine ⟨le_rfl, le_rfl, ?_, ?_, ?_, ?_⟩
  · fin_cases k <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessFour, Equiv.swap_self]
  · intro i hi
    fin_cases k <;> fin_cases i <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessFour, Equiv.swap_self] at *
  · intro j hj
    fin_cases k <;> fin_cases j <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessFour, Equiv.swap_self] at *
  · intro hk
    simp only [diagonalStates, dif_pos k.isLt, Fin.eta, id_eq]

lemma witnessThree_input : entryMax witnessThree = 1 := by
  apply le_antisymm
  · apply entryMax_le _ _ (by norm_num)
    intro i j; fin_cases i <;> fin_cases j <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, witnessThree]
  · simpa [witnessThree] using entry_le witnessThree 0 0
lemma witnessFour_input : entryMax witnessFour = 1 := by
  apply le_antisymm
  · apply entryMax_le _ _ (by norm_num)
    intro i j; fin_cases i <;> fin_cases j <;> norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, witnessFour]
  · simpa [witnessFour] using entry_le witnessFour 0 0

lemma witnessThree_growth : growth witnessThree (diagonalStates witnessThree) = 3 := by
  have hp : 0 < entryMax witnessThree := by rw [witnessThree_input]; norm_num
  apply le_antisymm
  · apply growth_le_of_entry_bounds _ _ _ (by norm_num) hp
    intro k i j
    rw [witnessThree_input]
    fin_cases k <;> fin_cases i <;> fin_cases j <;>
      norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessThree, Equiv.swap_self]
  · have h := growth_ge_entry witnessThree (diagonalStates witnessThree) hp 2 2 2
    rw [witnessThree_input] at h
    norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessThree,
      Equiv.swap_self] at h ⊢
    exact h

lemma witnessFour_growth : growth witnessFour (diagonalStates witnessFour) = 14/3 := by
  have hp : 0 < entryMax witnessFour := by rw [witnessFour_input]; norm_num
  apply le_antisymm
  · apply growth_le_of_entry_bounds _ _ _ (by norm_num) hp
    intro k i j
    rw [witnessFour_input]
    fin_cases k <;> fin_cases i <;> fin_cases j <;>
      norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessFour, Equiv.swap_self]
  · have h := growth_ge_entry witnessFour (diagonalStates witnessFour) hp 3 3 3
    rw [witnessFour_input] at h
    norm_num [Fin.lt_def, Fin.le_def, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail, diagonalStates, schurStep, witnessFour,
      Equiv.swap_self] at h ⊢
    exact h

theorem witness_certificates_proved :
    witnessThree.det = 3 ∧ witnessFour.det = 70/9 ∧
    isPath witnessThree (diagonalStates witnessThree) id id ∧
    isPath witnessFour (diagonalStates witnessFour) id id ∧
    entryMax witnessThree = 1 ∧ entryMax witnessFour = 1 ∧
    growth witnessThree (diagonalStates witnessThree) = 3 ∧
    growth witnessFour (diagonalStates witnessFour) = 14/3 :=
  ⟨witnessThree_det, witnessFour_det, witnessThree_path, witnessFour_path,
    witnessThree_input, witnessFour_input, witnessThree_growth, witnessFour_growth⟩

#assert_trust kernel witness_certificates_proved
end NLA.IE15
