import all NLA.MI06.Proof
import Lean.Elab.Command
set_option pp.proofs true
open Lean Elab Command in
run_cmd do
  let names := (← getEnv).constants.toList.map Prod.fst
  let selected := names.filter fun n => n.toString.endsWith "scalar_squared_gap" || n.toString.endsWith "scalar_squared_gap._proof_1_7"
  if selected.length != 2 then throwError "expected exactly two scalar declarations, found {selected.length}"
  liftTermElabM do
    for n in selected do
      let ci ← getConstInfo n
      match ci with
      | .thmInfo ti => logInfo m!"DECL {n} : {ti.type} := {ti.value}"
      | _ => throwError "Expected accessible theorem body for {n}"
