#!/bin/bash
rm ./Search.pl ./auth.pm ./auth.html ./newUser.html ./newUser.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/Search.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/auth.pm
wget https://raw.github.com/stevommmm/LogSearchNerd/master/auth.html
wget https://raw.github.com/stevommmm/LogSearchNerd/master/newUser.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/newUser.html
chmod +x ./Search.pl ./auth.pm ./newUser.pl
