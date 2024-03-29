# Ubiquiti Unifi System Installation Automator

ease my works using Ubiquiti Unifi products on Debian/Ubuntu based server.
It will install the newest Unifi Controller only since VoIP and Video has been deprecated lately.

## Requirements

ODROID XU4 will go as far Ubuntu 18 with MongoDB 3.2.22-2 from Dominic Chen due to dependecies limitations while AMD64/ARM64 based will not be affected by it.


### Installing

Just run below command or copy paste it and it will run everything automatically

```
curl -fsSL https://raw.githubusercontent.com/aryonp/unifi/master/install_unifi.sh > /tmp/install_unifi.sh && sudo bash /tmp/install_unifi.sh

```

for ODROID XU4

```
curl -fsSL https://raw.githubusercontent.com/aryonp/unifi/master/install_unifi_odroid_xu4.sh > /tmp/install_unifi_odroid_xu4.sh && sudo bash /tmp/install_unifi_odroid_xu4.sh

```

for ODROID N2

```
curl -fsSL https://raw.githubusercontent.com/aryonp/unifi/master/install_unifi_odroid_n2.sh > /tmp/install_unifi_odroid_n2.sh && sudo bash /tmp/install_unifi_odroid_n2.sh

```

### What it did

1. It will update your system first
2. Add needed repositories
3. Install supporting apps
4. Restarting Unifi services
5. Set log for Unifi Controller

## Authors

* **Aryo Pratama** - (https://github.com/aryonp)

## Special Thanks for MongoDB 3.2 armhf!

* **Dominic Chen** - (https://github.com/ddcc)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
