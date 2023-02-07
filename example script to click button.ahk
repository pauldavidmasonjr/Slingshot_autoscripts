#SingleInstance, Force
#Persistent
;#Include Acc.ahk ; https://autohotkey.com/board/topic/77303-acc-library-ahk-l-updated-09272012/

^f::
wb := IEGo("http://www.google.com","Google")
if wb
   wb.Refresh
return

IEGo(URL, TabName := "") 
{ 
   if (TabName) 
   {  ; Search for pre-existing ie tab
      For wb in ComObjCreate("Shell.Application").Windows 
      {
         If  wb.LocationName= TabName and InStr(wb.FullName, "iexplore.exe") 
         {
            window:=0, client:=-4 ; constants for ie 11, varies on other versions
            ControlGet hwnd, hwnd, , DirectUIHWND2, % "ahk_class IEFrame ahk_id " wb.hwnd ; get control hwnd
            client := Acc_ObjectFromWindow(hwnd, client) ;note - the client object should be the 4th child of the window
            page_tab_list := Acc_Children(client)[1]
            for each, child in Acc_Children(page_tab_list) 
            {
               if InStr(child.accName(0),TabName) 
               {
                  child.accDoDefaultAction(0) ; Selects correct tab
                  Winactivate, ahk_id %hwnd% ; Activates the IE Window
                  return wb
               }
            }
         }
      }
   }
   ; No ie tab found, so create it
   wb := ComObjCreate("InternetExplorer.Application")
   wb.Visible := True
   if URL
   {
      wb.Navigate(URL)
      while wb.busy
         sleep 100
   }
   return wb
}
Top
Display posts from previous: 
All posts
 Sort by 
Post time
 
Ascending
 
Post Reply3 posts • Page 1 of 1
Return to “Ask For Help”

Jump to
Who is online