#!/bin/bash
EXPECTED="HTK{pr1v1l3g3d_c0nta1n3r_3sc4p3}"
if [ "$1" == "$EXPECTED" ]; then
    echo "Верно! Корпус Б гордиться тобой!"
    exit 0
else
    echo "Неверно"
    exit 1
fi
