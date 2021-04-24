'*******************************************************************************
' FileVersionGetter.vbs
'*******************************************************************************
Option Explicit

' �萔�錾
Const InputFilePath       = "./"
Const InputFileName       = "SoftwareList"
Const InputFileExtension  = ".txt"
Const OutputFilePath      = "./"
Const OutputFileName      = "SoftwareVersion"
Const OutputFileExtension = ".txt"

' �t�@�C���V�X�e���I�u�W�F�N�g
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

' �C���v�b�g�t�@�C��
Dim inputFile
Set inputFile = fso.OpenTextFile(InputFilePath & _
                                 InputFileName & _
                                 InputFileExtension)

' �A�E�g�v�b�g�t�@�C��
Dim outputFile
Set outputFile = fso.CreateTextFile(OutputFilePath & _
                                    OutputFileName & _
                                    "_" & Replace(Replace(Replace(Now(),"/",""),":","")," ","") & _
                                    OutputFileExtension)

'�t�@�C���Ɍ��݂̓��t����������
outputFile.WriteLine(Now)

Do Until inputFile.AtEndOfStream
    '�t�@�C������ǂݎ��
    Dim strAry
    strAry = Split(inputFile.ReadLine,",")

    '���W�X�g������C���X�g�[���p�X���擾���܂��B
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
    '���W�X�g���փA�N�Z�X���ăC���X�g�[���p�X���擾����B
    '�擾�ł��Ȃ������ꍇ��installPath�͋�
    dim workInstallPath
    on error resume next
        workInstallPath = CreateObject("WScript.Shell").RegRead(regString)
    on error goto 0

    '���W�X�g������擾�����p�X�Ƀt�@�C��������������B
    If Len(Trim(workInstallPath)) > 0 Then
        If Right(workInstallPath, 1)<> chrw(92) Then
            workInstallPath = workInstallPath & chrw(92) & exeName
        Else
            workInstallPath = workInstallPath & exeName
        End If
    End If

    GetInstallPath = workInstallPath
End Function