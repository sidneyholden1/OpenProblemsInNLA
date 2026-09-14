import Solution
import LeanCert.Tactic.Verification
set_option pp.proofs true
#print NLA.MF16.actual_krawczyk_checked
#print axioms NLA.MF16.actual_krawczyk_checked
#assert_trust kernel NLA.MF16.actual_krawczyk_checked
#print NLA.MF16.certified_root_proved
#print axioms NLA.MF16.certified_root_proved
#assert_trust kernel NLA.MF16.certified_root_proved
