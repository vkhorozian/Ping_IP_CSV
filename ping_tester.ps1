# ===============================
# Reliable Ping IPs from CSV (PS 5.1)
# ===============================

$InputCsv  = "C:\Users\Administrator\Desktop\Ping_Test\ips.csv"
$OutputCsv = "C:\Users\Administrator\Desktop\Ping_Test\PingReport.csv"

$PingCount = 3
$Results = @()

# Import CSV
$IPs = Import-Csv $InputCsv

foreach ($Entry in $IPs) {

    # Safely extract IP address (column header = 'IPAddress')
    $RawIP = $Entry.IPAddress

    if ([string]::IsNullOrWhiteSpace($RawIP)) {
        Write-Warning "Skipping empty IP entry"
        continue
    }

    $IPAddress = $RawIP.Trim()
    Write-Host "Pinging $IPAddress..."

    # PS 5.1 compatible ping
    $PingResults = Test-Connection -ComputerName $IPAddress -Count $PingCount -ErrorAction SilentlyContinue

    if ($PingResults) {
        $AvgResponse = [math]::Round(
            ($PingResults | Measure-Object ResponseTime -Average).Average, 2
        )

        $Results += [PSCustomObject]@{
            IPAddress     = $IPAddress
            Status        = "Online"
            AvgResponseMs = $AvgResponse
            PacketsSent   = $PingCount
            PacketsRecv   = $PingResults.Count
            Timestamp     = Get-Date
        }
    }
    else {
        $Results += [PSCustomObject]@{
            IPAddress     = $IPAddress
            Status        = "Offline"
            AvgResponseMs = $null
            PacketsSent   = $PingCount
            PacketsRecv   = 0
            Timestamp     = Get-Date
        }
    }
}

$Results | Export-Csv $OutputCsv -NoTypeInformation
Write-Host "`nPing test complete. Report saved to $OutputCsv"
