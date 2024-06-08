#!/home/vlademiro/sistemas/sistemas30/bin/hbmclip

**********************************************
* Name  : nmapSimpleForm
* Date  : 2024-06-02 - 17:28:04
* Notes : Formulário simples para uso com o NMAP
/*
   1. 
   2. 
*/
***********************************************
#include 'hbmediator.ch' // Use --virtual-include command line parameter (to use embedded file header)
#include 'inkey.ch'
PROCEDURE nmapSimpleForm( ... )
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
    cIP := SPACE(30)
    @ 07,05 SAY "Endereço IP para análise : " GET cIP
    READ

    IF LASTKEY()<>K_ESC
       cComando :=  hb_StrFormat("nmap %s",alltrim(cIP))
       messageScreen( "Executando : " + cComando )
       cResult := VLJ_RUN( cComando )
       messageScreen()
       IF IsExecError()
            alert( ExecError() )
       ELSE
            MemoEdit( cResult )
       ENDIF
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
