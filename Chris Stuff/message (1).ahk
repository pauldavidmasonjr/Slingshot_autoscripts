#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, RegEx

$^o:: ; Enters prices as one-time prices
	enterPrices(Clipboard, "one-time")
return

$^r:: ; Enters prices as initial and recurring prices
	enterPrices(Clipboard, "recurring")
return

$^l:: ; Enters prices as initial and recurring prices
	enterPrices(Clipboard, "lawn")
return

$!End::
	reload
return

$Pause:: pause

;Functions

enterPrices(data, type)
{
	waitQuick()
	send +{Tab}
	waitQuick()
	send +{Tab}
	waitQuick()
	replaceSp("1")
	Loop, parse, data, `n, `r
	{
		waitQuick()
		RegExMatch(A_Loopfield, "^[^\t]+", tier)
		tier := RegExReplace(tier, "(,| )")
		RegExMatch(A_Loopfield, "[^\t]+$", recurringPrice)
		if (not type == "recurring")
			initialPrice := recurringPrice
		else
			RegExMatch(A_Loopfield, "(?<=\t)[^\t]+", initialPrice)
		if RegExMatch(tier, "(?<=\d-)\d+", topTier)
			tier := topTier
		if RegExMatch(initialPrice, "\$?[\d\.,]+-\$?[\d\.,]+")
		{
			RegExMatch(initialPrice, "[^-]+(?=-)", initialPriceMax)
			RegExMatch(initialPrice, "(?<=-)[^-]+", initialPriceMin)
			if (initialPriceMax < initialPriceMin)
			{
				temp := initialPriceMax
				initialPriceMax := initialPriceMin
				initialPriceMin := temp
			}
		}
		else
		{
			initialPriceMax := initialPrice
			initialPriceMin := initialPrice
		}
		if (not RegExMatch(initialPriceMax, "\d+\.\d+"))
			initialPriceMax .= ".00"
		if (not RegExMatch(initialPriceMin, "\d+\.\d+"))
			initialPriceMin .= ".00"
		if RegExMatch(recurringPrice, "\$?[\d\.,]+-\$?[\d\.,]+")
		{
			RegExMatch(recurringPrice, "[^-]+(?=-)", recurringPriceMax)
			RegExMatch(recurringPrice, "(?<=-)[^-]+", recurringPriceMin)
			if (recurringPriceMax < recurringPriceMin)
			{
				temp := recurringPriceMax
				recurringPriceMax := recurringPriceMin
				recurringPriceMin := temp
			}
		}
		else
		{
			recurringPriceMax := recurringPrice
			recurringPriceMin := recurringPrice
		}
		if (not RegExMatch(recurringPriceMax, "\d+\.\d+"))
			recurringPriceMax .= ".00"
		if (not RegExMatch(recurringPriceMin, "\d+\.\d+"))
			recurringPriceMin .= ".00"
		send {Tab}
		waitQuick()
		sendQuicklySp(tier)
		waitQuick()
		send {Tab}
		waitQuick()
		sendQuicklySp(initialPriceMax)
		waitQuick()
		send {Tab}
		waitQuick()
		sendQuicklySp(initialPriceMin)
		waitQuick()
		send {Tab}
		waitQuick()
		if (type == "one-time")
		{
			recurringPriceMax := 0
			recurringPriceMin := 0
		}
		sendQuicklySp(recurringPriceMax)
		waitQuick()
		send {Tab}
		waitQuick()
		sendQuicklySp(recurringPriceMin)
		waitQuick()
		send {Tab}
		waitQuick()
		send {Tab}
		waitQuick()
		send {Space}
		Loop, 7
		{
			waitQuick()
			send +{Tab}
		}
	}
	Loop, 6
	{
		waitQuick()
		send {Tab}
	}
	waitQuick()
	send {Enter}
	waitQuick()
}

lookupRow(data, row)
{
	iterator := 0
	rowData := ""
	Loop, parse, data, `n, `r
	{
		iterator++
		if (iterator == row)
		{
			rowData := A_Loopfield
			break
		}
	}
	return rowData
}

lookupColumn(data, column)
{
	data := flipTable(data)
	return lookupRow(data, column)
}

getNumOfRows(data)
{
	RegExReplace(data, "\r?\n", , rows)
	rows++
	return rows
}

getNumOfColumns(data)
{
	RegExReplace(data, "\t", , columns)
	columns++
	return columns
}

removeColumn(data, column)
{
	global leftovers
	extractColumn(data, column)
	return leftovers
}

removeRow(data, row)
{
	global leftovers
	extractRow(data, row)
	return leftovers
}

lookupTable(column, row, data := "@useClipboard")
{
	return tableLookup(column, row, data)
}

tableLookup(column, row, data := "@useClipboard")
{
	if (data == "@useClipboard")	
		data := Clipboard
	columnData := extractColumn(data, column)
	loopNum := 0
	Loop, parse, columnData, `n, `r
	{
		loopNum++
		if (loopNum == row)
			return A_Loopfield
	}
	return "ERROR: No Data"
}
wait()
{
	sleep 1500
}

waitMed()
{
	sleep 500
}

waitQuick()
{
	sleep 100
}

replace(text, replaceWith := "$0nullstring")
{
	send ^a
	if (replaceWith != "$0nullstring" and needle != "$0nullstring")
	{
		stringToReplace := read()
		replacementText := RegExReplace(stringToReplace, text, replaceWith)
		if (replacementText == "")
			send {Backspace}
		else
			sendQuickly(replacementText)
	}
	else
	{
		if (text == "")
			send {Backspace}
		else
			sendQuickly(text)
	}
}

replaceSp(text)
{
	send ^a
	sendQuicklySp(text)
}

sendQuick(text)
{
	sendQuickly(text)
}

sendQuicklySp(text)
{
	tempClip := Clipboard
	Clipboard := text
	Loop, 5
	{
		waitQuick()
		if (tempClip != Clipboard)
			break
	}
	Loop
	{
		waitQuick()
		if (Clipboard == text)
			break
		else
			Clipboard := text
	}
	waitQuick()
	send ^v
	waitQuick()
	Clipboard := tempClip
}

sendQuickly(text)
{
	theSendMode := A_SendMode
	text := RegExReplace(text, "\r?\n\r?", "`n")
	SendMode Input
	sendraw %text%
	SendMode %theSendMode%
}

readAll()
{
	send ^a
	waitQuick()
	return read()
}

read()
{
	tempClip := Clipboard
	Clipboard := ""
	send ^c
	Loop, 3
	{
		waitQuick()
		if (tempClip != Clipboard)
			break
	}
	waitQuick()
	contentRead := Clipboard
	Clipboard := tempClip
	return contentRead
}

flipTable(data)
{
	RegExMatch(data, "^[^\r\n]+", firstLine)
	RegExReplace(firstLine, "\t", "", tabCount)
	loopRound := 0
	flippedTable := ""
	Loop
	{
		if (loopRound > tabCount)
			break
		loopRound++
		newNextLine := extractColumn(data, loopRound)
		newNextLine := RegExReplace(newNextLine, "\r?\n", "`t")
		if (loopRound == 1)
			flippedTable := newNextLine
		else
			flippedTable = %flippedTable%`r`n%newNextLine%
	}
	return flippedTable
}

deReference(text)
{
	toReturn := RegExReplace(text, "\$", "$$$$")
	return toReturn
}

unSpecChar(text, type:="haystack")
{
	global altClip
	global recentlyUsedClip
	origText := text
	fixedAltClip := altClip
	if (text != recentlyUsedClip)
		text := StrReplace(text, "\v2", recentlyUsedClip)
	if (text != Clipboard)
		text := StrReplace(text, "\v", Clipboard)
	if (text != altClip)
	{
		text := RegExReplace(text, "\\c2", deReference(fixedAltClip))
	}
	if (text != altClip)
	{
		text := RegExReplace(text, "\\c(?!2)", deReference(altClip))
	}
	if (text != Clipboard)
	{
		noParens := RegExReplace(Clipboard, " ?\([^\)]+\)", "")
		text := StrReplace(text, "\Pv", noParens)
	}
	if (text != altClip)
	{
		noParens := RegExReplace(altClip, " ?\([^\)]+\)", "")
		text := StrReplace(text, "\Pc", noParens)
	}
	if (text != Clipboard)
	{
		RegExMatch(Clipboard, "(?<=\()[^(?=\))]+(?=\))", parens)
		text := StrReplace(text, "\pv", parens)
	}
	if (text != altClip)
	{
		RegExMatch(altClip, "(?<=\()[^(?=\))]+(?=\))", parens)
		text := StrReplace(text, "\pc", parens)
	}
	if (type == "haystack")
	{
		text := StrReplace(text, "\", "\\")
		text := StrReplace(text, "/", "\/")
		text := StrReplace(text, "*", "\*")
		text := StrReplace(text, "+", "\+")
		text := StrReplace(text, "?", "\?")
		text := StrReplace(text, ".", "\.")
		text := StrReplace(text, "(", "\(")
		text := StrReplace(text, ")", "\)")
		text := StrReplace(text, "{", "\{")
		text := StrReplace(text, "}", "\}")
		text := StrReplace(text, "|", "\|")
		text := StrReplace(text, "[", "\[")
		text := StrReplace(text, "]", "\]")
		text := StrReplace(text, "^", "\^")
		;text := StrReplace(text, "#", "\#")
		;text := StrReplace(text, "$$", "$")
		text := StrReplace(text, "$", "\$")
	}
	else
		text := StrReplace(text, "$", "$$")
	return text
}

specChar(text, haystackOrNeedle := "needle")
{
	global altClip
	global recentlyUsedClip
	clippy := unSpecChar(Clipboard, "other")
	clippyRU := unSpecChar(recentlyUsedClip, "other")
	clippyAlt := unSpecChar(deReference(altClip), "other")
	clippyAltFixed := altClip
	clippyAltFixed := unSpecChar(deReference(clippyAltFixed), "other")
	;MsgBox, %altClip% -> %clippyAlt% -> %clippyAltFixed%
	if (text != Clipboard)
	{
		noParens := RegExReplace(Clipboard, " ?\([^\)]+\)", "")
		text := RegExReplace(text, "\\Pv", noParens)
	}
	if (text != altClip)
	{
		noParens := RegExReplace(altClip, " ?\([^\)]+\)", "")
		text := RegExReplace(text, "\\Pc", noParens)
	}
	if (text != Clipboard)
	{
		RegExMatch(Clipboard, "(?<=\()[^(?=\))]+(?=\))", parens)
		text := RegExReplace(text, "\\pv", parens)
	}
	if (text != altClip)
	{
		RegExMatch(altClip, "(?<=\()[^(?=\))]+(?=\))", parens)
		text := RegExReplace(text, "\\pc", parens)
	}
	text := RegExReplace(text, "(?<!\\)\\r","`r")
	text := RegExReplace(text, "(?<!\\)\\n","`n")
	text := RegExReplace(text, "(?<!\\)\\t","`t")
	text := RegExReplace(text, "\\v2", clippyRU)
	text := RegExReplace(text, "\\[Pp]?v", clippy)
	text := RegExReplace(text, "\\[Pp]?c2", clippyAltFixed)
	text := RegExReplace(text, "\\[Pp]?c(?!2)", clippyAlt)
	if (haystackOrNeedle == "needle")
		text := RegExReplace(text, "\\\$", "$$$$")
	text := RegExReplace(text, "\\(\d)", "$$$1")
	return text
}
extractrow(data, rownum)
{
	global leftovers
	flippedtable := fliptable(data)
	rowdata := extractcolumn(flippedtable, rownum)
	rowdata := regexreplace(rowdata, "\r?\n", "`t")
	leftovers := fliptable(leftovers)
	return rowdata
}

extractcolumn(data, columnnum)
{
	global leftovers
	looptimes := columnnum - 1
	regex := "om)^()([^\t\r\n]*)"
	regexmatch(data, "^[^\r\n]+", firstline)
	regexreplace(firstline, "\t", "", tabcount)
	if (looptimes > 0)
	{
		loop, %looptimes%
		{
			regex := regexreplace(regex, "\)\(\[\^\\t\\r\\n\]\*\)$", "")
			regex = %regex%[^\t\r\n]*\t)([^\t\r\n]*)
		}
	}
	columndata := ""
	leftovers := data
	passthrough := 0
	loop, parse, data, `n, `r
	{
		prekeep := ""
		passthrough++
		dataline := a_loopfield
		regexmatch(dataline, regex, match)
		prekeep := unspecchar(match.value(1))
		totrim := match.value(2)
		totrim := regexreplace(totrim, "\t")
		;uprekeep := regexreplace(prekeep, "\\\$", ".")
		if (columnnum == 1)
			toremove := "(?<=" . prekeep . ")" . totrim
		else
		{
			prekeep := regexreplace(prekeep, "`t$")
			toremove := "(?<=" . prekeep . ")`t" . totrim
		}
		if (prekeep == "")
			toremove := regexreplace(toremove, "\(\?<=\)", "m)^")
		tokeep := match.value(2)
		if (passthrough == 1)
			columndata := tokeep
		else
			columndata .= "`r`n" . tokeep
		wasleftovers := leftovers
		leftovers := regexreplace(leftovers, toremove . "\t", "", , 1)
		if (wasleftovers == leftovers)
			leftovers := regexreplace(leftovers, "\t" . toremove, "", , 1)
	}
	return columndata
}