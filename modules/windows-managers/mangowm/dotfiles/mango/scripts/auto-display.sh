#!/bin/bash
LOCKFILE="/tmp/noctalia-qs.lock"

# Nếu lockfile tồn tại và tiến trình trong đó vẫn sống -> thoát
if [ -e "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    echo "Noctalia đang chạy, thoát."
    exit 0
fi

# Xóa lockfile cũ nếu tiến trình đã chết
rm -f "$LOCKFILE"

# Ghi PID mới
echo $$ > "$LOCKFILE"

# Chạy Noctalia
exec /usr/bin/qs -c noctalia-shell
