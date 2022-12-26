#!/bin/bash

# a. Create copy of passwd file to passwd_new.
cp ./passwd ./passwd_new

# b. Change shell for user saned from /usr/sbin/nologin to /bin/bash using AWK
awk -F: '/saned/{$NF="/bin/bash";}1' OFS=: ./passwd_new > ./tmpfile1 && mv -f ./tmpfile1 ./passwd_new

# c. Change shell for user avahi from /usr/sbin/nologin to /bin/bash using SED
sed -i '/avahi:/s/\/usr\/sbin\/nologin/\/bin\/bash/' ./passwd_new

# d. Save only 1-st 3-th 5-th 7-th columns of each string based on : delimiter
 awk -F: '{print $1, $3, $5, $7}' OFS=: ./passwd_new > ./tmpfile2 && mv -f ./tmpfile2 ./passwd_new

# e. Remove all lines from file containing word daemon
sed -i '/daemon/d' ./passwd_new

# f. Change shell for all users with even UID to /bin/zsh
awk -F: '{ if ($2%2=="0") {$NF="/bin/zsh";} }1' OFS=: ./passwd_new > ./tmpfile3 && mv -f ./tmpfile3 ./passwd_new