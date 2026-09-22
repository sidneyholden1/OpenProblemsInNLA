import Solution
import Lean.Util.FoldConsts
#print axioms NLA.IE17.iterates
#print axioms NLA.IE17.backward_increase
#print axioms NLA.IE17.approximation_increase
#print axioms NLA.IE17.counterexample
open Lean Elab Command in
run_cmd do
  let some (.thmInfo ci) := (← getEnv).find? ``NLA.IE17.approximation_increase
    | throwError "missing approximation theorem"
  let names := ci.value.getUsedConstants.filter (fun n => n.toString.startsWith "LeanCert.")
  if names.isEmpty then throwError "no direct LeanCert theorem dependency"
  for n in names do logInfo m!"Actual approximation proof dependency: {n}"
