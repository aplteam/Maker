; This script is needed by Maker's tests

#define MyAppName "Firlefanz"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "APL Team Ltd"
#define TargetDir "C:\Users\kai\AppData\Local\Temp\kai_131131807.tmp"
#define MyBlank " "

[SetUp]

AppName="{#MyAppName}"
AppVersion={#MyAppVersion}
AppVerName={#MyAppName}{#MyBlank}{#MyAppVersion}
DefaultDirName={pf32}\{#MyAppPublisher}\{#MyAppName}

[Files]
Source: "This_shold_not_exist"; DestDir: "{commonappdata}\{#MyAppName}";