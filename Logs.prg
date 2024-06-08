#!/home/vlademiro/sistemas/sistemas30/bin/hbmclip

**********************************************
* Name  : Logs
* Date  : 2024-06-01 - 19:11:47
* Notes : 
/*
   1. 
   2. 
*/
***********************************************
#include 'hbmediator.ch' // Use --virtual-include command line parameter (to use embedded file header)
PROCEDURE Logs( ... )
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams 

    **************************************Templates***************************************
    * SHELL ADD PARAM "-first" TITLE "First" BOOLEAN // Logical parameter
    * SHELL ADD PARAM "-second" TITLE "Second" STRING DEFAULT "Default Value" // Default value
    * SHELL ADD PARAM "-third" TITLE "Third" STRING MANDATORY // Must be value
    ************************************************************************************
    SHELL ADD PARAM "-json" TITLE "Return in json format" BOOLEAN
    SHELL PRINT HELP TO cPrintParams
    IF hb_AScan( hb_Acmdline() , "--help" ) <> 0
        Hbm_Help( cPrintParams )
        RETURN
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    IF IS_PIPE_CONTENT()
        AAdd(aData,m->__PIPE)
        //PIPE TO <aArray> AS ARRAY
        //PIPE TO <cStr> AS STRING
    ENDIF

    IF hParams["-json"]
        SHELL JSON ON // Enable Json format in return message
    ELSE
        SHELL JSON OFF // Disable Json format in return message
    ENDIF

    //SHELL DEBUG hParams // Debug
    //SHELL DEBUG aData // Debug

    **************************************Return Message Templates*****************************
    * SHELL RETURN ERROR <cReturn> [ERRORCODE <nCode>] // error
    * SHELL RETURN <cReturn> [AS ARRAY>] // success
    ************************************************************************************

    /* Insert your code here */
    Save Screen to cTela
    DO WHILE .T.
        aFiles := Directory("*.log")
        IF Len( aFiles ) == 0
           hb_Alert("Não foram encontrados arquivos de log")
           EXIT
        ENDIF   
        aHead := { "Nome do arquivo","Tamanho","Data","Hora" , "Atributo"}

        nRet := Browse2D(6,3,25,95,aFiles,aHead,"GR+/N",;
                "Tecle ENTER sobre o nome do arquivo para ver o seu conteúdo" )
        IF nRet == 0
            exit
        ELSE
            MemoEdit( MemoRead( aFiles[nRet][1]) )
            Restore Screen From cTela
        ENDIF    
    ENDDO    

RETURN

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objective : "
    ?
    ? "Parameters standard"
    ? "--help    This help (script) "
    ? "--?       Help " + ExeName() + " (executable) "
    ? "--virtual-include : embedded ch files "
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF


RETURN
