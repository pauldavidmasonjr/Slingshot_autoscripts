

^Numpad3::
MsgBox, Webapp Services Included Drag and Dropper


MultiLineInput(Text:="Waiting for Input") {
    Global MLI_Edit
    Gui, 1: Add, Edit, vMLI_Edit x2 y2 w498 r4
    Gui, 1: Add, Button, gMLI_OK x1 y63 w199 h30, &OK
    Gui, 1: Add, Button, gMLI_Cancel x200 y63 w199 h30, &Cancel
    Gui, 1: Show, h100 w500, %Text%
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

; DropdownPriceType(Text:="Waiting for Input") {
;     Global PriceFreq
;     PriceOptions = One-Time Service Price Update|Recurring Service Price Update

;     Gui, 2: Add, DDL, w300 vPriceFreq, %PriceOptions%
;     Gui, 2: Add, Button, gMLI_OK_2 x1 y63 w199 h30, &OK
;     Gui, 2: Add, Button, gMLI_Cancel_2 x200 y63 w199 h30, &Cancel
;     Gui, 2: Show, h94 w400, %Text%
;     Goto, MLI_Wait_2
;     MLI_OK_2:
;         GuiControlGet, PriceFreq
;     MLI_Cancel_2:
;     GuiEscape_2:
;         ReturnNow := True
;     MLI_Wait_2:
;         While (!ReturnNow)
;             Sleep, 100
;     Gui, 2: Destroy

;     Return PriceFreq
;     ;StrGet(&string2,,"UTF-16")
; }

;Collect Logic Items
Array := MultiLineInput("Enter comma diliminated list of the Services covered")

; PriceOption := DropdownPriceType("Select Type of Price Update You Wish To Perform")
MsgBox, Double click in Search field under "Not Covered" Section. You will have two seconds to do so.Push(
    
sleep, 2000

for index, element in Array 
    {
        sendEvent {click 2}
        Send, %element%
        ;MsgBox, Do you see the correct result?
        MouseMove, 0, -3
        sleep, 5000
    }  



MsgBox Script has concluded

return
        