# Auto_Screenshot.ps1

這個 PowerShell 腳本用於定期模擬滑鼠點擊並捕捉螢幕區域的截圖，並將截圖儲存到指定的資料夾中。您可以根據需求調整一些關鍵變數，如儲存路徑、截圖區域、點擊的滑鼠位置等。

## 腳本功能

- **自動模擬滑鼠點擊**：根據指定的位置模擬滑鼠點擊。
- **截取螢幕區域**：根據設定的區域截取螢幕，並保存為 PNG 圖片。
- **定期執行**：每次截圖後，等待指定的間隔時間再進行下一次操作。

## 變數設定

腳本中包含以下變數，您可以根據需要進行調整：

```powershell
# Set output folder, interval, and iteration count
$outputFolder = "path"  # 資料夾路徑
$interval = 3  # 截圖間隔 (秒)
$iterations = 500  # 執行的總次數 (截圖次數)

# Set screenshot area
$x = 301       # 截圖區域左上角 x 座標
$y = 138       # 截圖區域左上角 y 座標
$width = 1615-301  # 截圖區域寬度
$height = 1009-138  # 截圖區域高度
$mouseX = 1890  # 模擬點擊的 x 座標
$mouseY = 575   # 模擬點擊的 y 座標
