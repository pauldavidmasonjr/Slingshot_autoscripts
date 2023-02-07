^Numpad1::
MsgBox, "This Script will help you to insert options into a single column drop down field in gravity forms UI"

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

;Collect Logic Items
Array := MultiLineInput("Paste List of Logic Items (One per line)")

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

;select info source
 ; You might also want to add the window selection info like the photoshop ahk_class
InputBox, OptionText, Dropdown option select, Type the desired option exactly how it appears in the dropdown., , 200, 200

;select comparison operator
InputBox, numDownClicksOperator, Compare Operator Select, Insert # associated with compare operator that you want `n`n0 - is `n1 - is not `n2 - greater than `n3 - less than `n4 - contains `n5 - starts with `n6 - ends with, , 400, 300


MsgBox "Now 'click' into first option field after selecting 'ok' below. You will have 2 seconds to do so"

sleep, 2000 ;(wait 2 seconds)

;loop through array and paste items in fields
for index, element in Array
{
    Send %OptionText%

    Send {Tab}

    loop %numDownClicksOperator%
    {
        Send {down}
    }
    
    Send {Tab}

    ;Send, %element%

    ;loop %numTabs% {
        ;Send {Tab}
    ;}

    Send {Tab}
}

for index, element in Array
{
    ;MsgBox %element%
    Send +{Tab}
    Send +{Tab}
    Send +{Tab}
    
}

for index, element in Array
{

    Send {Tab}

    Send {Up}
    Send {Down}    
    Send {Tab}

    Send, %element%

    ;loop %numTabs% {
        ;Send {Tab}
    ;}

    Send {Tab}
}


MsgBox, Script has finished. Enjoy your extra time!
; Create the array, initially empty:
;Array := [] ; or Array := Array()

; Write to the array:
;Loop, Read, specialtyPests.ini ; This loop retrieves each line from the file, one at a time.
;{
    ;MsgBox, [ Options, A_LoopReadLine, Text, Timeout]
    ;Array.Push(A_LoopReadLine) ; Append this line to the array.
;}

; Read from the array:
; Loop % Array.MaxIndex()   ; More traditional approach.
;for index, element in Array ; Enumeration is the recommended approach in most cases.
;loop, 1
;{
    ;MsgBox, [ Options, element, Text, Timeout]
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}
    ;  Send {down}

    ;Send {Tab}

    ; Send {up}
    ; Send {up}
    ; Send {up}
    ; Send {up}

     ;Send {Down}
     ;Send {Down}     
     ;Send {Down}    
     ;Send {Down}   


    ;Send {Tab}
    ;Send {Tab}
    ;sleep, 500 ;(wait 2 seconds) 

    ;Send, %element%
    ;Send, 'test'

    ;Send {Tab}

    ;sleep, 2000 ;(wait 2 seconds) 
    ;wb.document.getElementByClassName("add_field_choice").click()
;}                                                                                                       