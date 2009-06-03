About
---
Revolt is a sound-spectrum visualizer originally written by [Antti Kupila](http://www.anttikupila.com/flash/revolt-actionscript-3-based-spectrum-analyzer-source-released).

It has been updated with a simple Transport control and some javascript functionality by [Kongregate](http://www.kongregate.com).


Embed
---
When embedding it within a web page, include the flashvar mp3 with the url of the mp3 to load.
You can also provide the value 'true' to the flashvar autoPlay to have the mp3 begin playing immediately.

Build
---
Assuming you have mxmlc installed at /usr/local/flex3/bin/mxmlc you can invoke an ant task to build the swf.

<pre>
$ cd build
$ ant
Buildfile: build.xml

build:
     [exec] Loading configuration file /usr/local/flex3/frameworks/flex-config.xml
     [exec] /build/revolt.swf (10906 bytes)

BUILD SUCCESSFUL
Total time: 10 seconds
</pre>

License
---
This work is licensed under a [CreativeCommons Attribution-ShareAlike 2.5 license](http://creativecommons.org/licenses/by-sa/2.5/).