#!/bin/bash
# Maakt de waarde voor de omgevingsvariabele AR_MCP_AUTH (Mac of Linux, Terminal).
# Starten:  bash maak-sleutel.sh
read -r -p "Adres van je Autorespond (bijv. https://mijn.jouwbedrijf.nl): " SITE
read -r -p "WordPress-gebruikersnaam van je AI-gebruiker: " USER_
read -r -s -p "Applicatiewachtwoord (onzichtbaar, spaties mogen blijven staan): " PASS; echo
SITE="${SITE%/}"; case "$SITE" in http*) ;; *) SITE="https://$SITE";; esac
PASS="$(printf '%s' "$PASS" | tr -d ' ')"
AUTH="Basic $(printf '%s:%s' "$USER_" "$PASS" | base64 | tr -d '\n')"; PASS=""
INIT='{"jsonrpc":"2.0","id":0,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"maak-sleutel","version":"1"}}}'
OK=0
for k in "CRM en e-mail|/wp-json/fluent-crm/mcp" "Projecten en taken|/wp-json/fluent-boards/mcp" "Formulieren|/wp-json/fluentform/mcp" "Afspraken (staat standaard uit)|/wp-json/fluent-booking/mcp"; do
  label="${k%%|*}"; path="${k##*|}"
  code=$(curl -s -o /dev/null -w '%{http_code}' -X POST "$SITE$path" -H "Authorization: $AUTH" -H 'Accept: application/json, text/event-stream' -H 'Content-Type: application/json' -d "$INIT")
  if [ "$code" = "200" ]; then OK=$((OK+1)); echo "  OK   $label"; else echo "  $code  $label  (401 = gebruikersnaam of wachtwoord onjuist; 403 = geen rechten; 404 = koppeling staat uit)"; fi
done
if [ "$OK" = "0" ]; then echo "Geen enkele koppeling werkt. Controleer het adres, de gebruikersnaam en het applicatiewachtwoord."; exit 1; fi
echo; echo "Zet in je Claude-omgeving deze twee variabelen:"; echo
echo "AR_SITE_URL = $SITE"
echo "AR_MCP_AUTH = $AUTH"
echo; echo "Sluit dit venster daarna. Bewaar de tweede waarde nergens anders; hij is gelijk aan je wachtwoord."
