# openvpn

As of December 2018, `openvpn` does not work out of the box due to the
penguin VM not using ChromeOS' VPN. A fix for this is to run this from crosh
(Cntl+Alt+T from Chrome):

```
vmc stop termina
vmc start termina
lxc config device add penguin tun unix-char path=/dev/net/tun
```

Then launch Terminal and run:

```
apt-get install open.vpn
```

To connect:

```
openvpn --config file.opvn
```
