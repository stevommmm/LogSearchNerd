LogSearchNerd
-------------

A log searching method written for the [nerd.nu](http://nerd.nu) Minecraft servers.

It provides the ability to search the output logs, which are stored in a gzipped format but are otherwise plain text.

A sqlite database is used for user authentication, it can be created via the MakeDB.pl script. Which will also insert the account admin:admin with a random password salt in the crypt function,  *I recommend changing this*

From there running GitGet.sh should download all the resources needed from this GitHub repo. Making sure that you are up to day. 

**Be mindful of updating your password salt when you overwride on update**

I do not intend to support this anywhere but on the nerd.nu web server, it was not indented to be modular or easy to install on another server.
