# Set output folder, interval, and iteration count
$outputFolder = "path"  # 資料夾路徑
$interval = 3  # 截圖間隔 (秒)
$iterations = 500  # 執行的總次數 (截圖次數)

# Set screenshot area
$x = 301       # 截圖區域左上角 x 座標
$y = 138       # 截圖區域左上角 y 座標
$width = 1615-301  # 截圖區域寬度
$height = 1009-138  # 截圖區域高度

# Check and create output folder
if (!(Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# Import required .NET classes
$code = @"
using System;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;
using System.Windows.Forms;

public class Screenshot {
    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);

    [DllImport("user32.dll")]
    public static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, int dwExtraInfo);

    public struct POINT {
        public int X;
        public int Y;
    }

    public static void CaptureScreen(string filename, int x, int y, int width, int height) {
        using (Bitmap bmp = new Bitmap(width, height)) {
            using (Graphics g = Graphics.FromImage(bmp)) {
                g.CopyFromScreen(x, y, 0, 0, bmp.Size);
            }
            bmp.Save(filename, ImageFormat.Png);
        }
    }

    public static void ClickMouse(int x, int y) {
        Cursor.Position = new Point(x, y);
        mouse_event(0x0002 | 0x0004, (uint)x, (uint)y, 0, 0); // MOUSEEVENTF_LEFTDOWN | MOUSEEVENTF_LEFTUP
    }
}
"@

Add-Type -TypeDefinition $code -ReferencedAssemblies System.Windows.Forms, System.Drawing

# Define mouse position
$mouseX = 1890  # 模擬點擊的 x 座標
$mouseY = 575   # 模擬點擊的 y 座標

# Start from 0
$count = 0

while ($count -lt $iterations) {
    # Simulate mouse click
    [Screenshot]::ClickMouse($mouseX, $mouseY)

    # Generate timestamp and capture screenshot
    $timestamp = (Get-Date -Format "yyyyMMdd_HHmmss")
    $screenshotPath = Join-Path $outputFolder "screenshot_$timestamp.png"
    [Screenshot]::CaptureScreen($screenshotPath, $x, $y, $width, $height)
    Write-Output "Screenshot $count saved to $screenshotPath"

    # Wait interval
    Start-Sleep -Seconds $interval
    $count++
}

Write-Output "Screenshot capture completed. Total iterations: $iterations"
