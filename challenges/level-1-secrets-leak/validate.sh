#!/bin/bash
EXPECTED="HTK{f0und_s3cr3t_1n_env_vars}"
if [ "$1" == "$EXPECTED" ]; then
    echo "✅ Верно! Корпус А гордиться тобой!"
    exit 0
else
    echo "❌ Неверно"
    exit 1
fi
