Absolutely! Here’s a professional and clear **Markdown README** you can drop into your GitHub repo. I’ve written it so that someone can understand the requirements, the CSV format, and how to run the script without needing to read the code.

---

# Ping Tester Script

A simple **PowerShell script** to ping a list of IP addresses from a CSV file and generate a detailed report of online/offline status with average response times.

---

## Features

* Reads a list of IP addresses from a CSV file.
* Pings each IP address multiple times.
* Determines whether each IP is **Online** or **Offline**.
* Computes **average response time** for each reachable IP.
* Generates a CSV report with detailed results.
* Compatible with **Windows PowerShell 5.1**.

---

## CSV File Setup

The script relies on a CSV file containing the IP addresses you want to test.

### ✅ Requirements

1. **Header must be exactly**:

   ```
   IPAddress
   ```
2. Each IP address should be listed on a **separate row** under the header.
3. **No blank lines or extra spaces** above or below the header.
4. Save the CSV in **standard UTF-8 or ANSI format** (default for Notepad).

### Example CSV (`ips.csv`)

```csv
IPAddress
192.168.226.105
192.168.226.110
192.168.226.119
192.168.226.121
192.168.226.142
192.168.226.143
192.168.226.166
192.168.226.194
192.168.226.195
192.168.226.196
192.168.226.197
192.168.226.198
192.168.226.230
192.168.226.231
192.168.226.235
192.168.226.236
192.168.226.240
192.168.226.247
192.168.226.34
192.168.227.197
192.168.227.126
```

> ⚠️ Make sure there are no extra spaces in the header (`IPAddress`) or IP values.
> ⚠️ Do **not** include additional columns unless you modify the script accordingly.

---

## Script Setup

1. Save the script `ping_tester.ps1` somewhere convenient, e.g.:

```
C:\Users\Administrator\Desktop\Ping_Test\ping_tester.ps1
```

2. Edit the script to match your CSV file path:

```powershell
$InputCsv  = "C:\Users\Administrator\Desktop\Ping_Test\ips.csv"
$OutputCsv = "C:\Users\Administrator\Desktop\Ping_Test\PingReport.csv"
```

3. Optional: Adjust the number of pings per IP:

```powershell
$PingCount = 3
```

---

## How to Run

1. Open **PowerShell**.
2. Navigate to the folder containing the script, for example:

```powershell
cd C:\Users\Administrator\Desktop\Ping_Test
```

3. Run the script:

```powershell
.\ping_tester.ps1
```

4. The script will output a **CSV report** at the path you specified in `$OutputCsv` (default: `PingReport.csv`).

---

## Output

The resulting CSV contains the following columns:

| Column        | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| IPAddress     | The IP that was tested                                        |
| Status        | Online / Offline                                              |
| AvgResponseMs | Average ping response time in milliseconds (blank if offline) |
| PacketsSent   | Number of pings sent                                          |
| PacketsRecv   | Number of pings received                                      |
| Timestamp     | Date and time the test was run                                |

### Example Output

```csv
IPAddress,Status,AvgResponseMs,PacketsSent,PacketsRecv,Timestamp
192.168.226.105,Online,2.33,3,3,2026-01-21 16:42:10
192.168.226.110,Offline,,3,0,2026-01-21 16:42:12
192.168.226.119,Online,1.75,3,3,2026-01-21 16:42:15
```

---

## Notes

* Compatible with **Windows PowerShell 5.1**.
* The script **does not require PowerShell 7**.
* Make sure ICMP (ping) is allowed on the target devices; otherwise, they may appear offline.
* For large lists, the script can take some time, as it pings each IP sequentially. (Parallel execution can be added in a future version.)
