#!/bin/sh

set -e

./configure
make clean

# echo with default options
make

# echo with minimal PPPoE server options
(make clean || exit 0)
make USE_SERIAL= USE_DEMAND= COMP= USE_FULL_AUTH= USE_ECP= USE_FULL_IPCP= USE_FULL_LCP= USE_EAP= USE_ECP= USE_PAM= PLUGIN=y HAVE_INET6=y

# build with each item alone
for f in USE_SERIAL USE_DEMAND COMP USE_FULL_AUTH USE_ECP USE_FULL_IPCP USE_FULL_LCP USE_EAP USE_ECP USE_PAM
do
    echo
    echo "TRYING WITH $f=y"
    echo
    # try with
    (make clean || exit 0)
    make $f=y

    echo
    echo "TRYING WITH $f=n"
    echo
    # try without
    (make clean || exit 0)
    make $f=
done





