/*----------------------------------------------------------------------------
 HMG - Harbour Windows GUI library source code

 Copyright 2002-2017 Roberto Lopez <mail.box.hmg@gmail.com>
 http://sites.google.com/site/hmgweb/

 Head of HMG project:

      2002-2012 Roberto Lopez <mail.box.hmg@gmail.com>
      http://sites.google.com/site/hmgweb/

      2012-2017 Dr. Claudio Soto <srvet@adinet.com.uy>
      http://srvet.blogspot.com

 This program is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free Software
 Foundation; either version 2 of the License, or (at your option) any later
 version.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License along with
 this software; see the file COPYING. If not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA (or
 visit the web site http://www.gnu.org/).

 As a special exception, you have permission for additional uses of the text
 contained in this release of HMG.

 The exception is that, if you link the HMG library with other
 files to produce an executable, this does not by itself cause the resulting
 executable to be covered by the GNU General Public License.
 Your use of that executable is in no way restricted on account of linking the
 HMG library code into it.

 Parts of this project are based upon:

	"Harbour GUI framework for Win32"
 	Copyright 2001 Alexander S.Kresin <alex@belacy.belgorod.su>
 	Copyright 2001 Antonio Linares <alinares@fivetech.com>
	www - http://www.harbour-project.org

	"Harbour Project"
	Copyright 1999-2008, http://www.harbour-project.org/

	"WHAT32"
	Copyright 2002 AJ Wos <andrwos@aust1.net>

	"HWGUI"
  	Copyright 2001-2008 Alexander S.Kresin <alex@belacy.belgorod.su>

---------------------------------------------------------------------------*/
MEMVAR _HMG_SYSDATA
#include "hmg.ch"
#include "common.ch"
*-----------------------------------------------------------------------------*
Function _DefineSpinner ( ControlName, ParentForm, x, y, w, value ,fontname, ;
                          fontsize, RangeMin, RangeMax, tooltip, change, lostfocus, ;
                          gotfocus, h, HelpId, invisible, notabstop , bold, ;
                          italic, underline, strikeout, wrap, readonly, increment , backcolor , fontcolor )
*-----------------------------------------------------------------------------*
Local cParentForm , RetArray , mVar , k
Local ControlHandle
Local FontHandle


   DEFAULT RangeMin     TO  - 2147483648   // 0x80000000
   DEFAULT RangeMax     TO  2147483647     // 0x7FFFFFFF

   DEFAULT w         TO 120
   DEFAULT h         TO 24
   DEFAULT value     TO RangeMin
   DEFAULT change    TO ""
   DEFAULT lostfocus TO ""
   DEFAULT gotfocus  TO ""
   DEFAULT invisible TO FALSE
   DEFAULT notabstop TO FALSE
   DEFAULT wrap      TO FALSE
   DEFAULT readonly  TO FALSE
   DEFAULT increment TO 1

	if _HMG_SYSDATA [ 264 ] = .T.
		ParentForm := _HMG_SYSDATA [ 223 ]
		if .Not. Empty (_HMG_SYSDATA [ 224 ]) .And. ValType(FontName) == "U"
			FontName := _HMG_SYSDATA [ 224 ]
		EndIf
		if .Not. Empty (_HMG_SYSDATA [ 182 ]) .And. ValType(FontSize) == "U"
			FontSize := _HMG_SYSDATA [ 182 ]
		EndIf
	endif
	if _HMG_SYSDATA [ 183 ] > 0
		IF _HMG_SYSDATA [ 240 ] == .F.
		x 	:= x + _HMG_SYSDATA [ 334 ] [_HMG_SYSDATA [ 183 ]]
		y 	:= y + _HMG_SYSDATA [ 333 ] [_HMG_SYSDATA [ 183 ]]
		ParentForm := _HMG_SYSDATA [ 332 ] [_HMG_SYSDATA [ 183 ]]
		ENDIF
	EndIf

	If .Not. _IsWindowDefined (ParentForm)
		MsgHMGError("Window: "+ ParentForm + " is not defined. Program terminated")
	Endif

	If _IsControlDefined (ControlName,ParentForm)
		MsgHMGError ("Control: " + ControlName + " Of " + ParentForm + " Already defined. Program Terminated")
	endif

	mVar := '_' + ParentForm + '_' + ControlName

	cParentForm := ParentForm

	ParentForm = GetFormHandle (ParentForm)

	RetArray := InitSpinner ( ParentForm, 0, x, y, w , '' , 0 , RangeMin, RangeMax , h, invisible, notabstop, wrap, readonly )

	ControlHandle := RetArray [1]

	if ValType(fontname) != "U" .and. ValType(fontsize) != "U"
		FontHandle := _SetFont (ControlHandle,FontName,FontSize,bold,italic,underline,strikeout)
	Else
		FontHandle := _SetFont (ControlHandle,_HMG_SYSDATA [ 342 ],_HMG_SYSDATA [ 343 ],bold,italic,underline,strikeout)
	endif

	If _HMG_SYSDATA [ 265 ] = .T.
		aAdd ( _HMG_SYSDATA [ 142 ] , RetArray )
	EndIf

	if ValType(tooltip) != "U"
		SetToolTip ( ControlHandle , tooltip , GetFormToolTipHandle (cParentForm) )
	endif

	k := _GetControlFree()

	Public &mVar. := k

	_HMG_SYSDATA [1] [k] := "SPINNER"
	_HMG_SYSDATA [2]  [k] :=  ControlName
	_HMG_SYSDATA [3] [k] :=   RetArray
	_HMG_SYSDATA [4] [k] :=   ParentForm
	_HMG_SYSDATA [  5 ]  [k] :=  0
	_HMG_SYSDATA [  6 ]  [k] :=  ""
	_HMG_SYSDATA [  7 ]  [k] :=  {}
	_HMG_SYSDATA [  8 ]  [k] :=  0
	_HMG_SYSDATA [  9 ]  [k] :=  ""
	_HMG_SYSDATA [ 10 ]  [k] :=  lostfocus
	_HMG_SYSDATA [ 11 ] [k] :=   gotfocus
	_HMG_SYSDATA [ 12 ]  [k] :=  change
	_HMG_SYSDATA [ 13 ]  [k] :=  .F.
	_HMG_SYSDATA [ 14 ]  [k] :=  backcolor
	_HMG_SYSDATA [ 15 ]  [k] :=  fontcolor
	_HMG_SYSDATA [ 16 ]  [k] :=  ""
	_HMG_SYSDATA [ 17 ]  [k] :=  {}
	_HMG_SYSDATA [ 18 ] [k] :=   y
	_HMG_SYSDATA [ 19 ]  [k] :=  x
	_HMG_SYSDATA [ 20 ]  [k] :=  w
	_HMG_SYSDATA [ 21 ]   [k] := h
	_HMG_SYSDATA [ 22 ]  [k] :=  0
	_HMG_SYSDATA [ 23 ]  [k] :=  iif ( _HMG_SYSDATA [ 183 ] > 0 ,_HMG_SYSDATA [ 333 ] [_HMG_SYSDATA [ 183 ]] , -1 )
	_HMG_SYSDATA [ 24 ]  [k] :=  iif ( _HMG_SYSDATA [ 183 ] > 0 ,_HMG_SYSDATA [ 334 ] [_HMG_SYSDATA [ 183 ]] , -1 )
	_HMG_SYSDATA [ 25 ]  [k] :=  ""
	_HMG_SYSDATA [ 26 ]  [k] :=  0
	_HMG_SYSDATA [ 27 ] [k] :=   fontname
	_HMG_SYSDATA [ 28 ]  [k] :=  fontsize
	_HMG_SYSDATA [ 29 ]  [k] :=  {bold,italic,underline,strikeout}
	_HMG_SYSDATA [ 30 ]  [k] :=   tooltip
	_HMG_SYSDATA [ 31 ]  [k] :=   RangeMin
	_HMG_SYSDATA [ 32 ]  [k] :=   RangeMax
	_HMG_SYSDATA [ 33 ]  [k] :=   ''
	_HMG_SYSDATA [ 34 ]  [k] :=   if(invisible,FALSE,TRUE)
	_HMG_SYSDATA [ 35 ]  [k] :=   HelpId
	_HMG_SYSDATA [ 36 ]  [k] :=   FontHandle
	_HMG_SYSDATA [ 37 ]  [k] :=   0
	_HMG_SYSDATA [ 38 ]  [k] :=   .T.
	_HMG_SYSDATA [ 39 ] [k] := 0
	_HMG_SYSDATA [ 40 ] [k] := { NIL , NIL , NIL , NIL , NIL , NIL , NIL , NIL }

	if ValType(value) == "N"
		SetSpinnerValue ( RetArray [2] , Value )
	endif

	if increment <> 1
	   SetSpinnerIncrement( RetArray[2], increment )
	endif

Return Nil

