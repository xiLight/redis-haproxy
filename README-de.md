# Redis mit TLS via HAProxy (Docker)

Dieses Projekt stellt einen Redis-Server mit TLS-Verschlüsselung bereit – einfach per Docker Compose. Perfekt für alle, die Redis sicher und unkompliziert nutzen wollen.

## Features
- Redis 7 mit Passwortschutz
- TLS/SSL via HAProxy (Let’s Encrypt)
- Einfache Konfiguration über `.env`
- Automatisiertes Zertifikat-Setup

---

## Voraussetzungen
- [Docker](https://docs.docker.com/get-docker/) & [Docker Compose](https://docs.docker.com/compose/install/)
- Domain (z.B. redis.example.com, muss auf deinen Server zeigen)
- Port 80 muss für Zertifikatserstellung frei sein
- **Certbot** installiert (`sudo apt install certbot` auf Debian/Ubuntu)

---

## Schnellstart

1. **Repo klonen**
   ```
   git clone https://github.com/DEIN_GITHUB_USER/redis-haproxy-tls.git
   cd redis-haproxy-tls
   ```

2. **.env anlegen**
   Kopiere die Beispiel-Datei und passe sie an:
   ```
   cp .env.example .env
   # Bearbeite .env und trage deine Werte ein
   ```
   - `REDIS_PASSWORD`: Sicheres Passwort für Redis
   - `DOMAIN`: Deine Domain (z.B. redis.example.com)
   - `EMAIL`: Für Let’s Encrypt Benachrichtigungen
   - `CONTAINER_NAME`: (Optional) Name des Redis-Containers (Standard: `redis`)

3. **SSL-Zertifikat erstellen**
   ```
   ./renewcert.sh
   ```
   Das Skript prüft, ob certbot installiert ist, und erstellt das Zertifikat für deine Domain.

4. **Container starten**
   ```
   docker compose up -d
   ```

5. **Redis nutzen**
   Verbinde dich mit einem Redis-Client, der TLS unterstützt (z.B. `redis-cli` ab v6):
     URL
     ```rediss://:PW@DOMAIN:6379```
   ```java
   new JedisPool(poolConfig, redisHost, redisPort, 5000, redisPassword, 0, true);
     ```
---

## Hinweise & Sicherheit
- **Passwort:** Wähle ein starkes Passwort! Teile es nicht öffentlich.
- **.env & Zertifikate:** Werden nicht ins Repo übernommen (`.gitignore`).
- **Backups:** Redis speichert Daten im Volume `redis_data`.
- **Zertifikat erneuern:** Einfach erneut `./renewcert.sh` ausführen.
- **Firewall:** Öffne nur Port 6379 (TLS) nach außen.

---

## Fehlerbehebung
- **Zertifikatserstellung schlägt fehl?**
  - Prüfe, ob Port 80 frei ist und die Domain auf deinen Server zeigt.
  - Certbot muss installiert sein.
- **Verbindung klappt nicht?**
  - Nutze einen Client mit TLS-Unterstützung.
  - Prüfe Passwort und Domain.

---

## Umgebungsvariablen
- `REDIS_PASSWORD`: Passwort für Redis-Authentifizierung (erforderlich)
- `DOMAIN`: Deine Domain für das SSL-Zertifikat (erforderlich)
- `EMAIL`: E-Mail für Let's Encrypt Benachrichtigungen (erforderlich)
- `CONTAINER_NAME`: (Optional) Name des Redis-Containers (Standard: `redis`)