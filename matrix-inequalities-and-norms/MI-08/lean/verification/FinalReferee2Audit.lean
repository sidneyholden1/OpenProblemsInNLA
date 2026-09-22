import Solution
import Lean.Util.FoldConsts
#print axioms NLA.MI08.fixed_sign_equivalence
#print axioms NLA.MI08.design_obstructions
#print axioms NLA.MI08.hadamard_twelve
#print axioms NLA.MI08.finite_minimums
open Lean Elab Command in
run_cmd do
  let some (.thmInfo ci) := (← getEnv).find? ``NLA.MI08.hadamard_twelve | throwError "missing theorem"
  let names := ci.value.getUsedConstants.filter (fun n => n.toString.startsWith "LeanCert.")
  if names.isEmpty then throwError "no direct LeanCert theorem dependency"
  for n in names do logInfo m!"Actual proof dependency: {n}"
