#!/system/bin/sh
MODDIR=${0%/*}

# 使用 chcon 命令，将模块中的 fonts.xml 文件的 SELinux Context
# 修改为系统原生的 system_file 类型。
# 从 ls -Z 命令得知，正确的上下文是 u:object_r:system_file:s0

# 为配置文件修改上下文
chcon u:object_r:system_file:s0 $MODDIR/system/etc/fonts.xml

# 为字体文件修改上下文
chcon -R u:object_r:system_file:s0 $MODDIR/system/fonts
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/NotoSans-Italic-VF.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/NotoSans-VF.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/NotoSansCJK-VF.ttc
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/NotoSansMono-VF.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/NotoSerif-Italic-VF.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/NotoSerif-VF.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/Plangothic-P1.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/TH-Tshyn-P2.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/TH-Tshyn-P0.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/TH-Tshyn-P1.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/TH-Tshyn-P2.ttf
# chcon u:object_r:system_file:s0 $MODDIR/system/fonts/TH-Tshyn-P16.ttf