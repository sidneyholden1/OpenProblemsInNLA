/- Actual maxima and root limits from complete finite-word bounds. -/
import NLA.MF12.Geometry
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Analysis.SpecialFunctions.Pow.Continuity
import Mathlib.Order.ConditionallyCompleteLattice.Finset
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
open Filter
noncomputable section
namespace NLA.MF12

def binaryProduct {d : ℕ} (A B : Mat d) (w : List Bool) : Mat d :=
  (w.map (fun b => if b then A else B)).prod

def PairBounds {d : ℕ} (A B : Mat d) (γ : ℝ) : Prop :=
  ∃ c C : ℝ, 0 < c ∧ c ≤ C ∧
    (∀ w : List Bool, 1 ≤ w.length → ‖binaryProduct A B w‖ ≤ C*(w.length:ℝ)^γ) ∧
    (∀ k : ℕ, 1 ≤ k → ∃ w : List Bool, w.length=k ∧ c*(k:ℝ)^γ ≤ ‖binaryProduct A B w‖)

lemma pairNorms_range {d : ℕ} (A B : Mat d) (k : ℕ) :
    productNorms ({A,B} : Set (Mat d)) k =
      Set.range (fun w : Fin k → Bool => ‖binaryProduct A B (List.ofFn w)‖) := by
  classical
  ext t
  constructor
  · rintro ⟨w,hw,rfl⟩
    let v : Fin k → Bool := fun i => decide (w i = A)
    refine ⟨v,?_⟩
    have he (i : Fin k) : (if v i then A else B) = w i := by
      have hi := hw i
      simp only [Set.mem_insert_iff,Set.mem_singleton_iff] at hi
      rcases hi with h | h
      · simp [v,h]
      · by_cases hh : B = A
        · simp [v,h,hh]
        · simp [v,h,hh]
    simp only [binaryProduct,List.map_ofFn,wordProduct]
    congr 3
    funext i
    exact he i
  · rintro ⟨w,rfl⟩
    refine ⟨fun i => if w i then A else B,?_,?_⟩
    · intro i; by_cases h : w i = true <;> simp [h]
    · simp [binaryProduct,wordProduct,List.map_ofFn,Function.comp_def]

lemma pairNorms_valid {d : ℕ} (A B : Mat d) (k : ℕ) :
    (productNorms ({A,B} : Set (Mat d)) k).Finite ∧
    (productNorms ({A,B} : Set (Mat d)) k).Nonempty := by
  rw [pairNorms_range]
  exact ⟨Set.finite_range _,Set.range_nonempty _⟩

lemma binary_mem {d : ℕ} (A B : Mat d) (w : List Bool) :
    ‖binaryProduct A B w‖ ∈ productNorms ({A,B} : Set (Mat d)) w.length := by
  rw [pairNorms_range]
  refine ⟨fun i => w[i],?_⟩
  simp

lemma polynomial_root_limit (a γ : ℝ) (ha : 0 < a) :
    Tendsto (fun k : ℕ => (a*(k:ℝ)^γ)^(1/(k:ℝ))) atTop (nhds 1) := by
  have hn : Tendsto (fun k : ℕ => (k:ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  have hi : Tendsto (fun k : ℕ => 1/(k:ℝ)) atTop (nhds 0) :=
    tendsto_const_nhds.div_atTop hn
  have ha' := (tendsto_const_nhds (x:=a)).rpow hi (Or.inl ha.ne')
  have hb := (tendsto_rpow_div.comp hn).rpow_const (p:=γ) (Or.inl one_ne_zero)
  have hh := ha'.mul hb
  simp only [Real.rpow_zero,Real.one_rpow,one_mul] at hh
  apply hh.congr'
  filter_upwards [eventually_ge_atTop 1] with k hk
  have hk0 : 0 ≤ (k:ℝ) := Nat.cast_nonneg _
  dsimp only [Function.comp_def]
  rw [Real.mul_rpow ha.le (Real.rpow_nonneg hk0 γ),← Real.rpow_mul hk0,← Real.rpow_mul hk0]
  congr 1
  ring

lemma realizes_of_pairBounds {d : ℕ} (A B : Mat d) (γ : ℝ) (h : PairBounds A B γ) :
    RealizesExponent ({A,B} : Set (Mat d)) γ := by
  classical
  obtain ⟨c,C,hc,hcC,hu,hl⟩ := h
  have hC : 0 < C := hc.trans_le hcC
  have hm (k : ℕ) : IsGreatest (productNorms ({A,B} : Set (Mat d)) k)
      (maximalProductNorm ({A,B} : Set (Mat d)) k) := by
    have hv := pairNorms_valid A B k
    exact ⟨hv.2.csSup_mem hv.1,fun t ht => le_csSup hv.1.bddAbove ht⟩
  have hb (k : ℕ) (hk : 1 ≤ k) :
      c*(k:ℝ)^γ ≤ maximalProductNorm ({A,B} : Set (Mat d)) k ∧
      maximalProductNorm ({A,B} : Set (Mat d)) k ≤ C*(k:ℝ)^γ := by
    constructor
    · obtain ⟨w,hw,hh⟩ := hl k hk
      exact hh.trans ((hm k).2 (by simpa [hw] using binary_mem A B w))
    · have hx := (hm k).1
      rw [pairNorms_range] at hx
      obtain ⟨w,hw⟩ := hx
      rw [← hw]
      simpa using hu (List.ofFn w) (by simpa using hk)
  refine ⟨Set.toFinite _,by simp, c,C,hc,hcC,fun k hk => ⟨hm k,(hb k hk).1,(hb k hk).2⟩,?_⟩
  apply tendsto_of_tendsto_of_tendsto_of_le_of_le' (polynomial_root_limit c γ hc)
    (polynomial_root_limit C γ hC)
  · filter_upwards [eventually_ge_atTop 1] with k hk
    exact Real.rpow_le_rpow (by positivity) (hb k hk).1 (by positivity)
  · filter_upwards [eventually_ge_atTop 1] with k hk
    apply Real.rpow_le_rpow _ (hb k hk).2 (by positivity)
    exact (show 0 ≤ c*(k:ℝ)^γ by positivity).trans (hb k hk).1

end NLA.MF12
