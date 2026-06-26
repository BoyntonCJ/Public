Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = "SilentlyContinue"
$script:Version = "6.6"
$script:ComputerName = $env:COMPUTERNAME
$script:Username = $env:USERNAME

############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####
####    GuruTune - Read Me
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####
####	NAME:		GuruTune
#### 	AUTHOR:		Charles Boynton (Guru)
#### 	DATE:		06/03/2024
#### 	EMAIL:		GuruTecLLC@Gmail.com
#### 	SYNOPSIS:   Tunes numerous settings to increase Windows 11 systen responsiveness 
####
#### 	VERSION HISTORY:
#### 	    Ver: 0; Ver Date: 06/03/2024; Initial Version
#### 	    Ver: 1; Ver Date: 04/10/2025; Initial 'Stripped' Version
#### 	    Ver: 2; Ver Date: 07/22/2025; Added Additional changes to Service Startup Type, added exit messages
#### 	    Ver: 2.1; Ver Date: 08/01/2025; Changed XBox services to Manual from Disabled
#### 	    Ver: 3; Ver Date: 08/09/2025; Adding in Cache clearing, Log-Me, Set-RegKey, Reporting tasks, Restore Point creations
####		     Added Numerous Additional Settings
#### 	    Ver: 3.1; Ver Date: 09/07/2025; Re-adding in minimum time between restore points, Removing Update Reporting
####		     Added Reporting of services orig state, Removed Disk Caching settings, added Set-Service
#### 	    Ver: 3.1.1; Ver Date: 09/16/2025; Minor corrections to Set-Service - $Name Help Message
#### 	    Ver: 4; Ver Date: 09/17/2025; Numerous changes to settings and structure to improve performance increase.
#### 	    Ver: 4.1; Ver Date: 09/24/2025; Cleaned up Comments
#### 	    Ver: 4.2; Ver Date: 09/24/2025; Cleaned up Power Settings
#### 	    Ver: 4.2.1; Ver Date: 10/09/2025; Cleaned Up, Added a few settings for bdedit and HW Accelerated Gpu scheduling
#### 	    Ver: 5; Ver Date: 10/18/2025; Major Changes, added performance test, Modularized actionm functions
#### 	    Ver: 5.1; Ver Date: 10/23/2025; Major Changes, added Focused testing to Set-Regkey, 
####                    Additional Cleanup and CPU Waits for tests
#### 	    Ver: 5.1.1; Ver Date: 10/24/2025; Correcting math for computer scores
#### 	    Ver: 5.2; Ver Date: 10/28/2025; Added Additional Registry Tuning Items
#### 	    Ver: 5.2.1; Ver Date: 10/30/2025; Fixed Report-Drivers, added Increase Percentage, Other minor changes
#### 	    Ver: 5.2.2; Ver Date: 12/6/2025; Minor Reporting Change
#### 	    Ver: 5.2.3; Ver Date: 12/8/2025; Added Reporting of User and Computer Names
#### 	    Ver: 5.2.4; Ver Date: 12/16/2025; Trimming Set-Registry Testing, corrected Repair-DISM Validation
#### 	    Ver: 5.3; Ver Date: 12/23/2025; Added Numerous Reg Values and corrections, and Checkdisk
#### 	    Ver: 5.3.1; Ver Date: 12/28/2025; Removed Test-Network functionality, Minor corrections to Comp 
####                    Score formula and msgbox notifications
#### 	    Ver: 5.3.2; Ver Date: 12/29/2025; Added Reset-WindowsUpdates
#### 	    Ver: 5.3.3; Ver Date: 12/29/2025; Added Disable Delivery Optimization
#### 	    Ver: 5.3.4; Ver Date: 01/07/2026; Added Additional Manual Services, Changed Message Boxes to tiny forms
#### 	    Ver: 6; Ver Date: 01/13/2026; Added GUI, Disable CoPilot and Disable Recall
#### 	    Ver: 6.1; Ver Date: 01/26/2026; Addition of minor services change, Added DiagTrack & ClickToRunSvc set to manual
#### 	    Ver: 6.1.1; Ver Date: 01/26/2026; Added Report-Specs, and test to initial speed check to avoid redundant test
#### 	    Ver: 6.1.2; Ver Date: 01/27/2026; Commented out Widget and Search bar setting changes
#### 	    Ver: 6.2; Ver Date: 02/01/2026; Added Disk Cleanup, Change File Explorer Start location to C:, 
####                    Disable: folder data type detection, Websearch In Start, Search Suggestions, 
####                    Added: Disable-Indexing & Remove-WebExperience, $AllButton, * Added AV Scan
#### 	    Ver: 6.3; Ver Date: 02/15/2026; Adding Infotips, re-added OS Check, added Version Check
#### 	    Ver: 6.3.1; Ver Date: 02/15/2026; Adjusted network tuning, Get-EarliestLogfile, adjusted Get-OrigCompScore, 
####                    Modularized Go-Pressed, removed from autoclose
#### 	    Ver: 6.3.2; Ver Date: 02/19/2026; Correct Clear-Temp, changed output folder to Desktop\Gurutune, 
####                    Corrected Get-EarliestLogFile to sort by filename, Adjusted Services
#### 	    Ver: 6.3.3; Ver Date: 02/19/2026; removed Log-Me in Get-EarliestLogfile
#### 	    Ver: 6.3.3.1; Ver Date: 02/19/2026; Updated Logging in set-Regkey
#### 	    Ver: 6.4; Ver Date: 02/19-20/2026; Added Registry Reverting, Adjusted logging, Corrected Power Plan Selection, 
####                    changed PROCTHROTTLEMIN 75 | Out-Null    # DC CPU MIN(Battery), Adjusted Form screen position
####                    Added Clean-PowerPlans, adjusted powerplan selection
#### 	    Ver: 6.4.1; Ver Date: 02/20/2026; Added Reboot to registry restore, re-ordered Functions for ease , updated
####                    Main Sub "remote version not found" actions, Disabled "Disable Web Exp Pack", Added Tooltips,
####                    Added Donation button, Additional Variable Cleanup
#### 	    Ver: 6.4.2; Ver Date: 02/22/2026; Reworked Initial Speed Test Requirements
#### 	    Ver: 6.5; Ver Date: 02/23/2026; Added Verify-RemoteHash, Adjusted logging for Get-RemoteVersion and Clear-Temp
####                    Renamed Disable-copilot to Remove-Co-pilot, test-speed pulled OScore first, Added Set-Verbose
####                    Moved Version verification to Verify-Version, adjusted Set-Services logging for reversion ease
####                    Adjusted Log-Me to pull Get-EarliestLogfile, Added Get-ServiceList and Updated Set-Services
####                    Added Revert-Services, Functionised Verify-RemoteHash and Verify-OS, Added Delays in Test-Disk,
####                    Adjusted options labeled as system changes for restore point, adjusted Repair-SFC Function,
####                    Adjusted form alignment, corrected button in CheckRevertSvc, Ajusted Set-OrigRegValue, 
####                    Added timestamp to Backup-Reg, updated Go-Pressed to clear form at end, Switched to System.Windows.Forms.MessageBox
#### 	    Ver: 6.5.1; Ver Date: 02/23-24/2026; Correct Verify-remotehash
#### 	    Ver: 6.5.2; Ver Date: 02/24/2026; Adding Verify-VSSRunning and 
#### 	    Ver: 6.5.2.1; Ver Date: 02/25/2026; Adjusted Set-OrigRegValue to use any result not just "Reg changed:"
#### 	    Ver: 6.5.2.2; Ver Date: 02/25/2026; Adjusting Set-Original Value, and Restore point logic, Disabled RevReg Button for debugging
#### 	    Ver: 6.5.2.3; Ver Date: 02/25/2026; Correct "Remove OneDrive" after name change
#### 	    Ver: 6.5.2.4; Ver Date: 02/26/2026; Moved Speed-Test to end, Disable-Recall Added "-norestart" to supress prompt
#### 	    Ver: 6.5.2.5; Ver Date: 02/27/2026; Minor bug corrections
#### 	    Ver: 6.5.2.6; Ver Date: 02/28/2026; Adding "env:LOCALAPPDATA\Temp" to Clear-temp, Added Set-ScheduleTask
#### 	    Ver: 6.5.3; Ver Date: 03/11/2026; Updated Set-RegKey for more reliable reporting of $orig, re-enabled RevReg Button, 
####                    Moved Remove-OneDrive and Remove-CoPilot to buttons instead of checks, Added Placeholder for OneDrive File Deletion
#### 	    Ver: 6.5.3.1; Ver Date: 03/12/2026; Added additional logging to Remove-OneDrive and Remove-OneNote, Corrected Selection 
####                    of install file in remove-OneDrive
#### 	    Ver: 6.5.3.2; Ver Date: 03/18/2026; Cleaned up and sorted registry changes in Set-registry and Revert-registry
#### 	    Ver: 6.5.3.3; Ver Date: 03/28/2026; Corrected Wording of MsgBoxes
#### 	    Ver: 6.5.4; Ver Date: 03/28/2026; Added Clean-OneDrive
#### 	    Ver: 6.5.5; Ver Date: 04/06/2026; Moved GuruTuneLog and BackupReg to My Docs instead of Desktop
#### 	    Ver: 6.6; Ver Date: 06/22/2026; Preparing for GitHub, Removed Donation link, Commented out Version and Hashfile Checker
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####
####	To run, right click GuruTune and select 'Run With PowerShell'
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####
####	If GuruTune errors right away, this probably means that your 'Execution Policy'
####    is not set to enable the running of scripts.
####
####	First, sorry for the anxiety.
####	
####	Second, to fix this:
####		Click the Start Menu and type 'PowerShell'
####		Click 'Run As Administrator' on the top result
####		Copy and paste: 
####			"Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
####		Press Enter and Accept any prompts
####		Rerun GuruTune
####		To Revert, Copy and paste: 
####			"Set-ExecutionPolicy -ExecutionPolicy Restricted"
####		Press Enter and Accept any prompts
####
####	Thank for your patience with Microsoft's 'Security Feature'.
####	
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####	Free For Personal Use.
####	Contact For professional licensing.
####
####    Donations accepted @: https://www.gurutecllc.com/donate-today
####
####	HTTP:\\www.GuruTecLLC.Com
####	GuruTecLLC@GMail.Com
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Functions
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Backup-Reg{
        Log-Me "Backing Up Registry" -Disp $true
        $Dt = Get-Date -Format "yyyyMMdd"
        $Tm = Get-Date -Format "hhmm"
        $GuruFolder = "$env:USERPROFILE\Documents\GuruTune"

        if (-not (Test-Path $GuruFolder)) {New-Item -Path $GuruFolder -ItemType Directory | Out-Null}
        reg export HKCU "$GuruFolder\HKCU-Backup $script:ComputerName - $dt - $Tm.reg" /y | Out-Null
        reg export HKLM "$GuruFolder\HKLM-Backup $script:ComputerName - $dt - $Tm.reg" /y | Out-Null
        Remove-Variable -Name Dt,Tm,GuruFolder -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Clean-PowerPlans{
        $active = (powercfg /getactivescheme) -replace '.*GUID:\s+([a-f0-9\-]+).*','$1'
        $plans = powercfg /list | Select-String "GuruTune" | ForEach-Object {
            if ($_ -match 'Power Scheme GUID:\s+([a-f0-9\-]+)') {$matches[1]}}
        $plans = $plans | Where-Object { $_ -ne $active }
        if ($plans.Count -gt 0) {foreach ($guid in $plans) {powercfg -delete $guid}}
        Remove-Variable -Name active,plans -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Clean-OneDrive{
        If ((Test-Path "$env:ProgramFiles\Microsoft OneDrive\OneDrive.exe") -or (Test-Path "$env:ProgramFiles(x86)\Microsoft OneDrive\OneDrive.exe") -or 
            (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*OneDrive*" })){
            $OneDriveInstalled = $true}
        Else {$OneDriveInstalled = $false}

        $OneDrivePath = (Get-ItemProperty "HKCU:\Software\Microsoft\OneDrive" -ErrorAction SilentlyContinue).userfolder
        if (!($OneDrivePath)) {
            Write-Host "Could not detect OneDrive path from registry. Falling back to default."
            If (Test-Path "$env:USERPROFILE\OneDrive"){$OneDrivePath = "$env:USERPROFILE\OneDrive"}
            Else{
                $strMsg = “
**********************************    
                 
           GuruTune 
                                              
**********************************    

    OneDrive File Removal

**********************************    

    Cannot Find OneDrive Path!

**********************************    
  Email if I can assist in any way.              


        Have A Blessed Day,
              ~ Guru
          
        GuruTecLLC@Gmail.com
      HTTPS:\\WWW.GuruTecLLC.Com"
                $Response = [System.Windows.Forms.MessageBox]::Show($strMsg,"OneDrive Path Unknown",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
                Log-Me -Msg "OneDrive File Clearing Aborted - OneDrive Path Unknown!" -disp $true

                Remove-Variable -Name OneDriveInstalled,OneDrivePath,strMsg,Response -ErrorAction SilentlyContinue | out-null
                Exit}}
    
        If ($OneDriveInstalled) {
            Get-ChildItem -Path $OneDrivePath -Recurse -File | ForEach-Object {
                try {attrib -U $_.FullName}
                catch {}}
            Log-Me -Msg "OneDrive File Clearing - Marked Files Online Only - $OneDrivePath" -disp $true
            Remove-Variable -Name OneDriveInstalled,OneDrivePath,strMsg,Response -ErrorAction SilentlyContinue | out-null}
        Else {
            $Response = [System.Windows.Forms.MessageBox]::Show($strMsg,"WARNING: Not Reversable",[System.Windows.Forms.MessageBoxButtons]::OKCANCEL,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            If ($Response -like "OK"){
                Remove-Item -Path $OneDrivePath -Recurse -Force -ErrorAction SilentlyContinue
                Log-Me -Msg "OneDrive File Clearing - Removed OneDrive Folder - $OneDrivePath" -disp $true
                Remove-Variable -Name OneDriveInstalled,OneDrivePath,strMsg,Response -ErrorAction SilentlyContinue | out-null}}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Clear-Temp{
        Log-Me "Clearing Temp Files" -Disp $true
        Stop-Service -Name wuauserv -Force
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -boolDel:$true
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
        Remove-Item "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
        Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force | Out-Null
        Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force | Out-Null
        Remove-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -Recurse -Force | Out-Null
        Log-Me -Msg "Clearing Temp Files - Clearing Browsers" -Disp $true
        Get-ChildItem "$env:LOCALAPPDATA\Temp" -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
        try {Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue} catch {}}

        $browserCachePaths = @{
            "Brave"         = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache"
            "Chrome"        = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"
            "DuckDuckGo"    = "$env:LOCALAPPDATA\Packages\DuckDuckGo.DesktopBrowser_ya2fgkz3nks94\LocalCache"
            "Edge"          = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"
            "Opera"         = "$env:APPDATA\Opera Software\Opera Stable\Cache"
            "Vivaldi"       = "$env:LOCALAPPDATA\Vivaldi\User Data\Default\Cache"}
        foreach ($browser in $browserCachePaths.Keys) {
            $cachePath = $browserCachePaths[$browser]
            if (Test-Path $cachePath) {
                Remove-Item "$cachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
                Log-Me "Cleared cache for $browser" -Disp $true}}
        $firefoxProfileRoot = "$env:APPDATA\Mozilla\Firefox\Profiles"
        if (Test-Path $firefoxProfileRoot) {
            Get-ChildItem $firefoxProfileRoot -Directory | ForEach-Object {
                $firefoxCachePath = "$($_.FullName)\cache2"
                if (Test-Path $firefoxCachePath) {
                    Remove-Item "$firefoxCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
                    Log-Me "Cleared cache for Firefox profile: $($_.Name)"}}}

        Log-Me -Msg "Clearing Temp Files - DISM - VERY SLOW (up to 10 Mins+)" -Disp $true
        DISM /online /cleanup-image /startcomponentcleanup
        $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"
        Log-Me -Msg "Clearing Temp Files - Setting Recurring Cleanup" -Disp $true        

        Set-RegKey -Path $path -Name "01"   -Value 1      # Enable Storage Sense
        Set-RegKey -Path $path -Name "2048" -Value 7      # Weekly
        Set-RegKey -Path $path -Name "04"   -Value 1      # Temp files cleanup
        Set-RegKey -Path $path -Name "256"  -Value 30     # OneDrive dehydration
        Start-ScheduledTask -TaskName "StorageSense" -TaskPath "\Microsoft\Windows\StorageSense\"
        Remove-Variable -Name browserCachePaths,firefoxProfileRoot,path -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Disable-Indexing{
        Set-Service -Name 'Wsearch' -Start Disabled}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Disable-Recall{
        Log-Me -Msg "Disabling Recall" -Disp $true
        Set-RegKey -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" -Name "AllowRecallEnablement" -Value "0"	# Disable Recall
        Disable-WindowsOptionalFeature -Online -FeatureName "Recall" -Remove -NoRestart -ErrorAction SilentlyContinue | Out-Null
        Get-ScheduledTask -TaskPath "\Microsoft\Windows\Recall\*" -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null
        Get-ScheduledTask -TaskPath "\Microsoft\Windows\AI\Recall*" -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Get-EarliestLogfile {
        $GuruFolder = "$env:USERPROFILE\Documents\GuruTune"
        
        $logs = Get-ChildItem -Path $GuruFolder -Filter "GuruTuneLog -*.txt" -ErrorAction SilentlyContinue
        if (-not $logs) { 
            if (-not (Test-Path $GuruFolder)) {New-Item -Path $GuruFolder -ItemType Directory | Out-Null}
            $DateStamp = Get-Date -Format 'yyyyMMdd'
            $LogFile   = Join-Path $GuruFolder "GuruTuneLog - $script:ComputerName - $DateStamp.txt"
            New-Item -Path $LogFile -ItemType File | Out-Null
            return $LogFile}

        # Extract the yyyyMMdd date from the filename and convert to DateTime
        $earliest = $logs |
            ForEach-Object {
                if ($_.BaseName -match '\s(\d{8})$') {
                    $date = [datetime]::ParseExact($matches[1], 'yyyyMMdd', $null)
                    [PSCustomObject]@{
                        File = $_
                        Date = $date}}} | Sort-Object Date |Select-Object -First 1
        if ($earliest) {
            Remove-Variable -Name GuruFolder,logs -ErrorAction SilentlyContinue | out-null
            return $earliest.File.FullName}
        Remove-Variable -Name GuruFolder,logs,earliest -ErrorAction SilentlyContinue | out-null
        return $null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Get-PowerGUID{
        $GUID = powercfg /list | Where-Object {$_ -match "GuruTune"} | ForEach-Object {if ($_ -match "Power Scheme GUID: ([a-fA-F0-9\-]+)") {return $matches[1]}}
        If (!($GUID)){
            $SourceGUID = powercfg /list | Where-Object {$_ -match "Ultimate"} | ForEach-Object {if ($_ -match "Power Scheme GUID: ([a-fA-F0-9\-]+)") {return $matches[1]}}
            If (!($SourceGUID)){$SourceGUID = powercfg /list | Where-Object {$_ -match "High"} | ForEach-Object {if ($_ -match "Power Scheme GUID: ([a-fA-F0-9\-]+)") {return $matches[1]}}}    
            If (!($SourceGUID)) {$SourceGUID = (powercfg /getactivescheme) -replace '.*GUID:\s+([a-f0-9\-]+).*','$1'}
            $GUID = [guid]::NewGuid().ToString()
            powercfg -duplicatescheme $SourceGUID $GUID | Out-Null
            powercfg -changename $GUID "GuruTune" | Out-Null}
         Remove-Variable -Name SourceGUID -ErrorAction SilentlyContinue | out-null
         Return $GUID}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Get-OrigCompScore{
        $LogFile = Get-EarliestLogfile
        $OldCompScore = (Select-String -Path $LogFile -Pattern 'Computer Score:' | Select-Object -First 1).Line -replace '.*Computer Score:\s*',''
        Remove-Variable -Name LogFile -ErrorAction SilentlyContinue | out-null
        return $OldCompScore}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Get-RemoteVersion {
        $Url = "https://gurutecllc.com/guru-tools/p/gurutune?format=json"
        $json = Invoke-WebRequest $Url -UseBasicParsing
        $data = $json.Content | ConvertFrom-Json
        $body = $data.item.excerpt

        Remove-Variable -Name Url,json,data -ErrorAction SilentlyContinue | out-null
        if ($body -match "Version[:\s]+(\d+(\.\d+){1,3})") {
            Remove-Variable -Name body -ErrorAction SilentlyContinue | out-null
            return [version]$Matches[1]} 
        else {return $null}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Get-ServiceList{
        param([Parameter(Mandatory = $true, HelpMessage = "All\Manual\Disabled")][string]$Type)

        If ($Type -like "Manual"){
            Return @('AMD External Events Utility','cdpsvc','CDPUserSvc*','ClickToRunSvc','DiagTrack','DPS','TrkWks','WSAIFabricSvc','MapsBroker',
                'InventorySvc','OneSyncSvc_6b01e','UsoSvc','whesvc','edgeupdate','PcaSvc','sppsvc','UevAgentService')}
        
        Elseif ($Type -like "Disabled"){
            Return @('HvHost','RemoteAccess','RemoteRegistry','SCardSvr','ScDeviceEnum','vmicguestinterface','vmicheartbeat','vmickvpexchange','vmicrdv',
                'vmicshutdown','vmictimesync','vmicvmsession','vmicvss','WerSvc')}
        
        Elseif ($Type -like "All"){
            Return @('AMD External Events Utility','cdpsvc','CDPUserSvc*','ClickToRunSvc','DiagTrack','DPS','TrkWks','WSAIFabricSvc','MapsBroker',
                'InventorySvc','OneSyncSvc_6b01e','UsoSvc','whesvc','edgeupdate','PcaSvc','sppsvc','UevAgentService',
                'HvHost','RemoteAccess','RemoteRegistry','SCardSvr','ScDeviceEnum','vmicguestinterface','vmicheartbeat','vmickvpexchange','vmicrdv',
                'vmicshutdown','vmictimesync','vmicvmsession','vmicvss','WerSvc')}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   
    Function Get-VSSSpace{
        $strVSS = (vssadmin list shadowstorage)
        $TotalSpace = $strVSS[-2]
        $TotalSpace  = ($TotalSpace -split 'Space:\s*')[1] -split '\s+' | Select-Object -First 1
        $UsedSpace = $strVSS[-3]
        $UsedSpace  = ($UsedSpace -split 'Space:\s*')[1] -split '\s+' | Select-Object -First 1
        [int]$AvailSpace = [int]$TotalSpace - [int]$UsedSpace
        If ($AvailSpace -le 2){
            $freeGB = [math]::Round((Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace/ 1GB,2)
            If (($freeGB -gt 5) -and ($AvailSpace -le 2)){
                $newsize = $TotalSpace + 2
                $newsize = "$newsize" + "GB"
                vssadmin Resize ShadowStorage /For=c: /On=c: /MaxSize=$newsize}
            Elseif ($AvailSpace -le 2) {
                $msgBox = New-Object System.Windows.Forms.Form
                $msgBox.TopMost = $true
                $msgBox.StartPosition = "CenterScreen"
                $msgBox.Size = New-Object System.Drawing.Size(1,1)
                $msgBox.ShowInTaskbar = $false
                $msgBox.Show()
                $msgBox.Activate()
                $strMsg = "
                GuruTune

*******************************************
        Not Enough Shadow Copy Space
*******************************************
    I cannot expand the shadow copy storage
        Due to a lack of disk space.

        Please proceed with caution or
        free up some storage space.

        Press 'OK' to proceed anyway.
*******************************************
            Donations Accepted @:

https://www.gurutecllc.com/donate-today

            Have A Blessed Day,
                ~ Guru
          
            GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
                $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Out of Space",[System.Windows.Forms.MessageBoxButtons]::OKCancel,[System.Windows.Forms.MessageBoxIcon]::Information)
                $msgBox.Close()
                If ($Response -like "Cancel"){
                    Log-Me -Msg "VSS Failed: Cancelling"
                    Remove-Variable -Name strVSS,Drive,TotalSpace,UsedSpace,AvailSpace  -ErrorAction SilentlyContinue | out-null
                    Remove-Variable -Name freeGB,newsize,msgBox,strMsg,response -ErrorAction SilentlyContinue | out-null
                    Exit}
                Else {
                    Log-Me -Msg "VSS Failed: Proceeding"
                    Remove-Variable -Name strVSS,Drive,TotalSpace,UsedSpace,AvailSpace  -ErrorAction SilentlyContinue | out-null
                    Remove-Variable -Name freeGB,newsize,msgBox,strMsg,response -ErrorAction SilentlyContinue | out-null
                    Return $False}}
            Else{
                Log-Me -Msg "VSS Verified: Proceeding"
                Remove-Variable -Name strVSS,Drive,TotalSpace,UsedSpace,AvailSpace  -ErrorAction SilentlyContinue | out-null
                Remove-Variable -Name freeGB,newsize,msgBox,strMsg,response -ErrorAction SilentlyContinue | out-null
                Return $true}}
        Else{
            Log-Me -Msg "VSS Verified: Proceeding"
            Remove-Variable -Name strVSS,Drive,TotalSpace,UsedSpace,AvailSpace  -ErrorAction SilentlyContinue | out-null
            Remove-Variable -Name freeGB,newsize,msgBox,strMsg,response -ErrorAction SilentlyContinue | out-null
            Return $true}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Log-Me{
    param([Parameter(Mandatory = $true, HelpMessage = "Message")][string]$Msg,
          [Parameter(Mandatory = $false, HelpMessage = "Display Message")][bool]$Disp=$true)
        $Dt = Get-Date -Format "yyyyMMdd"
        $Tm = Get-Date -Format "hh:mm:ss"
        $Log = "$Dt : $Tm ; $Msg"
        $Logfile = Get-EarliestLogfile
        
        If ($Disp -eq $true){
            Write-host $log
            $StatusLabel.Text = "$Msg"
            $StatusLabel.Refresh()}
        $log >> $Logfile
        Remove-Variable -Name Dt,Tm,Log,LogFile,Disp -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Remove-Copilot{
                $top = New-Object System.Windows.Forms.Form
        $top.TopMost = $true
        $top.ShowInTaskbar = $false
        $top.WindowState = 'Minimized'
        $top.Show()
        $top.Hide()
        $strMsg = "
    Guru Tune Version $script:Version
************************************
                    
        Welcome $script:Username

************************************
        
        Removing CoPilot

************************************
    You will need to reinstall 
       the app after this!

************************************
Press 'OK' When you are ready
        to proceed
   
************************************
Have A Blessed Day

        ~Guru
GuruTecLLC@Gmail.com
HTTPS:\\WWW.GuruTecLLC.Com"
        $response = [System.Windows.Forms.MessageBox]::Show($top,$strMsg,"Guru Tune Version $script:Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel)
        $top.Dispose()
        If ($response -like "OK"){

        Log-Me -Msg "Removing Co-Pilot" -Disp $true
        Set-RegKey -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1  # Disable CoPilot
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -Value 0  # 
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -Value 0  # 
        Get-AppxPackage -Name "*Microsoft.Windows.Copilot*" | Remove-AppxPackage | Out-Null
        Get-AppxPackage Microsoft.Copilot -AllUsers | Remove-AppxPackage -AllUsers | Out-Null
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -Like "Microsoft.Copilot" | Remove-AppxProvisionedPackage -Online | Out-Null
        #Get-AppxPackage MicrosoftWindows.Client.WebExperience -AllUsers | Remove-AppxPackage -AllUsers | Out-Null
        Get-ScheduledTask -TaskPath "\Microsoft\Windows\Copilot\" -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null
        Get-ScheduledTask -TaskPath "\Microsoft\Windows\AI\Copilot\" -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null
        Get-AppxPackage -AllUsers -Name "Microsoft.MicrosoftOfficeHub*" | Remove-AppxPackage -AllUsers | Out-Null}
        Log-Me -Msg "Removing Co-Pilot - Completed" -Disp $true
        Remove-Variable -Name top,strMsg,response -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Remove-OneDrive{
        $top = New-Object System.Windows.Forms.Form
        $top.TopMost = $true
        $top.ShowInTaskbar = $false
        $top.WindowState = 'Minimized'
        $top.Show()
        $top.Hide()
        $strMsg = "
    Guru Tune Version $script:Version
************************************
                    
        Welcome $script:Username

************************************
    Removing OneDrive Local App
************************************
    Do Not Use if you use OneDrive 
        For Personal or Business!


You will need to use the Online Version 
            After this!

************************************
Press 'OK' When you are ready
        to proceed
   
************************************
Have A Blessed Day

        ~Guru
GuruTecLLC@Gmail.com
HTTPS:\\WWW.GuruTecLLC.Com"
        $response = [System.Windows.Forms.MessageBox]::Show($top,$strMsg,"Guru Tune Version $script:Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel)
        $top.Dispose()
        If ($response -like "OK"){
            $OneDrivePaths = @(
                "$env:SystemRoot\System32\OneDriveSetup.exe",      # 64‑bit system location
                "$env:SystemRoot\SysWOW64\OneDriveSetup.exe",      # 32‑bit fallback
                "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" # User install
                )
            $OneDriveInstalled = $OneDrivePaths | Where-Object { Test-Path $_ }
            if ($OneDriveInstalled) {
                If ($OneDriveinstalled.Count -gt 1){$OneDriveInstalled = $OneDriveInstalled[0]}
                Log-me -msg "Removing OneDrive - You must use Online version or reinstall app after this!" -disp $true
                Start-Process $OneDriveInstalled -ArgumentList "/uninstall"
                Log-me -msg "Removing OneDrive - Completed" -disp $true
            } else {Log-me -msg "Removing OneDrive - OneDrive Installation Not Found!" -disp $true}}
        Remove-Variable -Name top,strMsg,response,OneDrivePaths,OneDriveInstalled -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Remove-WebExperience{
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0	# Taskbar Widgets
        Set-Service -Name "WindowsWebExperiencePack" -Start Disabled
        Get-AppxPackage *WebExperience* | Remove-AppxPackage -ErrorAction SilentlyContinue | Out-Null
        Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like "*WebExperience*" } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Out-Null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Rename-ToBackup {
        $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
        $SoftwareDistribution = Join-Path $env:SystemRoot 'SoftwareDistribution'
        if (-not (Test-Path $SoftwareDistribution)) {
            Log-Me "Rename Error: Path not found, skipping: $SoftwareDistribution" -Disp $false}
        Else{
            $backup = "$SoftwareDistribution.$timestamp.bak"
            Rename-Item -Path $SoftwareDistribution -NewName $backup -ErrorAction SilentlyContinue | Out-Null
            Log-Me "Renamed: $Path -> $backup" -Disp $false}

        $Catroot2 = Join-Path $env:SystemRoot 'System32\catroot2'
        if (-not (Test-Path $Catroot2)) {
            Log-Me "Rename Error: Path not found, skipping: $Catroot2" -Disp $false}
        Else{
            $backup = "$Catroot2.$timestamp.bak"
            Rename-Item -Path $Catroot2 -NewName $backup -ErrorAction SilentlyContinue | Out-Null
            Log-Me "Renamed: $Path -> $backup" -Disp $false}
        
        Remove-Variable timestamp,SoftwareDistribution,backup -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Repair-Disk{
        Log-Me -Msg "System Repair - Check Disk - VERY SLOW" -Disp $true
        $DiskStat = chkdsk C:
        If (!($DiskStat[-15] -like "Windows has scanned the file system and found no problems.")){
            $script:RebootRequired = $true
            "Y" | chkdsk C: /F
            Log-Me -Msg "System Repair - Check Disk - Repairing" -Disp $true}
        Remove-Variable -Name DiskStat -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Repair-DISM{
        Log-Me -Msg "System Repair - DISM - VERY SLOW" -Disp $true
        $DISMRes = DISM /Online /Cleanup-Image /ScanHealth
        If ($DISMRes[-2] -like "No component store corruption detected."){
            Log-Me -Msg "DISM Verified" -Disp $false}
        Else {
            $DISMRes = DISM /Online /Cleanup-Image /RestoreHealth
            $script:RebootRequired = $true
            If ($DISMRes[-1] -like "The operation completed successfully.") {Log-Me -Msg "DISM Repaired" -Disp $false}
            Else {Log-Me -Msg "DISM Error - PC Reset Recommended" -Disp $True}}
        Remove-Variable -Name DISMRes -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Repair-SFC{               
        Log-Me -Msg "System Repair - SFC - VERY SLOW" -Disp $true
        $SFC = SfC /scannow
        $Str = $SFC[-4]
        $normalized = $str -replace '[\p{C}]', ''
        If ($normalized -match "did not find"){
            Log-Me -Msg "System Repair - SFC - Repaired" -Disp $true}
        Else {Log-Me -Msg "System Repair - SFC - Alert: $normalized" -Disp $true}
        $script:RebootRequired = $true
        Remove-Variable -Name SFC,Str,normalized -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Report-All{
        Report-Key
        Report-Specs
        Report-Bios
        Report-Events
        Report-Drivers}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Report-Bios{
        Log-Me "Reporting - Board and BIOS"
        $BIOS = Get-CimInstance -ClassName Win32_BIOS
        $MOBO = Get-CimInstance -ClassName Win32_BaseBoard
        $BIOSMan = $BIOS.Manufacturer
        $Ver = $BIOS.Version
        $Dt = $BIOS.ReleaseDate
        $BoardMan = $MOBO.Manufacturer
        $Mod = $MOBO.Product
        $SN = $MOBO.SerialNumber
        Log-Me "BIOSMan:$BIOSMan;Version:$Ver;VerDate:$Dt;BoardMan:$BoardMan;Model:$Mod;SN:$SN" -Disp $false
        Remove-Variable -Name bios,MOBO,BIOSMan,Ver,Dt,BoardMan,Mod,SN -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Report-Drivers{
        Log-Me "Reporting - Drivers"
        $ExcludedClasses = @("System", "VOLUME", "VOLUMESNAPSHOT", "WPD", "NET", "SOFTWAREDEVICE","PRINTQUEUE", 
                "COMPUTER", "MEDIA", "FIRMWARE", "SECURITYDEVICES","SOFTWARECOMPONENT", "DISPLAY", "HIDCLASS")
        $Drivers = Get-WmiObject Win32_PnPSignedDriver |
            Where-Object {($_.DeviceClass -ne $null) -and ($ExcludedClasses -notcontains $_.DeviceClass)} |
            Where-Object {[datetime]::ParseExact($_.DriverDate.Substring(0,8), 'yyyyMMdd', $null) -lt (Get-Date).AddYears(-2)}

        $BadDrivers = $Drivers | Select-Object -Property DeviceName, FriendlyName, Signer, @{Name = 'Date';
            Expression = { [datetime]::ParseExact($_.DriverDate.Substring(0,8), 'yyyyMMdd', $null) }} -Unique | 
            Sort-Object -Property DeviceName
        foreach ($driver in $BadDrivers) {Log-Me "Driver Name:$($driver.DeviceName);Friendly Name:$($driver.FriendlyName);Date:$($driver.Date);Signer:$($driver.Signer)" -Disp $false}
        
        Remove-Variable -Name ExcludedClasses,Drivers,badDrivers -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}   
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Report-Events{
        Log-Me "Reporting - Event Logs"
        $startTime = (Get-Date).AddHours(-24)
        $logNames = @("System", "Application", "Setup", "Security")
        $levels = @(1, 2)
        $events = foreach ($log in $logNames) {
                foreach ($level in $levels) {
                    Get-WinEvent -FilterHashtable @{
                        LogName   = $log
                        Level     = $level
                        StartTime = $startTime} -ErrorAction SilentlyContinue}}
        $groupedEvents = $events | Group-Object Id
        foreach ($group in $groupedEvents) {
                $eventId = $group.Name
                $count = $group.Count
                $latestEvent = $group.Group | Sort-Object TimeCreated -Descending | Select-Object -First 1
                $message = $latestEvent.Message
                Log-Me "Event ID: $eventId ;Count: $count ;Message: $message" -Disp $false}
        Remove-Variable -Name logNames,levels,events,groupedEvents -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Report-Key{
        Log-Me "Reporting - Windows Product Key" -Disp $True
        $ProductKey = (Get-WmiObject -Query "select * from SoftwareLicensingService").OA3xOriginalProductKey
        If ($ProductKey){Log-Me "Windows Product Key:$ProductKey" -Disp $false}
        Else {Log-Me "Windows Product Key Digital" -Disp $false}
        Remove-Variable -Name ProductKey -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Report-Specs{
        Log-Me "Reporting - Computer Specs" -Disp $True
        $Cpu = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name
        Log-Me -Msg "CPU: $Cpu" -Disp $false

        $RAM = [Math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        Log-Me -Msg "RAM: $RAM" -Disp $false
        
        $GPUs = Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name
        If ($GPUs.Count -gt 1){For-each $gpu in $GPUs{Log-Me -Msg $gpu -Disp $false}}
        Else {Log-Me -Msg $gpu -Disp $false}

        $Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
            Select-Object DeviceID,
            @{Name="TotalGB"; Expression = {"{0:N2}" -f ($_.Size / 1GB)}},
            @{Name="FreeGB";  Expression = {"{0:N2}" -f ($_.FreeSpace / 1GB)}}
        If ($Drives.Count -gt 1){For-each $Drive in $Drives{Log-Me -Msg $Drive -Disp $false}}
        Else {Log-Me -Msg $Drives -Disp $false}
        Remove-Variable Cpu,RAM,GPUs,Drives,Drive -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Reset-UpdateBITS{
        $bitsJobs = Get-BitsTransfer -AllUsers -ErrorAction SilentlyContinue
        if ($bitsJobs) {
            Log-Me -Msg "Removing BITS Jobs: $bitsJobs.count" -Disp $false
            $bitsJobs | Remove-BitsTransfer -Confirm:$false | Out-Null}
        Else {Log-Me -Msg "No BITS Jobs" -Disp $false}
        Remove-Variable bitsJobs -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Reset-WindowsUpdates{
        Log-Me "Resetting - Windows Updates" -Disp $true
        Stop-UpdateServices
        Rename-ToBackup
        Start-UpdateServices
        wuauclt.exe /resetauthorization /detectnow
        usoclient.exe startscan}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Revert-Registry{
        Log-Me -Msg "Reverting Registry - SLOW" -Disp $true
        Set-OrigRegValue -Path "HKCU:\Control Panel\Accessibility" -Name "Animation"	# Accessibility - Visual Effects - Animations Effects = Disabled
        Set-OrigRegValue -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks"	# hung application Handling at shutdown
        Set-OrigRegValue -Path "HKCU:\Control Panel\Desktop" -Name "MouseTrails"	# Mouse Settings
        Set-OrigRegValue -Path "HKCU:\Control Panel\Desktop" -Name "MouseWheelRouting"	# Mouse Settings
        Set-OrigRegValue -Path "HKCU:\Control Panel\Desktop" -Name "WindowAnimation"	# Disable Windows Animations
        Set-OrigRegValue -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed"	# Mouse Settings
        Set-OrigRegValue -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1"	# Mouse Settings
        Set-OrigRegValue -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2"	# Mouse Settings
        Set-OrigRegValue -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Name "FolderType"	# disable folder data type detection
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Clipboard" -Name "CloudClipboardSyncEnabled"	# Disable Clipboard Internet Syncing
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory"	# Disable Clipboard History
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Edge\Performance" -Name "PerformanceModeEnabled"	# Browser Performance
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode"	# Enable Game Mode
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled"	# Game Mode
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection"	# Restrict Inking Data Transmission
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection"	# Restrict Typing Data Transmission
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Lighting" -Name "UseDynamicLighting"	# Personalization - Dynamic Lighting - Use Dynamic Lighting on my device = disabled
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod"	# Disable Feedback Frequency
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInDays"	# Disable Feedback Frequency
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds"	# Disable feedback frequency
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness"	# Increase Process Priority for Games
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "RestartApps"	# App Restarts
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled"	# Disable Advertising ID
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled"	# Optional: Disable other content suggestions
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled"	# Disable Suggestions In Start
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled"	# Disable “Tips and Tricks” and suggestions in Windows
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled"	# Disable Start menu suggestions
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled"	# Disable App suggestions in Settings
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled"	# Disable Tips and feature highlights in Settings
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled"	# Disable suggestions in the Windows Timeline
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray"	# Taskbar
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewOnFocus"	# File Explorer
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableDragDrop"	# Mouse Settings
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt"	# File Explorer
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo"	# File Explorer opens to This PC
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo"	# Change File Explorer Start location to C:
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowInfoTip"	# File Explorer
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowPreviewHandlers"	# File Explorer
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications"	# Sync Popups
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton"	# Show Systray Task View Button
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations"	# Disable Start menu recommendations
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs"	# Disable tracking of recently opened items
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath"	# Display Full Path - Title Bar
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPathAddress"	# Display Full Path - Address Bar
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec"	# Disable Startup Delay
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "WaitForIdleState"	# Disable Startup Delay
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting"	# Visual Settings - Max Performance
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK"	#Privacy and Security - General
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled"	#Privacy and Security - General
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled"	# System - Notifications- Notifications = Disabled
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled"	# Disable Websearch In Start
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled"	# Disable AI-powered search
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode"	# Disable AI-powered search
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled"	# Privacy & Security - Search - Search My Accounts = Disabled
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SearchMode"	# Privacy & Security - Search - Enhanced Search
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency"	# Accessibility - Visual Effects - Transparency effects = Disabled
        Set-OrigRegValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled"	# Disable Out Of Box Experience
        Set-OrigRegValue -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData"	# Disable Tailored Experience
        Set-OrigRegValue -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions"	# Disable Search Suggestions
        Set-OrigRegValue -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions"	# Disable AI-powered search
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex"	#Disable Network Throttling
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness"	#Multimedia Class Scheduler Service - Background reservation
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category"	#Game Scheduling Priority
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState"	# Disable Location Tracking
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value"	# Disable Location Tracking
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode"	# Windows Update - Advanced Options - Delivery Optimization - Allow Downloads from other devices = Disabled
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableDragDropBreadcrumb"	# Mouse Settings
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled"	# Data Collection
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry"	# Data Collection
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "DehydrateCloudFilesThresholdDays"	# Storage Sense - Cleanup old local copies
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "DeleteDownloadsFolder"	# Storage Sense - Auto Downloads Cleanup
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "DeleteTempFiles"	# Storage Sense - Auto Temp File Cleanup
        Set-OrigRegValue -Path "HKLM:\Software\Microsoft\Windows\Windows Error Reporting" -Name "Disabled"	# Disable Windows Hardware Error Reporting (WHEA)
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Edge" -Name "ConfigureDoNotTrack"	# Edge "Do Not Track" advertisement
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Edge" -Name "PersonalizationReportingEnabled"	# Disable Edge Personalization Data transmission
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Edge" -Name "ShowRecommendationsEnabled"	# Edge Reccomendations
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection"	# Disable implicit handwriting and text data collection
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting"	# Defender Submissions
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent"	# Defender Submissions
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy"	# Disable Advertising ID
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory"	# Disable Inventory Collector
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR"	# Disable Steps Recorder
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerFeatures"	# Disable automatic installation of suggested apps
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures"	# Silently installing or recommending apps
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry"	# Data Collection
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications"	# Disable Feedback Notifications
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode"	# Disable Delivery Optimization
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\OOBE" -Name "DisablePrivacyExperience"	#Disable Out Of Box Experience
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "AllowStorageSenseGlobal"	# Storage Sense - Enable Globally
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "AllowStorageSenseTemporaryFilesCleanup"	# Storage Sense - Auto Temp File Cleanup
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "ConfigStorageSenseCloudContentDehydrationThreshold"	# Storage Sense - Cleanup old local copies
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "ConfigStorageSenseDownloadsCleanupThreshold"	# Storage Sense - Downloads threshold
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "ConfigStorageSenseGlobalCadence"	# Storage Sense - Cleanup Cadence
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed"	# Disable recordings of user activity
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "PublishUserActivities"	# Disable storing User's activity history
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "UploadUserActivities"	# Disable Submission of User's activity history to MS
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled"	# Disable windows error reporting
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana"	# Disable Cortana
        Set-OrigRegValue -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "EnableDynamicContentInWSB"	# Registry path for Search Highlights
        Set-OrigRegValue -Path "HKLM:\System\ControlSet001\Services\Ndu" -Name "Start"	# Network Data Usage Monitor - Manual Start
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout"	# System Settings
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode"	# Hardware-Accelerated GPU Scheduling
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Power\PowerSettings\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMax"	# Disable Core Parking
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Power\PowerSettings\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMin"	# Disable Core Parking
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff"	# Disable Power Throttling
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation"	# Set Processor Scheduling to Programs
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown"	# Reboot Refreshes Pagefile
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache"	# Set Processor Scheduling to Programs
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher"	# Disable Prefetch
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnableSuperfetch"	# Disable Super fetch
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize"	# more room for drivers
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status"	# Disable Location Tracking
        Set-OrigRegValue -Path "HKLM:\System\CurrentControlSet\Services\USB" -Name "DisableSelectiveSuspend"	# DisableSelectiveSuspend
        Set-OrigRegValue -Path "HKLM:\System\Maps" -Name "AutoUpdateEnabled"	# Disable Location Tracking

        Log-Me -Msg "Registry Reverting Complete" -Disp $true
        Remove-Variable -Name LogFile,SearchStr,result
        
        $msgBox = New-Object System.Windows.Forms.Form
        $msgBox.TopMost = $true
        $msgBox.StartPosition = "CenterScreen"
        $msgBox.Size = New-Object System.Drawing.Size(1,1)
        $msgBox.ShowInTaskbar = $false
        $msgBox.Show()
        $msgBox.Activate()
        $strMsg = "
            Guru Has Tuned You!

*******************************************
        A Computer Reboot Is Required
        Press 'OK' when you are ready
*******************************************
    Many items may be slower the first time
    you open them as they need to rebuild
            their cache or temp files. 
      
            Please open them after the 
        reboot and reboot once more for
                full responsiveness.

*******************************************
            Donations Accepted @:

https://www.gurutecllc.com/donate-today

                Have A Blessed Day,
                        ~ Guru
          
            GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
        $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Reboot Required",
            [System.Windows.Forms.MessageBoxButtons]::OKCancel,
            [System.Windows.Forms.MessageBoxIcon]::Information)
        $msgBox.Close()                
        if ($response -eq [System.Windows.Forms.DialogResult]::OK) {
            Log-Me "Rebooting" -Disp $true
            Remove-Variable -Name SystemChanges,top,strMsg,response,End,Diff,msgBox -ErrorAction SilentlyContinue | out-null
            Restart-Computer -Force}
        else {
            $msgBox = New-Object System.Windows.Forms.Form
            $msgBox.TopMost = $true
            $msgBox.StartPosition = "CenterScreen"
            $msgBox.Size = New-Object System.Drawing.Size(1,1)
            $msgBox.ShowInTaskbar = $false
            $msgBox.Show()
            $msgBox.Activate()
            $strMsg = "
                GuruTune

***********************************
    A Computer Reboot Is Required.

Please reboot As Soon As Possible 
        to avoid complications.

***********************************
        Have A Blessed Day,
                ~ Guru
          
        GuruTecLLC@Gmail.com
    HTTPS:\\WWW.GuruTecLLC.Com"
            $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Reboot Required",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information)
            $msgBox.Close()  
            Log-Me "Reboot Aborted" -Disp $true
            Remove-Variable -Name SystemChanges,top,strMsg,response,End,Diff,msgBox -ErrorAction SilentlyContinue | out-null}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Revert-Services{
        Log-Me -msg "Reverting Services" -disp $true
        $Logfile = Get-EarliestLogfile
        $Services = Get-ServiceList -Type "All"
        Foreach ($svc in $Services){ 
            $OrigStart = (Select-String -Path $LogFile -Pattern "Service Change: $svc" | Select-Object -First 1).Line -replace '.*Orig:\s*',''
            If ($OrigStart){
                Set-Service -Name $SVC -Start $OrigStart -Disp $false
                Log-Me -msg "Reverting Service: $svc ;Orig Start: $OrigStart" -disp $true
                If ($OrigStart -like "Automatic") {Start-Service -Name $svc | Out-Null}}
            Else{log-me -msg "Reverting Service Failed: $svc ; Original Start Unknown" -disp $false}}
        Log-Me -msg "Finished Reverting Services" -disp $true
        Remove-Variable -Name Logfile,Services,svc,OrigStart -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Run-AVMSRTScan {
        Log-Me -Msg "Starting Malicious Software Removal Tool (MSRT) - Full Scan - VERY SLOW" -Disp $true
        Log-Me -Msg "Please press 'Next' on the popup" -Disp $true
        Set-regkey -path "HKLM:\SOFTWARE\Microsoft\RemovalTools\MRT" -Name "EulaAccepted" -Value 1    # Accept MSRT EULA
        Start-Process -FilePath "$env:SystemRoot\System32\mrt.exe" -ArgumentList "/F:Y" -Wait
        $MSRTLog  = "$env:SystemRoot\debug\mrt.log"
        if (!(Test-Path $MSRTLog)) {Log-Me "AV - MSRT - Finished - log file missing!"
            Remove-Variable -Name MSRTLog -ErrorAction SilentlyContinue | Out-Null 
            Return $false}
        $content = Get-Content $MSRTLog -Raw
        $infectMatch = [regex]::Match($content, "Infection\s+Found:\s+(\d+)", "IgnoreCase")
        if ($infectMatch.Success -like "True") {
            $count = [int]$infectMatch.Groups[1].Value
            if ($count -gt 0) { 
                Log-Me "AV - MSRT - Infections detected: $count" -Disp $true
                Remove-Variable -Name MSRTLog,content,infectMatch,count -ErrorAction SilentlyContinue | Out-Null
                Return $false} 
            else {
                Log-Me "AV - MSRT - Clean" -Disp $true
                Remove-Variable -Name MSRTLog,content,infectMatch,count -ErrorAction SilentlyContinue | Out-Null
                Return $true}}
        if ($content -match "No\s+infection\s+found") {
            Log-Me "AV - MSRT - Clean" -Disp $true
            Remove-Variable -Name MSRTLog,content,infectMatch -ErrorAction SilentlyContinue | Out-Null
            Return $true}
        Log-Me "AV - MSRT - Status Unknown." -Disp $true
        Remove-Variable -Name MSRTLog,content,infectMatch -ErrorAction SilentlyContinue | Out-Null
        Return $false}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Run-AVMSERTScan{
        Log-Me -Msg "Starting Microsoft Safety Scanner (MSERT) - Very Slow!" -Disp $true
        $MSERTPath = "$env:TEMP\msert.exe"
        Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?LinkId=212732" -OutFile $MSERTPath -UseBasicParsing -ErrorAction SilentlyContinue | Out-Null
        If (!(Test-Path $MSERTPath)){
            Log-Me -Msg "AV - MSERT - MSERT Not Found!"
            Remove-Variable -Name MSERTPath -ErrorAction SilentlyContinue | Out-Null 
            Return $false}
        Log-Me -Msg "Please Accept the Agreement and Click Next twice" -Disp $true
        Start-Process -FilePath $MSERTPath -ArgumentList "/F" -Wait
        $MSERTLog  = "$env:SystemRoot\debug\msert.log"
        $content = Get-Content $MSERTLog -Raw
        $infectMatch = [regex]::Match($content, "Infection\s+Found:\s+(\d+)", "IgnoreCase")
        if ($infectMatch.Success) {
            $count = [int]$infectMatch.Groups[1].Value
            if ($count -gt 0) {
                log-me -msg "AV - MSERT - $count Infections Found" -Disp $true
                Remove-Variable -Name MSERTPath,MSERTLog,exe,content,infectMatch,count -ErrorAction SilentlyContinue | Out-Null
                Return $false} 
            else {
                log-me -msg "AV - MSERT - Clean Scan"
                Remove-Variable -Name MSERTPath,MSERTLog,exe,content,infectMatch,count -ErrorAction SilentlyContinue | Out-Null
                return $true}}
        Elseif ($content -match "No\s+infection\s+found") {
            log-me -msg "AV - MSERT - Clean Scan" -Disp $true
            Remove-Variable -Name MSERTPath,MSERTLog,exe,content,infectMatch -ErrorAction SilentlyContinue | Out-Null
            Return $true}
        Else {
            log-me -msg "AV - MSERT - Scan Results Unknown!" -Disp $true
            Remove-Variable -Name MSERTPath,MSERTLog,exe,content,infectMatch -ErrorAction SilentlyContinue | Out-Null
            Return $false}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Run-AvDefOffline {
        $top = New-Object System.Windows.Forms.Form
        $top.TopMost = $true
        $top.ShowInTaskbar = $false
        $top.WindowState = 'Minimized'
        $top.Show()
        $top.Hide()
        $strMsg = "
                      Guru Tune Version $script:Version
        ************************************
                    
                          Welcome $script:Username

        ************************************
                  
            I WILL reboot for the offline 3rd scan.
                    
        ************************************
               Press 'OK' When you are ready
                            to proceed
   
        ************************************
                    Have A Blessed Day

                            ~Guru
                GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
        $response = [System.Windows.Forms.MessageBox]::Show($top,$strMsg,"Guru Tune Version $script:Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel)
        if ($response -ne "OK") {
            Remove-Variable -Name strMsg, response -ErrorAction SilentlyContinue | out-null
            Log-Me -Msg "AV - Defender Offline - Cancelling Scan" -Disp $true
            Return "Cancelling"}

        Log-Me -Msg "Starting Windows Defender - Offline Scan" -Disp $true
        Log-Me -Msg "System Will Reboot Now To Scan!" -Disp $true
        sleep 10
        Update-MpSignature -ErrorAction SilentlyContinue | Out-Null
        $status = Get-MpComputerStatus
        if (-not $status.AntivirusSignatureLastUpdated) {Log-Me -Msg "MS AV Not Updated!" -Disp $true}
        $Scan = Start-MpWDOScan
        Remove-Variable -Name top,strMsg,response,status -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
    Function Run-AV{
        Log-Me -Msg "GuruTune Script Version $script:Version" -Disp $true
        Log-Me -Msg "Running Antivirus Scans" -Disp $true
        $top = New-Object System.Windows.Forms.Form
        $top.TopMost = $true
        $top.ShowInTaskbar = $false
        $top.WindowState = 'Minimized'
        $top.Show()
        $top.Hide()
        $strMsg = "
                  Guru Tune Version $script:Version
        ************************************
                    
                   Welcome $script:Username

        ************************************
                  This Script Will Run 3 
                   Separate MS AV Tools.
                       
                   These Steps are SLOW.

          It WILL reboot for the offline 3rd scan.
                    
                Please run ONLY when you have 
                    TIME and can REBOOT
        ************************************
                        For best results, 
                please CLOSE all apps and 
            STOP all activity until completion
   
        ************************************
               Press 'OK' When you are ready
                            to proceed
   
        ************************************
                    Have A Blessed Day

                            ~Guru
                GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
        $response = [System.Windows.Forms.MessageBox]::Show($top,$strMsg,"Guru Tune Version $script:Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel)
        if ($response -ne "OK") {
            Remove-Variable -Name strMsg, response -ErrorAction SilentlyContinue | out-null
            Log-Me -Msg "AV - Cancelling All Scans" -Disp $true
            Return $false}
        Run-AVMSRTScan
        Run-AVMSERTScan
        Run-AvDefOffline
        Remove-Variable -Name top,strMsg,response -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Appx{
        Log-Me "Appx Packages"
        $appxPackages = @(
            "Microsoft.Getstarted*",
            "Microsoft.People*",
            "MicrosoftCorporationII.MicrosoftFamily*",
            "MicrosoftCorporationII.QuickAssist*",
            "Microsoft.Bing*",
            "Microsoft.PowerAutomateDesktop",
            "Microsoft.Todos",
            "Microsoft.WindowsMaps",
            "Microsoft.WindowsSoundRecorder",
            "Microsoft.Zune*") 
        Foreach ($Package in $appxPackages){
            $MyPkg = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like $Package}
            If ($mypkg){
                $MyPkg | Remove-AppxProvisionedPackage -ErrorAction SilentlyContinue -AllUsers -Online | Out-Null
                Log-Me "Rem:$Package" -Disp $false}}
        Remove-Variable -Name appxPackages,Package,MyPkg -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Features{
        Log-Me "Optional Windows Features"
        $features = @(
            "Client-ProjFS",
            "HypervisorPlatform",
            "IIS-*",
            "Microsoft-Windows-Subsystem-Linux",
            "MSMQ-*",
            "Printing-Foundation-LPDPrintService",
            "Printing-Foundation-LPRPortMonitor",
            "Printing-XPSServices-Features",
            "SMB1Protoco*",
            "TelnetClient",              
            "TFTP",
            "TIFFIFilter",
            "VirtualMachinePlatform",
            "WAS-*",
            "WCF-*",
            "WorkFolders-Client")
        foreach ($feature in $features) {
            If ((Get-WindowsOptionalFeature -FeatureName $feature -Online).state -like "Enabled"){ 
                Disable-WindowsOptionalFeature -FeatureName $feature -Online -NoRestart | Out-Null
                Log-Me "Rem:$feature" -Disp $false}}
	    Remove-Variable -Name features,feature -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
    Function Set-Network {
        Log-Me "Network"
        $NetTest = Test-Net -Disp $false
        Get-NetAdapter | ForEach-Object {Enable-NetAdapterChecksumOffload -Name $_.Name -ErrorAction SilentlyContinue | Out-Null}
        netsh int tcp set global rss=enabled rsc=disabled netdma=enabled | Out-Null
        netsh int tcp set heuristics disabled | Out-Null
        $tcpSetting = "InternetCustom"
        Set-NetTCPSetting -SettingName "InternetCustom" `
            -MinRto 300 `
            -InitialCongestionWindowMss @(10) `
            -CongestionProvider "CUBIC" `
            -CwndRestart $false `
            -DelayedAckTimeout 40 `
            -DelayedAckFrequency 1 `
            -MemoryPressureProtection "Enabled" `
            -AutoTuningLevelLocal "Experimental" `
            -EcnCapability "Enabled" `
            -Timestamps "Enabled" `
            -InitialRto 300 `
            -ScalingHeuristics "Disabled" `
            -NonSackRttResiliency "Disabled" `
            -ForceWS "Enabled" `
            -MaxSynRetransmissions 2
        Set-NetTCPSetting -SettingName "InternetCustom" -AutomaticUseCustom "Enabled"

        $ip = Get-NetIPAddress -AddressFamily IPv4 |
            Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1' -and $_.PrefixOrigin -eq 'Dhcp' } |
            Select-Object -ExpandProperty IPAddress -First 1

        if ($ip) {
            $interfacesPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
            $targetKey = Get-ChildItem $interfacesPath | Where-Object {(Get-ItemProperty $_.PSPath).DhcpIPAddress -eq $ip}
            if ($targetKey) {
                $keyPath = $targetKey.PSPath
                New-ItemProperty -Path $keyPath -Name "TcpAckFrequency" -PropertyType DWord -Value 1 -Force | Out-Null
                New-ItemProperty -Path $keyPath -Name "TCPNoDelay" -PropertyType DWord -Value 1 -Force | Out-Null}}
        Test-Net -OrigVal $Net -Disp $false| Out-Null
        Remove-Variable -Name ip, interfacesPath, targetKey, keyPath -ErrorAction SilentlyContinue | Out-Null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-OrigRegValue {
        param([Parameter(Mandatory)][string]$Path,
            [Parameter(Mandatory)][string]$Name)
    
        [string]$LogFile = Get-EarliestLogfile
        [string]$SearchStr = "$path ;Name: $name"
        [string]$result = Select-String -Path $LogFile -Pattern $SearchStr -SimpleMatch -List
        [string]$Orig = ($result -split "Orig: ")[1] -split " ;" | Select-Object -First 1
        
        If ($result){
            If ($orig -like "NewRegKey"){
                Log-Me -Msg "Reverting; Removing: $path ;Name: $name" -Disp $true
                Remove-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue}
            ElseIf ((!($Orig)) -or ($Orig -like $null)){
                Log-Me -Msg "Reverting Registry; Failed Finding Original Value: $path ;Name: $name" -Disp $true}
            Else {
                Log-Me -Msg "Reverting Registry; Changing: $path ;Name: $name ;Original: $Orig" -Disp $true
                Set-RegKey -Path $Path -Name $name -Value $Orig}}
        Else{Log-Me -Msg "Reverting Registry; No Results Found: $path ;Name: $name" -Disp $true}
        Remove-Variable -Name LogFile,SearchStr,result,orig -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
    Function Set-Packages{
        Log-Me "Unneeded Windows Packages"
        $Packages = @(
            "Microsoft-Windows-InternetExplorer*",
            "Microsoft-Windows-Printing-WFS*",
            "Microsoft-Windows-StepsRecorder*",
            "Microsoft-Windows-WordPad*",
            "Microsoft-Windows-WorkFolders-Client-Package")
        foreach ($Package in $Packages){
            $objPackage = Get-WindowsPackage -PackageName $Package -online
            If ($objPackage){
                foreach ($obj in $objPackage){
                    Log-Me "Rem:$obj.packagename" -Disp $false
                    Remove-WindowsPackage -PackageName $obj.packagename -NoRestart -Online| Out-Null}}}
	    Remove-Variable -Name Packages,Package,objPackage -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Pagefile{
        Log-Me "Page File"
        $RAM = [Math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        $PFSizeMB = [Math]::Round($RAM * 1536)
        [int32]$PFSize = $PFSizeMB
        $CurrentPageFile = Get-WmiObject -Query "select * from Win32_PageFileSetting"
        $strName = $CurrentPageFile.Name
        $Min = $CurrentPageFile.InitialSize
        $Max = $CurrentPageFile.MaximumSize
        Log-Me "Orig: $strName ;Min: $Min ;Max: $Max" -Disp $false
        $NewDrive = (Get-CimInstance Win32_LogicalDisk | Where-Object {
            $_.DriveType -ne 2 -and $_.DeviceID -ne 'C:' -and ($_.FreeSpace / 1MB) -ge $PFSize
            } | Select-Object -First 1).DeviceID
        If (!($NewDrive)){$NewDrive = "C:"}
        $CurrentPageFile.Delete() | Out-Null
        $strName = "$NewDrive\pagefile.sys"
        $driveInfo = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$NewDrive'"
        $freeMB = [math]::Round($driveInfo.FreeSpace / 1MB, 2)
        If ($freeMB -lt $PFSize){$PFSize = $freeMB-($freeMB * 0.1)}



        Set-RegKey -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "$strName $PFSize $PFSize"
        Log-Me "New: $strName;$PFSize;$PFSize" -Disp $False
        Remove-Variable -Name RAM,PFSizeMB,PFSize,CurrentPageFile,NewDrive,strName,driveInfo,freeMB,Min,Max -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Power{
        Log-Me "Power Plan"
        $Scheme = ((powercfg /getactivescheme) -split '\(|\)')[1] 
        Log-Me "Power Plan Orig: $Scheme" -Disp $true
        
        Clean-PowerPlans
        $NewGUID = Get-PowerGUID
        Start-Sleep -Seconds 3
        powercfg -setactive $NewGUID | Out-Null
        Start-Sleep -Seconds 3
        powercfg -setacvalueindex $NewGUID 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0 | Out-Null    # AC Wireless Adapter Power (Plugged in)
        powercfg -setdcvalueindex $NewGUID 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0 | Out-Null    # DC Wireless Adapter Power (Battery)
        powercfg -setacvalueindex $NewGUID SUB_PROCESSOR PROCTHROTTLEMIN 100 | Out-Null    # AC CPU MIN(Plugged in)
        powercfg -setdcvalueindex $NewGUID SUB_PROCESSOR PROCTHROTTLEMIN 75 | Out-Null    # DC CPU MIN(Battery)
        powercfg -setacvalueindex $NewGUID SUB_PROCESSOR PROCTHROTTLEMAX 100 | Out-Null    # AC CPU Max(Plugged in)
        powercfg -setdcvalueindex $NewGUID SUB_PROCESSOR PROCTHROTTLEMAX 100 | Out-Null    # DC CPU Max(Battery)
        powercfg -setacvalueindex $NewGUID SUB_DISK DISKIDLE 0 | Out-Null    # AC Disk Sleep (Plugged in)
        powercfg -setdcvalueindex $NewGUID SUB_DISK DISKIDLE 0 | Out-Null    # DC Disk Sleep (Battery)
        powercfg -setacvalueindex $NewGUID SUB_SLEEP STANDBYIDLE 1800 | Out-Null    # AC (Plugged in) - Sleep Timer (30 mins)
        powercfg -setdcvalueindex $NewGUID SUB_SLEEP STANDBYIDLE 900 | Out-Null     # DC (Battery) - Sleep Timer (15 mins)
        powercfg -setacvalueindex $NewGUID SUB_SLEEP HYBRIDSLEEP 0 | Out-Null       # AC (Plugged in) - Disable Hybrid Sleep
        powercfg -setdcvalueindex $NewGUID SUB_SLEEP HYBRIDSLEEP 0 | Out-Null       # DC (Battery) - Disable Hybrid Sleep
        powercfg -setacvalueindex $NewGUID SUB_PCIEXPRESS ASPM 0 | Out-Null       # AC (Plugged in) - PCIE Link State Power Management
        powercfg -setdcvalueindex $NewGUID SUB_PCIEXPRESS ASPM 0 | Out-Null       # DC (Battery) - PCIE Link State Power Management
        powercfg -setactive $NewGUID | Out-Null
        powercfg -h OFF | Out-Null
        $name = (powercfg /list | Select-String $NewGUID).ToString().Split('()')[1]
        Log-Me "Power Plan New: $name" -Disp $true
	    Remove-Variable -Name Guid,Matches,name -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-RegKey{
    param([Parameter(Mandatory = $true, HelpMessage = "Registry Key Path")][string]$Path,
          [Parameter(Mandatory = $true, HelpMessage = "Registry Key Name")][string]$Name,
          [Parameter(Mandatory = $true, HelpMessage = "Registry Key Value")]$Value)

	    Try{$Orig = Get-ItemPropertyValue -Path $path -Name $Name}
        Catch{$Orig = $null}

	    If ($Orig -like $value){
		    Log-Me "Reg Confirmed: $Path ;Name: $Name ;Orig: $Orig" -Disp $false
        } Else {
		    if (!(Test-Path $Path)) {
                $Orig = "NewRegKey"
			    New-Item -Path $Path -Force | Out-Null
   			    Log-Me -Msg "Reg Add: $Path" -Disp $false}
            ElseIf (!($Orig)){
                $Orig = Get-ItemPropertyValue -Path $path -Name $Name
                If ((!($orig)) -or ($Orig -like $null)){$Orig = "NewRegKey"}}

            Set-ItemProperty -Path $Path -Name $Name -Value $Value | Out-Null
		    rundll32.exe user32.dll, UpdatePerUserSystemParameters
            Log-Me -Msg "Reg Changed: $Path ;Name: $Name ;Orig: $Orig ;New: $Value" -Disp $false
		    Start-Sleep -Seconds 1}
        Remove-Variable -Name Orig,Path,Name,Value -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Registry{
        Backup-Reg
        Log-Me "Registry - VERY SLOW"
        Set-RegKey -Path "HKCU:\Control Panel\Accessibility" -Name "Animation" -Value "0"	# Accessibility - Visual Effects - Animations Effects = Disabled
        Set-RegKey -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value "1"	# hung application Handling at shutdown
        Set-RegKey -Path "HKCU:\Control Panel\Desktop" -Name "MouseTrails" -Value 0	# Mouse Settings
        Set-RegKey -Path "HKCU:\Control Panel\Desktop" -Name "MouseWheelRouting" -Value 2	# Mouse Settings
        Set-RegKey -Path "HKCU:\Control Panel\Desktop" -Name "WindowAnimation" -Value 0	# Disable Windows Animations
        Set-RegKey -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0	# Mouse Settings
        Set-RegKey -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0	# Mouse Settings
        Set-RegKey -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0	# Mouse Settings
        Set-RegKey -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Name "FolderType" -Value "NotSpecified"	# disable folder data type detection
        Set-Regkey -Path "HKCU:\Software\Microsoft\Clipboard" -Name "CloudClipboardSyncEnabled" -Value 0	# Disable Clipboard Internet Syncing
        Set-Regkey -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Value 0	# Disable Clipboard History
        Set-RegKey -Path "HKCU:\Software\Microsoft\Edge\Performance" -Name "PerformanceModeEnabled" -Value 1	# Browser Performance
        Set-RegKey -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1	# Enable Game Mode
        Set-RegKey -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1	# Game Mode
        Set-RegKey -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection"  -Value 1	# Restrict Inking Data Transmission
        Set-RegKey -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1	# Restrict Typing Data Transmission
        Set-RegKey -Path "HKCU:\Software\Microsoft\Lighting" -Name "UseDynamicLighting" -Value 0	# Personalization - Dynamic Lighting - Use Dynamic Lighting on my device = disabled
        Set-RegKey -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0	# Disable Feedback Frequency
        Set-RegKey -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInDays" -Value 0	# Disable Feedback Frequency
        Set-Regkey -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInNanoSeconds" -Value 0	# Disable feedback frequency
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0	# Increase Process Priority for Games
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "RestartApps" -Value 0	# App Restarts
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0	# Disable Advertising ID
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value 0	# Optional: Disable other content suggestions
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0	# Disable Suggestions In Start
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0	# Disable “Tips and Tricks” and suggestions in Windows
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0	# Disable Start menu suggestions
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0	# Disable App suggestions in Settings
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0	# Disable Tips and feature highlights in Settings
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Value 0	# Disable suggestions in the Windows Timeline
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0	# Taskbar
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewOnFocus" -Value 1	# File Explorer
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableDragDrop" -Value 1	# Mouse Settings
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0	# File Explorer
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value "1"	# File Explorer opens to This PC
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1	# Change File Explorer Start location to C:
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowInfoTip" -Value 0	# File Explorer
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowPreviewHandlers" -Value 0	# File Explorer
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value 0	# Sync Popups
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0	# Show Systray Task View Button
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations" -Value 0	# Disable Start menu recommendations
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value 0	# Disable tracking of recently opened items
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 1	# Display Full Path - Title Bar
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPathAddress" -Value 1	# Display Full Path - Address Bar
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0	# Disable Startup Delay
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "WaitForIdleState" -Value 0	# Disable Startup Delay
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2	# Visual Settings - Max Performance
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" -Value 0	#Privacy and Security - General
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0	#Privacy and Security - General
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0	# System - Notifications- Notifications = Disabled
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value "0"	# Disable Websearch In Start
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0	# Disable AI-powered search
        Set-Regkey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0	# Disable AI-powered search
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Value 0	# Privacy & Security - Search - Search My Accounts = Disabled
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SearchMode" -Value 2	# Privacy & Security - Search - Enhanced Search
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0	# Accessibility - Visual Effects - Transparency effects = Disabled
        Set-RegKey -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value 0	# Disable Out Of Box Experience
        Set-RegKey -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value "1"	# Disable Tailored Experience
        Set-RegKey -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions " -Value "1"	# Disable Search Suggestions
        Set-Regkey -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1	# Disable AI-powered search
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value "ffffffff"	#Disable Network Throttling
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value "10"	#Multimedia Class Scheduler Service - Background reservation
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Value "High"	#Game Scheduling Priority
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value "0"	# Disable Location Tracking
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny"	# Disable Location Tracking
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Value 0	# Windows Update - Advanced Options - Delivery Optimization - Allow Downloads from other devices = Disabled
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableDragDropBreadcrumb" -Value 1	# Mouse Settings
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Value "Off"	# Data Collection
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0	# Data Collection
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "DehydrateCloudFilesThresholdDays" -Value 30	# Storage Sense - Cleanup old local copies
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "DeleteDownloadsFolder" -Value 1	# Storage Sense - Auto Downloads Cleanup
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "DeleteTempFiles" -Value 1	# Storage Sense - Auto Temp File Cleanup
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value "1"	# Disable Windows Hardware Error Reporting (WHEA)
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Edge" -Name "ConfigureDoNotTrack" -Value "1"	# Edge "Do Not Track" advertisement
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Edge" -Name "PersonalizationReportingEnabled" -Value "0"	# Disable Edge Personalization Data transmission
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Edge" -Name "ShowRecommendationsEnabled" -Value "0"	# Edge Reccomendations
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1	# Disable implicit handwriting and text data collection
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting" -Value 1	# Defender Submissions
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Value 1	# Defender Submissions
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value "1"	# Disable Advertising ID
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value 1	# Disable Inventory Collector
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Value 1	# Disable Steps Recorder
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerFeatures" -Value 1	# Disable automatic installation of suggested apps
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1	# Silently installing or recommending apps
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0	# Data Collection
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value "1"	# Disable Feedback Notifications
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Value "0"	# Disable Delivery Optimization
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\OOBE" -Name "DisablePrivacyExperience" -Value 1	#Disable Out Of Box Experience
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "AllowStorageSenseGlobal" -Value 1	# Storage Sense - Enable Globally
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "AllowStorageSenseTemporaryFilesCleanup" -Value 1	# Storage Sense - Auto Temp File Cleanup
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "ConfigStorageSenseCloudContentDehydrationThreshold" -Value 30	# Storage Sense - Cleanup old local copies
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "ConfigStorageSenseDownloadsCleanupThreshold" -Value 90	# Storage Sense - Downloads threshold
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\StorageSense" -Name "ConfigStorageSenseGlobalCadence" -Value 2	# Storage Sense - Cleanup Cadence
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0	# Disable recordings of user activity
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0	# Disable storing User's activity history
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0	# Disable Submission of User's activity history to MS
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1	# Disable windows error reporting
        Set-RegKey -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0	# Disable Cortana
        Set-Regkey -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "EnableDynamicContentInWSB" -Value 0	# Registry path for Search Highlights
        Set-RegKey -Path "HKLM:\System\ControlSet001\Services\Ndu" -Name "Start" -Value "3"	# Network Data Usage Monitor - Manual Start
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "2000"	# System Settings
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2	# Hardware-Accelerated GPU Scheduling
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Power\PowerSettings\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMax" -Value 0	# Disable Core Parking
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Power\PowerSettings\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMin" -Value 0	# Disable Core Parking
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1	# Disable Power Throttling
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 26	# Set Processor Scheduling to Programs
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value "0"	# Reboot Refreshes Pagefile
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 0	# Set Processor Scheduling to Programs
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher" -Value 0	# Disable Prefetch
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnableSuperfetch" -Value 0	# Disable Super fetch
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Value "30"	# more room for drivers
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Value "0"	# Disable Location Tracking
        Set-RegKey -Path "HKLM:\System\CurrentControlSet\Services\USB" -Name "DisableSelectiveSuspend" -Value 1	# DisableSelectiveSuspend
        Set-RegKey -Path "HKLM:\System\Maps" -Name "AutoUpdateEnabled" -Value "0"	# Disable Location Tracking
	
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-ScheduleTask {
      param([Parameter(Mandatory = $true, HelpMessage = "Schedule Task Name")][string]$Name,
            [Parameter(Mandatory = $true, HelpMessage = "Schedule Task Path")][string]$Path,
            [Parameter(Mandatory = $false, HelpMessage = "Enable = True")]$Enable)

        $task = Get-ScheduledTask -TaskPath $Path -TaskName $Name -ErrorAction SilentlyContinue
        foreach ($task in $tasks) {
            If ($Enable) {}
                Log-Me -Msg "Schedule Task: $task.TaskName ;Enabled: $Enable"
                Try{Enable-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath -ErrorAction SilentlyContinue}
                Catch {}
            Else {
                Log-Me -Msg "Schedule Task: $task.TaskName ;Enabled: $Enable"
                Disable-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath -ErrorAction SilentlyContinue | Out-Null
                while ((Get-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath).State -ne 'Disabled') {Start-Sleep -Milliseconds 200}}
                }}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Service{
    param([Parameter(Mandatory = $true, HelpMessage = "Service Name")][string]$Name,
          [Parameter(Mandatory = $true, HelpMessage = "Startup Type")]$Start,
          [Parameter(Mandatory = $false, HelpMessage = "Display")]$Disp = $true)

            If (Get-Service -Name $Name){
		        $Service = Get-Service -Name $Name
                If ($Service.count -gt 1){
                    foreach ($svc in $Service) {
                        $OrigStart = $svc.starttype
		                $svc | Set-Service -StartupType $Start | Out-Null
                        If (($Start -like "Manual") -or ($Start -like "Disabled")){$svc | Stop-Service -Force -NoWait}
                        If ($Disp -like $true){Log -Me -Msg "Service Change: $Name ; New: $start ; Orig: $OrigStart" -Disp $true}
                        Else {Log -Me -Msg "Service Change: $Name ; New: $start ; Orig: $OrigStart" -Disp $false}}}
                Else {
                    $OrigStart = $service.starttype
		            $Service | Set-Service -StartupType $Start | Out-Null
                    If (($Start -like "Manual") -or ($Start -like "Disabled")){$svc | Stop-Service -Force -NoWait}
                    If ($Disp -like $true){Log-Me -Msg "Service Change: $Name ; New: $start ; Orig: $OrigStart" -Disp $true}
                    Else {Log-Me -Msg "Service Change: $Name ; New: $start ; Orig: $OrigStart" -Disp $false}}}
        
            Remove-Variable -Name Service,svc,OrigStart -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Services{
        Log-Me "Tuning Services" -Disp $true
        $ManualServices = Get-ServiceList -Type "Manual" 
        Foreach ($svc in $ManualServices){
            $orig = (Get-Service -Name $svc).StartType
            Set-Service -Name $SVC -Start "Manual" -disp $false}
        
        $DisabledServices = Get-ServiceList -Type "Disabled"
        Foreach ($svc in $DisabledServices){
            $orig = (Get-Service -Name $svc).StartType
            Set-Service -Name $SVC -Start "Disabled" -Disp $false}

        Remove-Variable -Name ManualServices,DisabledServices,svc,orig -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-SupPackages{
        Log-Me "Superseded Packages"
        $Packages = Get-WindowsPackage -Online | Where-object {$_.PackageState -eq "Superseded"}
        Foreach ($Package in $Packages){
            $Name = $Package.PackageName
            if ($name -notcontains "PowerShell-ISE"){
                $Package | Remove-WindowsPackage -NoRestart -Online -ErrorAction SilentlyContinue | Out-Null
                Log-Me "Rem:$Name" -Disp $false}}
        Remove-Variable -Name Packages,Package,Name -ErrorAction SilentlyContinue | out-null
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-System{
        Log-Me "System"
        fsutil behavior set disablelastaccess 1 | Out-Null #Disable Last Access Timestamping
        bcdedit /set disabledynamictick yes | Out-Null 	# disables Dynamic Ticks
        bcdedit /deletevalue useplatformclock | Out-Null 	# Remove outdated High Precision Event Timer
        Start-Sleep -Seconds 3}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Tasks{
        Log-Me "Scheduled Tasks"
        Get-ScheduledTask | Where-Object {$_.TaskName -match "CCleaner|Consolidator|UsbCeip|Adobe|Edge|Google|Office"} | 
            Set-ScheduleTask -Name $_.Taskname -Path $_.TaskPath -Enable $false}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Set-Verbose{
        set-regkey -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value 1}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
    Function Stop-UpdateServices{
        $WuServices = @(
            'wuauserv',   # Windows Update
            'bits',       # Background Intelligent Transfer Service
            'cryptsvc',   # Cryptographic Services
            'appidsvc',   # Application Identity (used in some MS scripts)
            'msiserver')   # Windows Installer (often stopped in reset recipes)
        foreach ($svc in $WuServices) {
            Stop-Service -ServiceName $Svc -Force | Out-Null
            Log-Me "Service Stopped: $svc" -Disp $false}
        Remove-Variable WuServices,svc -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Start-UpdateServices{
    $WuServices = @(
        'wuauserv',   # Windows Update
        'bits',       # Background Intelligent Transfer Service
        'cryptsvc',   # Cryptographic Services
        'appidsvc',   # Application Identity
        'msiserver')   # Windows Installer
    foreach ($svc in $WuServices) {
        Start-Service -ServiceName $svc | Out-Null
        Log-Me "Service Started: $svc" -Disp $false}
    Remove-Variable WuServices,svc -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
    Function Test-CPU{
    param([Parameter(Mandatory = $False, HelpMessage = "Original Value")][string]$OrigVal,
    [Parameter(Mandatory = $False, HelpMessage = "Display Messages")][Bool]$Disp = $True)
        Log-Me "Testing - CPU - SLOW" -Disp $Disp
        $outputComp = & winsat cpu -compression
        $Line = $outputComp | Where-Object { $_ -like "*> CPU LZW Compression*" }
        $Item = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 1
        $Comp = ($Item -split '\.')[0]
        $Comp = [int](([int]$Comp)*10)

        $outputEnc  = & winsat cpu -encryption
        $Line = $outputEnc | Where-Object { $_ -like "*> CPU AES256 Encryption*" }
        $Item = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 1
        $Encr = ($Item -split '\.')[0]
        
        $Score = [int]([int]$Comp + [int]$Encr)
        Log-Me -Msg "CPU Score: $Score" -Disp $Disp
        If ($OrigVal){
            $Diff = $Score - $OrigVal
            Log-Me -Msg "Difference: $Diff" -Disp $Disp
            Remove-Variable -Name Diff | Out-Null} 

        Remove-Variable -Name OrigVal,Disp,outputComp,Line,Item,Comp,outputEnc,Encr -ErrorAction SilentlyContinue | out-null
        Return $Score}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Test-Disk{
    param([Parameter(Mandatory = $False, HelpMessage = "Original Value")][string]$OrigVal,
    [Parameter(Mandatory = $False, HelpMessage = "Display Messages")][Bool]$Disp = $True)
        Log-Me "Testing - Disk" -Disp $Disp
        Start-Sleep -Seconds 3
        $output = & winsat disk -seq -read 2>&1
        $Line = $output | Where-Object { $_ -like "*> Disk  Sequential 64.0 Read*" }
        $Item = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 2 | Select-Object -first 1
        $DiskSeq64ReadInt = ($Item -split '\.')[0]
        Start-Sleep -Seconds 1
        $output = & winsat disk -seq -write 2>&1
        $Line = $output | Where-Object { $_ -like "*> Disk  Sequential 64.0 Write*" }
        $Item = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 2 | select -first 1
        $DiskSeq64WriteInt = ($Item -split '\.')[0]
        Start-Sleep -Seconds 1
        $output = & winsat disk -ran -write 2>&1
        $Line = $output | Where-Object { $_ -like "*> Disk  Random 16.0 Write*" }
        $Item = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 1
        $DiskRand16WriteInt = ($Item -split '\.')[0]
        $DiskRand16WriteInt = [int]([int]$DiskRand16WriteInt*10)
    
        $Score = [int]$DiskSeq64ReadInt + [int]$DiskSeq64WriteInt + [int]$DiskRand16WriteInt
        Log-Me -Msg "Disk Score: $Score" -Disp $Disp
        If ($OrigVal){
            $Diff = $Score - $OrigVal
            Log-Me -Msg "Difference: $Diff" -Disp $Disp
            Remove-Variable -Name Diff -ErrorAction SilentlyContinue | out-null} 
        

        Remove-Variable -Name OrigVal,disp,output,Line,Item,DiskSeq64ReadInt -ErrorAction SilentlyContinue | out-null
        Remove-Variable -Name DiskSeq64WriteInt,DiskRand16WriteInt -ErrorAction SilentlyContinue | out-null
        Return $Score} 
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Test-GPU{
    param([Parameter(Mandatory = $False, HelpMessage = "Original Value")][string]$OrigVal,
    [Parameter(Mandatory = $False, HelpMessage = "Display Messages")][Bool]$Disp = $True)
        Log-Me "Testing - GPU" -Disp $Disp
        $output = & winsat d3d -dx10 -batch -f 2>&1
        $Line = $output | Where-Object { $_ -like "*> Direct3D Batch Performance*" }
        $Direct3DBatch = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 1
        $Score1 = [int]($Direct3DBatch -split '\.')[0]
        $Score1 = [int](([int]$Score1)*1000)
        
        $output = & winsat dwm 2>&1
        $Line = $output | Where-Object { $_ -like "*> Video Memory Throughput*" }
        $VideoMemoryThroughput = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 1
        $Score2 = [int]($VideoMemoryThroughput -split '\.')[0]
        $Score2 = [int](([int]$Score2)/10)
        
        $Score = [int]([int]$Score1 + [int]$Score2)
        Log-Me -Msg "GPU Score: $Score" -Disp $Disp
        If ($OrigVal){
            $Diff = $Score - $OrigVal
            Log-Me -Msg "Difference: $Diff" -Disp $Disp
            Remove-Variable -Name Diff | Out-Null}
        
    
        Remove-Variable -Name OrigVal,disp,output,Line,Direct3DBatch,Score1,Score2 -ErrorAction SilentlyContinue | out-null
        Return $Score}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Test-RAM{
    param([Parameter(Mandatory = $False, HelpMessage = "Original Value")][string]$OrigVal,
    [Parameter(Mandatory = $False, HelpMessage = "Display Messages")][Bool]$Disp = $True)
        Log-Me "Testing - RAM" -Disp $Disp
        $output = & winsat mem 2>&1
        $Line = $output | Where-Object { $_ -like "*> Memory Performance*" }
        $Score = ($Line -split "\s{2,}") | Where-Object { $_.Trim() } | Select-Object -Last 1
        $ScoreInt = [int]($Score -split '\.')[0]
        Log-Me -Msg "RAM Score: $ScoreInt" -Disp $Disp

        If ($OrigVal){
            $Diff = $ScoreInt - $OrigVal
            Log-Me -Msg "Difference: $Diff" -Disp $Disp
            Remove-Variable -Name Diff -ErrorAction SilentlyContinue | out-null}
        
    
        Remove-Variable -Name OrigVal,disp,output,Line,Score -ErrorAction SilentlyContinue | out-null
        Return $ScoreInt}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Test-Resp {
    param([Parameter(Mandatory = $False, HelpMessage = "Original Value")][string]$OrigVal,
    [Parameter(Mandatory = $False, HelpMessage = "Display Messages")][Bool]$Disp = $True)
        Log-Me "Testing - Response Time" -Disp $Disp
        do {
            $start = [DateTime]::Now
            1..5 | ForEach-Object {$position = [System.Windows.Forms.Cursor]::Position}
            $end = [DateTime]::Now
            $responseTime = ($end - $start).ticks
        } while (($responseTime -eq 0) -or ($responseTime -ge 99999))

        Log-me "ResponseTime: $responseTime" -Disp $Disp
        
        If ($OrigVal){
            $Diff = $responseTime - $OrigVal
            Log-me "ResponseTime change: $Diff" -Disp $Disp
            Remove-Variable -Name Diff -ErrorAction SilentlyContinue | out-null}
        
        Remove-Variable -Name OrigVal,Disp,start,end -ErrorAction SilentlyContinue | out-null
        Return $responseTime}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Test-Speed{
        Stop-Process -Name explorer -Force
        Wait-CPU
        $OScore = Get-OrigCompScore
        Log-Me -Msg "Speed Testing: $script:ComputerName" -Disp $false
        $CPU = Test-CPU
        Log-Me -Msg "CPU: $CPU" -Disp $false
        $RAM = Test-RAM
        Log-Me -Msg "RAM: $RAM" -Disp $false
        $Disk = Test-Disk
        Log-Me -Msg "DISK: $Disk" -Disp $false
        $GPU = Test-GPU
        Log-Me -Msg "GPU: $GPU" -Disp $false
        $Response = Test-Resp
        Log-Me -Msg "RESP TIME: $Response" -Disp $false
        $CompScore = [int]($CPU + $RAM + $Disk + $GPU - ($Response/10))
        Log-Me -Msg "Computer Score: $CompScore" -Disp $true
        If ($OScore){
            Log-Me -Msg "Original Computer Score: $OScore" -Disp $true
            $DiffCompScore = $CompScore - $OScore
            $DiffPerc = [int](($DiffCompScore/$CompScore)*100)
            Log-Me -Msg "Improvement: $DiffPerc %" -Disp $true}
        Remove-Variable CPU,RAM,Disk,GPU,Response,CompScore,OScore -ErrorAction SilentlyContinue | out-null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Verify-RemoteHash {
        $CurrentScript = $PSCommandPath
        $Hash = (Get-FileHash -Path $CurrentScript).hash
        $Url = "https://gurutecllc.com/guru-tools/p/gurutune?format=json"
        $json = Invoke-WebRequest $Url -UseBasicParsing
        $data = $json.Content | ConvertFrom-Json
        $body = $data.item.excerpt
        $RemoteHash = ($body -replace '<[^>]+>', '') -replace '.*\.PS1 SHA256:\s*([A-F0-9]{64}).*','$1'
        if ($RemoteHash) {
            If ($RemoteHash -like $Hash){
                Log-Me -Msg "Remote Hash Verified" 
                Remove-Variable -Name CurrentScript,Hash,Url,json -ErrorAction SilentlyContinue | out-null
                Remove-Variable -Name data,body -ErrorAction SilentlyContinue | out-null
                Return $true}
            Else {
                Log-Me -Msg "Verifying Hash Failed" -Disp $false
                $strMsg = “
**********************************    
                 
           GuruTune 
                                              
**********************************    

Local and Remote Hash Mismatch!
Proceed with caution if you did 
    not change the file!

**********************************    

 Please visit: GuruTecLLC.Com to 
 obtain the most updated version
    and verify hash files.


**********************************    
  Email if I can assist in any way.              


        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
                $Response = [System.Windows.Forms.MessageBox]::Show($strMsg,"Cannot Verify Online Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
                If ($Response -like "Cancel"){
                    Log-Me -Msg "Remote Hash Check Failed: Cancelling"
                    Remove-Variable -Name CurrentScript,Hash,Url,json -ErrorAction SilentlyContinue | out-null
                    Remove-Variable -Name data,body,strMsg,Response -ErrorAction SilentlyContinue | out-null
                    Return $false}
                Else {
                    Log-Me -Msg "Remote Hash Check Failed: Proceeding"
                    Remove-Variable -Name CurrentScript,Hash,Url,json -ErrorAction SilentlyContinue | out-null
                    Remove-Variable -Name data,body,strMsg,Response -ErrorAction SilentlyContinue | out-null
                    Return $true}}}
        Else{
            Log-Me -Msg "Hash Check Failed - Could not verify remote Hash" -Disp $false
            $strMsg = “
**********************************    
                 
           GuruTune 
                                              
**********************************    

Local and Remote Hash Mismatch!
Proceed with caution if you did 
    not change the file!

**********************************    

 Please visit: GuruTecLLC.Com to 
 obtain the most updated version
    and verify hash files.


**********************************    
  Email if I can assist in any way.              


        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
            #$Response = [System.Windows.MessageBox]::Show($strMsg,"Cannot Verify Online Version","OKCancel","exclamation")
            $Response = [System.Windows.Forms.MessageBox]::Show($strMsg,"Cannot Verify REmote Hash",[System.Windows.Forms.MessageBoxButtons]::OKCancel,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            If ($Response -like "Cancel"){
                Log-Me -Msg "Remote Hash Check Failed: Cancelling"
                Remove-Variable -Name CurrentScript,Hash,Url,json -ErrorAction SilentlyContinue | out-null
                Remove-Variable -Name data,body,strMsg,Response -ErrorAction SilentlyContinue | out-null
                Exit}
            Else {
                Log-Me -Msg "Remote Hash Check Failed: Proceeding"
                Remove-Variable -Name CurrentScript,Hash,Url,json -ErrorAction SilentlyContinue | out-null
                Remove-Variable -Name data,body,strMsg,Response -ErrorAction SilentlyContinue | out-null
                Return $true}}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        
    Function Verify-RemoteVersion{
        $localVersion = [version]$script:Version
        $remoteVersion = Get-RemoteVersion
        if ($remoteVersion -eq $null -or $remoteVersion -eq "Not Found") {
            $strMsg = “
**********************************    
                 
           GuruTune
                                              
**********************************    

    Cannot Verify Online Version
        Proceed with caution.

**********************************    

 Please visit: GuruTecLLC.Com to 
 obtain the most updated version.


**********************************    
  Email if I can assist in any way.              



        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
            #[System.Windows.MessageBox]::Show($strMsg,"Cannot Verify Online Version","OK","exclamation")
            $Response = [System.Windows.Forms.MessageBox]::Show($strMsg,"Cannot Verify Remote Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            If ($Response -like "Cancel"){
                Log-Me -Msg "Remote Version Check Failed: Cancelling"
                Remove-Variable -Name CurrentScript,Hash,Url,json -ErrorAction SilentlyContinue | out-null
                Remove-Variable -Name data,body,strMsg,Response -ErrorAction SilentlyContinue | out-null
                Exit}
            
            Log-Me -Msg "Version Check Failed - Online Version Not Found" -Disp $false
            Remove-Variable -Name localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null
            Return $false}
        elseif ($remoteVersion -gt $localVersion) {
            Log-Me -Msg "Update available! Please update to version: $remoteVersion" -Disp $true
            $strMsg = “
**********************************    
        
    Guru Tune Needs to be updated.
        
**********************************  
              
        GuruTune Version $script:Version
        Current Version $remoteVersion

                                              
**********************************    

    Please update to the current version 

            prior to use!
**********************************    
                            

        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
            [System.Windows.Forms.MessageBox]::Show($strMsg,"Update Found",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            #[System.Windows.MessageBox]::Show($strMsg,"Older Version Found!","OK","exclamation")
            Start-Process "https://www.gurutecllc.com/guru-tools/p/gurutune"
            Remove-Variable -Name localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null
            Exit}
        else {
            Log-Me -Msg "Guru Tune Version Confirmed" -Disp $true
            Remove-Variable -Name localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null
            Return $true}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Verify-OS{
        $OSVer = (Get-WmiObject -class Win32_OperatingSystem).Caption
        If (!($OSVer.contains("Windows 11"))) {
            $strMsg = “
**********************************    
                 
           GuruTune
                                              
**********************************    

      Windows 11 Required

**********************************    

I would HIGHLY recommend upgrading as 
   Microsoft has 'End Of Lifed' 
    Windows 10 in October 2025.


**********************************    
  Email if I can assist in any way.              



        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
            #[System.Windows.MessageBox]::Show($strMsg,"Invalid Operating System","OK","exclamation")
            [System.Windows.Forms.MessageBox]::Show($strMsg,"Invalid Operating System",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            Return $false}
        Else {Return $true}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Verify-Version{
        $localVersion = [version]$script:Version
        $remoteVersion = Get-RemoteVersion
        if ($remoteVersion -eq $null -or $remoteVersion -eq "Not Found") {
            $strMsg = “
**********************************    
                 
           GuruTune
                                              
**********************************    

    Cannot Verify Online Version
        Proceed with caution.

**********************************    

 Please visit: GuruTecLLC.Com to 
 obtain the most updated version.


**********************************    
  Email if I can assist in any way.              



        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
            #[System.Windows.MessageBox]::Show($strMsg,"Cannot Verify Online Version","OK","exclamation")
            [System.Windows.Forms.MessageBox]::Show($strMsg,"Cannot Verify Online Version",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            Log-Me -Msg "Version Check Failed" -Disp $false
            Remove-Variable -Name localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null}
        elseif ($remoteVersion -gt $localVersion) {
            Log-Me -Msg "Update available! Please update to version: $remoteVersion" -Disp $true
            $strMsg = “
**********************************    
        
    Guru Tune Needs to be updated.
        
**********************************  
              
        GuruTune Version $script:Version
        Current Version $remoteVersion

                                              
**********************************    

    Please update to the current version 

            prior to use!
**********************************    
                            

        Have A Blessed Day!

**********************************    
                            
            ~ Guru
        GuruTecLLC@Gmail.com"
            #[System.Windows.MessageBox]::Show($strMsg,"Update Available!","OK","exclamation")
            [System.Windows.Forms.MessageBox]::Show($strMsg,"Update Available!",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Exclamation)
            Start-Process "https://www.gurutecllc.com/guru-tools/p/gurutune"
            Remove-Variable -Name localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null
            Remove-Variable * -Scope Script -Force -ErrorAction SilentlyContinue | Out-Null
            Exit}
        else {
            Log-Me -Msg "Guru Tune Version Confirmed" -Disp $true
            Remove-Variable -Name localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Verify-VSSRunning{
        $Result = $true
        $strVSS = (vssadmin list shadowstorage)
        If (($strVSS -like "No items found*") -or ($strVSS -like "No shadow copy*")){
            $freeGB = [math]::Round((Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='c:'").FreeSpace / 1GB,2)
            If ($freeGB -ge 5){
                Enable-ComputerRestore -Drive "C:"
                Checkpoint-Computer -Description "GuruTune Pre-change Restore Point" -RestorePointType "MODIFY_SETTINGS"
                vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=3GB
                $Result = $true}
            Else{
                $msgBox = New-Object System.Windows.Forms.Form
                $msgBox.TopMost = $true
                $msgBox.StartPosition = "CenterScreen"
                $msgBox.Size = New-Object System.Drawing.Size(1,1)
                $msgBox.ShowInTaskbar = $false
                $msgBox.Show()
                $msgBox.Activate()
                $strMsg = "
*******************************************
                GuruTune

*******************************************
        Not Enough Shadow Copy Space
*******************************************
    I cannot expand the shadow copy storage
        Due to a lack of disk space.

I will not be able to create a Restore Point!

        Please proceed with caution or
        free up some storage space.

        Press 'OK' to proceed anyway.
*******************************************
            Donations Accepted @:

https://www.gurutecllc.com/donate-today

            Have A Blessed Day,
                ~ Guru
          
            GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
                $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Out of Space",[System.Windows.Forms.MessageBoxButtons]::OKCancel,[System.Windows.Forms.MessageBoxIcon]::Information)
                $msgBox.Close()
                If ($Response -like "Cancel"){
                    Log-Me -Msg "VSS Failed: Cancelling"
                    Remove-Variable -Name Result,strVSS,freeGB,msgBox,strMsg,response -ErrorAction SilentlyContinue | out-null
                    Exit}
                Else {
                    Log-Me -Msg "VSS Failed: Proceeding"
                    $Result =  $false}}}
        Else{$Result = $true}
        Set-RegKey -Path "HKLM:\Software\Microsoft\Windows" -Name "Animation" -Value "0"	# Accessibility - Visual Effects - Animations Effects = Disabled
        Remove-Variable -Name strVSS,freeGB,msgBox,strMsg,response -ErrorAction SilentlyContinue | out-null
        return $Result}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   
    Function Wait-CPU{
        Log-Me "Waiting on CPU"
        Start-Sleep -Seconds 5
        $CPU = [math]::Round((Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue, 2)
        If ($CPU -gt 5){
            Log-Me "Waiting on CPU - Very Slow"
            Start-Sleep -Seconds 10
            $CPU = [math]::Round((Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue, 2)
            If ($CPU -gt 5){Start-Sleep -Seconds 15}}
        Remove-Variable -Name CPU -ErrorAction SilentlyContinue | out-null}



############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#### Form Functions    
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
    $CheckRevertSvc = {
        $revert = $false
        [string]$LogFile   = Get-EarliestLogfile
        [string]$SearchStr = "Service Change:"
        $results = Select-String -Path $LogFile -Pattern $SearchStr -SimpleMatch

        if ($results) {$revert = $true}
        Remove-Variable -Name LogFile,SearchStr,results -ErrorAction SilentlyContinue | out-null
        $RevSVCButton.Enabled = $revert}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    $CheckRevertReg = {
        $revert = $false
        [string]$LogFile   = Get-EarliestLogfile
        [string]$SearchStr = "Reg Changed: "
        [string]$ignoreStr = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management ;Name: PagingFiles"
        $results = Select-String -Path $LogFile -Pattern $SearchStr -SimpleMatch

        if ($results) {
            $valid = $results | Where-Object { $_.Line -notlike "*$ignoreStr*" }
            if ($valid) {$revert = $true}}
        Remove-Variable -Name LogFile,SearchStr,ignoreStr,results -ErrorAction SilentlyContinue | out-null
        $RevRegButton.Enabled = $revert}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    $UpdateGoButtonState = {
        $anyChecked = $false
        foreach ($ctrl in $toggleControls.Values) {
            if ($ctrl.Checked) {$anyChecked = $true
                break}}
        foreach ($ctrl in $toggleControls.Values) {
            if ($ctrl.Checked) {$anyChecked = $true
                break}}
        foreach ($ctrl in $toggleControls.Values) {
            if ($ctrl.Checked) {$anyChecked = $true
                break}}
    $goButton.Enabled = $anyChecked}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
    Function Go-Pressed{
        Log-Me "Guru Tune Version $script:Version" -Disp $false
            $top = New-Object System.Windows.Forms.Form
            $top.TopMost = $true
            $top.ShowInTaskbar = $false
            $top.WindowState = 'Minimized'
            $top.Show()
            $top.Hide()
            $strMsg = "
                      Guru Tune Version $script:Version
        ************************************
                    
                          Welcome $script:Username

        ************************************
                       Some Steps are SLOW
                    
                 Please run when you have 
                    TIME and can REBOOT
        ************************************
                        For best results, 
                please CLOSE all apps and 
            STOP all activity until completion

        ************************************

           Do not run on Company Devices, or if 
           you use web hosting, Hyper-V, TFTP 
                   or Linux services
   
        ************************************
               Press 'OK' When you are ready
                            to proceed
   
        ************************************
                    Have A Blessed Day

                            ~Guru
                GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
            $response = [System.Windows.Forms.MessageBox]::Show($top,$strMsg,"Guru Tune Version $script:Version",[System.Windows.Forms.MessageBoxButtons]::OKCancel)
            $top.Dispose()
            if ($response -ne "OK") {
                Remove-Variable -Name top,strMsg,response -ErrorAction SilentlyContinue | out-null
                Return}
            Log-Me -Msg $script:ComputerName -Disp $false
            $script:Start = Get-Date
            Log-Me -Msg "Start Time: $script:Start" -Disp $true
            $script:RebootRequired = $false
            
            $otherStates = $toggleControls.Keys | Where-Object {$_ -notin @("SpeedTest", "Report")} | Where-Object { $toggleControls[$_].CheckState -ne [System.Windows.Forms.CheckState]::Unchecked } | ForEach-Object { $toggleControls[$_].CheckState }
            If ($otherStates){
                If ((Verify-VSSRunning -like $true) -and (Get-VSSSpace -like $true)){
                    $SystemChanges = $toggleControls.GetEnumerator() | Where-Object { $_.Key -notin @("Report", "SpeedTest","Clean","DiskCheck","DISM","SFC") } | Select-Object -ExpandProperty Value
                    if ($SystemChanges) {
                        Log-Me "Creating Restore Point - SLOW" -Disp $true
                        Set-RegKey -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Value 15
	                    Checkpoint-Computer -Description "GuruTune Pre-change Restore Point" -RestorePointType "MODIFY_SETTINGS"}}}

            if (($toggleControls["SpeedTest"].CheckState -eq [System.Windows.Forms.CheckState]::Checked) -and ($otherStates -contains [System.Windows.Forms.CheckState]::Checked)){Test-Speed}

            If ($toggleControls["Power"].Checked){Set-Power}
            If ($toggleControls["Pagefile"].Checked){Set-Pagefile
                $script:RebootRequired = $true}
            If ($toggleControls["System"].Checked){Set-System
                $script:RebootRequired = $true}
            If ($toggleControls["Network"].Checked){Set-Network}
            If ($toggleControls["Registry"].Checked){Set-Registry
                $script:RebootRequired = $true}
            If ($toggleControls["Services"].Checked){Set-Services
                $script:RebootRequired = $true}
            If ($toggleControls["Appx"].Checked){Set-Appx
                $script:RebootRequired = $true}
            If ($toggleControls["Features"].Checked){Set-Features
                $script:RebootRequired = $true}
            If ($toggleControls["Packages"].Checked){Set-Packages
                $script:RebootRequired = $true}
            If ($toggleControls["Tasks"].Checked){Set-Tasks
                $script:RebootRequired = $true}
            If ($toggleControls["MSUpdates"].Checked){Reset-WindowsUpdates}
            If ($toggleControls["Disable Recall"].Checked){Disable-Recall
                 $script:RebootRequired = $true}
#            If ($toggleControls["Remove Co-Pilot"].Checked){Remove-Copilot
                 #$script:RebootRequired = $true}
#            If ($toggleControls["Remove OneDrive"].Checked){Remove-OneDrive}
            If ($toggleControls["Disable Indexing"].Checked){Disable-Indexing
                 $script:RebootRequired = $true}
            If ($toggleControls["Verbose"].Checked){Set-Verbose}
            #If ($toggleControls["Remove Web Exp"].Checked){Remove-WebExperience
            #     $script:RebootRequired = $true}
            If ($toggleControls["Report"].Checked){Report-All}
            If ($toggleControls["DiskCheck"].Checked){Repair-Disk}
            If ($toggleControls["DISM"].Checked){Repair-DISM}
            If ($toggleControls["SFC"].Checked){Repair-SFC}
            If ($toggleControls["Clean"].Checked){Clear-Temp}
            If ($toggleControls["SpeedTest"].Checked){Test-Speed}

            $End = Get-Date
            $Diff = $end - $script:Start
            Log-Me -Msg "End Time: $End" -Disp $true
            Log-Me -Msg "Run Time: $Diff" -Disp $true

            if ($script:RebootRequired -eq $true) {
                $msgBox = New-Object System.Windows.Forms.Form
                $msgBox.TopMost = $true
                $msgBox.StartPosition = "CenterScreen"
                $msgBox.Size = New-Object System.Drawing.Size(1,1)
                $msgBox.ShowInTaskbar = $false
                $msgBox.Show()
                $msgBox.Activate()
                $strMsg = "
            Guru Has Tuned You!

*******************************************
    Many items may be slower the first time
    you open them as they need to rebuild
            their cache or temp files. 
      
            Please open them after the 
        reboot and reboot once more for
                full responsiveness.
*******************************************
        A Computer Reboot Is Required
        Press 'OK' when you are ready
*******************************************
            Donations Accepted @:

https://www.gurutecllc.com/donate-today

                Have A Blessed Day,
                        ~ Guru
          
            GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
                $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Reboot Required",
                    [System.Windows.Forms.MessageBoxButtons]::OKCancel,
                    [System.Windows.Forms.MessageBoxIcon]::Information)
                $msgBox.Close()                
                if ($response -eq [System.Windows.Forms.DialogResult]::OK) {
                    Log-Me "Rebooting" -Disp $true
                    Remove-Variable -Name SystemChanges,top,strMsg,response,End,Diff,msgBox -ErrorAction SilentlyContinue | out-null
                    Restart-Computer -Force}
                else {
                    $msgBox = New-Object System.Windows.Forms.Form
                    $msgBox.TopMost = $true
                    $msgBox.StartPosition = "CenterScreen"
                    $msgBox.Size = New-Object System.Drawing.Size(1,1)
                    $msgBox.ShowInTaskbar = $false
                    $msgBox.Show()
                    $msgBox.Activate()
                    $strMsg = "
                GuruTune

***********************************
    A Computer Reboot Is Required.

Please reboot As Soon As Possible 
        to avoid complications.

***********************************
        Have A Blessed Day,
                ~ Guru
          
        GuruTecLLC@Gmail.com
    HTTPS:\\WWW.GuruTecLLC.Com"
                    $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Reboot Required",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information)
                    $msgBox.Close()  
                    & $CheckRevertSvc
                    & $CheckRevertReg
                    $toggleControls.Values | ForEach-Object { $_.Checked = $false }
                    $UpdateGoButtonState
                    Log-Me "Reboot Aborted" -Disp $true
                    Remove-Variable -Name SystemChanges,top,strMsg,response,End,Diff,msgBox -ErrorAction SilentlyContinue | out-null}}                    
            Else {
                $msgBox = New-Object System.Windows.Forms.Form
                $msgBox.TopMost = $true
                $msgBox.StartPosition = "CenterScreen"
                $msgBox.Size = New-Object System.Drawing.Size(1,1)
                $msgBox.ShowInTaskbar = $false
                $msgBox.Show()
                $msgBox.Activate()
                $strMsg = "
                Guru Has Tuned You!
    
*******************************************
    Many items may be slower the first time
    you open them as they need to rebuild
            their cache or temp files. 
          
            Please open them and reboot 
                full responsiveness.

*******************************************
            Donations Accepted @:

https://www.gurutecllc.com/donate-today

                Have A Blessed Day,
                        ~ Guru
          
            GuruTecLLC@Gmail.com
            HTTPS:\\WWW.GuruTecLLC.Com"
                $response = [System.Windows.Forms.MessageBox]::Show($msgBox,$strMsg,"Reboot Required",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information)
                $msgBox.Close()
                & $CheckRevertSvc
                & $CheckRevertReg
                $toggleControls.Values | ForEach-Object { $_.Checked = $false }
                $UpdateGoButtonState
                Remove-Variable -Name SystemChanges,top,strMsg,response,End,Diff,msgBox -ErrorAction SilentlyContinue | out-null}}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function New-Toggle {
    param([string]$Label,
        [int]$Left,
        [int]$Top)

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text = $Label
        $cb.AutoSize = $true
        $cb.Left = $Left
        $cb.Top = $Top
        return $cb}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Function Show-form{
        $form = New-Object System.Windows.Forms.Form
        $form.Text = "Guru Tune Version $script:Version"
        $form.Size = New-Object System.Drawing.Size(500, 600)
        $form.StartPosition = "Manual"
        $screen = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
        $form.Left = $screen.Right - $form.Width
        $form.Top  = ($screen.Height - $form.Height) / 2   # optional: vertical centering
        $form.AutoScroll = $true
        $form.TopMost = $true
        $toggleControls = @{}

        $grpOptions = New-Object System.Windows.Forms.GroupBox
        $grpOptions.Text = "Options"
        $grpOptions.Left = 20
        $grpOptions.Top = 10
        $grpOptions.Width = 440
        $grpOptions.Height = 150
        $optionNames = @("Appx","Features","MSUpdates","Network","Packages","Pagefile",
            "Power","Registry","Services","System","Tasks","Verbose")
        $colPositions = @(50, 190, 330)
        $columnCount  = $colPositions.Count
        $rowCount = [math]::Ceiling($optionNames.Count / $columnCount)
        $topMargin = 10
        $bottomMargin = 10
        $availableHeight = $grpOptions.Height - $topMargin - $bottomMargin
        $rowSpacing = [math]::Floor($availableHeight / $rowCount)
        $startTop = $topMargin + [math]::Floor(($availableHeight - ($rowSpacing * ($rowCount - 1))) / 2)
        for ($i = 0; $i -lt $optionNames.Count; $i++) {
            $colIndex = $i % $columnCount
            $rowIndex = [math]::Floor($i / $columnCount)
            $left = $colPositions[$colIndex]
            $top  = $startTop + ($rowIndex * $rowSpacing)
            $cb = New-Toggle -Label $optionNames[$i] -Left $left -Top $top
            $grpOptions.Controls.Add($cb)
            $toggleControls[$optionNames[$i]] = $cb
            $cb.Add_CheckedChanged($UpdateGoButtonState)}
        $form.Controls.Add($grpOptions)

        $grpRepairs = New-Object System.Windows.Forms.GroupBox
        $grpRepairs.Text = "Repairs"
        $grpRepairs.Left = 20
        $grpRepairs.Top = $grpOptions.Bottom + 10
        $grpRepairs.Width = 440
        $grpRepairs.Height = 60
        $repairNames = @("DiskCheck","DISM","SFC")
        $colPositions = @(50, 190, 330)
        $top = 35
        for ($i = 0; $i -lt $repairNames.Count; $i++) {
            $cb = New-Toggle -Label $repairNames[$i] -Left $colPositions[$i] -Top $top
            $grpRepairs.Controls.Add($cb)
            $toggleControls[$repairNames[$i]] = $cb
            $cb.Add_CheckedChanged($UpdateGoButtonState)}
        $form.Controls.Add($grpRepairs)

        $grpActions = New-Object System.Windows.Forms.GroupBox
        $grpActions.Text = "Actions"
        $grpActions.Left = 20
        $grpActions.Top = $grpRepairs.Bottom + 10
        $grpActions.Width = 440
        $grpActions.Height = 100   # 150 for 3 rows
        $actionNames = @("Clean","Disable Indexing","Disable Recall",
            "Report","SpeedTest")
        $cols = 3
        $colPositions = @(50, 190, 330)   # evenly spaced columns
        $rowHeights   = @(30, 65, 100)    # evenly spaced rows
        for ($i = 0; $i -lt $actionNames.Count; $i++) {
            $colIndex = $i % $cols
            $left = $colPositions[$colIndex]
            $rowIndex = [math]::Floor($i / $cols)
            $top = $rowHeights[$rowIndex]
            $cb = New-Toggle -Label $actionNames[$i] -Left $left -Top $top
            $grpActions.Controls.Add($cb)
            $toggleControls[$actionNames[$i]] = $cb
            $cb.Add_CheckedChanged($UpdateGoButtonState)}
        $form.Controls.Add($grpActions)

        $StatusLabel = New-Object System.Windows.Forms.Label
        $StatusLabel.AutoSize = $false
        $StatusLabel.Width = 440
        $StatusLabel.Height = 25
        $StatusLabel.Left = 20
        $StatusLabel.Top = $grpActions.Bottom + 10
        $StatusLabel.BorderStyle = 'Fixed3D'
        $StatusLabel.TextAlign = 'MiddleCenter'
        $StatusLabel.Text = "Status: Ready"
        $form.Controls.Add($StatusLabel)

        $goButton = New-Object System.Windows.Forms.Button
        $goButton.Text = "Go"
        $goButton.Width = 100
        $goButton.Height = 35
        $goButton.Left = 50
        $goButton.Top = $StatusLabel.Bottom + 100
        $goButton.Add_Click({Go-Pressed})
        $form.Controls.Add($goButton)
        & $UpdateGoButtonState

        $AllButton = New-Object System.Windows.Forms.Button
        $AllButton.Text = "Check All"
        $AllButton.Width = 100
        $AllButton.Height = 35
        $AllButton.Left = 350
        $AllButton.Top = $StatusLabel.Bottom + 100
        $AllButton.Add_Click({
            if ($allButton.Text -eq "Check All") {
                foreach ($cb in $toggleControls.Values) {$cb.Checked = $true}
                Update-GoButtonState -ToggleControls $toggleControls -GoButton $goButton
                $AllButton.Text = "Uncheck All"}
            elseif ($allButton.Text -eq "Uncheck All") {
                foreach ($cb in $toggleControls.Values) {$cb.Checked = $false}
                Update-GoButtonState -ToggleControls $toggleControls -GoButton $goButton
                $AllButton.Text = "Check All"}})
        $form.Controls.Add($AllButton)

        $OneDrvButton = New-Object System.Windows.Forms.Button
        $OneDrvButton.Text = "Remove OneDrive"
        $OneDrvButton.Width = 100
        $OneDrvButton.Height = 35
        $OneDrvButton.Left = 50
        $OneDrvButton.Top = $StatusLabel.Bottom + 55
        $OneDrvButton.Add_Click({Remove-OneDrive})
        $form.Controls.Add($OneDrvButton)

        $OneDrvCacheButton = New-Object System.Windows.Forms.Button
        $OneDrvCacheButton.Text = "OneDrive Files - Coming Soon"
        $OneDrvCacheButton.Width = 100
        $OneDrvCacheButton.Height = 35
        $OneDrvCacheButton.Left = 200
        $OneDrvCacheButton.Top = $StatusLabel.Bottom + 55
        $OneDrvCacheButton.Add_Click({Clean-OneDrive})
        $OneDrvCacheButton.Enabled = $false
        $form.Controls.Add($OneDrvCacheButton)
        
        $RemCoPilotButton = New-Object System.Windows.Forms.Button
        $RemCoPilotButton.Text = "Remove CoPilot"
        $RemCoPilotButton.Width = 100
        $RemCoPilotButton.Height = 35
        $RemCoPilotButton.Left = 350
        $RemCoPilotButton.Top = $StatusLabel.Bottom + 55
        $RemCoPilotButton.Add_Click({Remove-Copilot})
        $form.Controls.Add($RemCoPilotButton)

        $AVButton = New-Object System.Windows.Forms.Button
        $AVButton.Text = "MS Antivirus Scan"
        $AVButton.Width = 100
        $AVButton.Height = 35
        $AVButton.Left = 50
        $AVButton.Top = $StatusLabel.Bottom + 10
        $AVButton.Add_Click({Run-AV})
        $form.Controls.Add($AVButton)

        $RevRegButton = New-Object System.Windows.Forms.Button
        $RevRegButton.Text = "Revert Registry"
        $RevRegButton.Width = 100
        $RevRegButton.Height = 35
        $RevRegButton.Left = 350
        $RevRegButton.Top = $StatusLabel.Bottom + 10
        $RevRegButton.Add_Click({Revert-Registry})
        $form.Controls.Add($RevRegButton)
        & $CheckRevertReg

        $RevSVCButton = New-Object System.Windows.Forms.Button
        $RevSVCButton.Text = "Revert Service"
        $RevSVCButton.Width = 100
        $RevSVCButton.Height = 35
        $RevSVCButton.Left = 200
        $RevSVCButton.Top = $StatusLabel.Bottom + 10
        $RevSVCButton.Add_Click({Revert-Services})
        $form.Controls.Add($RevSVCButton)
        & $CheckRevertSvc

        $ToolTip = New-Object System.Windows.Forms.ToolTip
        $ToolTip.AutoPopDelay = 15000
        $ToolTip.InitialDelay = 500
        $ToolTip.ReshowDelay = 200
        $ToolTip.ShowAlways = $true
        $tooltips = @{
            "Appx"              = "Removes unused AppX packages to reduce clutter."
            "Clean"             = "Cleans temporary files, logs, and caches."
            "Disable Indexing"  = "Disables Search Indexing for Search. Do Not Use if you search for your files."
            "Disable Recall"    = "Disables Windows Recall features for privacy."
            "DiskCheck"         = "Runs CHKDSK to detect and repair disk issues."
            "DISM"              = "Runs DISM health restore to repair component store corruption."
            "Features"          = "Enables or disables optional Windows features."
            "MSUpdates"         = "Resets Windows Update components and clears update caches."
            "Network"           = "Adjusts network stack parameters for throughput and lower jitter."
            "Packages"          = "Removes optional Windows packages not needed for most workflows."
            "Pagefile"          = "Configures pagefile size and placement for stability and speed."
            "Power"             = "Creates an Optimized Windows power plan for maximum performance."
            "Registry"          = "Applies registry optimizations with automatic backup."
#            "Remove Co-Pilot"   = "Removes Windows Copilot Completely."
#            "Remove OneDrive"   = "Uninstalls MS OneDrive App. You will have to use OneDrive Online after this!"
            "Report"            = "Generates a detailed system report."
            "Services"          = "Disables unnecessary services while preserving compatibility."
            "SFC"               = "Runs System File Checker to repair protected system files."
            "SpeedTest"         = "Runs a network speed test and logs results."
            "System"            = "Applies system-level tweaks for responsiveness and reduced latency."
            "Tasks"             = "Disables scheduled tasks that cause background activity."
            "Verbose"           = "Verbose Messaging at Logon\Logoff"}
        foreach ($key in $tooltips.Keys) {if ($toggleControls.ContainsKey($key)) {$ToolTip.SetToolTip($toggleControls[$key], $tooltips[$key])}}
        $ToolTip.SetToolTip($goButton, "Run the selected options.")
        $ToolTip.SetToolTip($AllButton, "Check\Uncheck all boxes.")
        $ToolTip.SetToolTip($AVButton, "Run 3 Built-In Microsoft Antiviruses.")
        $ToolTip.SetToolTip($RevRegButton, "Revert Registry Changes. Changes Must be found in the GuruTune Log file.")
        $ToolTip.SetToolTip($RevSVCButton, "Revert Service Changes. Changes Must be found in the GuruTune Log file.")
        $ToolTip.SetToolTip($OneDrvButton,"Remove OneDrive Desktop App. You must use Online OneDrive after this! Does not clear local files, delete your local OneDrive files If you would like to clear the space.")
        $ToolTip.SetToolTip($RemCoPilotButton,"Remove CoPilot completely")
        $ToolTip.SetToolTip($OneDrvCacheButton, "Marks File Online Only if OneDrive is installed, Deletes local Folder if not! Not Reversable!")
        
        $form.ShowDialog()}


    
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#### Main Sub    
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Run AS Admin
    $Principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
    if (-Not $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        # Relaunch te script as Administrator
        Log-Me "Relaunching As Admin"
	    $Arguments = "-NoExit -File `"$PSCommandPath`" -NoProfile"
        Start-Process -FilePath "powershell.exe" -ArgumentList $Arguments -Verb RunAs -Wait
	    Remove-Variable -Name Arguments | Out-Null
        exit}

# OS Check
    $Check = Verify-OS
    If ($Check -like $false){
        Remove-Variable -Name Check,Principal,OSVer,localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null
        Remove-Variable * -Scope Script -Force -ErrorAction SilentlyContinue | Out-Null
        Exit}

#File Hash Checker
#    $Check = Verify-RemoteHash
#    If ($check -like $false){
#        Remove-Variable -Name Check,Principal,OSVer,localVersion,remoteVersion,strMsg -ErrorAction SilentlyContinue | out-null
#        Remove-Variable * -Scope Script -Force -ErrorAction SilentlyContinue | Out-Null
#        Exit}

# Script Version Check
    #Verify-Version

    Show-form

    Remove-Variable * -Scope Local -Force -ErrorAction SilentlyContinue | Out-Null
    Remove-Variable * -Scope Script -Force -ErrorAction SilentlyContinue | Out-Null
    Exit