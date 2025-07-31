# 这是一个 Noto Sans 的 KernelSU Next / Magisk 模块

#### 该模块可以将手机的字体修改为 Noto Sans 动态字重

- 支持 `无衬线`、`窄版`、`衬线`、`等宽` 等字体样式；
- 支持 `英文`、`中文（区分港、台繁体写法）`、`日文`、`韩文` 等语言；
- 使用 `遍黑体`、`天珩全字库` 以补全生僻字符；

---

#### 测试环境

- 设备： Oneplus 12
- 系统： Oxygen OS based on Android 15
- 系统版本： CPH2581_15.0.0_832(EX01)
- Root 方案： KernelSU Next v1.0.9(12797)

---

#### KernelSU Next 踩坑记

1. 我刚迁移到 KernelSU Next 时，发现字体模块会导致系统 UI 闪退；

2. 我发现往 `/system/apps` 等目录放 apk 的模块无法生效（apk 未被安装为系统应用），但向 `/system/bin` 目录中放二进制文件的模块可以正常工作；

3. 我怀疑是否只正确挂载 `/system/bin` 目录，因此用 `mount | grep /system` 命令查看；

4. 我发现该目录确实被成功挂载，比如找到这样的行：`KSU on /system/fonts type tmpfs ...`；

5. 我开始思考，既然能挂载，为啥不生效呢？明明完全相同的模块之前 KernelSU 下挺正常啊？甚至这个字体模块只是简单的挂载文件而已；

6. 我尝试直接从系统中提取原本的 `fonts.xml` 文件，放到模块中来进行 “无意义挂载” ，结果发现系统 UI 仍然闪退：

    - 我想，这太奇怪了，因为字体配置文件没有改动；

    - 而且权限、用户和组也没问题，这个模块甚至没有任何复杂的脚本；

7. 然后我想到了另一样东西：SELiux 上下文，我使用 `ls -lZ` 分别查看系统中的字体文件、和模块挂载的字体文件，发现了问题所在：

    - 挂载的字体，上下文是： `u:object_r:adb_data_file:s0`

    - 而系统字体，上下文是： `u:object_r:system_file:s0`

8. 于是我尝试添加一个 `sepolicy.rule` 文件来允许系统正常读取模块挂载的 “adb 文件” ，发现模块仍然无法生效；

9. 于是，我干脆尝试在 `service.sh` 中使用 `chcon <context> <target_file>` 来修改上下文，发现模块终于被成功应用了。

*    **—— 原来是因为 KernelSU Next 没有自动处理 `/system/bin` 之外的文件的 SELinux Context 。加两行简单的命令，改一下需要挂载的字体及其配置文件的 "身份证" 就好了。😂**

---

#### 具体 fonts.xml 修改

- 替换英文字体：

  | fonts.xml 开头的位置：英文字体         | 含义     | 使用文件                                   |
  | -------------------------------------- | -------- | ------------------------------------------ |
  | `<family name="sans-serif">`           | 默认字体 | NotoSans-VF.ttf<br/>NotoSans-Italic-VF.ttf |
  | `<family name="sans-serif-condensed">` | 窄版字体 | NotoSans-VF.ttf<br/>NotoSans-Italic-VF.ttf |
  | `<family name="serif">` | 衬线字体 | NotoSerif-VF.ttf<br/>NotoSerif-Italic-VF.ttf |
  | `<family name="serif">`                | 等宽字体 | NotoSans-Mono-VF.ttf                       |

- 替换中、日、韩文字体：

  | fonts.xml 靠后的位置：中日韩字体 | 含义         | 使用文件           |
  | -------------------------------- | ------------ | ------------------ |
  | `<family lang="zh-Hans">`        | 中文简体     | NotoSansCJK-VF.ttc |
  | `<family lang="zh-Hant">`        | 中文繁体港版 | NotoSansCJK-VF.ttc |
  | `<family lang="zh-Bopo">`        | 中文繁体台版 | NotoSansCJK-VF.ttc |
  | `<family lang="ja">`             | 日文         | NotoSansCJK-VF.ttc |
  | `<family lang="ko">`             | 韩文         | NotoSansCJK-VF.ttc |

- 可替换 emoji 表情：
  | fonts.xml 靠后的位置：emoji 表情 | 含义        | 使用文件 |
  | -------------------------------- | ----------- | -------- |
  | `<family lang="und-Zsye">`       | emoji       | 未修改   |
  | `<family lang="und-Zsym">`       | emoji Flags | 未修改   |

---

#### 关于通用性

- 在不同 Android 机型、不同的 ROM 中，字体及其配置文件并不一致，很难设计完美的通用模块；
- 建议提取当前系统中的 `/system/etc/fonts.xml` 文件，根据需要进行调整；
  - 靠前的 `<family >` 一般会被优先调用；
  - 不建议调换不同 `<family >` 之间的前后顺序；
  - 不建议修改已有的 `<alias >` 别名。
