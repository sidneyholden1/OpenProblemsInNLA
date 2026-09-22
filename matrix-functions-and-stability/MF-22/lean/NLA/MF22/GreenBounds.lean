/- Uniform finite Green-entry bound by exact cancellation of the expanding mode.
Source mathematics: George Stepaniants. Formalization: Sidney Holden with Codex. -/
import NLA.MF22.GrowthDenominator
set_option autoImplicit false
set_option maxHeartbeats 1500000
set_option leancert.trust "kernel"
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF22

def greenEntry (T : FourMat) (n j l : ℕ) (i s : Fin 4) : ℂ :=
  (if l<j then (T^(j-1-l)) i s else 0) -
    (T^j) i 0 / (T^n) 0 0 * (T^(n-1-l)) 0 s

lemma green_early_identity (T : FourMat) (lam : ℂ) (P : FourMat) (R : ℕ → FourMat)
    (hRank : ∀ i s, P i 0*P 0 s=P 0 0*P i s)
    (hPower : ∀ k, T^k=lam^k • P+R k)
    (n j l : ℕ) (hj : j≤n) (hlj : l<j) (i s : Fin 4) (hd : (T^n) 0 0 ≠ 0) :
    greenEntry T n j l i s = R (j-1-l) i s+
      lam^(j-1-l)*(P i s*R n 0 0)/(T^n) 0 0-
      lam^j*(P i 0*R (n-1-l) 0 s)/(T^n) 0 0-
      lam^(n-1-l)*(R j i 0*P 0 s)/(T^n) 0 0-
      (R j i 0*R (n-1-l) 0 s)/(T^n) 0 0 := by
  have hp (k : ℕ) (a b : Fin 4) : (T^k) a b=lam^k*P a b+R k a b := by
    simpa using congrArg (fun A : FourMat => A a b) (hPower k)
  have hidx : j-1-l+n=j+(n-1-l) := by omega
  have hc : lam^(j-1-l)*P i s*(lam^n*P 0 0) =
      lam^j*P i 0*(lam^(n-1-l)*P 0 s) := by
    calc
      _ = lam^(j-1-l+n)*(P 0 0*P i s) := by rw [pow_add]; ring
      _ = lam^(j+(n-1-l))*(P i 0*P 0 s) := by rw [hidx,hRank]
      _ = _ := by rw [pow_add]; ring
  unfold greenEntry
  rw [if_pos hlj]
  field_simp [hd]
  rw [hp n 0 0,hp (j-1-l) i s,hp j i 0,hp (n-1-l) 0 s]
  linear_combination hc

lemma green_late_identity (T : FourMat) (lam : ℂ) (P : FourMat) (R : ℕ → FourMat)
    (hPower : ∀ k, T^k=lam^k • P+R k)
    (n j l : ℕ) (hlj : ¬l<j) (i s : Fin 4) :
    greenEntry T n j l i s =
      -(lam^(j+(n-1-l))*(P i 0*P 0 s)/(T^n) 0 0)-
      lam^j*(P i 0*R (n-1-l) 0 s)/(T^n) 0 0-
      lam^(n-1-l)*(R j i 0*P 0 s)/(T^n) 0 0-
      (R j i 0*R (n-1-l) 0 s)/(T^n) 0 0 := by
  have hp (k : ℕ) (a b : Fin 4) : (T^k) a b=lam^k*P a b+R k a b := by
    simpa using congrArg (fun A : FourMat => A a b) (hPower k)
  unfold greenEntry
  rw [if_neg hlj,hp j i 0,hp (n-1-l) 0 s,pow_add]
  ring

lemma norm_four_difference (a b c d : ℂ) :
    ‖a-b-c-d‖ ≤ ‖a‖+‖b‖+‖c‖+‖d‖ := by
  linarith [norm_sub_le (a-b-c) d, norm_sub_le (a-b) c, norm_sub_le a b]

 theorem green_bounded_of_decomposition (T : FourMat) (lam : ℂ) (P : FourMat)
    (R : ℕ → FourMat) (B : ℝ) (hL : 1<‖lam‖) (hGamma : P 0 0 ≠ 0)
    (hRank : ∀ i s, P i 0*P 0 s=P 0 0*P i s)
    (hPower : ∀ k, T^k=lam^k • P+R k) (hB : 0<B)
    (hR : ∀ k i s, ‖R k i s‖≤B) :
    ∃ C : ℝ, 0<C ∧ ∃ N : ℕ, 1≤N ∧ ∀ n, N≤n →
      (T^n) 0 0 ≠ 0 ∧ ∀ j, j≤n → ∀ l, l<n → ∀ i s,
        ‖greenEntry T n j l i s‖≤C := by
  classical
  let D : ℝ := 1+B+∑ i : Fin 4, ∑ s : Fin 4, ‖P i s‖
  have hD : 0<D := by dsimp [D]; positivity
  have hBD : B≤D := by
    have hh : 0 ≤ ∑ i : Fin 4, ∑ s : Fin 4, ‖P i s‖ := by positivity
    dsimp [D]; linarith
  have hPD (i s : Fin 4) : ‖P i s‖≤D := by
    have h1 : ‖P i s‖ ≤ ∑ t : Fin 4, ‖P i t‖ :=
      Finset.single_le_sum (f := fun t : Fin 4 => ‖P i t‖) (by intros; positivity) (Finset.mem_univ s)
    have h2 : (∑ t : Fin 4, ‖P i t‖) ≤ ∑ k : Fin 4, ∑ t : Fin 4, ‖P k t‖ :=
      Finset.single_le_sum (f := fun k : Fin 4 => ∑ t : Fin 4, ‖P k t‖) (by intros; positivity) (Finset.mem_univ i)
    dsimp [D]
    linarith
  have hRD (k : ℕ) (i s : Fin 4) : ‖R k i s‖≤D := (hR k i s).trans hBD
  obtain ⟨N,hN,hden⟩ := dominant_denominator lam (P 0 0) hL hGamma B hB
    (fun n => R n 0 0) (fun n => hR n 0 0)
  have hp (k : ℕ) : (T^k) 0 0=P 0 0*lam^k+R k 0 0 := by
    have hh := congrArg (fun A : FourMat => A 0 0) (hPower k)
    simpa [mul_comm] using hh
  let E : ℝ := 2*D^2/‖P 0 0‖
  have hE : 0<E := by dsimp [E]; exact div_pos (by positivity) (norm_pos_iff.mpr hGamma)
  refine ⟨D+4*E,by positivity,N,hN,?_⟩
  intro n hn
  have hd := hden n hn
  rw [← hp n] at hd
  refine ⟨hd.1,?_⟩
  have bound (k : ℕ) (hk : k≤n) (x y : ℂ) (hx : ‖x‖≤D) (hy : ‖y‖≤D) :
      ‖lam^k*(x*y)/(T^n) 0 0‖ ≤ E := by
    have hh := normalized_power_bound lam (P 0 0) ((T^n) 0 0) (x*y) n k hL.le hGamma hd.2 hk
    have hxy : ‖x*y‖≤D^2 := by
      rw [norm_mul,pow_two]
      exact mul_le_mul hx hy (norm_nonneg _) hD.le
    exact hh.trans (div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hxy (by norm_num)) (norm_nonneg _))
  intro j hj l hl i s
  have hjb := bound j hj (P i 0) (R (n-1-l) 0 s) (hPD i 0) (hRD _ _ _)
  have htb := bound (n-1-l) (by omega) (R j i 0) (P 0 s) (hRD _ _ _) (hPD 0 s)
  have hzb := bound 0 (by omega) (R j i 0) (R (n-1-l) 0 s) (hRD _ _ _) (hRD _ _ _)
  simp only [pow_zero,one_mul] at hzb
  by_cases hlj : l<j
  · have hmb := bound (j-1-l) (by omega) (P i s) (R n 0 0) (hPD i s) (hRD _ _ _)
    rw [green_early_identity T lam P R hRank hPower n j l hj hlj i s hd.1]
    have hnorm := norm_four_difference
      (R (j-1-l) i s+lam^(j-1-l)*(P i s*R n 0 0)/(T^n) 0 0)
      (lam^j*(P i 0*R (n-1-l) 0 s)/(T^n) 0 0)
      (lam^(n-1-l)*(R j i 0*P 0 s)/(T^n) 0 0)
      ((R j i 0*R (n-1-l) 0 s)/(T^n) 0 0)
    have hadd := norm_add_le (R (j-1-l) i s) (lam^(j-1-l)*(P i s*R n 0 0)/(T^n) 0 0)
    linarith [hRD (j-1-l) i s]
  · have hmb := bound (j+(n-1-l)) (by omega) (P i 0) (P 0 s) (hPD i 0) (hPD 0 s)
    rw [green_late_identity T lam P R hPower n j l hlj i s]
    have hnorm := norm_four_difference
      (-(lam^(j+(n-1-l))*(P i 0*P 0 s)/(T^n) 0 0))
      (lam^j*(P i 0*R (n-1-l) 0 s)/(T^n) 0 0)
      (lam^(n-1-l)*(R j i 0*P 0 s)/(T^n) 0 0)
      ((R j i 0*R (n-1-l) 0 s)/(T^n) 0 0)
    rw [norm_neg] at hnorm
    linarith
#assert_trust kernel green_bounded_of_decomposition
end NLA.MF22
