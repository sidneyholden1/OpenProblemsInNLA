import Solution
import LeanCert.Tactic.Verification
set_option pp.universes true
set_option pp.proofs true
#check @NLA.MI21.operatorNorm_isUnitaryInvariant
#print axioms NLA.MI21.operatorNorm_isUnitaryInvariant
#assert_trust kernel NLA.MI21.operatorNorm_isUnitaryInvariant
#check @NLA.MI21.counterexample
#print axioms NLA.MI21.counterexample
#assert_trust kernel NLA.MI21.counterexample
#check @NLA.MI21.not_geometricMeanNormConjecture
#print axioms NLA.MI21.not_geometricMeanNormConjecture
#assert_trust kernel NLA.MI21.not_geometricMeanNormConjecture
#print NLA.MI21.witness_eigenvalue_gt_one
#print axioms NLA.MI21.witness_eigenvalue_gt_one
#assert_trust kernel NLA.MI21.witness_eigenvalue_gt_one
