#!/system/bin/sh
# 请不要硬编码 /magisk/modname/... ; 请使用 $MODDIR/...
# 这将使你的脚本更加兼容，即使Magisk在未来改变了它的挂载点
MODDIR=${0%/*}

# 这个脚本将以 late_start service 模式执行
# 更多信息请访问 Magisk 主题

# 等待 pm 命令可用
while [ -z "$(command -v pm)" ]; do
  sleep 1
done

# 等待系统完全就绪（可略微延迟）
sleep 10

# 检查主用户是否已经安装
ModuleID="adAwayHost"
AdAwayApp="org.adaway"
pm list packages | grep -q "$AdAwayApp" || {
    # 仅为主用户 (user 0) 安装
    cp $MODDIR/AdAway.apk /data/local/tmp/AdAway.apk
    pm install --user 0 $MODDIR/AdAway.apk
    rm /data/local/tmp/AdAway.apk
}
