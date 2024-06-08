#!/bin/hbmclip

**********************************************
* Name  : AtualizarSistema
* Date  : 2024-06-05 - 21:46:56
* Notes : 
/*
   1. 
   2. 
*/
***********************************************
#include 'hbmediator.ch' // Use --virtual-include command line parameter (to use embedded file header)
PROCEDURE AtualizarSistema( ... )
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
    USE hbmver SHARED
    ImpTextScrInit( 10 , 5 , 50 , { "SUCESSO" , " FALHA "} )
    IF sn( "A versão atual do sistema é " + hb_ntos(field->ver) + ";Esse processo irá atualizar o sistema.;(IMPORTANTE:Não interrompa esse processo);Você deseja continuar ?" )
        ImpTextScr( "Verificando o acesso à internet." , .t.  )
        ImpTextScr( "Verificando a próxima versão " , .t.  )
        ALERT("Processo finalizado.;Você pode consultar os logs da operação em update.log")
    ELSE        
        alert("O processo de atualização não será realizado.")
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
