#!/home/vlademiro/sistemas/sistemas30/bin/hbmclip

**********************************************
* Name  : Limpeza
* Date  : 2024-06-01 - 18:20:08
* Notes : Excluir os arquivos temporários
/*
   1. 
   2. 
*/
***********************************************
#include 'hbmediator.ch' // Use --virtual-include command line parameter (to use embedded file header)
#include "fileio.ch"
PROCEDURE Limpeza( ... )
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
    @ 6,2 say Center("Excluindo os arquivos temporários")


    ImpTextScrInit( 10 , 5 , 50 , { "SUCESSO" , " FALHA "} )
    lTemArquivo := .f.   
    IF File("*.log")    
       ImpTextScr( "Logs do sistema (*.log)" , FileDelete( "*.log" )  )
       lTemArquivo := .t.
    ENDIF
    IF File("*.bkp")
       ImpTextScr( "Arquivos com extensão bkp (*.bkp)" , FileDelete( "*.bkp" )  )
       lTemArquivo := .t.
    ENDIF   

    IF lTemArquivo
        FootPauseScreen("Tecle algo")
    ELSE
        hb_Alert("Não foram encontrados arquivos temporários para serem excluídos.")
    ENDIF    


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
