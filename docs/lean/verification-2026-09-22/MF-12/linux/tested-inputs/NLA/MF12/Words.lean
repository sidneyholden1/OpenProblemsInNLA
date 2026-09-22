/- Exact factorization of every source word, retaining its full length. -/
import NLA.MF12.Growth
import NLA.MF12.ScalarBudget
set_option autoImplicit false
set_option maxHeartbeats 2000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12

lemma compression_eq (α : ℝ) (q : ℕ) :
    compressU * seed (fractionalParameter α)^q * embedV = compressed α q := by
  simpa [compressed,ell] using compressed_powers_proved (fractionalParameter α) q

lemma binary_cons {d : ℕ} (A B : Mat d) (b : Bool) (w : List Bool) :
    binaryProduct A B (b::w) = (if b then A else B)*binaryProduct A B w := by
  simp [binaryProduct]

lemma word_factorization (α : ℝ) (w : List Bool) :
    binaryProduct (seed (fractionalParameter α)) reset w = seed (fractionalParameter α)^w.length ∨
    ∃ a b : ℕ, ∃ qs : List ℕ,
      binaryProduct (seed (fractionalParameter α)) reset w =
        seed (fractionalParameter α)^a * embedV * (qs.map (compressed α)).prod *
          compressU * seed (fractionalParameter α)^b ∧
      a+b+qs.sum+qs.length+1 = w.length := by
  induction w with
  | nil => left; simp [binaryProduct]
  | cons h w ih =>
    cases h with
    | true =>
      rcases ih with ih | ⟨a,b,qs,ih,hlen⟩
      · left; simp only [binary_cons,ite_true,List.length_cons,ih,pow_succ']
      · right; refine ⟨a+1,b,qs,?_,by simp only [List.length_cons]; omega⟩
        simp only [binary_cons,ite_true,ih,pow_succ',Matrix.mul_assoc]
    | false =>
      rcases ih with ih | ⟨a,b,qs,ih,hlen⟩
      · right; refine ⟨0,w.length,[],?_,by simp⟩
        simp only [binary_cons,Bool.false_eq_true,ite_false,ih,pow_zero,List.map_nil,List.prod_nil,
          Matrix.one_mul,Matrix.mul_one,VU_reset]
      · right; refine ⟨0,b,a::qs,?_,by simp only [List.sum_cons,List.length_cons]; omega⟩
        simp only [binary_cons,Bool.false_eq_true,ite_false,ih,pow_zero,Matrix.one_mul,List.map_cons,List.prod_cons]
        rw [← VU_reset]
        simp only [Matrix.mul_assoc,← compression_eq]

end NLA.MF12
