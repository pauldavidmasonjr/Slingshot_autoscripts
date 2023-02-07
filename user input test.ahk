^Numpad2::
MsgBox, script starting
;Send, Click
;Control, ChooseString, "Address (ZIP / Postal Code)", ComboBox1, gfield_rule_select ; You might also want to add the window selection info like the photoshop ahk_class

;Control, ChooseString, "Address (ZIP / Postal Code)"
wb.document.all["field_rule_field_0"].value := "Address (ZIP / Postal Code)"