
unzip -o "$ZIPFILE" AdAway.apk -d $TMPDIR >&2 || { echo "解压模块失败！"; exit 1; }

MODDIR=$TMPDIR
PKG="org.adaway"

# 检查用户是否已经安装
if pm list packages  | grep -q "$PKG"; then
  echo "AdAway 已安装，卸载现有的防止冲突"
  pm uninstall "$PKG"
fi

# 仅为主用户 (user 0) 安装
# cp $MODDIR/AdAway.apk /data/local/tmp/AdAway.apk
# ls /data/local/tmp/AdAway.apk -l
echo "正在安装 AdAway"
pm install --user 0 $MODDIR/AdAway.apk
rm $MODDIR/AdAway.apk
echo "安装完成,请重启手机使用"
