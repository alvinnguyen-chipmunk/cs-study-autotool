/*******************************************************************************
 *  (C) Copyright 2009 Molisys Solutions Co., Ltd. , All rights reserved       *
 *                                                                             *
 *  This source code and any compilation or derivative thereof is the sole     *
 *  property of Molisys Solutions Co., Ltd. and is provided pursuant to a      *
 *  Software License Agreement.  This code is the proprietary information      *
 *  of Molisys Solutions Co., Ltd and is confidential in nature.  Its use and  *
 *  dissemination by any party other than Molisys Solutions Co., Ltd is        *
 *  strictly limited by the confidential information provisions of the         *
 *  Agreement referenced above.                                                *
 ******************************************************************************/

/**
 * @defgroup    <groupIdentifier>	    <Group Name>    //Optional
 * @ingroup	    superGroupIdentifier                    //Optional
 * @brief       <Brief description>
 *
 * <Long description>
 * @{
 */

/**
 * @file    cStylSheetExample.c
 * @brief   Example program use stylSheet library
 *
 * Long description.
 * @date    20/07/2017
 * @author  alvin.nguyen
 */

/********** Include section ***************************************************/
#include "stdio.h"
#include <stdlib.h>
#include <glib.h>

#include "cStylSheet.h"

/********** Local Constant and compile switch definition section **************/

/********** Local Type definition section *************************************/

/********** Local Macro definition section ************************************/

/********** Local (static) variable definition section ************************/

/********** Local (static) function declaration section ***********************/

/********** Local function definition section *********************************/

/********** Global function definition section ********************************/
int main()
{
    gchar * sheetPath = g_strdup("/home/alvin/Templates/stylSheet/example.xlsx");

    stylAutotoolSampleInit(sheetPath);

    stylAutotoolSamplePrint("Alvin", "Nguyen"       , "15/05/1991");
    stylAutotoolSamplePrint("Logan", "Bui"          , "12/11/1991");
    stylAutotoolSamplePrint("Thinh", "Nguyen Trong" , "03/09/1991");

    stylAutotoolSampleFinalize();

    return EXIT_SUCCESS;
}

/**@}*/



