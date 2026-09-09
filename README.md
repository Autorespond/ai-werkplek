# Autorespond AI-werkplek

Startpakket om je Autorespond te koppelen aan Claude **in de browser** (claude.ai/code), voor jezelf én je
virtuele assistent. Werkt ook voor **routines**: taken die Claude automatisch uitvoert op vaste tijden,
ook als je computer uit staat.

De koppelingen: CRM en e-mail, projecten en taken, formulieren en (sinds september 2026) afspraken.

Er staat niets geheims in dit pakket. Het bevat alleen de adressen van de koppelingen en spelregels voor
de AI. Je eigen inloggegevens zet je in je eigen Claude-omgeving; die verlaten je account niet.

## Wat je nodig hebt
- Een Claude-abonnement (Pro, Max of Team). Voor een VA die onder jouw verantwoordelijkheid werkt: een
  Team-account met een eigen seat.
- Een gratis GitHub-account (Claude in de browser haalt dit pakket daar vandaan).
- In Autorespond: een aparte gebruiker voor de AI met beperkte rechten en een applicatiewachtwoord. Hoe
  je die maakt staat in de kennisbank:
  https://mijn.autorespond.nl/docs/je-ai-assistent-koppelen-aan-autorespond-alle-koppelingen-op-een-rij/

## In vijf stappen
1. **GitHub**: maak een account op github.com (gratis) als je die nog niet hebt.
2. **Claude**: ga naar https://claude.ai/code en koppel je GitHub-account als daarom wordt gevraagd.
3. **Omgeving**: maak een omgeving (environment) aan, bijvoorbeeld "Autorespond":
   - Network access: **Custom**, voeg het adres van je Autorespond toe (bijvoorbeeld
     `mijn.jouwbedrijf.nl`) en vink "include default list" aan.
   - Environment variables: `AR_SITE_URL` (het volledige adres, met https://) en `AR_MCP_AUTH`.
     De waarde van `AR_MCP_AUTH` maak je met `scripts/maak-sleutel.ps1` (Windows) of
     `scripts/maak-sleutel.sh` (Mac). Het script test meteen of de koppeling werkt.
4. **Sessie**: nieuwe sessie, repository `Autorespond/ai-werkplek`, omgeving "Autorespond".
5. **Eerste vraag**: typ `/start`. Claude controleert de koppelingen en vat samen wat er kan.

## Routines: laat Claude werken terwijl je slaapt
Op https://claude.ai/code/routines maak je een routine: dezelfde repository en omgeving, een opdracht en
een schema (bijvoorbeeld werkdagen om 08:00). Voorbeelden van opdrachten staan in
`routines/voorbeelden.md`. Elke run wordt een sessie die je later nakijkt, ook op je telefoon.

Let op: een routine vraagt niets tussendoor. Geef je AI-gebruiker daarom alleen de rechten die de
routine nodig heeft, en laat de opdracht altijd eindigen met een samenvatting in plaats van een actie
naar buiten.

## Veiligheid in het kort
- Dit pakket bevat geen wachtwoorden. Je applicatiewachtwoord staat alleen in je eigen Claude-omgeving.
- Maak in Autorespond een aparte gebruiker voor de AI met de rol Abonnee en precies de rechten die je
  wilt geven. Wat de gebruiker niet mag, kan de AI ook niet.
- Klaar met de koppeling of wil je hem vernieuwen? Trek het applicatiewachtwoord in bij de gebruiker in
  Autorespond. Dat werkt per direct.
- Je VA werkt met een eigen AI-gebruiker en een eigen applicatiewachtwoord, in zijn of haar eigen
  Claude-omgeving. Zo zie je in Autorespond wie wat heeft gedaan.

## Vragen
Kennisbank: https://mijn.autorespond.nl/docs/ · Support: via het supportportaal in je Autorespond.
