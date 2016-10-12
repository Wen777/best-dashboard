# Grafana + Collectd + InfluxDB

* [Odoo](https://hub.docker.com/_/odoo/) App server * 1
* Dashboard server (Grafana, InfluxDB)

# Quick start

User: admin
PW: admin

open [grafana](http://ec2-52-53-209-251.us-west-1.compute.amazonaws.com:3000/dashboard/db/host-overview) on your browser.
`you can check testing part. If you use that command, you will find the changes on grafana dashboard.`

## Installation

Components:
* App server
* Dashboard

App server:
    * Install Docker, htop, Collectd
    * Pull && Excute Odoo image

Dashboard server:
    * Install InfluxDB, Grafana
    * Configure Grafana to visualize metrics of app server.

***Dashboard template can download from grafana official site***

# Testing

Require: apache ab (load testing)

```{shell}
ab -n 1000 -c 50 http://ec2-52-53-157-250.us-west-1.compute.amazonaws.com:8069/
```
