Maven + YouTube Android Player API
==================================

[YouTube Android Player API](https://developers.google.com/youtube/android/player/) 
was recently released and made available for download on their 
[developer site](https://developers.google.com/youtube/android/player/downloads/).
However, it is not publicly available on Maven central and the javadocs are
loosely extracted as HTML files.

If you use Maven you may wish to install/deploy the library to either a local
repository or a private repo of your choice.  The included script helps you
do exactly that.

Instructions
------------

To install the library to a local Maven repository, simply run the included
script without any arguments.

To deploy the library to an external Maven repository, run the script with
additional arguments:

    ./mvn-install-youtubeplayerapi.sh [repo-id repo-url]

Once completed you can make your project dependent on the library by adding
the following dependency declaration:

```xml
<dependency>
  <groupId>com.google.android</groupId>
  <artifactId>youtube-android-player-api</artifactId>
  <version>1.0.0</version>
</dependency>
```

Acknowledgement
---------------

Note that this script is largely inspired by Jake Wharton's great work for
[gms-mvn-install](https://github.com/JakeWharton/gms-mvn-install).
