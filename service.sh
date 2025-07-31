#!/system/bin/sh
MODDIR=${0%/*}

# 使用 chcon 命令，将模块中的字体文件和 fonts.xml 文件的 SELinux Context
# 从 ls -Z 命令得知，正确的上下文是 u:object_r:system_file:s0

# 为配置文件修改上下文
chcon u:object_r:system_file:s0 $MODDIR/system/etc/fonts.xml

# 为字体文件修改上下文
chcon -R u:object_r:system_file:s0 $MODDIR/system/fonts
