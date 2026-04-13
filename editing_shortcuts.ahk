; SingleInstance stops the dialog box from opening on each update
#SingleInstance Force
;
; shift+alt d: insert the current date
current_date := FormatTime(A_Now, 'MMM dd yyyy HH:mm')
+!d::Send current_date
; ----------------------------------------------------;
; type "#confcc" to paste the confirmation text below when updating CC lists.
:*T:#confcc::Thanks, confirming <> has been added to the Personal Enrichment newsletter list.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UPDATE THESE VARS WITH EACH NEW CATALOG!  ;
; ----------------------------------------------------;
publication := "14 Apr 2026 6:55 AM"
expiry := "14 Jul 2026 6:55 PM"
breadcrumb := "-26su"
;-----------------------------------------------------;
; Work-Specific Editing Shortcuts
; ----------------------------------------------------;
; shift+ctrl s: publish date for courses
+^s::Send publication
; shift+ctrl e: expiration date for courses
+^e::Send expiry
; shift+ctrl b: insert "breadcrumb" into course title
+^b::Send breadcrumb
; shift+ctrl n: add *NEW!* to course titles
+^n::Send " *NEW{!}*"
; shift+ctrl o: paste " online"
+^o:: Send " online"
; alt+ctrl g: paste " online-$breadcrumb" eg. "online-26WS"
+^g:: Send " online" . breadcrumb
; alt+ctrl o: paste " (online)"
!^o:: Send " (online)"
; shift+ctrl f: paste " Flex Online"
+^f:: Send "Flex Online"
;
; alt-hyphen to replace hyphens with emdashes in clipboard text
!-::
{
  Clip0 := ClipBoardAll()
  A_ClipBoard := StrReplace(A_ClipBoard, "-", "–")
  Send "^v"
  Sleep 300
  A_ClipBoard := Clip0
  ObjSetCapacity(Clip0, 0)
  Return
}
;
; alt-r: paste "Register" for newsletter course buttons
!r:: Send "Register"
{
   Clip0 := ClipBoardAll()
   A_ClipBoard := StrReplace(A_ClipBoard, "-", "–")
   Send "^v"
   Sleep 300
   A_ClipBoard := Clip0
   ObjSetCapacity(Clip0, 0)
   Return
}
;
; alt-v: paste text from the clipboard without new lines
!v::
{
   Clip0 := ClipBoardAll()
   A_ClipBoard := StrReplace(A_ClipBoard, "`r", "")
   A_ClipBoard := StrReplace(A_ClipBoard, "`n", " ")
   Send "^v"
   Sleep 300
   A_ClipBoard := Clip0
   ObjSetCapacity(Clip0, 0)
   Return
}
;
; ----------------------------
; Upper / Lower / Title Case cliboard text
; from https://www.autohotkey.com/boards/viewtopic.php?style=1&p=553731#p553731
ClipboardPasteUppercase(*) {
  A_Clipboard := ""
  SendInput("^c")
  if (!ClipWait(1, 1))
    return
  str := A_Clipboard
  if (str == "")
    return
  A_Clipboard := format("{:U}", str)
  if (!ClipWait(0.5, 0))
    return
  SendInput("^v")
  Sleep(500)
}
ClipboardPasteLowercase(*) {
  A_Clipboard := ""
  SendInput("^c")
  if (!ClipWait(1, 1))
    return
  str := A_Clipboard
  if (str == "")
    return
  A_Clipboard := format("{:l}", str)
  if (!ClipWait(0.5, 0))
    return
  SendInput("^v")
  Sleep(500)
}
ClipboardPasteTitlecase(*) {
  A_Clipboard := ""
  SendInput("^c")
  if (!ClipWait(1, 1))
    return
  str := A_Clipboard
  if (str == "")
    return
  A_Clipboard := format("{:T}", str)
  if (!ClipWait(0.5, 0))
    return
  SendInput("^v")
  Sleep(500)
}
ClipboardPasteSentenceCase(*) {
  A_Clipboard := ""
  SendInput("^c")
  if (!ClipWait(1, 1))
    return
  str := A_Clipboard
  if (str == "")
    return
  A_Clipboard := RegExReplace(str, "(?:^|\.|\R)[- 0-9\*\(]*\K(.)([^\.\r\n]*)", "$U1$L2")
  if (!ClipWait(0.5, 0))
    return
  SendInput("^v")
  Sleep(500)
}
+^u::ClipboardPasteUppercase()
+^l::ClipboardPasteLowercase()
+^t::ClipboardPasteTitlecase()
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Emulate MacOS
;-----------------
;
; remap capslock to control
; this does not work in VSCode for some reason
SetCapsLockState false
SetStoreCapsLockMode false
CapsLock::Control
;
; ctrl-a or ctrl-LArrow to move to start of line
^a:: Send "{Home}"
^Left:: Send "{Home}"
;
; ctrl-e or ctrl-RArrow to move to end of line
^e:: Send "{End}"
^Right:: Send "{End}"
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Attempt to auto-save in Word
; note: 1) sometimes adds "s" to text
;       2) sometimes triggers save in other apps
;
; SetTimer AutoSaveWord, 1000

; AutoSaveWord()
; {
;   if not WinExist("Word") {
;     return
;   }
;   if WinWaitActive("Word") {
;     SetKeyDelay 1000
;     Send "{Ctrl Down}"
;     Send "{s}"
;     Send "{Ctrl Up}"
;   }
; }
