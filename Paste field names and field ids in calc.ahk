^Numpad5::
MsgBox, This script will help you paste field name and ids in calculation fields. 

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

Array := MultiLineInput("Enter field ID numbers (One per line)")

InputBox, OptionText, Field Admin Label, Type "Admin Field Label" that will be applied to all pasted fields., , 200, 200

MsgBox, Place curser on line where you want price fields to start. (2 seconds)

sleep, 3000

for index, element in Array 
{
    SendRaw, {%OptionText%:%element%} +
    Send, {Enter}
}


MsgBox, Script has Concluded.