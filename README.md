# Ubiquiti Unifi System Installation Automator

ease my works using Ubiquiti Unifi products on Debian/Ubuntu based server.
It will install the newest Unifi Controller together with Unifi Video 3.8.5

## Requirements

You need to install Ubuntu Server 16.04.3 LTS and get its IP fixed


### Installing

Just run below command or copy paste it and it will run everything automatically

```
curl -fsSL https://raw.githubusercontent.com/aryonp/unifi/master/install_unifi.sh > /tmp/install_unifi.sh && sudo bash /tmp/install_unifi.sh

```

### What it did

1. It will update your system first
2. Add needed repositories
3. Install newest unifi controller and video 3.8.5
4. Since openjava will slow you down, it will install Oracle Java 8 with JCE Unlimited Strength Jurisdiction Policy
5. Restarting unifi services

## Authors

* **Aryo Pratama** - (https://github.com/aryonp)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

