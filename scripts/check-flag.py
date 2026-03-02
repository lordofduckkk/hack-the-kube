#!/usr/bin/env python3
import sys

FLAGS = {
    "level-1": "HTK{f0und_s3cr3t_1n_env_vars}",
    "level-2": "HTK{pr1v1l3g3d_c0nta1n3r_3sc4p3}",
    "level-3": "HTK{rb4c_3sc4l4t10n_clust3r_4dm1n}",
}

if len(sys.argv) != 3:
    print("Использование: check-flag.py <level> <flag>")
    sys.exit(1)

level, flag = sys.argv[1], sys.argv[2]
if flag == FLAGS.get(level):
    print("✅ Верно")
    sys.exit(0)
else:
    print("❌ Неверно")
    sys.exit(1)
