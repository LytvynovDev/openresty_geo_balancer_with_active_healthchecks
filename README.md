# Openresty geo balancer with active healthchecks

## Description

- Implements geo balancing using MaxMind GeoIP2 db
- Implements upstream active healthchecks with a Lua script
- Contains a backup server

## Commands

- Start: `docker compose up -d`
- Stop: `docker compose down`

## Notes

### MaxMind GeoIP2 db

You need to provide your MaxMind `ACCOUNT_ID` and `LICENSE_KEY` into the `.env` file in order to download and use the GeoIP2 db.

### Example templates

Production servers are just a sample exaple of a real production servers, which will handle the traffic. `example_templates` folder contains sample `index.html` files for each server to apparently show which server provided a response.