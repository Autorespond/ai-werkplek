# Maakt de waarde voor de omgevingsvariabele AR_MCP_AUTH (Windows, PowerShell).
# Vraagt je WordPress-gebruikersnaam en applicatiewachtwoord (onzichtbaar), test de koppeling met je
# Autorespond en toont EEN keer de waarde die je in de Claude-omgeving plakt. Er wordt niets opgeslagen.
#
# Starten:  powershell -NoProfile -ExecutionPolicy Bypass -File maak-sleutel.ps1
param([string]$Site, [string]$User)
$ErrorActionPreference = 'Stop'
if (-not $Site) { $Site = Read-Host "Adres van je Autorespond (bijv. https://mijn.jouwbedrijf.nl)" }
if (-not $User) { $User = Read-Host "WordPress-gebruikersnaam van je AI-gebruiker" }
$Site = $Site.Trim().TrimEnd('/'); if ($Site -notmatch '^https?://') { $Site = 'https://' + $Site }
$sec = Read-Host -AsSecureString "Applicatiewachtwoord (spaties mogen blijven staan)"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
if ([string]::IsNullOrWhiteSpace($plain)) { Write-Host "Niets ingevoerd."; exit 1 }
$plain = $plain -replace '\s', ''
$auth = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("$User`:$plain")); $plain = $null
$init = '{"jsonrpc":"2.0","id":0,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"maak-sleutel","version":"1"}}}'
$ok = 0
foreach ($k in @(@('CRM en e-mail', '/wp-json/fluent-crm/mcp'), @('Projecten en taken', '/wp-json/fluent-boards/mcp'), @('Formulieren', '/wp-json/fluentform/mcp'), @('Afspraken (staat standaard uit)', '/wp-json/fluent-booking/mcp'))) {
  try {
    $r = Invoke-WebRequest -Method Post -Uri ($Site + $k[1]) -Headers @{ Authorization = $auth; Accept = 'application/json, text/event-stream'; 'Content-Type' = 'application/json' } -Body $init -UseBasicParsing
    if ($r.StatusCode -eq 200) { $ok++; Write-Host ("  OK   " + $k[0]) } else { Write-Host ("  " + $r.StatusCode + "  " + $k[0]) }
  } catch {
    $code = '???'; if ($_.Exception.Response) { $code = [int]$_.Exception.Response.StatusCode }
    Write-Host ("  " + $code + "  " + $k[0] + "  (401 = gebruikersnaam of wachtwoord onjuist; 403 = geen rechten; 404 = koppeling staat uit)")
  }
}
if ($ok -eq 0) { Write-Host "Geen enkele koppeling werkt. Controleer het adres, de gebruikersnaam en het applicatiewachtwoord."; exit 1 }
Write-Host ""
Write-Host "Zet in je Claude-omgeving deze twee variabelen:"
Write-Host ""
Write-Host ("AR_SITE_URL = " + $Site)
Write-Host ("AR_MCP_AUTH = " + $auth)
Write-Host ""
Write-Host "Sluit dit venster daarna. Bewaar de tweede waarde nergens anders; hij is gelijk aan je wachtwoord."
