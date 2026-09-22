import NLA.IE04.Measurability
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option leancert.trust "kernel"
#assert_trust kernel NLA.IE04.measurable_tail_proved
#print axioms NLA.IE04.measurable_tail_proved
