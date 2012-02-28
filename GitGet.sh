#!/bin/bash
echo "Removing Files.";
rm auth.html  auth.pm  changeUser.pl  GitGet.sh  MakeDB.pl  newUser.pl  pastezomg.pl  Search.pl  UserAuth.db  User.html
echo "Downloading latest source from GitHub.com"
wget https://raw.github.com/stevommmm/LogSearchNerd/master/auth.html
wget https://raw.github.com/stevommmm/LogSearchNerd/master/auth.pm
wget https://raw.github.com/stevommmm/LogSearchNerd/master/changeUser.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/GitGet.sh
wget https://raw.github.com/stevommmm/LogSearchNerd/master/MakeDB.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/newUser.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/pastezomg.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/Search.pl
wget https://raw.github.com/stevommmm/LogSearchNerd/master/UserAuth.db
wget https://raw.github.com/stevommmm/LogSearchNerd/master/User.html
echo "Adding +x to executable files."
chmod +x ./auth.pm ./changeUser.pl ./newUser.pl ./Search.pl
