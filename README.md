strava-auto-upload
==================

plug your device in and it'll email your latest .fit files to upload@strava.com

pull requests welcome. questions? latchkey@gmail.com

cavaets
-------

1. OS X only
1. assumes that you can send email from your desktop

config
------

1. ```git clone``` this repo
1. execute mountain lion (10.8) commands below if you are running this version
1. edit ```upload.sh``` and change the two variables at the top as necessary
1. edit ```strava.plist``` and specify the absolute path to the ```upload.sh``` script
1. copy ```strava.plist``` to ```~/Library/LaunchAgents/strava.plist```
1. execute ```launchctrl load ~/Libarary/LaunchAgents/strava.plist```

removal
-------
1. execute ```launchctrl unload ~/Libarary/LaunchAgents/strava.plist```

debug
-----
1. the ```$HOME/.strava-auto-upload``` folder contains the last file uploaded and a log of everything

osx mountain lion (10.8)
------------------------

there is a bug with postfix configuration with Mountain Lion that [causes an error](http://blog.deversus.com/2012/07/fix-for-postfix-in-mac-os-x-10-8-mountain-lion/). This fixed it for me:

```
sudo mkdir -p /Library/Server/Mail/Data/spool
sudo /usr/sbin/postfix set-permissions
sudo /usr/sbin/postfix start
```

future
------

1. simple installer
1. other platforms?
1. strava is working on an upload api and deprecating the email interface