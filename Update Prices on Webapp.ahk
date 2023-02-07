

^Numpad0::
MsgBox, This script will help updated prices in Webapp

Odd(n)
{
    return n&1
}
Even(n)
{
    return mod(n, 2) = 0
}

MultiLineInput(Text:="Waiting for Input") {
    Global MLI_Edit
    Gui, 1: Add,Edit,ReadOnly , One Time Service Example:`n 104.00 (Initial Price) `n 150.00 (Initial Price)
    Gui, 1: Add,Edit,ReadOnly , Recurring Price Example Input: `n104.00 (initial price) `n150.00 (recurring price)`n125.00 (initial price) `n175.00 (recurring price)`netc
    Gui, 1: Add, Edit, vMLI_Edit x2 y150 w498 r12
    Gui, 1: Add, Button, gMLI_OK x6 y320 w199 h30, &OK
    Gui, 1: Add, Button, gMLI_Cancel x205 y320 w199 h30, &Cancel
    Gui, 1: Show, h350 w500, %Text%
    Goto, MLI_Wait
    MLI_OK:
        GuiControlGet, MLI_Edit
    MLI_Cancel:
    GuiEscape:
        ReturnNow := True
    MLI_Wait:
        While (!ReturnNow)
            Sleep, 100
    Gui, 1: Destroy

    Return StrSplit(MLI_Edit, "`n")
}

SQFTMultiLineInput(Text:="Waiting for Input") {
    Global SQFTInputs
    Gui, 4: Add,Edit,ReadOnly , Enter Square Footages in required order one per line:`nEXAMPLE:`n0`n1000`n1001`n1500`n1501`n2000`nETC
    Gui, 4: Add, Edit, vSQFTInputs x2 y150 w498 r12
    Gui, 4: Add, Button, gMLI_OK_4 x6 y320 w199 h30, &OK
    Gui, 4: Add, Button, gMLI_Cancel_4 x205 y320 w199 h30, &Cancel
    Gui, 4: Show, h350 w500, %Text%
    Goto, MLI_Wait_4
    MLI_OK_4:
        GuiControlGet, SQFTInputs
    MLI_Cancel_4:
    GuiEscape_4:
        ReturnNow := True
    MLI_Wait_4:
        While (!ReturnNow)
            Sleep, 100
    Gui, 4: Destroy

    Return StrSplit(SQFTInputs, "`n")
}

DropdownPriceType(Text:="Waiting for Input") {
    Global PriceFreq
    PriceOptions = One-Time Service Price Update|Recurring Service Price Update

    
    Gui, 2: Add, DDL, w300 vPriceFreq, %PriceOptions%
    Gui, 2: Add, Button, gMLI_OK_2 x1 y63 w199 h30, &OK
    Gui, 2: Add, Button, gMLI_Cancel_2 x200 y63 w199 h30, &Cancel
    Gui, 2: Show, h94 w500, %Text%
    Goto, MLI_Wait_2
    MLI_OK_2:
        GuiControlGet, PriceFreq
    MLI_Cancel_2:
    GuiEscape_2:
        ReturnNow := True
    MLI_Wait_2:
        While (!ReturnNow)
            Sleep, 100
    Gui, 2: Destroy

    Return PriceFreq
    ;StrGet(&string2,,"UTF-16")
}

SizeRestraintEditDeterminer(Text:="Waiting for Input") {
    Global EditSizeRestraints
    userOptions = Yes|No

    Gui, 3: Add, DDL, w300 vEditSizeRestraints, %userOptions%
    Gui, 3: Add, Button, gMLI_OK_3 x1 y63 w199 h30, &OK
    Gui, 3: Add, Button, gMLI_Cancel_3 x200 y63 w199 h30, &Cancel
    Gui, 3: Show, h94 w300, %Text%
    Goto, MLI_Wait_3
    MLI_OK_3:
        GuiControlGet, EditSizeRestraints
    MLI_Cancel_3:
    GuiEscape_3:
        ReturnNow := True
    MLI_Wait_3:
        While (!ReturnNow)
            Sleep, 100
    Gui, 3: Destroy

    Return EditSizeRestraints
    ;StrGet(&string2,,"UTF-16")
}

;Determine if updating size restraints
SizeRestraintsUserChoice := SizeRestraintEditDeterminer("Edit Price Tier sq ft sizes?")
affirm = Yes
Neg = No

;Collect Logic Items
Array := MultiLineInput("Enter prices ordered top to bottom")

PriceOption := DropdownPriceType("Select Type of Service Frequency")

if (SizeRestraintsUserChoice = affirm)
{
    sqftInputs := SQFTMultiLineInput("Enter SQ FT restraints")

    MsgBox, One Time Service price insert will execute now. `n`nDouble-Click into first price field. `n`nYou will have 2 seconds to do so.

    sleep, 2000

    for index, element in sqftInputs 
    {
        if (Odd(index))
        {
            Send, %element%
            Send, {TAB}
        }
        sleep, 200
        if (Even(index) && index != sqftInputs.Length())
        {
            Send, %element%
            Send, {TAB}
            Send, {TAB}
            Send, {TAB}
            Send, {TAB}
            Send, {TAB}
            Send, {TAB}
            sleep, 200
            Send, {SPACE}
            Send +{Tab}
            Send +{Tab}
            Send +{Tab}
            Send +{Tab}
            Send +{Tab}
            Send +{Tab}
            Send +{Tab}
        }
        sleep, 200
    } 
    if(index == sqftInputs.Length())
    {
        Send, %element%
    }
}
if (SizeRestraintsUserChoice = Neg)
{
}

onetime = One-Time Service Price Update
recurring = Recurring Service Price Update



If (PriceOption = onetime)
{
    ;MsgBox, One Time Service price insert will execute now. `n`nDouble-Click into first price field. `n`nYou will have 2 seconds to do so.

    sleep, 2000

    for index, element in Array 
    {
        Send, %element%
        Send, {TAB}
        Send, %element%
        Send, {TAB}
        Send, {TAB}
        Send, {TAB}
        Send, {TAB}
        Send, {TAB}
        Send, {TAB}
    }
}
if (PriceOption = recurring)
{
    ;MsgBox, Recurring Service price insert will execute now. `n`nDouble-Click into first price field. `n`nYou will have 2 seconds to do so.
    for index, element in Array 
    {
        if (index < Array.Length() / 2)
        {
            if(index = 1)
            {
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                ;Send, 1
            }
            else 
            {
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                Send +{Tab}
                ;Send, 2+
            }
        }
        
        
        ;msgBox, test stop
    } 
    Send, {TAB}
    Send, {TAB}
    sleep, 2000
        
    for index, element in Array 
    {
        if (Odd(index))
        {
            Send, %element%
            Send, {TAB}
            Send, %element%
        }
        if (Even(index))
        {
            Send, {TAB}
            Send, %element%
            Send, {TAB}
            Send, %element%
            Send, {TAB}
            Send, {TAB}
            Send, {TAB}
            Send, {TAB}
        }
        sleep, 200
    }  
}

MsgBox Script has concluded

return
        