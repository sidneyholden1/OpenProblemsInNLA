import Solution
import Lean
open Lean Elab Command
private def retentionPath (env : Environment) (target : Name) : Nat → List (Name × List Name) → NameSet → Option (List Name)
  | 0, _, _ => none
  | _, [], _ => none
  | k+1, (n,path)::rest, seen =>
    if n == target then some (path.reverse)
    else if seen.contains n then retentionPath env target k rest seen
    else
      let children := match env.find? n with
        | none => []
        | some ci => match ci.value? (allowOpaque := true) with
          | none => []
          | some v => v.getUsedConstants.toList.filter (fun d => "NLA.".isPrefixOf d.toString)
      retentionPath env target k (rest ++ children.map (fun d => (d,d::path))) (seen.insert n)
run_cmd do
  let env ← getEnv
  match retentionPath env `NLA.MI22.numerical_separation 10000 [(`NLA.MI22.not_weightedLogMajorizationConjecture, [`NLA.MI22.not_weightedLogMajorizationConjecture])] {} with
  | none => throwError "No retained material scalar path"
  | some path => logInfo m!"Material scalar retained: {path}"
