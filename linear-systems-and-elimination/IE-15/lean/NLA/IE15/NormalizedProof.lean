/- Full finite-order normalized path bounds, using actual Schur updates.
George Stepaniants's IE-15 proof; Sidney Holden/Codex formalization. -/
import NLA.IE15.SignScaling
import NLA.IE15.ScalarFour
import NLA.IE15.PathBounds
set_option maxHeartbeats 2000000
noncomputable section
namespace NLA.IE15

def leftRatio {n : ℕ} (T : ℕ → Mat n) (k i : Fin n) : ℝ :=
  T k.val i k / T k.val k k

def rightRatio {n : ℕ} (T : ℕ → Mat n) (k j : Fin n) : ℝ :=
  T k.val k j / T k.val k k

lemma leftRatio_bound {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (k i : Fin n) (hi : k ≤ i)
    (hp : 0 < T k.val k k) : |leftRatio T k i| ≤ 1 := by
  have hh := (h.2 k).2.2.2.1 i hi
  simp only [id_eq, abs_of_pos hp] at hh
  simpa [leftRatio,abs_div,abs_of_pos hp] using (div_le_one hp).mpr hh

lemma rightRatio_bound {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (k j : Fin n) (hj : k ≤ j)
    (hp : 0 < T k.val k k) : |rightRatio T k j| ≤ 1 := by
  have hh := (h.2 k).2.2.2.2.1 j hj
  simp only [id_eq, abs_of_pos hp] at hh
  simpa [rightRatio,abs_div,abs_of_pos hp] using (div_le_one hp).mpr hh

lemma ratio_update {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (k i j : Fin n) (hi : k < i) (hj : k < j)
    (hp : T k.val k k ≠ 0) :
    T (k.val+1) i j = T k.val i j - T k.val k k * leftRatio T k i * rightRatio T k j := by
  have hh := (h.2 k).2.2.2.2.2 (by omega)
  rw [hh]
  simp only [schurStep,id_eq,Equiv.swap_self,Equiv.refl_apply,hi,hj,and_self,ite_true]
  unfold leftRatio rightRatio
  field_simp

lemma pivot_mul_leftRatio {n : ℕ} (T : ℕ → Mat n) (k i : Fin n)
    (hp : T k.val k k ≠ 0) : T k.val k k * leftRatio T k i = T k.val i k := by
  unfold leftRatio
  field_simp

lemma pivot_mul_rightRatio {n : ℕ} (T : ℕ → Mat n) (k j : Fin n)
    (hp : T k.val k k ≠ 0) : T k.val k k * rightRatio T k j = T k.val k j := by
  unfold rightRatio
  field_simp

lemma first_two_constraints {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (z o l : Fin n)
    (hz : z.val = 0) (ho : o.val = 1) (hl : 1 < l.val)
    (hinit : ∀ i j, |T 0 i j| ≤ 1)
    (hp : 0 < T z.val z z) (hq : 0 < T o.val o o) :
    |T o.val o o + T z.val z z * leftRatio T z o * rightRatio T z o| ≤ 1 ∧
    |T o.val o o * (-rightRatio T o l) + T z.val z z * leftRatio T z o * (-rightRatio T z l)| ≤ 1 ∧
    |T o.val o o * leftRatio T o l + T z.val z z * leftRatio T z l * rightRatio T z o| ≤ 1 := by
  have hzo : z < o := by omega
  have hzl : z < l := by omega
  have he22 := ratio_update T h z o o hzo hzo hp.ne'
  have he23 := ratio_update T h z o l hzo hzl hp.ne'
  have he32 := ratio_update T h z l o hzl hzo hp.ne'
  have he : z.val+1 = o.val := by omega
  rw [he] at he22 he23 he32
  refine ⟨?_, ?_, ?_⟩
  · have heq : T o.val o o + T z.val z z * leftRatio T z o * rightRatio T z o = T 0 o o := by rw [he22,hz]; ring
    rw [heq]; exact hinit o o
  · have heq : T o.val o o * (-rightRatio T o l) + T z.val z z * leftRatio T z o * (-rightRatio T z l) = -T 0 o l := by
      rw [mul_neg,pivot_mul_rightRatio T o l hq.ne',he23,hz]; ring
    rw [heq,abs_neg]; exact hinit o l
  · have heq : T o.val o o * leftRatio T o l + T z.val z z * leftRatio T z l * rightRatio T z o = T 0 l o := by
      rw [pivot_mul_leftRatio T o l hq.ne',he32,hz]; ring
    rw [heq]; exact hinit l o

lemma first_two_bound {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (z o l : Fin n)
    (hz : z.val = 0) (ho : o.val = 1) (hl : 1 < l.val)
    (hinit : ∀ i j, |T 0 i j| ≤ 1)
    (hp : 0 < T z.val z z) (hq : 0 < T o.val o o)
    (hrow0 : 0 ≤ T z.val l z) (hrow1 : 0 ≤ T o.val l o) :
    T z.val z z * leftRatio T z l * (-rightRatio T z l) +
    T o.val o o * leftRatio T o l * (-rightRatio T o l) ≤ 2 := by
  have hp1 : T z.val z z ≤ 1 := by simpa [hz, abs_of_pos (hz ▸ hp)] using hinit z z
  have hzo : z ≤ o := by omega
  have hzl : z ≤ l := by omega
  have hol : o ≤ l := by omega
  have hc1 : 0 ≤ leftRatio T z l := div_nonneg hrow0 hp.le
  have hc2 : 0 ≤ leftRatio T o l := div_nonneg hrow1 hq.le
  have hc1' := (abs_le.mp (leftRatio_bound T h z l hzl hp)).2
  have hc2' := (abs_le.mp (leftRatio_bound T h o l hol hq)).2
  have hd1 : |-rightRatio T z l| ≤ 1 := by simpa using rightRatio_bound T h z l hzl hp
  have hd2 : |-rightRatio T o l| ≤ 1 := by simpa using rightRatio_bound T h o l hol hq
  obtain ⟨h22,h23,h32⟩ := first_two_constraints T h z o l hz ho hl hinit hp hq
  exact scalar_three_bound _ _ _ _ _ _ _ _ hp hp1 hq
    (leftRatio_bound T h z o hzo hp) (rightRatio_bound T h z o hzo hp)
    hc1 hc1' hc2 hc2' hd1 hd2 h22 h23 h32

theorem normalized_three_bound : normalizedBound 3 3 := by
  intro T h hinit hpos hrow k i j
  have h0 : 0 ≤ T 0 2 0 := (hrow 0 2 (by decide)).resolve_right (by norm_num)
  have h1 : 0 ≤ T 1 2 1 := (hrow 1 2 (by decide)).resolve_right (by norm_num)
  have hW := first_two_bound T h 0 1 2 rfl rfl (by decide) hinit (hpos 0) (hpos 1) h0 h1
  have hstep0 := ratio_update T h 0 2 2 (by decide) (by decide) (hpos 0).ne'
  have hstep1 := ratio_update T h 1 2 2 (by decide) (by decide) (hpos 1).ne'
  have hfinal : |T 2 2 2| ≤ 3 := by
    have hp2 : 0 < T 2 2 2 := hpos (2 : Fin 3)
    rw [abs_of_pos hp2]
    have hlast := (abs_le.mp (hinit 2 2)).2
    norm_num only [Fin.val_zero,Fin.val_one] at hstep0 hstep1 hW
    nlinarith only [hW,hstep0,hstep1,hlast]
  by_cases hk : k.val < 2
  · have hb := normalized_stage_entry_bound T h hinit k i j
    have hkcases : k.val = 0 ∨ k.val = 1 := by omega
    rcases hkcases with hk0 | hk1
    · rw [hk0] at hb ⊢; norm_num at hb; linarith
    · rw [hk1] at hb ⊢; norm_num at hb; linarith
  have hk2 : k = 2 := by apply Fin.ext; omega
  subst k
  by_cases hij : i = 2 ∧ j = 2
  · rcases hij with ⟨rfl,rfl⟩; exact hfinal
  · have hz := path_zero_padding T h (2 : Fin 3) i j (by omega)
    rw [hz]; norm_num

lemma two_updates_entry {n : ℕ} (T : ℕ → Mat n)
    (h : isPath (T 0) T id id) (z o i j : Fin n)
    (hz : z.val = 0) (ho : o.val = 1) (hi : 1 < i.val) (hj : 1 < j.val)
    (hp : 0 < T z.val z z) (hq : 0 < T o.val o o) :
    T 2 i j = T 0 i j - T z.val z z * leftRatio T z i * rightRatio T z j -
      T o.val o o * leftRatio T o i * rightRatio T o j := by
  have h0 := ratio_update T h z i j (by omega) (by omega) hp.ne'
  have h1 := ratio_update T h o i j (by omega) (by omega) hq.ne'
  rw [hz] at h0
  rw [ho] at h1
  rw [h1,h0,hz,ho]

 theorem normalized_four_bound : normalizedBound 4 (14/3) := by
  intro T h hinit hpos hrow k i j
  let p := T 0 0 0
  let q := T 1 1 1
  let r := T 2 2 2
  let a := leftRatio T 0 1
  let b := rightRatio T 0 1
  let c1 := leftRatio T 0 3
  let c2 := leftRatio T 1 3
  let d1 := -rightRatio T 0 3
  let d2 := -rightRatio T 1 3
  let u1 := leftRatio T 0 2
  let u2 := leftRatio T 1 2
  let v1 := rightRatio T 0 2
  let v2 := rightRatio T 1 2
  let C := leftRatio T 2 3
  let D := -rightRatio T 2 3
  have hp : 0 < p := hpos (0 : Fin 4)
  have hq : 0 < q := hpos (1 : Fin 4)
  have hr : 0 < r := hpos (2 : Fin 4)
  have hp1 : p ≤ 1 := (abs_le.mp (hinit 0 0)).2
  have hrow0 : 0 ≤ T 0 3 0 := (hrow 0 3 (by decide)).resolve_right (by norm_num)
  have hrow1 : 0 ≤ T 1 3 1 := (hrow 1 3 (by decide)).resolve_right (by norm_num)
  have hrow2 : 0 ≤ T 2 3 2 := (hrow 2 3 (by decide)).resolve_right (by norm_num)
  have ha : |a| ≤ 1 := leftRatio_bound T h 0 1 (by decide) hp
  have hb : |b| ≤ 1 := rightRatio_bound T h 0 1 (by decide) hp
  have hc1 : 0 ≤ c1 := div_nonneg hrow0 hp.le
  have hc2 : 0 ≤ c2 := div_nonneg hrow1 hq.le
  have hc1' : c1 ≤ 1 := (abs_le.mp (leftRatio_bound T h 0 3 (by decide) hp)).2
  have hc2' : c2 ≤ 1 := (abs_le.mp (leftRatio_bound T h 1 3 (by decide) hq)).2
  have hd1 : |d1| ≤ 1 := by simpa [d1] using rightRatio_bound T h 0 3 (by decide) hp
  have hd2 : |d2| ≤ 1 := by simpa [d2] using rightRatio_bound T h 1 3 (by decide) hq
  have hu1 : |u1| ≤ 1 := leftRatio_bound T h 0 2 (by decide) hp
  have hu2 : |u2| ≤ 1 := leftRatio_bound T h 1 2 (by decide) hq
  have hv1 : |v1| ≤ 1 := rightRatio_bound T h 0 2 (by decide) hp
  have hv2 : |v2| ≤ 1 := rightRatio_bound T h 1 2 (by decide) hq
  have hC : 0 ≤ C := div_nonneg hrow2 hr.le
  have hC1 : C ≤ 1 := (abs_le.mp (leftRatio_bound T h 2 3 (by decide) hr)).2
  have hD1 : D ≤ 1 := by
    have hD := rightRatio_bound T h 2 3 (by decide) hr
    dsimp [D]; linarith only [(abs_le.mp hD).1]
  have hconstraints := first_two_constraints T h 0 1 3 rfl rfl (by decide) hinit hp hq
  change |q+p*a*b| ≤ 1 ∧ |q*d2+p*a*d1| ≤ 1 ∧ |q*c2+p*c1*b| ≤ 1 at hconstraints
  obtain ⟨h22,h24,h42⟩ := hconstraints
  have hW : p*c1*d1+q*c2*d2 ≤ 2 := scalar_three_bound p q a b c1 c2 d1 d2 hp hp1 hq ha hb hc1 hc1' hc2 hc2' hd1 hd2 h22 h24 h42
  have e33 := two_updates_entry T h 0 1 2 2 rfl rfl (by decide) (by decide) hp hq
  change r = T 0 2 2 - p*u1*v1-q*u2*v2 at e33
  have h33 : r+p*u1*v1+q*u2*v2 ≤ 1 := by linarith only [e33,(abs_le.mp (hinit 2 2)).2]
  have e34 := two_updates_entry T h 0 1 2 3 rfl rfl (by decide) (by decide) hp hq
  have e43 := two_updates_entry T h 0 1 3 2 rfl rfl (by decide) (by decide) hp hq
  have erD : r*D = -T 2 2 3 := by
    change T 2 2 2 * (-rightRatio T 2 3) = _
    rw [mul_neg]; congr 1
    exact pivot_mul_rightRatio T (2 : Fin 4) 3 hr.ne'
  have erC : r*C = T 2 3 2 := pivot_mul_leftRatio T (2 : Fin 4) 3 hr.ne'
  have e34' : T 2 2 3 = T 0 2 3 + p*u1*d1+q*u2*d2 := by
    dsimp [p,q,u1,d1,u2,d2]; simpa only [mul_neg,sub_eq_add_neg,Fin.val_zero,Fin.val_one,Fin.reduceFinMk,Fin.val_ofNat, Nat.add_zero] using e34
  have e43' : T 2 3 2 = T 0 3 2 - p*c1*v1-q*c2*v2 := e43
  have h34 : r*D+p*u1*d1+q*u2*d2 ≤ 1 := by linarith only [erD,e34',(abs_le.mp (hinit 2 3)).1]
  have h43 : r*C+p*c1*v1+q*c2*v2 ≤ 1 := by linarith only [erC,e43',(abs_le.mp (hinit 3 2)).2]
  have e44 := two_updates_entry T h 0 1 3 3 rfl rfl (by decide) (by decide) hp hq
  have e44' : T 2 3 3 = T 0 3 3+p*c1*d1+q*c2*d2 := by
    dsimp [p,q,c1,d1,c2,d2]; simpa only [mul_neg,sub_eq_add_neg,Fin.val_zero,Fin.val_one,Fin.reduceFinMk,Fin.val_ofNat, Nat.add_zero] using e44
  have e3 := ratio_update T h (2 : Fin 4) 3 3 (by decide) (by decide) hr.ne'
  have e3' : T 3 3 3 = T 2 3 3+r*C*D := by
    change T 3 3 3 = T 2 3 3 - T 2 2 2 * leftRatio T 2 3 * rightRatio T 2 3 at e3
    dsimp [r,C,D]; simpa only [mul_neg,sub_eq_add_neg,Fin.val_zero,Fin.val_one,Fin.reduceFinMk,Fin.val_ofNat, Nat.add_zero] using e3
  have hfinal : |T 3 3 3| ≤ 14/3 := by
    have hp3 : 0 < T 3 3 3 := hpos (3 : Fin 4)
    rw [abs_of_pos hp3]
    by_cases hD : 0 ≤ D
    · have hbound := scalar_four_bound p q r a b c1 c2 d1 d2 u1 u2 v1 v2 C D
        hp hp1 hq hr ha hb hc1 hc1' hc2 hc2' hd1 hd2 h22 h24 h42
        hu1 hu2 hv1 hv2 hC hC1 hD hD1 h33 h34 h43
      linarith only [hbound,e44',e3',(abs_le.mp (hinit 3 3)).2]
    · have hnonpos : r*C*D ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (mul_nonneg hr.le hC) (by linarith)
      linarith only [hnonpos,hW,e44',e3',(abs_le.mp (hinit 3 3)).2]
  by_cases hk : k.val < 3
  · have hbnd := normalized_stage_entry_bound T h hinit k i j
    have hkcases : k.val = 0 ∨ k.val = 1 ∨ k.val = 2 := by omega
    rcases hkcases with hk0 | hk1 | hk2
    · rw [hk0] at hbnd ⊢; norm_num at hbnd; linarith
    · rw [hk1] at hbnd ⊢; norm_num at hbnd; linarith
    · rw [hk2] at hbnd ⊢; norm_num at hbnd; linarith
  have hk3 : k = 3 := by apply Fin.ext; omega
  subst k
  by_cases hij : i = 3 ∧ j = 3
  · rcases hij with ⟨rfl,rfl⟩; exact hfinal
  · have hz := path_zero_padding T h (3 : Fin 4) i j (by omega)
    rw [hz]; norm_num

end NLA.IE15
