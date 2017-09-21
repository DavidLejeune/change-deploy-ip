wscript.echo "      ____              __        "
wscript.echo "     / __ \   ____ _   / /      ___ "
wscript.echo "    / / / /  / __ `/  / /      / _ \"
wscript.echo "   / /_/ /  / /_/ /  / /___   /  __/"
wscript.echo "  /_____/   \__,_/  /_____/   \___/ "
wscript.echo ""
wscript.echo "    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+"
wscript.echo "    |L|i|n|u|x|s|h|e|l|l| |C|L|I|"
wscript.echo "    +-+-+-+-+-+-+-+-+-+-+ +-+-+-+"
wscript.echo ""
wscript.echo "  >> Author : David Lejeune"
wscript.echo "  >> Created : 19/09/2017"
wscript.echo ""
wscript.echo " ###################################"
wscript.echo " #      AUTOMATIC IP CHANGER       #"
wscript.echo " #       FOR CI DEPLOYMENTS        #"
wscript.echo " ###################################"
wscript.echo ""

Set fso = CreateObject("Scripting.FileSystemObject")


' FUNCTIONS ----------------------------------------------
Function ReportFolderStatus(fldr)
   Dim fso, msg
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FolderExists(fldr)) Then
      msg = fldr & " exists."
   Else
      msg = fldr & " doesn't exist."
   End If
   Wscript.echo msg
End Function


Function CreateUpdateScript(strCommands)
Set objFSO=CreateObject("Scripting.FileSystemObject")

' How to write file
Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.Write strCommands
objFile.Close

End Function

Function AddCommands(strRepo)
strCommands = strCommands & "pwd" & vbCrlf
strCommands = strCommands & "cd " & strGitDir & strRepo & vbCrlf
strCommands = strCommands & "git diff" & vbCrlf
strCommands = strCommands & "git checkout " & strBranch & vbCrlf
strCommands = strCommands & "git pull origin " & strBranch & vbCrlf
strCommands = strCommands & "rm deploy-to-ip.txt" & vbCrlf
strCommands = strCommands & "Set-Content .\deploy-to-ip.txt " & """" & strIP & """" & vbCrlf
strCommands = strCommands & "git add ." & vbCrlf
strCommands = strCommands & "git commit -a -m " & """" & "Deployment ip is now " & strIP & """" & vbCrlf
strCommands = strCommands & "git push origin " & strBranch & vbCrlf
strCommands = strCommands & "echo " & """" & "------------------------------------" & """" & vbCrlf


End Function

' -------------------------------------------------------

' VARIABLES ----------------------------------------------
strWeb = "angular-client"
strDB = "django-mqtt-server"
strEngine = "vmnengine"

outFile= strCurDir & "update-ip.ps1"
' -------------------------------------------------------



wscript.echo ""
wscript.echo "Note :"
wscript.echo "For this to work all neccessary folders must reside under"
wscript.echo "the same parent folder."
wscript.echo "ex. parent folder structure"
wscript.echo "GIT/"
wscript.echo " |-- " & strWeb & "/"
wscript.echo " |-- " & strDB & "/"
wscript.echo " |-- " & strEngine & "/"
wscript.echo " |-- change-deploy-ip  (this repo)"




Dim WshShell, strCurDir
Set WshShell = CreateObject("WScript.Shell")
strCurDir    = WshShell.CurrentDirectory & "\"

Wscript.echo ""
Wscript.echo "Current directory : " & strCurDir
strGitDir = Replace(strCurDir,"change-deploy-ip\","")
Wscript.echo "Repository parent folder : " & strGitDir

strWeb = "angular-client"
strDB = "django-mqtt-server"
strEngine = "vmnengine"

Wscript.echo ""
Wscript.echo "Checking if repository folders exist"
ReportFolderStatus(strGitDir & strWeb)
ReportFolderStatus(strGitDir & strDB)
ReportFolderStatus(strGitDir & strEngine)

strBranch = ""
Wscript.echo ""
Wscript.echo "Do you want to change the ip for the master or develop branch?"
Wscript.echo "Press 1 for Master branch"
Wscript.echo "Press 2 for Develop branch"
WScript.StdOut.Write("Make your choice and press [ENTER] > ")
WScript.StdIn.Read(0)
strInput = WScript.StdIn.ReadLine()
if (strInput = 1) Then
  strBranch = "master"
elseif (strInput = 2) Then
  strBranch = "develop"
Else
  wscript.echo "Learn to type you imbecile"
  strBranch = "to be an idiot"
end if
WScript.Echo "You chose : " & strBranch
wscript.echo

wscript.echo "Now select the repo's for which to update the ip address"
wscript.echo "To select simply add the values for each repo"
wscript.echo "ex. all repos = 7"
wscript.echo "1 > " & strWeb
wscript.echo "2 > " & strDB
wscript.echo "4 > " & strEngine
WScript.StdOut.Write("Make your choice and press [ENTER] > ")
WScript.StdIn.Read(0)
strInput = WScript.StdIn.ReadLine()


wscript.echo ""
WScript.StdOut.Write("What is the new ip address to deploy to and press [ENTER] > ")
WScript.StdIn.Read(0)
strIP = WScript.StdIn.ReadLine()

strCommands = ""
Select Case strInput
Case 1
	wscript.echo "You chose " & strWeb
  AddCommands(strWeb)
Case 2
	wscript.echo "You chose " & strDB
  AddCommands(strDB)
Case 3
	wscript.echo "You chose " & strWeb
  AddCommands(strWeb)

  wscript.echo "You chose " & strDB
  AddCommands(strDB)

Case 4
	wscript.echo "You chose " & strEngine
  AddCommands(strEngine)

Case 5
	wscript.echo "You chose " & strWeb
  AddCommands(strWeb)

  wscript.echo "You chose " & strEngine
  AddCommands(strEngine)

Case 6
	wscript.echo "You chose " & strDB
  AddCommands(strDB)

  wscript.echo "You chose " & strEngine
  AddCommands(strEngine)

Case 7
	wscript.echo "You chose " & strWeb
  AddCommands(strWeb)

	wscript.echo "You chose " & strDB
  AddCommands(strDB)

  wscript.echo "You chose " & strEngine
  AddCommands(strEngine)

Case else
  wscript.echo "You aren't the brighest light in the candle shop are you ?!?!"
End Select

CreateUpdateScript(strCommands)
WshShell.Run("powershell.exe -noexit ./update-ip.ps1")

Set WshShell = Nothing
