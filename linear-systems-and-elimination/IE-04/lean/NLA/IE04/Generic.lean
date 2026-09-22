import NLA.IE04.Realize
import NLA.IE04.Regular

/-! Genericity for the actual total GEPP recurrence under arbitrary affine
Gaussian perturbations. Every nonzero rational numerator has an explicit
reverse-Schur witness. The rational-expression framework is adapted from KE-05;
mathematical IE-04 source: George Stepaniants. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped Classical BigOperators
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

abbrev Flat (n : ℕ) := Fin n × Fin n → ℝ

def flatPerturb {n : ℕ} (center : Mat n) (σ : ℝ) (x : Flat n) : Mat n :=
  perturb center σ (fun i j => x (i,j))

lemma flatPerturb_regular {n : ℕ} (center : Mat n) (σ : ℝ) (a : Flat n) (i j : Fin n) :
    RegularAt a (fun x => flatPerturb center σ x i j) :=
  (RegularAt.const (center i j)).add ((RegularAt.const σ).mul (RegularAt.coord (i,j)))

lemma flatPerturb_surjective {n : ℕ} (center : Mat n) (σ : ℝ) (hσ : σ ≠ 0) (A : Mat n) :
    ∃ a : Flat n, flatPerturb center σ a = A := by
  refine ⟨fun ij => (A ij.1 ij.2-center ij.1 ij.2)/σ, ?_⟩
  ext i j
  change center i j + σ*((A i j-center i j)/σ) = A i j
  field_simp
  ring

lemma states_regular {n : ℕ} {a : Flat n} (F : Flat n → Mat n)
    (hF : ∀ i j, RegularAt a (fun x => F x i j)) (π : Schedule n)
    (k : ℕ) (hp : ∀ j : Fin n, j.val < k → states (F a) π j.val (π j) j ≠ 0)
    (i j : Fin n) : RegularAt a (fun x => states (F x) π k i j) := by
  induction k generalizing i j with
  | zero => exact hF i j
  | succ k ih =>
    have hi := ih (fun j hj => hp j (by omega))
    by_cases hk : k < n
    · let f : Fin n := ⟨k,hk⟩
      simp only [states, dif_pos hk]
      change RegularAt a (fun x => schurStep (states (F x) π k) f (π f) i j)
      by_cases hij : f < i ∧ f < j
      · simp only [schurStep, hij, and_self, ↓reduceIte]
        simpa only [div_eq_mul_inv] using
          (hi (Equiv.swap f (π f) i) j).sub
            (((hi (Equiv.swap f (π f) i) f).mul
              ((hi (π f) f).inv (hp f (by simp [f])))).mul (hi (π f) j))
      · simpa only [schurStep, hij, and_self, ↓reduceIte] using (RegularAt.const (a := a) 0)
    · simpa only [states, dif_neg hk, Matrix.zero_apply] using (RegularAt.const (a := a) 0)

lemma flat_pivot_ae {n : ℕ} (center : Mat n) (σ : ℝ) (hσ : 0 < σ)
    (π : Schedule n) (hπ : ∀ j, j ≤ π j) (k : Fin n) :
    ∀ᵐ x ∂Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1),
      states (flatPerturb center σ x) π k.val (π k) k ≠ 0 := by
  let B : Mat n := fun i j => if i=π k ∧ j=k then 1 else 0
  have hB : Padded B k.val := by
    intro i j hij
    by_cases he : i=π k ∧ j=k
    · rcases he with ⟨hu,hv⟩
      have hpk : k.val ≤ (π k).val := hπ k
      have hu' : i.val = (π k).val := congrArg Fin.val hu
      have hv' : j.val = k.val := congrArg Fin.val hv
      rcases hij with hi | hj <;> omega
    · simp [B, he]
  obtain ⟨A,hA,hp⟩ := exists_prefix_realization π hπ k.val k.isLt.le B hB
  obtain ⟨a,ha⟩ := flatPerturb_surjective center σ hσ.ne' A
  have hr := states_regular (flatPerturb center σ) (flatPerturb_regular center σ a) π k.val
    (by intro j hj; rw [ha, hp j hj]; norm_num) (π k) k
  apply hr.ae_ne_zero
  rw [ha, hA]
  simp [B]

lemma flat_tie_ae {n : ℕ} (center : Mat n) (σ : ℝ) (hσ : 0 < σ)
    (π : Schedule n) (hπ : ∀ j, j ≤ π j) (k i : Fin n) (hi : k ≤ i) (hik : i ≠ π k) :
    ∀ᵐ x ∂Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1),
      |states (flatPerturb center σ x) π k.val i k| ≠
        |states (flatPerturb center σ x) π k.val (π k) k| := by
  let B : Mat n := fun u v => if u=i ∧ v=k then 1 else 0
  have hB : Padded B k.val := by
    intro u v huv
    by_cases he : u=i ∧ v=k
    · rcases he with ⟨hu,hv⟩
      have hik' : k.val ≤ i.val := hi
      have hu' : u.val = i.val := congrArg Fin.val hu
      have hv' : v.val = k.val := congrArg Fin.val hv
      rcases huv with hu | hv <;> omega
    · simp [B, he]
  obtain ⟨A,hA,hp⟩ := exists_prefix_realization π hπ k.val k.isLt.le B hB
  obtain ⟨a,ha⟩ := flatPerturb_surjective center σ hσ.ne' A
  have hr (u v : Fin n) := states_regular (flatPerturb center σ)
    (flatPerturb_regular center σ a) π k.val
    (by intro j hj; rw [ha, hp j hj]; norm_num) u v
  have hh := ((hr i k).mul (hr i k)).sub ((hr (π k) k).mul (hr (π k) k))
  have hn : states (flatPerturb center σ a) π k.val i k * states (flatPerturb center σ a) π k.val i k -
      states (flatPerturb center σ a) π k.val (π k) k * states (flatPerturb center σ a) π k.val (π k) k ≠ 0 := by
    rw [ha, hA]
    simp [B, Ne.symm hik]
  filter_upwards [hh.ae_ne_zero hn] with x hx
  intro he
  apply hx
  have hs := congrArg (fun t : ℝ => t^2) he
  simpa [sq_abs, pow_two, sub_eq_zero] using hs

lemma gaussian_generic_flat {n : ℕ} (center : Mat n) (σ : ℝ) (hσ : 0 < σ) :
    ∀ᵐ x ∂Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1),
      (flatPerturb center σ x).det ≠ 0 ∧ ∃! π : Schedule n, IsLegal (flatPerturb center σ x) π := by
  have hp : ∀ᵐ x ∂Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1),
      ∀ k : Fin n, states (flatPerturb center σ x) id k.val k k ≠ 0 := by
    apply ae_all_iff.mpr
    intro k
    exact flat_pivot_ae center σ hσ id (fun j => le_rfl) k
  have ht : ∀ᵐ x ∂Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1),
      ∀ π : Schedule n, (∀ j, j ≤ π j) → ∀ k i : Fin n, k ≤ i → i ≠ π k →
        |states (flatPerturb center σ x) π k.val i k| ≠
          |states (flatPerturb center σ x) π k.val (π k) k| := by
    apply ae_all_iff.mpr
    intro π
    by_cases hπ : ∀ j, j ≤ π j
    · have hh : ∀ᵐ x ∂Measure.pi (fun _ : Fin n × Fin n => gaussianReal 0 1),
          ∀ k i : Fin n, k ≤ i → i ≠ π k →
            |states (flatPerturb center σ x) π k.val i k| ≠
              |states (flatPerturb center σ x) π k.val (π k) k| := by
        apply ae_all_iff.mpr
        intro k
        apply ae_all_iff.mpr
        intro i
        by_cases hi : k ≤ i
        · by_cases hik : i ≠ π k
          · filter_upwards [flat_tie_ae center σ hσ π hπ k i hi hik] with x hx
            exact fun _ _ => hx
          · exact Filter.Eventually.of_forall (by intro x _ hn; exact False.elim (hik hn))
        · exact Filter.Eventually.of_forall (by intro x hn; exact False.elim (hi hn))
      filter_upwards [hh] with x hx
      exact fun _ => hx
    · exact Filter.Eventually.of_forall (by intro x hn; exact False.elim (hπ hn))
  filter_upwards [hp,ht] with x hpx htx
  have hdet := det_ne_zero_of_pivots (flatPerturb center σ x) id (fun k => ⟨le_rfl,hpx k⟩)
  obtain ⟨π,hπ,huniq⟩ := existsUnique_first_legal (flatPerturb center σ x) hdet
  refine ⟨hdet,π,hπ.1,?_⟩
  intro τ hτ
  apply strict_legal_unique _ π hπ.1 ?_ τ hτ
  intro k i hi hik
  exact lt_of_le_of_ne ((hπ.1 k).2.2 i hi)
    (htx π (fun j => (hπ.1 j).1) k i hi hik)

end NLA.IE04
