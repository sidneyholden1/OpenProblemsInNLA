/- Exact source difference equations obtained from the actual transfer entries. -/
import NLA.MF22.Transfer
set_option autoImplicit false
set_option maxHeartbeats 1200000
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MF22
lemma transfer_top_zero (r : ℝ) (hr : 0<r) (w : Fin 4 → ℂ) (f : Fin 2 → ℂ) :
    sA r*((transfer r).mulVec w+(forcing r).mulVec f) 0+
    sB r*((transfer r).mulVec w+(forcing r).mulVec f) 1 =
      24*(r:ℂ)*w 0-96*Complex.I*w 1-sF r*w 2-sC r*w 3+f 0 := by
  have ha := coefA_ne_zero r hr
  simp [Matrix.mulVec,dotProduct,Fin.sum_univ_four,Fin.sum_univ_two,transfer,forcing]
  field_simp [ha]
  simp [sA,sB,sC,sD,sE,sF,coefA]
  ring_nf
  norm_num [Complex.I_sq]
  ring

lemma transfer_top_one (r : ℝ) (hr : 0<r) (w : Fin 4 → ℂ) (f : Fin 2 → ℂ) :
    sB r*((transfer r).mulVec w+(forcing r).mulVec f) 0+
    sD r*((transfer r).mulVec w+(forcing r).mulVec f) 1 =
      -96*Complex.I*w 0-24*(r:ℂ)*w 1-sC r*w 2-sE r*w 3+f 1 := by
  have ha := coefA_ne_zero r hr
  simp [Matrix.mulVec,dotProduct,Fin.sum_univ_four,Fin.sum_univ_two,transfer,forcing]
  field_simp [ha]
  simp [sA,sB,sC,sD,sE,sF,coefA]
  ring_nf
  norm_num [Complex.I_sq]
  ring

lemma transfer_bottom_two (r : ℝ) (w : Fin 4 → ℂ) (f : Fin 2 → ℂ) :
    ((transfer r).mulVec w+(forcing r).mulVec f) 2 = w 0 := by
  simp [Matrix.mulVec,dotProduct,Fin.sum_univ_four,Fin.sum_univ_two,transfer,forcing]
lemma transfer_bottom_three (r : ℝ) (w : Fin 4 → ℂ) (f : Fin 2 → ℂ) :
    ((transfer r).mulVec w+(forcing r).mulVec f) 3 = w 1 := by
  simp [Matrix.mulVec,dotProduct,Fin.sum_univ_four,Fin.sum_univ_two,transfer,forcing]
end NLA.MF22
