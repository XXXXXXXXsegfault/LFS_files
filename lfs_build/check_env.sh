#!/bin/bash
[ $(uname -m) == x86_64 ] &&
[ -x /bin/wget ] &&
[ -x /bin/make ] &&
[ -x /bin/gcc ] &&
[ -x /bin/g++ ] &&
[ -x /bin/bison ] &&
[ -x /bin/flex ]
