# 一定要在脚本开头设置以下变量，否则脚本不会自定义挂载系统文件
export SKIPMOUNT=0

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

  print_modname

  unzip -o "$ZIPFILE" customize.sh -d $MODPATH >&2

  if ! grep -q '^SKIPUNZIP=1$' $MODPATH/customize.sh 2>/dev/null; then
    ui_print "- 正在提取模块文件"
    unzip -o "$ZIPFILE" -x 'META-INF/*' -x AdAway.apk -d $MODPATH >&2

    # 默认权限
    set_perm_recursive $MODPATH 0 0 0755 0644
  fi

  # 加载 customization 脚本
  [ -f $MODPATH/customize.sh ] && . $MODPATH/customize.sh