# Ubiquiti Unifi System Installation Automator

ease my works using Ubiquiti Unifi products on Debian/Ubuntu based server.
It will install the newest Unifi Controller together with Unifi Video 3.10.2 (Not available on ODROID version)

## Requirements

You need to install Ubuntu Server 18.04 LTS on some PC/Mini-PC or ODROID XU4 with minimal server installation and get its IP fixed


### Installing

Just run below command or copy paste it and it will run everything automatically

```
curl -fsSL https://raw.githubusercontent.com/aryonp/unifi/master/install_unifi.sh > /tmp/install_unifi.sh && sudo bash /tmp/install_unifi.sh

```

for ODROID XU4

```
curl -fsSL https://raw.githubusercontent.com/aryonp/unifi/master/install_unifi_odroid_xu4.sh > /tmp/install_unifi_odroid_xu4.sh && sudo bash /tmp/install_unifi_odroid_xu4.sh

```

### What it did

1. It will update your system first
2. Add needed repositories
3. Install newest unifi controller and video 3.10.2 (not available on ODROID version)
4. Restarting unifi services

## Authors

* **Aryo Pratama** - (https://github.com/aryonp)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details