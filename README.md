# battery-notifierd
Daemon program to control laptop battery level and warn/suspend when running low for WMs

Warning: This application uses the command line tool `systemctl` which is part of the common init system **systemd**.
If your system uses an other init system, you should change the code accordingly.
Also this program uses an external tool `mpv` for sound generation.
Either install that programm, or change the code.
Furthermore the program depends on some other external files like icons, sounds or system files that may not exist on your system.
In that case changing these paths is recommended.

Nim compiler needed

## Build
To build the program simply run:
```
$ make build
```

## Run
The program can be executed by either use:
```
$ make run
```
Or when the program already has been built:
```
$ bin/battery_notifierd
```

## Use
To use this program by your Window Manager it is recommended, to call the program in the WM-configuration file to automatically thart the program on WM start up.
Because this program works as a daemon it is recommended to start it as a background process:
```
$ bin/battery_notifierd &
```
