/- MI-08 sign-design obstructions. Mathematical source: Matthew J. Colbrook.
The divisibility proof adapts Dennj Osele's Mathlib IsHadamard.four_dvd_card
from square rows to rectangular columns. Apache-2.0. -/
import NLA.MI08.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix
namespace NLA.MI08

theorem design_obstructions (d q : ℕ) (hq : 0 < q)
    (H : Matrix (Fin q) (Fin d) ℤ) (hH : SignDesign H) :
    d ≤ q ∧ (3 ≤ d → 4 ∣ q) := by
  constructor
  · have hn : (q : ℤ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hq)
    calc d = ((q : ℤ) • (1 : Matrix (Fin d) (Fin d) ℤ)).rank := by
           rw [Matrix.rank_smul_of_mem_nonZeroDivisors _ (mem_nonZeroDivisors_of_ne_zero hn)]
           simp
         _ = (H.transpose * H).rank := by rw [hH.2]
         _ ≤ H.transpose.rank := Matrix.rank_mul_le_left _ _
         _ ≤ q := Matrix.rank_le_width _
  · intro hd
    obtain ⟨a,b,c,hab,hac,hbc⟩ := Fintype.two_lt_card_iff.mp
      (show 2 < Fintype.card (Fin d) by simp only [Fintype.card_fin]; omega)
    have horth ⦃i j : Fin d⦄ (hij : i ≠ j) : ∑ r, H r i * H r j = 0 := by
      simpa [Matrix.mul_apply, Matrix.one_apply, hij] using congr_fun (congr_fun hH.2 i) j
    have hexpand : ∀ r, (1 + H r b * H r a) * (1 + H r c * H r a) =
        1 + H r b * H r a + H r c * H r a + H r b * H r c := by
      intro r
      obtain hr | hr := hH.1 r a <;> simp [hr] <;> ring
    have hdvd : ∀ r, (4 : ℤ) ∣ (1 + H r b * H r a) * (1 + H r c * H r a) := by
      intro r
      obtain ha | ha := hH.1 r a <;> obtain hb | hb := hH.1 r b <;>
        obtain hc | hc := hH.1 r c <;> simp [ha,hb,hc]
    have hsum : ∑ r, (1 + H r b * H r a) * (1 + H r c * H r a) = (q : ℤ) := by
      simp_rw [hexpand]
      simp [Finset.sum_add_distrib,horth hab.symm,horth hac.symm,horth hbc]
    rw [← Int.ofNat_dvd, ← hsum]
    exact Finset.dvd_sum fun r _ => hdvd r

/-- Exact finite integer computation, checked by the ordinary kernel. -/
lemma twelve_integer_certificate : SignDesign hadamardTwelve := by
  unfold SignDesign hadamardTwelve
  decide +kernel

theorem hadamard_twelve : SignDesign hadamardTwelve ∧ (0 : ℝ) < 12 := by
  refine ⟨twelve_integer_certificate, ?_⟩
  interval_decide (trust := kernel)

lemma restrict_design {q d e : ℕ} {H : Matrix (Fin q) (Fin d) ℤ}
    (hH : SignDesign H) (f : Fin e → Fin d) (hf : Function.Injective f) :
    SignDesign (H.submatrix id f) := by
  refine ⟨fun r j => hH.1 r (f j), ?_⟩
  ext i j
  have h := congr_fun (congr_fun hH.2 (f i)) (f j)
  simpa [Matrix.mul_apply,Matrix.one_apply,hf.eq_iff] using h
end NLA.MI08
