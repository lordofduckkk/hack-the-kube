#!/bin/bash
EXPECTED="HTK{rb4c_3sc4l4t10n_clust3r_4dm1n}"
if [ "$1" == "$EXPECTED" ]; then
    echo "✅ Верно! Корпус В гордиться тобой! "
    exit 0
else
    echo "❌ Неверно"
    exit 1
fi
