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
 * @file    cStylSheet.c
 * @brief   Simple interface to print data to excel file.
 *
 * Long description.
 * @date    20/07/2017
 * @author  alvin.nguyen
 */

/********** Include section ***************************************************/
#include "cStylSheet.h"

/********** Local Constant and compile switch definition section **************/

/********** Local Type definition section *************************************/

/********** Local Macro definition section ************************************/
#define F_NAME_COL_INDEX       0
#define L_NAME_COL_INDEX       1
#define BIRTHDAY_COL_INDEX     2

#define F_NAME_COL_TITLE       "First name"
#define L_NAME_COL_TITLE       "Last name"
#define BIRTHDAY_COL_TITLE     "Birthday"

/********** Local (static) variable definition section ************************/
static struct stylSheetObjectType_tr * stylSheetObject = NULL;

/********** Local (static) function declaration section ***********************/
static void stylAutotoolSampleTitle(void)
{
    g_return_if_fail(stylSheetObject!= NULL && stylSheetObject->book != NULL);

    lxw_worksheet   *workSheet    = stylSheetObject->sheet;
    lxw_format      *bold         = stylSheetObject->boldFormat;

    worksheet_write_string(workSheet, 0, F_NAME_COL_INDEX   , F_NAME_COL_TITLE      , bold);
    worksheet_write_string(workSheet, 0, L_NAME_COL_INDEX   , L_NAME_COL_TITLE      , bold);
    worksheet_write_string(workSheet, 0, BIRTHDAY_COL_INDEX , BIRTHDAY_COL_TITLE    , bold);
}

static gchar *stylAutotoolSamplePathUtf8(gchar *utf8Text)
{
    if (utf8Text==NULL)
		return NULL;
	gchar *localeText;
	localeText = g_locale_from_utf8(utf8Text, -1, NULL, NULL, NULL);
	if (localeText == NULL)
		localeText = g_strdup(utf8Text);
	return localeText;
}

/********** Local function definition section *********************************/

/********** Global function definition section ********************************/
void stylAutotoolSampleInit(gchar *sheetPath)
{
    stylSheetObject = g_slice_new(struct stylSheetObjectType_tr);
    stylSheetObject->book = NULL;
    stylSheetObject->sheet = NULL;
    stylSheetObject->path = NULL;
    stylSheetObject->boldFormat = NULL;

    stylSheetObject->path = stylAutotoolSamplePathUtf8(sheetPath);

    DEBUG("INFO: stylSheetObject->path: %s", stylSheetObject->path);

    stylSheetObject->book       = workbook_new(stylSheetObject->path);
    stylSheetObject->sheet      = workbook_add_worksheet(stylSheetObject->book, NULL);
    stylSheetObject->boldFormat = workbook_add_format(stylSheetObject->book);

    format_set_bold(stylSheetObject->boldFormat);

    worksheet_set_column(stylSheetObject->sheet, 0, F_NAME_COL_INDEX    , 20, NULL);
    worksheet_set_column(stylSheetObject->sheet, 0, L_NAME_COL_INDEX    , 30, NULL);
    worksheet_set_column(stylSheetObject->sheet, 0, BIRTHDAY_COL_INDEX  , 30, NULL);

    stylAutotoolSampleTitle();

    stylSheetObject->rowCursor = 1;
}

void stylAutotoolSampleFinalize(void)
{
    g_return_if_fail(stylSheetObject!= NULL && stylSheetObject->book != NULL);

    workbook_close(stylSheetObject->book);
    g_slice_free(struct stylSheetObjectType_tr, stylSheetObject);
}

void stylAutotoolSamplePrint(gchar *firstName, gchar *lastName, gchar *birthDay)
{
    g_return_if_fail(firstName!=NULL && lastName!=NULL && birthDay!=NULL);

    lxw_worksheet   *workSheet  = stylSheetObject->sheet;
    lxw_format      *bold       = stylSheetObject->boldFormat;
    gint currentCursor          = stylSheetObject->rowCursor;

    worksheet_write_string(workSheet, currentCursor, F_NAME_COL_INDEX   , firstName , NULL);
    worksheet_write_string(workSheet, currentCursor, L_NAME_COL_INDEX   , lastName  , NULL);
    worksheet_write_string(workSheet, currentCursor, BIRTHDAY_COL_INDEX , birthDay , NULL);

    stylSheetObject->rowCursor++;
}

/**@}*/



