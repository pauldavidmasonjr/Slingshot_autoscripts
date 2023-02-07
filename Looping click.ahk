^Numpad2::
MsgBox, This Script will allow you to right click as many times as you choose

InputBox, numClick, # Clicks Input, Insert # of clicks you want, 300, 300
MsgBox, You will have two seconds to place curser over what you want clicked.
sleep, 2000
; Write to the array:
Loop, %numClick%
{
    Sleep 400
    Click
}

MsgBox, Done Clicking