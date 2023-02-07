#SingleInstance, Force
#Persistent

driver:= ComObjCreate(""C:\Program Files\SeleniumBasic\chromedriver.exe"") ;Web driver 
driver.Start("chrome","http://duckduckgo.com/") ;chrome, firefox, ie, phantomjs, edge 
driver.Get("/") 

; driver:= ComObjCreate("Selenium.CHROMEDriver") ;Chrome driver ;~ 
; driver:= ComObjCreate("Selenium.IEDriver") ;Chrome driver ;~ 
; driver:= ComObjCreate("Selenium.FireFoxDriver") ;Chrome driver 
; driver.Get("http://duckduckgo.com/")


