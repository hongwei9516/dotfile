#Requires AutoHotkey v2.0
; 禁用 CapsLock 键的默认大小写切换功能
*CapsLock::Return

CapsLock & h:: Send "{Left}"
CapsLock & j:: Send "{Down}"
CapsLock & k:: Send "{Up}"
CapsLock & l:: Send "{Right}"

; explorer
CapsLock & r::
{
    if WinExist("ahk_class CabinetWClass")
        WinActivate "ahk_class CabinetWClass"
    else
        Run "explorer.exe"
    WinWait "ahk_class CabinetWClass"
    WinActivate "ahk_class CabinetWClass"
}

; Chrome
CapsLock & g::
{
    if WinExist("ahk_exe chrome.exe")
        WinActivate "ahk_exe chrome.exe"
    else
        Run "chrome.exe"
    WinWait "ahk_exe chrome.exe"
    WinActivate "ahk_exe chrome.exe"
}

; VS Code
CapsLock & c::
{
    if WinExist("ahk_exe Code.exe")
        WinActivate "ahk_exe Code.exe"
    else
        Run '"D:\Microsoft VS Code\Code.exe"'
    WinWait "ahk_exe Code.exe"
    WinActivate "ahk_exe Code.exe"
}

; Windows Terminal
CapsLock & t::
{
    if WinExist("ahk_exe WindowsTerminal.exe")
        WinActivate "ahk_exe WindowsTerminal.exe"
    else
        Run "wt.exe"
    WinWait "ahk_exe WindowsTerminal.exe"
    WinActivate "ahk_exe WindowsTerminal.exe"
}

CapsLock & u::
{
    ; 定义注册表路径和键名
    local keyPath := "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    local appsKeyName := "AppsUseLightTheme"
    local systemKeyName := "SystemUsesLightTheme"

    ; 读取当前应用程序主题设置 (0 = 深色, 1 = 浅色)
    local currentAppsTheme := RegRead(keyPath, systemKeyName)

    ; 判断当前模式并切换
    if (currentAppsTheme == 1) {
        ; --- 切换到深色模式 ---
        Send "+!#d" ; 切换到深色模式
    }
    else {
        ; --- 切换到浅色模式 ---
        Send "+!#l" ; 切换到浅色模式
    }
}

CapsLock & n::
{
    ; 定义注册表路径和键名
    local keyPath := "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    local appsKeyName := "AppsUseLightTheme"
    local systemKeyName := "SystemUsesLightTheme"

    ; 读取当前应用程序主题设置 (0 = 深色, 1 = 浅色)
    local currentAppsTheme := RegRead(keyPath, appsKeyName)

    ; 判断当前模式并切换
    if (currentAppsTheme == 1) {
        ; --- 切换到深色模式 ---
        ; 将应用程序主题设置为深色 (值为 0)
        RegWrite(0, "REG_DWORD", keyPath, appsKeyName)
        ; 将系统主题设置为深色 (值为 0)
        RegWrite(0, "REG_DWORD", keyPath, systemKeyName)
    }
    else {
        ; --- 切换到浅色模式 ---
        ; 将应用程序主题设置为浅色 (值为 1)
        RegWrite(1, "REG_DWORD", keyPath, appsKeyName)
        ; 将系统主题设置为浅色 (值为 1)
        RegWrite(1, "REG_DWORD", keyPath, systemKeyName)
    }
}

^Enter::
{
    ; 获取当前活动窗口的标题
    activeWinTitle := WinGetTitle("A")

    ; 如果成功获取到标题，继续执行
    if (activeWinTitle) {
        ; 获取窗口的最小化或最大化状态
        state := WinGetMinMax(activeWinTitle)

        ; 如果窗口不是最大化 (状态为0或-1)，则将其最大化
        if (state == 0 or state == -1) {
            WinMaximize(activeWinTitle)
        }
        ; 如果窗口是最大化 (状态为1)，则将其还原
        else if (state == 1) {
            WinRestore(activeWinTitle)
        }
    }
}

CapsLock & m::
{
    static ABM_SETSTATE := 0xA, ABS_AUTOHIDE := 0x1, ABS_ALWAYSONTOP := 0x2
    static hide := 0
    hide := !hide
    APPBARDATA := Buffer(size := 2 * A_PtrSize + 2 * 4 + 16 + A_PtrSize, 0)
    NumPut("UInt", size, APPBARDATA), NumPut("Ptr", WinExist("ahk_class Shell_TrayWnd"), APPBARDATA, A_PtrSize)
    NumPut("UInt", hide ? ABS_AUTOHIDE : ABS_ALWAYSONTOP, APPBARDATA, size - A_PtrSize)
    DllCall("Shell32\SHAppBarMessage", "UInt", ABM_SETSTATE, "Ptr", APPBARDATA)
}

^++BS::FileRecycleEmpty()