#!/bin/bash

# a. Create copy of passwd file to passwd_new.
cp ./passwd ./passwd_new
file="./passwd_new"

# b. Change shell for user saned from /usr/sbin/nologin to /bin/bash using AWK
awk -i inplace -F':' -OFS':' '/saned/{gsub("/usr/sbin/nologin","/bin/bash") }; {print}' "${file}"

# c. Change shell for user avahi from /usr/sbin/nologin to /bin/bash using SED
sed -i '/avahi/s/\/usr\/sbin\/nologin/\/bin\/bash/' "${file}"

# d. Save only 1-st 3-th 5-th 7-th columns of each string based on : delimiter
awk -i inplace -F':' -v OFS=: '{print $1, $3, $5, $7}' "${file}"

# e. Remove all lines from file containing word daemon
sed -i '/daemon/d' "${file}"

# f. Change shell for all users with even UID to /bin/zsh
awk -i inplace -F':' -v OFS=: '{ if ($2%2=="0") {gsub($4,"/bin/zsh") }; {print} }' "${file}"