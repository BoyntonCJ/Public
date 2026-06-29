    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $script:Version = "0.1"
    $script:PauseFlag  = $false
    $script:CancelFlag = $false
    $script:IsRunning  = $false    
    $script:SourceFolder = $null


############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
####
####    Guru Image\Video Dedupe - Read Me
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#############
####
####	NAME:		Guru DeDupe
#### 	AUTHOR:		Charles Boynton
#### 	DATE:		06/14/2026
#### 	EMAIL:		BoyntonCJ@Gmail.com
#### 	SYNOPSIS:   Runs non-recursive search on the supplied folder for images and videos, compares file hash's and keeps the oldest copy.
####                Moves newer copies to 'Dupes' subfolder of folder selected.
####
#### 	VERSION HISTORY:
#### 	    Ver: 0; Ver Date: 06/14/2026; Created Initial Version
#### 	    Ver: 0.1; Ver Date: 06/22/2026; Modularized functions, Added recursive search selector, Added Tooltips
####            Added Variable Cleanup
####
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#############
####
####	To run, right click De-Dupe and select 'Run With PowerShell'
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#############
####
####	If De-Dupe errors right away, this probably means that your 'Execution Policy'
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
####		Rerun Guru DeDupe
####		
####		To Revert to default, Copy and paste: 
####			"Set-ExecutionPolicy -ExecutionPolicy Restricted"
####		Press Enter and Accept any prompts
####
####	Thank for your patience with Microsoft's 'Security Feature'.
####	
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#############
####	Free For Personal Use. 
####	Please contact For professional licensing or custom coding changes.
####
####	Have A Blessed Day!
####
####	BoyntonCJ@GMail.Com
####
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Main Functions
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Function Log-Me {
    param([string]$msg)
    $LogPath = [IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "Guru DeDupe - Log.txt")
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "$timestamp  $msg" | Out-File -FilePath $LogPath -Append -Encoding UTF8
    
    Remove-Variable LogPath,timestamp -Force -ErrorAction SilentlyContinue | Out-Null}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Function Update-Status {
    param([string]$msg)
    $txtStatus.AppendText("$msg`r`n")
    Log-Me $msg}
    ############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Function Hash-Files {
    param($files)

    $results = @()
    $count   = 0
    $total   = $files.Count

    foreach ($file in $files) {
        [System.Windows.Forms.Application]::DoEvents()
        if ($script:CancelFlag) { return @() }

        while ($script:PauseFlag -and -not $script:CancelFlag) {
            [System.Windows.Forms.Application]::DoEvents()
            Start-Sleep -Milliseconds 200}
        if ($script:CancelFlag) { return @() }

        try {
            $hashObj = Get-FileHash -Path $file.FullName -Algorithm SHA256 -ErrorAction Stop
            $results += [PSCustomObject]@{
                Path = $file.FullName
                Hash = $hashObj.Hash}}
        catch {continue}
        $count++
        $lblHashing.Text = "Hashing: $count / $total"
        $progress.Value = [math]::Round(($count / $total) * 100)}
    
    Remove-Variable results,count,total,hashObj,results,Path,Hash -Force -ErrorAction SilentlyContinue | Out-Null
    return $results}


############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#### Form Functions    
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
Function Go-Scan{

    if (-not $script:SourceFolder) {
        Update-Status "No folder selected."
        return}
    if ($script:IsRunning) {
        Update-Status "Scan already in progress."
        return}

    $script:IsRunning = $true
    $script:PauseFlag = $false
    $script:CancelFlag = $false
    $btnScan.Enabled  = $false
    $btnPause.Enabled = $true
    $btnCancel.Enabled = $true
    $btnPause.Text    = "Pause"
    $progress.Value   = 0

    Update-Status "Starting duplicate scan..."
    $extensions = @(
        ".jpg",".jpeg",".png",".gif",".bmp",".tif",".tiff",
        ".mp4",".mov",".avi",".mkv",".wmv",".flv",".m4v")

    Update-Status "Scanning for media files..."
    if ($script:chkRecursive.Checked) {
        $files = Get-ChildItem -Path $script:SourceFolder -File -Recurse |
            Where-Object { $extensions -contains $_.Extension.ToLower() }}
    else {
        $files = Get-ChildItem -Path $script:SourceFolder -File |
            Where-Object { $extensions -contains $_.Extension.ToLower() }}

    if ($files.Count -eq 0) {
        Update-Status "No media files found."
        $btnPause.Enabled = $false
        $btnCancel.Enabled = $false
        $script:IsRunning = $false
        return}

    Update-Status "Found $($files.Count) files. Hashing..."

    $lblHashing.Text = "Hashing: 0 / $($files.Count)"
    $hashResults = Hash-Files -files $files
    if ($script:CancelFlag) { return }
    $validResults = $hashResults | Where-Object { $_ -and $_.Hash -and $_.Path }

    Update-Status "Hashing complete. Grouping duplicates..."

    $dupeFolder = Join-Path $script:SourceFolder "Dupes"
    if (-not (Test-Path $dupeFolder)) {
        New-Item -ItemType Directory -Path $dupeFolder | Out-Null}
    $groups = $validResults | Group-Object Hash
    foreach ($group in $groups) {
        [System.Windows.Forms.Application]::DoEvents()
        if ($script:CancelFlag) { return }
        while ($script:PauseFlag -and -not $script:CancelFlag) {
            [System.Windows.Forms.Application]::DoEvents()
            Start-Sleep -Milliseconds 200}
        if ($group.Count -gt 1) {
            $groupWithPaths = $group.Group | Where-Object { $_.Path }
            if ($groupWithPaths.Count -lt 2) { continue }

            $sorted = $groupWithPaths | Sort-Object {
                (Get-Item $_.Path).CreationTime}

            $keep = $sorted[0].Path
            Update-Status "Keeping oldest: $(Split-Path $keep -Leaf)"
            $dupes = $sorted | Select-Object -Skip 1
            foreach ($dupe in $dupes) {
                [System.Windows.Forms.Application]::DoEvents()
                if ($script:CancelFlag) { return }
                while ($script:PauseFlag -and -not $script:CancelFlag) {
                    [System.Windows.Forms.Application]::DoEvents()
                    Start-Sleep -Milliseconds 200}
                if (-not $dupe.Path) { continue }

                $file = Get-Item $dupe.Path
                $dest = Join-Path $dupeFolder $file.Name
                Move-Item $file.FullName $dest -Force
                Update-Status "Moved duplicate: $($file.Name)"}}}

    Update-Status "Done!"
    $progress.Value   = 100
    $lblHashing.Text  = "Hashing: 0 / 0"
    $btnPause.Enabled = $false
    $btnCancel.Enabled = $false
    $script:IsRunning = $false

    if ($script:SourceFolder) {$btnScan.Enabled = $true}
    Remove-Variable extensions,files,hashResults,hashObj,validResults,dupeFolder -Force -ErrorAction SilentlyContinue | Out-Null
    Remove-Variable groups,group,groupWithPaths,sorted,dupes,dupe,file,dest -Force -ErrorAction SilentlyContinue | Out-Null}
############# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Function Show-Form {

    $script:form = New-Object System.Windows.Forms.Form
    $script:form.Text = "Guru Image\Video Dedupe"
    $script:form.Size = New-Object System.Drawing.Size(600,420)
    $script:form.StartPosition = "CenterScreen"
    $script:form.KeyPreview = $true

    $script:btnSelect = New-Object System.Windows.Forms.Button
    $script:btnSelect.Text = "Select Folder"
    $script:btnSelect.Location = New-Object System.Drawing.Point(20,20)
    $script:btnSelect.Size = New-Object System.Drawing.Size(120,30)
    $script:form.Controls.Add($script:btnSelect)

    $script:btnScan = New-Object System.Windows.Forms.Button
    $script:btnScan.Text = "DeDupe Me!"
    $script:btnScan.Location = New-Object System.Drawing.Point(160,20)
    $script:btnScan.Size = New-Object System.Drawing.Size(120,30)
    $script:btnScan.Enabled = $false
    $script:form.Controls.Add($script:btnScan)

    $script:btnPause = New-Object System.Windows.Forms.Button
    $script:btnPause.Text = "Pause"
    $script:btnPause.Location = New-Object System.Drawing.Point(300,20)
    $script:btnPause.Size = New-Object System.Drawing.Size(120,30)
    $script:btnPause.Enabled = $false
    $script:form.Controls.Add($script:btnPause)

    $script:btnCancel = New-Object System.Windows.Forms.Button
    $script:btnCancel.Text = "Cancel"
    $script:btnCancel.Location = New-Object System.Drawing.Point(440,20)
    $script:btnCancel.Size = New-Object System.Drawing.Size(120,30)
    $script:btnCancel.Enabled = $false
    $script:form.Controls.Add($script:btnCancel)

    $script:lblFolder = New-Object System.Windows.Forms.Label
    $script:lblFolder.Text = "No folder selected"
    $script:lblFolder.Location = New-Object System.Drawing.Point(20,60)
    $script:lblFolder.Size = New-Object System.Drawing.Size(300,20)
    $script:form.Controls.Add($script:lblFolder)

    $script:chkRecursive = New-Object System.Windows.Forms.CheckBox
    $script:chkRecursive.Text = "Recursive"
    $script:chkRecursive.Location = New-Object System.Drawing.Point(475,60)
    $script:chkRecursive.Size = New-Object System.Drawing.Size(120,20)
    $script:form.Controls.Add($script:chkRecursive)

    $script:lblHashing = New-Object System.Windows.Forms.Label
    $script:lblHashing.Text = "Hashing: 0 / 0"
    $script:lblHashing.Location = New-Object System.Drawing.Point(20,80)
    $script:lblHashing.Size = New-Object System.Drawing.Size(540,20)
    $script:form.Controls.Add($script:lblHashing)

    $script:progress = New-Object System.Windows.Forms.ProgressBar
    $script:progress.Location = New-Object System.Drawing.Point(20,110)
    $script:progress.Size = New-Object System.Drawing.Size(540,25)
    $script:form.Controls.Add($script:progress)

    $script:txtStatus = New-Object System.Windows.Forms.TextBox
    $script:txtStatus.Multiline = $true
    $script:txtStatus.ScrollBars = "Vertical"
    $script:txtStatus.Location = New-Object System.Drawing.Point(20,150)
    $script:txtStatus.Size = New-Object System.Drawing.Size(540,220)
    $script:form.Controls.Add($script:txtStatus)

    $ToolTip = New-Object System.Windows.Forms.ToolTip
    $ToolTip.AutoPopDelay = 15000
    $ToolTip.InitialDelay = 500
    $ToolTip.ReshowDelay = 200
    $ToolTip.ShowAlways = $true
    $ToolTip.SetToolTip($script:btnSelect, "Select the folder to be scanned")
    $ToolTip.SetToolTip($script:btnScan, "Scan the selected folder")
    $ToolTip.SetToolTip($script:btnPause, "Pause before next file")
    $ToolTip.SetToolTip($script:btnCancel, "Cancel the current scan")
    $ToolTip.SetToolTip($script:lblFolder, "Selected folder")
    $ToolTip.SetToolTip($script:chkRecursive, "Scan sub-folders?")

    $script:btnSelect.Add_Click({
        $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
        if ($dialog.ShowDialog() -eq "OK") {
            $script:SourceFolder = $dialog.SelectedPath
            $script:lblFolder.Text = $script:SourceFolder
            Update-Status "Selected folder: $script:SourceFolder"
            if (-not $script:IsRunning) { $script:btnScan.Enabled = $true }}})

    $script:btnPause.Add_Click({
        if (-not $script:IsRunning) { return }
        if (-not $script:PauseFlag) {
            $script:PauseFlag = $true
            $script:btnPause.Text = "Resume"
            Update-Status "Paused..."}
        else {
            $script:PauseFlag = $false
            $script:btnPause.Text = "Pause"
            Update-Status "Resuming..."}})

    $script:btnCancel.Add_Click({
        $script:CancelFlag = $true
        Update-Status "Cancelling..."
        $script:form.Close()})

    $script:btnScan.Add_Click({ Go-Scan })

    $script:form.ShowDialog()}


Show-Form
