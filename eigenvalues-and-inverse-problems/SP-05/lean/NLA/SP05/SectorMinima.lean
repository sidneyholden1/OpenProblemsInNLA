/- Actual sector minima, by compactness of each nonempty unit eigensphere. -/
import NLA.SP05.Geometry
import Mathlib.Topology.Order.Compact
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Kronecker
noncomputable section
namespace NLA.SP05

lemma rayleigh_scale {n : ℕ} (K : BigMat n) (v : Vec n) (c : ℝ) (hc : c ≠ 0) :
    rayleigh K (c • v) = rayleigh K v := by
  unfold rayleigh
  rw [Matrix.mulVec_smul]
  simp only [Pi.smul_apply,smul_eq_mul]
  have hnum : (∑ i, c*v i*(c*(K.mulVec v) i)) = c^2*(∑i,v i*(K.mulVec v) i) := by
    rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i _; ring
  have hden : (∑ i, c*v i*(c*v i)) = c^2*(∑i,v i*v i) := by
    rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i _; ring
  rw [hnum,hden,mul_div_mul_left _ _ (pow_ne_zero _ hc)]

lemma sector_min_exists {n : ℕ} (A B : Mat n) (s : ℝ) (v₀ : Vec n)
    (hv₀ : v₀ ≠ 0) (hs₀ : (commutation n).mulVec v₀ = s • v₀) :
    ∃ u : Vec n, u ≠ 0 ∧ (commutation n).mulVec u = s • u ∧
      IsLeast (sectorValues A B s) (rayleigh (A ⊗ₖ B) u) := by
  let E := EuclideanSpace ℝ (Fin n×Fin n)
  let S : Set E := {v | ‖v‖ = 1 ∧ (commutation n).mulVec (WithLp.ofLp v) = s • WithLp.ofLp v}
  let F : E → ℝ := fun v => ∑ i, v i*((A ⊗ₖ B).mulVec (WithLp.ofLp v)) i
  have hcont : Continuous F := by
    dsimp [F,E]
    apply continuous_finsetSum
    intro i _
    apply Continuous.mul (by fun_prop)
    unfold Matrix.mulVec dotProduct
    apply continuous_finsetSum
    intro j _
    fun_prop
  have hclosed : IsClosed {v : E | (commutation n).mulVec (WithLp.ofLp v) = s • WithLp.ofLp v} := by
    dsimp [E]
    apply isClosed_eq
    · apply continuous_pi; intro i
      unfold Matrix.mulVec dotProduct
      apply continuous_finsetSum; intro j _; fun_prop
    · apply continuous_pi; intro i; fun_prop
  have hcompact : IsCompact S := by
    have hsp := isCompact_sphere (0:E) 1
    have heq : S = Metric.sphere (0:E) 1 ∩ {v:E | (commutation n).mulVec (WithLp.ofLp v) = s • WithLp.ofLp v} := by
      ext v; simp [S,Metric.mem_sphere,dist_zero_right]
    rw [heq]; exact hsp.inter_right hclosed
  have hnorm {v : E} (hv : v ≠ 0) : ‖(‖v‖⁻¹ : ℝ) • v‖ = 1 := by
    rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg (inv_nonneg.mpr (norm_nonneg _)), inv_mul_cancel₀ (norm_ne_zero_iff.mpr hv)]
  have hnormalize {v : E} (hv : v ≠ 0)
      (hs : (commutation n).mulVec (WithLp.ofLp v) = s • WithLp.ofLp v) :
      (‖v‖⁻¹ : ℝ) • v ∈ S := by
    refine ⟨hnorm hv,?_⟩
    change (commutation n).mulVec ((‖v‖⁻¹:ℝ) • WithLp.ofLp v) = s • ((‖v‖⁻¹:ℝ) • WithLp.ofLp v)
    rw [Matrix.mulVec_smul,hs,smul_comm]
  have hne : S.Nonempty := by
    let v : E := WithLp.toLp 2 v₀
    have hv : v ≠ 0 := by intro h; apply hv₀; exact congrArg WithLp.ofLp h
    exact ⟨_,hnormalize hv hs₀⟩
  obtain ⟨u,hu,hmin⟩ := hcompact.exists_isMinOn hne hcont.continuousOn
  have hu0 : u ≠ 0 := by intro h; simpa [h] using hu.1
  have hunit (w : E) (hw : ‖w‖ = 1) : rayleigh (A ⊗ₖ B) (WithLp.ofLp w) = F w := by
    have hd : ∑i,w i*w i = 1 := by
      simpa only [pow_two,hw,one_mul] using (EuclideanSpace.real_norm_sq_eq w).symm
    unfold rayleigh
    rw [hd,div_one]
  refine ⟨WithLp.ofLp u,?_,hu.2,?_,?_⟩
  · exact (WithLp.ofLp_eq_zero 2).ne.mpr hu0
  · exact ⟨_,(WithLp.ofLp_eq_zero 2).ne.mpr hu0,hu.2,rfl⟩
  · intro t ht
    obtain ⟨v,hv,hs,rfl⟩ := ht
    let w : E := WithLp.toLp 2 v
    have hw : w ≠ 0 := by intro he; exact hv (congrArg WithLp.ofLp he)
    have hm := hmin (hnormalize hw hs)
    change F u ≤ F ((‖w‖⁻¹:ℝ) • w) at hm
    rw [← hunit u hu.1, ← hunit _ (hnorm hw)] at hm
    change rayleigh (A ⊗ₖ B) (WithLp.ofLp u) ≤ rayleigh (A ⊗ₖ B) ((‖w‖⁻¹:ℝ) • v) at hm
    rw [rayleigh_scale _ _ _ (inv_ne_zero (norm_ne_zero_iff.mpr hw))] at hm
    exact hm

theorem sector_minima_attained_proved {n : ℕ} (hn : 2 ≤ n) (A B : Mat n)
    (_hA : A.PosDef) (_hB : B.PosDef) :
    (sectorValues A B 1).Nonempty ∧ BddBelow (sectorValues A B 1) ∧
    (sectorValues A B (-1)).Nonempty ∧ BddBelow (sectorValues A B (-1)) ∧
    ∃ u w : Vec n, u ≠ 0 ∧ w ≠ 0 ∧
      (commutation n).mulVec u = u ∧ (commutation n).mulVec w = -w ∧
      rayleigh (A ⊗ₖ B) u = sInf (sectorValues A B 1) ∧
      rayleigh (A ⊗ₖ B) w = sInf (sectorValues A B (-1)) := by
  let i : Fin n := ⟨0,by omega⟩
  let j : Fin n := ⟨1,by omega⟩
  have hij : i ≠ j := by intro h; have := congrArg Fin.val h; simp [i,j] at this
  let u₀ : Vec n := fun kl => if kl.1=i ∧ kl.2=i then 1 else 0
  let w₀ : Vec n := fun kl => (if kl.1=i ∧ kl.2=j then 1 else 0) -
    (if kl.1=j ∧ kl.2=i then 1 else 0)
  have hu₀ : u₀ ≠ 0 := by
    intro h; have := congrFun h (i,i); simp [u₀] at this
  have hw₀ : w₀ ≠ 0 := by
    intro h; have := congrFun h (i,j); simp [w₀,hij,hij.symm] at this
  have hus : (commutation n).mulVec u₀ = (1:ℝ) • u₀ := by
    funext kl; rw [commutation_mulVec]; simp [u₀,and_comm]
  have hws : (commutation n).mulVec w₀ = (-1:ℝ) • w₀ := by
    funext kl; rw [commutation_mulVec]
    simp only [w₀,Pi.smul_apply,smul_eq_mul,neg_one_mul]
    simp only [and_comm]
    ring
  obtain ⟨u,hu,hus,humin⟩ := sector_min_exists A B 1 u₀ hu₀ hus
  obtain ⟨w,hw,hws,hwmin⟩ := sector_min_exists A B (-1) w₀ hw₀ hws
  refine ⟨⟨_,humin.1⟩,⟨_,humin.2⟩,⟨_,hwmin.1⟩,⟨_,hwmin.2⟩,u,w,hu,hw,?_,?_,?_,?_⟩
  · simpa using hus
  · simpa using hws
  · exact humin.csInf_eq.symm
  · exact hwmin.csInf_eq.symm

#assert_trust kernel sector_minima_attained_proved
end NLA.SP05
