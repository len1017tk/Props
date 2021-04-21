'*************************************************
'* ソフトウェアバージョン確認スクリプト
'* softwareList.txtを参照して
'* 端末にインストールされたソフトウェアのバージョンを取得します。
'*************************************************

Option Explicit

Dim fso
set fso = CreateObject("Scripting.FileSystemObject")

Dim inputFile
set inputFile = fso.OpenTextFile("./SoftwareList.txt")

Dim outputFileName
outputFileName = "./SoftwareVersion" & Replace(Replace(Replace(Now(),"/",""),":","")," ","")& ".txt"
Dim outputFile
Set outputFile = fso.CreateObject(outputFileName)

'ファイルに現在の日付を書き込む
outputFile.writeLine(now)

do until inputFile.AtEndOfStream
    dim lineStr
    dim aryStr
    lineStr = inputFile.readLine
    aryStr = Split(lineStr,",")

    'レジストリからインストールパスを取得します。
    dim install_path
    install_path = getInstallPath(aryStr(0), aryStr(1))

    dim ret
    if fso.FileExists(install_path) = true then
        ret = fso.getFileVersion(install_path)
    end if

    if len(trim(install_path)) > 0 then
        outputFile.writeLine(install_path)
        outputFile.writeLine(ret)
    end if
loop
inputFile.close
outputfile.close

private function getInstallPath(exeName, regString)
    'レジストリへアクセスしてインストールパスを取得する。
    '取得できなかった場合はinstall_pathは空白
    dim workInstallPath
    on error resume next
        workInstallPath = CreateObject("WScript.Shell").regRead(regString)
    on error goto 0

    'レジストリから取得したパスにファイル名を結合する。
    if len(trime(workInstallPath)) > 0 then
        if right(workInstallPath, 1)<> chrw(92) then
            workInstallPath = workInstallPath & chrw(92) & exeName
        else
            workInstallPath = workInstallPath & exeName
        end if
    end if

    getInstallPath = workInstallPath
end function