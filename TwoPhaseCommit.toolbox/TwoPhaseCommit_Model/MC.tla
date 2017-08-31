---- MODULE MC ----
EXTENDS TwoPhaseCommit, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3
----

\* MV CONSTANT definitions RM
const_150417194436957000 == 
{r1, r2, r3}
----

\* SYMMETRY definition
symm_150417194436958000 == 
Permutations(const_150417194436957000)
----

\* INIT definition @modelBehaviorInit:0
init_150417194436959000 ==
TPInit
----
\* NEXT definition @modelBehaviorNext:0
next_150417194436960000 ==
TPNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_150417194436961000 ==
TPTypeOK
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_150417194436962000 ==
TCConsistent
----
=============================================================================
\* Modification History
\* Created Thu Aug 31 17:32:24 SGT 2017 by Navi-PC
