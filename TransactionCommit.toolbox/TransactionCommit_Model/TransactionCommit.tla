------------------------- MODULE TransactionCommit -------------------------

(***************************************************************************)
(* This specification is explained in "Transaction Commit", Lecture 5 of   *)
(* the TLA+ Video Course.                                                  *)
(***************************************************************************)
CONSTANT RM       \* The set of participating resource managers

VARIABLE rmState  \* rmState[rm] is the state of resource manager r.
-----------------------------------------------------------------------------
TCTypeOK == 
  (*************************************************************************)
  (* The type-correctness invariant                                        *)
  (*************************************************************************)
  rmState \in [RM -> {"working", "prepared", "committed", "aborted"}]
        
TCInit ==   rmState = [r \in RM |-> "working"] \* rmState is an array with index set r belonging to RM and set to value "working"
  (*************************************************************************)
  (* The initial predicate.                                                *)
  (*************************************************************************)

canCommit == \A r \in RM : rmState[r] \in {"prepared", "committed"}
  (*************************************************************************)
  (* True iff all RMs are in the "prepared" or "committed" state.          *)
  (*************************************************************************)

notCommitted == \A r \in RM : rmState[r] # "committed" 
  (*************************************************************************)
  (* True iff no resource manager has decided to commit.                   *)
  (*************************************************************************)
-----------------------------------------------------------------------------
(***************************************************************************)
(* We now define the actions that may be performed by the RMs, and then    *)
(* define the complete next-state action of the specification to be the    *)
(* disjunction of the possible RM actions.                                 *)
(***************************************************************************)
Prepare(r) == /\ rmState[r] = "working"
              /\ rmState' = [rmState EXCEPT ![r] = "prepared"]

Decide(r)  == \/ /\ rmState[r] = "prepared"
                 /\ canCommit
                 /\ rmState' = [rmState EXCEPT ![r] = "committed"]
              \/ /\ rmState[r] \in {"working", "prepared"}
                 /\ notCommitted
                 /\ rmState' = [rmState EXCEPT ![r] = "aborted"]

TCNext == \E r \in RM : Prepare(r) \/ Decide(r) \* for all r belonging to RM, the disjucntion of Prepare(r) or Decide(r)
  (*************************************************************************)
  (* The next-state action.                                                *)
  (*************************************************************************)
-----------------------------------------------------------------------------
TCConsistent ==  
  (*************************************************************************)
  (* A state predicate asserting that two RMs have not arrived at          *)
  (* conflicting decisions.  It is an invariant of the specification.      *)
  (*************************************************************************)
  \A r1, r2 \in RM : ~ /\ rmState[r1] = "comitted"
                       /\ rmState[r2] = "aborted"
-----------------------------------------------------------------------------
(***************************************************************************)
(* The following part of the spec is not discussed in Video Lecture 5.  It *)
(* will be explained in Video Lecture 8.                                   *)
(***************************************************************************)
TCSpec == TCInit /\ [][TCNext]_rmState
  (*************************************************************************)
  (* The complete specification of the protocol written as a temporal      *)
  (* formula.                                                              *)
  (*************************************************************************)

THEOREM TCSpec => [](TCTypeOK /\ TCConsistent)
  (*************************************************************************)
  (* This theorem asserts the truth of the temporal formula whose meaning  *)
  (* is that the state predicate TCTypeOK /\ TCInvariant is an invariant   *)
  (* of the specification TCSpec.  Invariance of this conjunction is       *)
  (* equivalent to invariance of both of the formulas TCTypeOK and         *)
  (* TCConsistent.                                                         *)
  (*************************************************************************)
=============================================================================
\* Modification History
\* Last modified Thu Aug 31 16:38:51 SGT 2017 by Navi-PC
\* Created Thu Aug 31 10:53:38 SGT 2017 by Navi-PC
