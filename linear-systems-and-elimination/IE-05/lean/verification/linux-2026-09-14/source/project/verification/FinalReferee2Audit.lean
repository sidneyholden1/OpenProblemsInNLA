import Solution
import Lean.Util.FoldConsts
#print axioms NLA.IE05.qr_certificates
#print axioms NLA.IE05.pivot_certificates
#print axioms NLA.IE05.growth_separation
#print axioms NLA.IE05.counterexample
open Lean Elab Command in
run_cmd do
  let some (.thmInfo ci) := (← getEnv).find? ``NLA.IE05.scalar_separation | throwError "missing theorem"
  let names := ci.value.getUsedConstants.filter (fun n => n.toString.startsWith "LeanCert.")
  if names.isEmpty then throwError "no direct LeanCert theorem dependency"
  for n in names do logInfo m!"Actual proof dependency: {n}"
