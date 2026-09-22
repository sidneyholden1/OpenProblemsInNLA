/- Exact sign and positive-scale transport of rook elimination. Apache-2.0. -/
import NLA.IE15.PathReduction
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE15

def unitSign (x : ℝ) : ℝ := if x < 0 then -1 else 1
lemma abs_unitSign (x : ℝ) : |unitSign x| = 1 := by
  unfold unitSign; split_ifs <;> norm_num
lemma unitSign_sq (x : ℝ) : unitSign x * unitSign x = 1 := by
  unfold unitSign; split_ifs <;> norm_num
lemma unitSign_mul (x : ℝ) : unitSign x * x = |x| := by
  unfold unitSign; split_ifs with hx
  · simp [abs_of_neg hx]
  · simp [abs_of_nonneg (le_of_not_gt hx)]
lemma unitSign_pos (x : ℝ) (hx : 0 < x) : unitSign x = 1 := by
  simp [unitSign, not_lt_of_ge hx.le]

def signScale {n : ℕ} (S : ℕ → Mat n) (s t : Fin n → ℝ) (M : ℝ) : ℕ → Mat n :=
  fun k i j => s i * S k i j * t j / M

lemma signScale_abs {n : ℕ} (S : ℕ → Mat n) (s t : Fin n → ℝ) (M : ℝ)
    (hs : ∀ i, |s i| = 1) (ht : ∀ j, |t j| = 1) (hM : 0 < M)
    (k : ℕ) (i j : Fin n) : |signScale S s t M k i j| = |S k i j| / M := by
  simp [signScale, abs_div, abs_mul, hs, ht, abs_of_pos hM]

lemma signScale_path {n : ℕ} (S : ℕ → Mat n) (s t : Fin n → ℝ) (M : ℝ)
    (hs : ∀ i, |s i| = 1) (ht : ∀ j, |t j| = 1) (hM : 0 < M)
    (h : isPath (S 0) S id id) :
    isPath (signScale S s t M 0) (signScale S s t M) id id := by
  constructor
  · rfl
  intro k
  have hh := h.2 k
  have hp : S k.val k k ≠ 0 := hh.2.2.1
  have hsk : s k ≠ 0 := by intro he; simpa [he] using hs k
  have htk : t k ≠ 0 := by intro he; simpa [he] using ht k
  refine ⟨le_rfl, le_rfl, div_ne_zero (mul_ne_zero (mul_ne_zero hsk hp) htk) hM.ne', ?_, ?_, ?_⟩
  · intro i hi
    simp only [id_eq, signScale_abs S s t M hs ht hM]
    exact div_le_div_of_nonneg_right (hh.2.2.2.1 i hi) hM.le
  · intro j hj
    simp only [id_eq, signScale_abs S s t M hs ht hM]
    exact div_le_div_of_nonneg_right (hh.2.2.2.2.1 j hj) hM.le
  · intro hk
    funext i j
    change s i * S (k.val+1) i j * t j / M = _
    rw [hh.2.2.2.2.2 hk]
    simp only [id_eq, schurStep, Equiv.swap_self, Equiv.refl_apply, signScale]
    split_ifs with hij
    · field_simp
    · simp

lemma path_input_pos {n : ℕ} (hn : 0 < n) (A : Mat n) (S : ℕ → Mat n)
    (r c : Fin n → Fin n) (h : isPath A S r c) : 0 < entryMax A := by
  let k : Fin n := ⟨0,hn⟩
  have hp := (h.2 k).2.2.1
  change S 0 (r k) (c k) ≠ 0 at hp
  rw [h.1] at hp
  exact (abs_pos.mpr hp).trans_le (entry_le A _ _)

/-- A sufficient normalized statement retaining the full actual diagonal recurrence. -/
def normalizedBound (n : ℕ) (b : ℝ) : Prop :=
  ∀ (T : ℕ → Mat n), isPath (T 0) T id id →
    (∀ i j, |T 0 i j| ≤ 1) →
    (∀ k : Fin n, 0 < T k.val k k) →
    (∀ k j : Fin n, k ≤ j → 0 ≤ T k.val j k ∨ j.val+1 ≠ n) →
    ∀ k i j : Fin n, |T k.val i j| ≤ b

lemma reduce_to_normalized_bound {n : ℕ} (hn : 0 < n) (b : ℝ) (hb : 0 ≤ b)
    (H : normalizedBound n b) (A : Mat n) (S : ℕ → Mat n)
    (r c : Fin n → Fin n) (h : isPath A S r c) : growth A S ≤ b := by
  let T := diagonalized S r c
  have hT : isPath (T 0) T id id := diagonalized_path A S r c h
  let z : Fin n := ⟨n-1, by omega⟩
  let a := unitSign (T z.val z z)
  let t : Fin n → ℝ := fun i => unitSign (a*T i.val z i)
  let s : Fin n → ℝ := fun i => unitSign (T i.val i i)*t i
  let M := entryMax A
  have hM : 0 < M := path_input_pos hn A S r c h
  have ht : ∀ i, |t i| = 1 := fun i => abs_unitSign _
  have hs : ∀ i, |s i| = 1 := by intro i; simp [s, abs_mul, abs_unitSign, ht]
  have hp : ∀ i : Fin n, T i.val i i ≠ 0 := fun i => (hT.2 i).2.2.1
  have haz : a*T z.val z z = |T z.val z z| := unitSign_mul _
  have htz : t z = 1 := unitSign_pos _ (haz ▸ abs_pos.mpr (hp z))
  have hsz : s z = a := by simp [s, htz, a]
  have hsp : ∀ i, s i*T i.val i i*t i = |T i.val i i| := by
    intro i
    dsimp [s,t]
    calc
      unitSign (T i.val i i)*unitSign (a*T i.val z i)*T i.val i i*unitSign (a*T i.val z i)
          = (unitSign (T i.val i i)*T i.val i i)*(unitSign (a*T i.val z i)*unitSign (a*T i.val z i)) := by ring
      _ = |T i.val i i| := by rw [unitSign_mul,unitSign_sq,mul_one]
  have hh := H (signScale T s t M) (signScale_path T s t M hs ht hM hT)
  have hinit : ∀ i j, |signScale T s t M 0 i j| ≤ 1 := by
    intro i j
    rw [signScale_abs T s t M hs ht hM]
    apply (div_le_one hM).mpr
    dsimp [T,diagonalized,M]
    rw [h.1]
    exact entry_le A _ _
  have hpos : ∀ k : Fin n, 0 < signScale T s t M k.val k k := by
    intro k
    change 0 < (s k*T k.val k k*t k)/M
    rw [hsp]
    exact div_pos (abs_pos.mpr (hp k)) hM
  have hrow : ∀ k j : Fin n, k ≤ j →
      0 ≤ signScale T s t M k.val j k ∨ j.val+1 ≠ n := by
    intro k j hkj
    by_cases hj : j.val+1 = n
    · left
      have hjz : j = z := by apply Fin.ext; dsimp [z]; omega
      subst j
      change 0 ≤ (s z*T k.val z k*t k)/M
      rw [hsz]
      have he : a*T k.val z k*t k = |a*T k.val z k| := by
        rw [mul_comm _ (t k)]; exact unitSign_mul _
      rw [he]
      exact div_nonneg (abs_nonneg _) hM.le
    · exact Or.inr hj
  have hbound := hh hinit hpos hrow
  apply growth_le_of_entry_bounds A S b hb hM
  intro k i j
  let e := pathPerm r k.val
  let f := pathPerm c k.val
  have he := hbound k (e.symm i) (f.symm j)
  rw [signScale_abs T s t M hs ht hM] at he
  have htval : T k.val (e.symm i) (f.symm j) = S k.val i j := by
    simp [T,diagonalized,e,f]
  rw [htval] at he
  exact (div_le_iff₀ hM).mp he

end NLA.IE15
