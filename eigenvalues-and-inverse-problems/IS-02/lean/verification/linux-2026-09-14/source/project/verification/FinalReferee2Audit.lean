import Solution
import Lean.Util.FoldConsts
#print axioms NLA.IS02.witness_certificates
#print axioms NLA.IS02.spectral_uniqueness
#print axioms NLA.IS02.locus_exclusion
#print axioms NLA.IS02.counterexample
open Lean Elab Command in
run_cmd do
  let some (.thmInfo ci) := (← getEnv).find? ``NLA.IS02.witness_certificates | throwError "missing theorem"
  let names := ci.value.getUsedConstants.filter (fun n => n.toString.startsWith "LeanCert.")
  if names.isEmpty then throwError "no direct LeanCert theorem dependency"
  for n in names do logInfo m!"Actual proof dependency: {n}"
