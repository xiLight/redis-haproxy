# Redis with TLS via HAProxy (Docker)

This project provides a Redis server with TLS encryption – easy to use via Docker Compose. Perfect for anyone who wants to run Redis securely and simply.

## Features
- Redis 7 with password protection
- TLS/SSL via HAProxy (Let’s Encrypt)
- Simple configuration via `.env`
- Automated certificate setup

---

## Requirements
- [Docker](https://docs.docker.com/get-docker/) & [Docker Compose](https://docs.docker.com/compose/install/)
- A domain (e.g. redis.example.com, must point to your server)
- Port 80 must be free for certificate creation
- **Certbot** installed (`sudo apt install certbot` on Debian/Ubuntu)

---

## Quick Start

1. **Clone the repo**
   ```
   git clone https://github.com/xiLight/redis-haproxy.git
   cd redis-haproxy
   ```

2. **Create your .env**
   Copy the example file and edit it:
   ```
   cp .env.example .env
   # Edit .env and enter your values
   ```
   - `REDIS_PASSWORD`: A strong password for Redis
   - `DOMAIN`: Your domain (e.g. redis.example.com)
   - `EMAIL`: For Let’s Encrypt notifications
   - `CONTAINER_NAME`: (Optional) Name for the Redis container (default: `redis`)

3. **Create SSL certificate**
   ```
   ./renewcert.sh
   ```
   The script checks if certbot is installed and creates the certificate for your domain.

4. **Start the containers**
   ```
   docker compose up -d
   ```

5. **Use Redis**
   Connect with a Redis client that supports TLS (e.g. `redis-cli` v6+):
     URL
     ```rediss://:PW@DOMAIN:6379```

     ```java
     new JedisPool(poolConfig, redisHost, redisPort, 5000, redisPassword, 0, true);
     ```

---

## Notes & Security
- **Password:** Use a strong password! Do not share it publicly.
- **.env & certificates:** Are excluded from the repo (`.gitignore`).
- **Backups:** Redis data is stored in the `redis_data` volume.
- **Renew certificate:** Just run `./renewcert.sh` again.
- **Firewall:** Only open port 6379 (TLS) to the outside.

---

## Troubleshooting
- **Certificate creation fails?**
  - Make sure port 80 is free and your domain points to your server.
  - Certbot must be installed.
- **Connection issues?**
  - Use a client with TLS support.
  - Check your password and domain.

---

## Environment Variables
- `REDIS_PASSWORD`: Password for Redis authentication (required)
- `DOMAIN`: Your domain for SSL certificate (required)
- `EMAIL`: Email for Let's Encrypt notifications (required)
- `CONTAINER_NAME`: (Optional) Name for the Redis container (default: `redis`)