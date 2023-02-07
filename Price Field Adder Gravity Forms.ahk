^Numpad4::
MsgBox, "This will add price fields for you in Gravity Forms"

MultiLineInput(Text:="Waiting for Input") {
    Global MLI_Edit
    Gui, Add, Edit, vMLI_Edit x2 y2 w396 r4
    Gui, Add, Button, gMLI_OK x1 y63 w199 h30, &OK
    Gui, Add, Button, gMLI_Cancel x200 y63 w199 h30, &Cancel
    Gui, Show, h94 w400, %Text%
    Goto, MLI_Wait
    MLI_OK:
        GuiControlGet, MLI_Edit
    MLI_Cancel:
    GuiEscape:
        ReturnNow := True
    MLI_Wait:
        While (!ReturnNow)
            Sleep, 100
    Gui, Destroy

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

;Collect Logic Items
Array := MultiLineInput("Paste pricing list (One price per line)")

;Collect # of TABS between each field
;InputBox, numTabs, # TABS needed, Enter number of TABS needed between each field, , 200, 200

;looping click to add # dropdown options needed
MsgBox "The script will not click the '+' button the number of times needed."
MsgBox "Hold your mouse over the '+' button after you click 'ok' below. You will have 2 seconds before the script start clicking"

sleep, 2000 ;(wait 2 seconds) 

for index, element in Array
{
    ;MsgBox %element%
    Click
    sleep, 200
    
}

;Get list of square footages
sqftInputs := SQFTMultiLineInput("Enter SQ FT restraints (One Per Line)")

;get admin field label
InputBox, AdminLabelInput, Admin Label, Type Desired Admin Label for all price Boxes, 300, 300

;;MsgBox, %AdminLabelInput%

;MsgBox, finish admin test

;MsgBox, open first price box
sleep, 2000 ;(wait 2 seconds)

byTwoIndex := 1
for index, element in Array
{
    sleep, 1000
    Send, {TAB}
    
    Send, {TAB}
    
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}

    sleep, 1000
    Send, ^a ; Ctrl + A
    Send, <span class ="pricerange">$%element%</span>

    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}

    Send {Right}
    sleep, 1000

    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}

    Send, ^a ; Ctrl + A

    Send, price-max-%element% price-min-%element% gf_inline
    sleep, 500
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}

    Send {Right}
    sleep, 1000
    tmpByTwoIndex := byTwoIndex+1
    sqft2 := sqftInputs[tmpByTwoIndex]

    Send, {TAB}
    Send, {TAB}
    Send,%AdminLabelInput% %sqft2%
    ;msgBox, pausing to test
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    sqft1 := sqftInputs[byTwoIndex]

    Send, %sqft1%
    sleep, 1000
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    
    
    
    
    ;MsgBox, %sqft2%
    sleep, 1000

    Send, %sqft2%            

    
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    Send, {TAB}
    sleep, 200

    send, {Enter}

    byTwoIndex := byTwoIndex + 2
    ;msgBox %byTwoIndex%
}

MsgBox, The script has concluded

                              