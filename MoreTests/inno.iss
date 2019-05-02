; This script is needed by Maker's tests

#define MyAppName "Firlefanz"
#define MyAppVersion "1.0.0"
#define TargetDir "C:\Users\kai\AppData\Local\Temp\kai_131131807.tmp"

[Files]
Source: "This_shold_not_exist"; DestDir: "{commonappdata}\{#MyAppName}";