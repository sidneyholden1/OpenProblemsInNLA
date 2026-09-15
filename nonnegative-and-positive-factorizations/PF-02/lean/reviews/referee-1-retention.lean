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
      let children : List Name := match env.find? n with
        | none => []
        | some ci => match ci.value? (allowOpaque := true) with
          | none => []
          | some v => v.getUsedConstants.toList.filter (fun (d : Name) => "NLA.".isPrefixOf d.toString)
      retentionPath env target k (rest ++ children.map (fun d => (d,d::path))) (seen.insert n)
run_cmd do
  let env ← getEnv
  match retentionPath env `NLA.PF02.witnessM_det 10000 [(`NLA.PF02.not_connectedOrbitConjecture, [`NLA.PF02.not_connectedOrbitConjecture])] {} with
  | none => throwError "No retained material proof path"
  | some path => logInfo m!"Material proof retained: {path}"
run_cmd do
  let env ← getEnv
  match retentionPath env `NLA.PF02.witness_coordinates_det 10000 [(`NLA.PF02.not_connectedOrbitConjecture, [`NLA.PF02.not_connectedOrbitConjecture])] {} with
  | none => throwError "No retained material proof path"
  | some path => logInfo m!"Material proof retained: {path}"
run_cmd do
  let env ← getEnv
  match retentionPath env `NLA.PF02.reflected_coordinates_det 10000 [(`NLA.PF02.not_connectedOrbitConjecture, [`NLA.PF02.not_connectedOrbitConjecture])] {} with
  | none => throwError "No retained material proof path"
  | some path => logInfo m!"Material proof retained: {path}"
run_cmd do
  let env ← getEnv
  match retentionPath env `NLA.PF02.congruence_coordinate_det 10000 [(`NLA.PF02.not_connectedOrbitConjecture, [`NLA.PF02.not_connectedOrbitConjecture])] {} with
  | none => throwError "No retained material proof path"
  | some path => logInfo m!"Material proof retained: {path}"
