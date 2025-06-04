; SingleInstance stops the dialog box from opening on each update
#SingleInstance Force
;
; shift+alt d: insert the current date
current_date := FormatTime(A_Now, 'MMM dd yyyy HH:mm')
+!d::Send current_date
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UPDATE THESE VARS WITH EACH NEW CATALOG!  ;
; ----------------------------------------------------;
publication := "15 Apr 2025 6:55 AM"
expiry := "14 July 2025 6:55 PM"
breadcrumb := "-25su"
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
