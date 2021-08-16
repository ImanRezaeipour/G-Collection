// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__293E53DB_C3F5_4AF2_9436_CA4F049B5101__INCLUDED_)
#define AFX_STDAFX_H__293E53DB_C3F5_4AF2_9436_CA4F049B5101__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers

#include <stdio.h>

//Needed for CWinSock2Async
#include <Winsock2.h>
#include "Winsock2Async.h"
#include <windows.h>								//Not necessary if using MFC
#include <TChar.h>									//..
#include <assert.h>									//..


// TODO: reference additional headers your program requires here

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__293E53DB_C3F5_4AF2_9436_CA4F049B5101__INCLUDED_)
