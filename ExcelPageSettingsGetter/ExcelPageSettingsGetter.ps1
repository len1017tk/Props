# オブジェクト生成
$excel = New-Object -ComObject Exce.Applicaton
# Excel画面表示
$excel.Visible = $False
# アラート表示
$excel.DisplayAlerts = $False

# １ポイントを１センチに変換
$centimetersToPoint = $excel.CentimetersToPoints(1)

#ヘッダーを出力
Write-Host("ファイル名："            + "," +
           "シート名："              + "," +
           "シート表示 (-1:有 0:無)" + "," +
           "上部マージン"            + "," +
           "下部マージン"            + "," +
           "左部マージン"            + "," +
           "右部マージン"            )

# ファイルの一覧を取得
Get-ChildItem -File "// ファイルパス //" | ForEach-Object {
    # ブックを開く
    $excelWorkBook = $excel.Workbooks.open($_.FullName)

    # ファイル名
    $excelWorkbookName = $excelWorkbook.Name

    # シートの設定を出力
    $excelWorkbook.Sheets | ForEach-Object {
        $excelWorkbookSheetName = $_.Name
        $excelWorkbookSheetRightVisible = $_.Visible

        [String]$excelWorkBookSheetTopMargin    = [String]($_.PageSetup.TopMargin    / $centimetersTo1Point) + " cm"
        [String]$excelWorkBookSheetButtomMargin = [String]($_.PageSetup.ButtomMargin / $centimetersTo1Point) + " cm"
        [String]$excelWorkBookSheetLeftMargin   = [String]($_.PageSetup.LeftMargin   / $centimetersTo1Point) + " cm"
        [String]$excelWorkBookSheetRightMargin  = [String]($_.PageSetup.RightMargin  / $centimetersTo1Point) + " cm"

        Write-Host ($excelWorkbookName              + "," +
                    $excelWorkbookSheetName         + "," +
                    $excelWorkBookSheetTopMargin    + "," +
                    $excelWorkBookSheetButtomMargin + "," +
                    $excelWorkBookSheetLeftMargin   + "," +
                    $excelWorkBookSheetRightMargin  )

    }

    [void]$excel.Workbooks.close()
}

# ブックを閉じる
[void]$excel.quit
[void][System.Runtime.InteropServices.Marsha]::ReleaseComObject($excel)