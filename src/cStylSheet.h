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
 * @file    cStylSheet.h
 * @brief   Simple interface to print data to excel file.
 *
 * Long description.
 * @date    20/07/2017
 * @author  alvin.nguyen
 */

#ifndef CSTYLSHEET_H
#define CSTYLSHEET_H

#ifdef __cplusplus
extern "C"
{
#endif

/********** Include section ***************************************************/
#include "stdio.h"
#include <stdlib.h>
#include <glib.h>

#include "xlsxwriter.h"

/********** Constant  and compile switch definition section *******************/

/********** Type definition section *******************************************/
typedef struct stylSheetObjectType_tr
{
    gchar           * path;
    lxw_workbook    * book;
    lxw_worksheet   * sheet;
    lxw_format      * boldFormat;
    gint              rowCursor;
}stylSheetObjectType_tr;

/********** Macro definition section*******************************************/
#ifdef __RELEASE__
    #define __DEBUG__(format, ...)
#else
    #define __DEBUG__(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
#endif // __RELEASE__

#define DEBUG(format, args...) __DEBUG__("%s||%s():[%d] " format "\n",__FILE__,__FUNCTION__, __LINE__, ##args)
#define DEBUG_1(format, ...) DEBUG("\n"      format, ##__VA_ARGS__)
#define DEBUG_0() DEBUG("\n")
#define STYL_DEBUG(format, ...) DEBUG("\n      "format, ##__VA_ARGS__)

/********** Function declaration section **************************************/
void stylAutotoolSampleInit(gchar *sheetPath);

void stylAutotoolSamplePrint(gchar *firstName, gchar *lastName, gchar *birthDay);

void stylAutotoolSampleFinalize(void);

#ifdef __cplusplus
}
#endif

#endif /* CSTYLSHEET_H */
/**@}*/
