Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class GetMousePosition {
    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);

    public struct POINT {
        public int X;
        public int Y;
    }

    public static POINT GetCursorPosition() {
        POINT lpPoint;
        GetCursorPos(out lpPoint);
        return lpPoint;
    }
}
"@

while ($true) {
    $pos = [GetMousePosition]::GetCursorPosition()
    Write-Output "X: $($pos.X), Y: $($pos.Y)"
    Start-Sleep -Seconds 1
}
