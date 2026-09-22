import Solution
import Lean.Util.FoldConsts
open Lean Elab Command
set_option maxRecDepth 100000
set_option maxHeartbeats 0
run_elab do
  let env ← getEnv
  let mut todo := #[`NLA.SP04.not_generic_smallest_multiplier]
  let mut seen : NameSet := {}
  while !todo.isEmpty do
    let n := todo.back!
    todo := todo.pop
    if seen.contains n then continue
    seen := seen.insert n
    if let some ci := env.find? n then
      if let some v := ci.value? (allowOpaque := true) then
        todo := todo ++ v.getUsedConstants
  for n in #[`NLA.SP04.low_product_margin, `NLA.SP04.high_product_margin,
      `NLA.SP04.diagonal_stationary_reduction_proved, `NLA.SP04.three_root_pattern,
      `NLA.SP04.localOrbit_derivative, `NLA.SP04.orbitDerivative_injective,
      `NLA.SP04.open_counterexample_family_proved, `AnalyticOnNhd.eq_of_eventuallyEq] do
    unless seen.contains n do throwError "Missing material dependency {n}"
    logInfo m!"MATERIAL {n}"
  for n in #[`NLA.SP04.low_product_margin, `NLA.SP04.high_product_margin] do
    let some ci := env.find? n | throwError "missing certificate"
    let some v := ci.value? (allowOpaque := true) | throwError "missing body"
    logInfo m!"CERTIFICATE {n}: {v.getUsedConstants}"
  logInfo m!"Value-closure visited {seen.toList.length} declarations."
