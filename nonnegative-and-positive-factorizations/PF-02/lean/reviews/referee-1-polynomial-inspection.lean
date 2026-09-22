import Solution
import Lean
open Lean Elab Command
set_option maxRecDepth 100000
run_cmd do
  let env ← getEnv
  let some ci := env.find? `NLA.PF02.congruence_coordinate_det | throwError "Missing theorem"
  let some value := ci.value? (allowOpaque := true) | throwError "Missing proof body"
  let names := value.getUsedConstants
  logInfo m!"Generic polynomial proof constants ({names.size}): {names}"
#print axioms NLA.PF02.congruence_coordinate_det
#assert_trust kernel NLA.PF02.congruence_coordinate_det
