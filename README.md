# 这是一个 Noto Sans 的 Magisk 模块

#### 该模块可以将手机的字体修改为 Noto Sans 动态字重

- 支持 无衬线、窄版、等宽 等字体样式；
- 支持 英文、中文（区分港、台繁体写法）、日文、韩文 等语言；
- 使用 遍黑体、天珩全字库 以补全生僻字符；
- 不支持修改 Google 系 Apps 的 UI 界面字体；



#### 测试环境

- 设备： Oneplus 12
- 系统： Oxygen OS based on Android 14
- 系统版本： CPH2581_14.0.0_840(EX01)



#### 具体 fonts.xml 修改：

- 替换英文字体：

  | fonts.xml 开头的位置：英文字体         | 含义     | 使用文件                                   |
  | -------------------------------------- | -------- | ------------------------------------------ |
  | `<family name="sans-serif">`           | 默认字体 | NotoSans-VF.ttf<br/>NotoSans-Italic-VF.ttf |
  | `<family name="sans-serif-condensed">` | 窄版字体 | NotoSans-VF.ttf<br/>NotoSans-Italic-VF.ttf |
  | `<family name="serif">`                | 等宽字体 | NotoSans-Mono-VF.ttf                       |

- 替换中、日、韩文字体：

  | fonts.xml 靠后的位置：中日韩字体 | 含义         | 使用文件           |
  | -------------------------------- | ------------ | ------------------ |
  | `<family lang="zh-Hans">`        | 中文简体     | NotoSansCJK-VF.ttc |
  | `<family lang="zh-Hant">`        | 中文繁体港版 | NotoSansCJK-VF.ttc |
  | `<family lang="zh-Hans">`        | 中文繁体台版 | NotoSansCJK-VF.ttc |
  | `<family lang="ja">`             | 日文         | NotoSansCJK-VF.ttc |
  | `<family lang="ko">`             | 韩文         | NotoSansCJK-VF.ttc |

- 可替换 emoji 表情：
  | fonts.xml 靠后的位置：emoji 表情 | 含义        | 使用文件 |
  | -------------------------------- | ----------- | -------- |
  | `<family lang="und-Zsye">`       | emoji       | 未修改   |
  | `<family lang="und-Zsym">`       | emoji Flags | 未修改   |



#### 关于通用性

- 在不同 Android 机型、不同的 ROM 中，字体及其配置文件并不一致，很难设计完美的通用模块；
- 建议提取当前系统中的 `/system/etc/fonts.xml` 文件，根据需要进行调整；
  - 靠前的 `<family >` 一般会被优先调用；
  - 不建议调换不同 `<family >` 之间的前后顺序；
  - 不建议修改已有的 `<alias >` 别名。