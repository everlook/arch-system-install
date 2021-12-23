### Printer install

```bash
$ sudo pacman -Sy cups 
$ sudo systemctl enable --now cups
$ sudo pacman -S hplip system-config-printer
```

* Use cups web interface to install printer
    * http://localhost:631

### Scanner install

```bash
$  sudo pacman -Sy sane-airscan simple-scan
```
