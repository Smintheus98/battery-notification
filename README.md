# battery-notifierd
Daemon program to control laptop battery level and warn/suspend when running low for WMs

Warning: This application uses the command line tool `systemctl` which is part of the common init system *systemd*.
If your system uses an other init system, you should change the code accordingly.

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
$ ./battery_notifierd
```

## Use
To use this program by your Window Manager it is recommended, to call the program in the WM-configuration file to automatically thart the program on WM start up.
Because this program works as a daemon it is recommended to start it as a background process:
```
$ ./battery_notifierd &
```
