import Solution
open Lean Elab Command
run_cmd do
  let env ← getEnv
  let mut pending := #[`NLA.SP04.not_generic_smallest_multiplier]
  let mut seen : NameSet := {}
  while !pending.isEmpty do
    let n := pending.back!
    pending := pending.pop
    if seen.contains n then continue
    seen := seen.insert n
    let some ci := env.find? n | throwError "Missing declaration {n}"
    let deps := ci.getUsedConstantsAsSet
    for d in deps.toList do
      if "NLA.SP04.".isPrefixOf d.toString then
        pending := pending.push d
  for n in [``NLA.SP04.low_product_margin, ``NLA.SP04.high_product_margin,
    ``NLA.SP04.diagonal_stationary_reduction_proved,
    ``NLA.SP04.scalar_unique_least, ``NLA.SP04.distanceSq_orthogonalTransform,
    ``NLA.SP04.localOrbit_derivative, ``NLA.SP04.orbitDerivative_injective,
    ``NLA.SP04.nonzero_polynomial_avoids_open] do
    unless seen.contains n do throwError "Target dependency missing: {n}"
    logInfo m!"Material local dependency: {n}"
  for n in [``NLA.SP04.low_product_margin, ``NLA.SP04.high_product_margin] do
    let some ci := env.find? n | throwError "Missing certificate"
    let some v := ci.value? (allowOpaque := true) | throwError "Missing certificate body"
    logInfo m!"Certificate {n} directly references {v.getUsedConstants}"
