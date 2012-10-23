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
1. if you are running mountain lion (10.8), execute the commands below
1. ```mkdir ~/.strava-auto-upload```
1. ```echo ACTIVITIES=\"/Volumes/GARMIN/Garmin/Activities\" >> ~/.strava-auto-upload/config```
1. ```echo FROM=\"YOUR_EMAIL_ADDRESS@DOMAIN.COM\" >> ~/.strava-auto-upload/config```
1. copy ```strava.plist``` to ```~/Library/LaunchAgents/strava.plist```
1. edit ```strava.plist``` and specify the absolute path to the ```upload.sh``` script and the location of your Activities folder
1. ```launchctl load ~/Libarary/LaunchAgents/strava.plist```

removal
-------
1. ```launchctl unload ~/Libarary/LaunchAgents/strava.plist```

debug
-----
1. ```$HOME/.strava-auto-upload``` contains the last file uploaded and a log of everything

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

alternatives
------------

* [automator action](http://irionman.blogspot.com/2012/10/stravas-little-helper-use-apples.html)