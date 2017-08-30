--------------------------- MODULE simpleProgram ---------------------------

EXTENDS Integers
VARIABLES i, pc   

Init == (pc = "start") /\ (i = 0)

Pick == /\ pc = "start"  
        /\ i' \in 0..1000
        /\ pc' = "middle"

Add1 == /\ pc = "middle" 
        /\ i' = i + 1
        /\ pc' = "done"  
           
Next == Pick \/ Add1
=============================================================================
\* Modification History
\* Last modified Wed Aug 30 12:14:30 SGT 2017 by Navi-PC
\* Created Wed Aug 30 12:12:51 SGT 2017 by Navi-PC
