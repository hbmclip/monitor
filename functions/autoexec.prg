#include "hbmediator.ch"
FUNCTION AUTOEXEC
    
    LOCAL lReturn, aStruct

    IF !FILE("hbmver.dbf")
       aStruct := {}
       AADD( aStruct , { "VER" , "N" , 12 , 0 } )
       AADD( aStruct , { "URL" , "C" , 512 , 0 } )
       USE hbmver STRUCT aStruct TO lReturn 
       APPEND BLANK
       REPLACE VER WITH 0 
       REPLACE URL WITH "http://localhost/apps/monitor" 
       CLOSE ALL
    ENDIF

	CONFIG LOG LEVEL INFO
	LOG "HELLO WORLD" INFO
	

    

RETURN NIL



