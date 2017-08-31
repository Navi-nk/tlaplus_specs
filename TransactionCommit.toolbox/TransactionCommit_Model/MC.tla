---- MODULE MC ----
EXTENDS TransactionCommit, TLC

\* CONSTANT definitions @modelParameterConstants:0RM
const_150416873358536000 == 
{"r1","r2","r3"}
----

\* INIT definition @modelBehaviorInit:0
init_150416873358537000 ==
TCInit
----
\* NEXT definition @modelBehaviorNext:0
next_150416873358538000 ==
TCNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_150416873358539000 ==
TCConsistent
----
=============================================================================
\* Modification History
\* Created Thu Aug 31 16:38:53 SGT 2017 by Navi-PC
