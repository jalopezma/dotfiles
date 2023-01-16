# Monitors

In `99-monitors-hotplug.rules` we have defined a rule to restart service when there are changes in the monitors connected.
It seems the `add` and `remove` actions are not triggering what I want and only the `change` does it.

```bash
sudo ln -s ~/repos/dotfiles/monitors/99-monitors-hotplug.rules /etc/udev/rules.d/99-monitors-hotplug.rules
sudo chmod 0644 /etc/udev/rules.d/99-monitors-hotplug.rules
touch /tmp/scripts.log && chmod 644 /tmp/scripts.log
sudo udevadm control --reload-rules 
```


You should have already linked the `monitors.sh` script in the `~/scripts/` folder.

```bash
ln -s ~/repos/dotfiles/scripts/monitors.sh ~/scripts/monitors.sh
```

You will also need to set the monitor service. I had to use a service as the udev rule is executing the script as `root` and that breaks the init of polybar.

```bash
sudo ln -s ~/repos/dotfiles/monitors/monitors.service /etc/systemd/system/monitors.service
systemctl daemon-reload
```
