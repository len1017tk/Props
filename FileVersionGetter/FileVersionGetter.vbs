'*******************************************************************************
' FileVersionGetter.vbs
'*******************************************************************************
Option Explicit

' 定数宣言
Const InputFilePath       = "./"
Const InputFileName       = "SoftwareList"
Const InputFileExtension  = ".txt"
Const OutputFilePath      = "./"
Const OutputFileName      = "SoftwareVersion"
Const OutputFileExtension = ".txt"

' ファイルシステムオブジェクト
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

' インプットファイル
Dim inputFile
Set inputFile = fso.OpenTextFile(InputFilePath & _
                                 InputFileName & _
                                 InputFileExtension)

' アウトプットファイル
Dim outputFile
Set outputFile = fso.CreateTextFile(OutputFilePath & _
                                    OutputFileName & _
                                    "_" & Replace(Replace(Replace(Now(),"/",""),":","")," ","") & _
                                    OutputFileExtension)

'ファイルに現在の日付を書き込む
outputFile.WriteLine(Now)

Do Until inputFile.AtEndOfStream
    'ファイルから読み取り
    Dim strAry
    strAry = Split(inputFile.ReadLine,",")

    'レジストリからインストールパスを取得します。
    Dim installPath
    installPath = GetInstallPath(strAry(0), strAry(1))

    Dim ret
    If fso.FileExists(installPath) = true Then
        ret = fso.GetFileVersion(installPath)
    End If

    If Len(Trim(installPath)) > 0 Then
        outputFile.WriteLine(installPath)
        outputFile.WriteLine(ret)
    End If
Loop

inputFile.close
outputfile.close

Private Function GetInstallPath(exeName, regString)
    'レジストリへアクセスしてインストールパスを取得する。
    '取得できなかった場合はinstallPathは空白
    dim workInstallPath
    on error resume next
        workInstallPath = CreateObject("WScript.Shell").RegRead(regString)
    on error goto 0

    'レジストリから取得したパスにファイル名を結合する。
    If Len(Trim(workInstallPath)) > 0 Then
        If Right(workInstallPath, 1)<> chrw(92) Then
            workInstallPath = workInstallPath & chrw(92) & exeName
        Else
            workInstallPath = workInstallPath & exeName
        End If
    End If

    GetInstallPath = workInstallPath
End Function