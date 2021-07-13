## Version: v3.34.1
## Date: 2021-3-25
## Update Content: 去除 "城城领现金" 过期活动互助码类与控制脚本功能环境变量


## 上面版本号中，如果第2位数字有变化，那么代表增加了新的参数，如果只有第3位数字有变化，仅代表更新了注释，没有增加新的参数，可更新可不更新

################################## 说 明 ##################################
## 以下配置中，带有 export 申明的，均由 lxk0301 大佬定义，均参考 lxk0301/scripts 仓库下的《环境变量说明》文档
## 详见：https://gitee.com/lxk0301/jd_scripts/blob/master/githubAction.md
## 其它关于互助码变量，考虑到直接按lxk0301大佬定义的变量去填的话，一是不方便记忆，二是容易搞混，所以最终的变量将由脚本去组合，您只要按注释去填即可
## 除此之外，还额外增加了是否自动删除失效任务AutoDelCron、是否自动增加新任务AutoAddCron、删除旧日志时间RmLogDaysAgo、随机延迟启动任务RandomDelay、是否添加自定义脚本EnableExtraShell五个人性化的设置供选择
## 所有赋值等号两边不能有空格，所有的值请一律在两侧添加半角的双引号，如果变量值中含有双引号，则外侧改为一对半角的单引号。
## 所有的赋值都可以参考 “定义东东萌宠是否静默运行” 部分，在不同时间设置不同的值，以达到您想要的效果，具体判断条件如下：
## $(date "+%d") 当前的日期，如：13
## $(date "+%w") 当前是星期几，如：3
## $(date "+%H") 当前的小时数，如：23
## $(date "+%M") 当前的分钟数，如：49
## 其他date命令的更多用法，可以在命令行中输入 date --help  查看
## 判断条件 -eq -ne -gt -ge -lt -le ，具体含义可百度一下

## ---------------------------------- 账 号 设 置 ----------------------------------

################################## 定义Cookie（必填） ##################################
## 请依次填入每个用户的Cookie，Cookie的具体形式（只有pt_key字段和pt_pin字段，没有其他字段）：pt_key=xxxxxxxxxx;pt_pin=xxxx;
## 1. 如果是通过控制面板编辑本文件，点击页面上方“扫码获取Cookie”即可获取，此方式获取的Cookie有效期为3个月
## 2. 还可以通过浏览器开发工具获取，此方式获得的Cookie只有1个月有效期，教程：https://github.com/SuperManito/JD-FreeFuck/wiki/GetCookies
## 必须按数字顺序1、2、3、4...依次编号下去，例子只有6个，超出6个您继续往下编号即可
## 不允许有汉字，如果ID有汉字，请在PC浏览器上获取Cookie，会自动将汉字转换为URL编码
Cookie1=""#major
Cookie2=""#spring
Cookie3=""#zjj
Cookie4=""
Cookie5=""
Cookie6=""



################################## 临时屏蔽某个Cookie（选填） ##################################
## 如果某些Cookie已经失效了，但暂时还没法更新，可以使用此功能在不删除该Cookie和重新修改Cookie编号的前提下，临时屏蔽掉某些编号的Cookie
## 多个Cookie编号以半角的空格分隔，两侧一对半角双引号，使用此功能后，在运行js脚本时账户编号将发生变化
## 举例1：TempBlockCookie="2"    临时屏蔽掉Cookie2
## 举例2：TempBlockCookie="2 4"  临时屏蔽掉Cookie2和Cookie4
## 如果只是想要屏蔽某个账号不玩某些小游戏，可以参考下面 case 这个命令的例子来控制，脚本名称请去掉后缀 “.js”
## case $1 in
##   jd_fruit)
##     TempBlockCookie="5"      # 账号5不玩东东农场
##     ;;
##   jd_dreamFactory | jd_jdfactory)
##     TempBlockCookie="2"      # 账号2不玩京喜工厂和东东工厂
##     ;;
##   jd_jdzz | jd_joy)
##     TempBlockCookie="3 6"    # 账号3、账号6不玩京东赚赚和宠汪汪
##     ;;
##  esac
TempBlockCookie=""


## ---------------------------------- D I Y 脚 本 功 能 设 置 ----------------------------------

################################## 是否添加 DIY 脚本（选填） ##################################
## 如果您自己会写shell脚本，并且希望在每次git_pull.sh这个脚本运行时，额外运行您的DIY脚本，请赋值为 "true"
## 同时，请务必将您的脚本命名为 diy.sh (只能叫这个文件名)，放在 config 目录下
EnableExtraShell=""

## 如果您想自动同步您的 DIY 脚本，请赋值为 "true"
EnableExtraShellUpdate=""

## DIY 脚本同步地址链接：（默认使用本人项目中的 DIY 脚本）
EnableExtraShellURL="https://gitee.com/SuperManito/JD-FreeFuck/raw/main/diy/diy.sh"

## 可在下方补充您需要用到的第三方活动脚本环境变量，例如通知变量，具体查看脚本内的注释，格式：export 变量名="变量值"
## export


## ---------------------------------- 项 目 脚 本 功 能 设 置 ----------------------------------

################################## 定义是否自动删除失效的脚本与定时任务（选填） ##################################
## 有的时候，某些JS脚本只在特定的时间有效，过了时间就失效了，需要自动删除失效的本地定时任务，则设置为 "true" ，否则请设置为 "false"
## 检测文件：lxk0301/jd_scripts 仓库中的 docker/crontab_list.sh，和 shylocks/Loon 仓库中的 docker/crontab_list.sh
## 当设置为 "true" 时，会自动从检测文件中读取比对删除的任务（识别以“jd_”、“jr_”、“jx_”开头的任务）
## 当设置为 "true" 时，脚本只会删除一整行失效的定时任务，不会修改其他现有任务，所以任何时候，您都可以自己调整您的crontab.list
## 当设置为 "true" 时，如果您有添加额外脚本是以“jd_”“jr_”“jx_”开头的，如检测文件中，会被删除，不是以“jd_”“jr_”“jx_”开头的任务则不受影响
AutoDelCron="true"


################################## 定义是否自动增加新的本地定时任务（选填） ##################################
## lxk0301 大佬会在有需要的时候，增加定时任务，如需要本地自动增加新的定时任务，则设置为 "true" ，否则请设置为 "false"
## 检测文件：lxk0301/jd_scripts 仓库中的 docker/crontab_list.sh，和 shylocks/Loon 仓库中的 docker/crontab_list.sh
## 当设置为 "true" 时，如果检测到检测文件中有增加新的定时任务，那么在本地也增加（识别以“jd_”、“jr_”、“jx_”开头的任务）
## 当设置为 "true" 时，会自动从检测文件新增加的任务中读取时间，该时间为北京时间
## 当设置为 "true" 时，脚本只会增加新的定时任务，不会修改其他现有任务，所以任何时候，您都可以自己调整您的crontab.list
AutoAddCron="true"


################################## 定义删除日志的时间（选填） ##################################
## 定义在运行删除旧的日志任务时，要删除多少天以前的日志，请输入正整数，不填则禁用删除日志的功能
RmLogDaysAgo="7"


################################## 定义随机延迟启动任务（选填） ##################################
## 如果任务不是必须准点运行的任务，那么给它增加一个随机延迟，由您定义最大延迟时间，单位为秒，如 RandomDelay="300" ，表示任务将在 1-300 秒内随机延迟一个秒数，然后再运行
## 在crontab.list中，在每小时第0-2分、第30-31分、第59分这几个时间内启动的任务，均算作必须准点运行的任务，在启动这些任务时，即使您定义了RandomDelay，也将准点运行，不启用随机延迟
## 在crontab.list中，除掉每小时上述时间启动的任务外，其他任务在您定义了 RandomDelay 的情况下，一律启用随机延迟，但如果您按照Wiki教程给某些任务添加了 "now"，那么这些任务也将无视随机延迟直接启动
RandomDelay="300"


## ---------------------------------- 京 东 隐 私 安 全 环 境 变 量 ----------------------------------

################################## 定义User-Agent（选填） ##################################
## 自定义lxk0301大佬仓库里京东系列js脚本的USER_AGENTS，不懂不知不会User-Agent的请不要随意填写内容，随意填写了出错概不负责
## 如需使用，请自行解除下一行注释
# export JD_USER_AGENT=""


## ---------------------------------- 推 送 通 知 环 境 变 量 ----------------------------------

################################## 定义通知TOKEN（选填） ##################################
## 想通过什么渠道收取通知，就填入对应渠道的值，您也可以同时使用多个渠道获取通知
## 目前提供：微信server酱、iOS Bark APP、pushplus(推送加)、telegram机器人、钉钉机器人、企业微信机器人、iGot等通知方式
## 具体教程请查看环境变量说明文档：https://gitee.com/lxk0301/jd_docker/blob/master/githubAction.md

## 1. Server酱
## 官方网站：https://sc.ftqq.com/3.version （旧版，4月停止支持）
##          https://sct.ftqq.com          （Turbo新版，支持更多渠道）
## 已兼容 Server酱·Turbo版
## 下方填写 SCHKEY 值或 SendKey 值
export PUSH_KEY="SCU174841T1e3a9013c31b557a1e764724777175a260ab76ff26c72"


## 2. BARK
## 参考图片：https://gitee.com/lxk0301/jd_docker/blob/master/icon/bark.jpg
## 下方填写app提供的设备码，例如：https://api.day.app/123 那么此处的设备码就是123
export BARK_PUSH=""

## 下方填写推送声音设置，例如choo，具体值请在bark-推送铃声-查看所有铃声
export BARK_SOUND=""


## 3. Telegram 
## 具体教程：https://gitee.com/lxk0301/jd_docker/blob/master/backUp/TG_PUSH.md
## 需设备可连接外网，"TG_BOT_TOKEN"和"TG_USER_ID"必须同时赋值！
## 下方填写自己申请@BotFather的Token，如10xxx4:AAFcqxxxxgER5uw
export TG_BOT_TOKEN=""

## 下方填写 @getuseridbot 中获取到的纯数字ID
export TG_USER_ID=""

## Telegram 代理IP（选填）
## 下方填写代理IP地址，代理类型为 http，比如您代理是 http://127.0.0.1:1080，则填写 "127.0.0.1"
## 如需使用，请自行解除下一行的注释
# export TG_PROXY_HOST=""

## Telegram 代理端口（选填）
## 下方填写代理端口号，代理类型为 http，比如您代理是 http://127.0.0.1:1080，则填写 "1080"
## 如需使用，请自行解除下一行的注释
# export TG_PROXY_PORT=""

## Telegram api自建反向代理（选填）
## 教程：https://www.hostloc.com/thread-805441-1-1.html
## 如反向代理地址 http://aaa.bbb.ccc 则填写 aaa.bbb.ccc
## 如需使用，请赋值代理地址链接，并自行解除下一行的注释
# export TG_API_HOST=""


## 4. 钉钉 
## 官方文档：https://developers.dingtalk.com/document/app/custom-robot-access
## 参考图片：https://gitee.com/lxk0301/jd_docker/blob/master/icon/DD_bot.png
## "DD_BOT_TOKEN"和"DD_BOT_SECRET"必须同时赋值！
## 下方填写token后面的内容，只需 https://oapi.dingtalk.com/robot/send?access_token=XXX 等于=符号后面的XXX即可
export DD_BOT_TOKEN=""

## 下方填写密钥，机器人安全设置页面，加签一栏下面显示的SEC开头的SECXXXXXXXXXX等字符
## 注:钉钉机器人安全设置只需勾选加签即可，其他选项不要勾选
export DD_BOT_SECRET=""


## 5. 企业微信机器人
## 官方说明文档：https://work.weixin.qq.com/api/doc/90000/90136/91770
## 下方填写密钥，企业微信推送 webhook 后面的 key
export QYWX_KEY=""


## 6. 企业微信应用
## 参考文档：http://note.youdao.com/s/HMiudGkb
##          http://note.youdao.com/noteshare?id=1a0c8aff284ad28cbd011b29b3ad0191
## 下方填写素材库图片id（corpid,corpsecret,touser,agentid），素材库图片填0为图文消息, 填1为纯文本消息
export QYWX_AM=""


## 7. iGot聚合
## 参考文档：https://wahao.github.io/Bark-MP-helper
## 下方填写iGot的推送key，支持多方式推送，确保消息可达
export IGOT_PUSH_KEY=""


## 8. Push Plus
## 官方网站：http://www.pushplus.plus
## 下方填写您的Token，微信扫码登录后一对一推送或一对多推送下面的token，只填 PUSH_PLUS_TOKEN 默认为一对一推送
export PUSH_PLUS_TOKEN=""

## 一对一多推送（选填）
## 下方填写您的一对多推送的 "群组编码" ，（一对多推送下面->您的群组(如无则新建)->群组编码）
## 注 1. 需订阅者扫描二维码 
##    2、如果您是创建群组所属人，也需点击“查看二维码”扫描绑定，否则不能接受群组消息推送
export PUSH_PLUS_USER=""


## ---------------------------------- 互 助 码 类 环 境 变 量 ----------------------------------

################################## 1. 定义东东农场互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyFruit1=""
MyFruit2=""
MyFruit3=""
MyFruit4=""
MyFruit5=""
MyFruit6=""
MyFruitA=""
MyFruitB=""

ForOtherFruit1=""
ForOtherFruit2=""
ForOtherFruit3=""
ForOtherFruit4=""
ForOtherFruit5=""
ForOtherFruit6=""


################################## 2. 定义东东萌宠互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyPet1=""
MyPet2=""
MyPet3=""
MyPet4=""
MyPet5=""
MyPet6=""
MyPetA=""
MyPetB=""

ForOtherPet1=""
ForOtherPet2=""
ForOtherPet3=""
ForOtherPet4=""
ForOtherPet5=""
ForOtherPet6=""


################################## 3. 定义种豆得豆互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyBean1=""
MyBean2=""
MyBean3=""
MyBean4=""
MyBean5=""
MyBean6=""
MyBeanA=""
MyBeanB=""

ForOtherBean1=""
ForOtherBean2=""
ForOtherBean3=""
ForOtherBean4=""
ForOtherBean5=""
ForOtherBean6=""


################################## 4. 定义东东工厂互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyJdFactory1=""
MyJdFactory2=""
MyJdFactory3=""
MyJdFactory4=""
MyJdFactory5=""
MyJdFactory6=""
MyJdFactoryA=""
MyJdFactoryB=""

ForOtherJdFactory1=""
ForOtherJdFactory2=""
ForOtherJdFactory3=""
ForOtherJdFactory4=""
ForOtherJdFactory5=""
ForOtherJdFactory6=""


################################## 5. 定义京喜工厂互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyDreamFactory1=""
MyDreamFactory2=""
MyDreamFactory3=""
MyDreamFactory4=""
MyDreamFactory5=""
MyDreamFactory6=""
MyDreamFactoryA=""
MyDreamFactoryB=""

ForOtherDreamFactory1=""
ForOtherDreamFactory2=""
ForOtherDreamFactory3=""
ForOtherDreamFactory4=""
ForOtherDreamFactory5=""
ForOtherDreamFactory6=""


################################## 6. 定义京东赚赚互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyJdzz1=""
MyJdzz2=""
MyJdzz3=""
MyJdzz4=""
MyJdzz5=""
MyJdzz6=""
MyJdzzA=""
MyJdzzB=""

ForOtherJdzz1=""
ForOtherJdzz2=""
ForOtherJdzz3=""
ForOtherJdzz4=""
ForOtherJdzz5=""
ForOtherJdzz6=""


################################## 7. 定义疯狂的JOY互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyJoy1=""
MyJoy2=""
MyJoy3=""
MyJoy4=""
MyJoy5=""
MyJoy6=""
MyJoyA=""
MyJoyB=""

ForOtherJoy1=""
ForOtherJoy2=""
ForOtherJoy3=""
ForOtherJoy4=""
ForOtherJoy5=""
ForOtherJoy6=""


################################## 8. 定义口袋书店互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyBookShop1=""
MyBookShop2=""
MyBookShop3=""
MyBookShop4=""
MyBookShop5=""
MyBookShop6=""
MyBookShopA=""
MyBookShopB=""

ForOtherBookShop1=""
ForOtherBookShop2=""
ForOtherBookShop3=""
ForOtherBookShop4=""
ForOtherBookShop5=""
ForOtherBookShop6=""


################################## 9. 定义签到领现金互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyCash1=""
MyCash2=""
MyCash3=""
MyCash4=""
MyCash5=""
MyCash6=""
MyCashA=""
MyCashB=""

ForOtherCash1=""
ForOtherCash2=""
ForOtherCash3=""
ForOtherCash4=""
ForOtherCash5=""
ForOtherCash6=""


################################## 10. 定义京喜农场互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
## 京喜农场助力码为 JSON 格式因此使用单引号，json 格式如下
## {"smp":"22bdadsfaadsfadse8a","active":"jdnc_1_btorange210113_2","joinnum":"1"}
## 助力码获取可以通过 bash jd.sh jd_get_share_code now 命令获取
## 注意：京喜农场 种植种子发生变化的时候，互助码也会变！！
MyJxnc1=''
MyJxnc2=''
MyJxnc3=''
MyJxnc4=''
MyJxnc5=''
MyJxnc6=''
MyJxncA=''
MyJxncB=''

ForOtherJxnc1=""
ForOtherJxnc2=""
ForOtherJxnc3=""
ForOtherJxnc4=""
ForOtherJxnc5=""
ForOtherJxnc6=""


################################## 11. 定义闪购盲盒互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MySgmh1=""
MySgmh2=""
MySgmh3=""
MySgmh4=""
MySgmh5=""
MySgmh6=""
MySgmhA=""
MySgmhB=""

ForOtherSgmh1=""
ForOtherSgmh2=""
ForOtherSgmh3=""
ForOtherSgmh4=""
ForOtherSgmh5=""
ForOtherSgmh6=""


################################## 12. 定义京喜财富岛互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyCfd1=""
MyCfd2=""
MyCfd3=""
MyCfd4=""
MyCfd5=""
MyCfd6=""
MyCfdA=""
MyCfdB=""

ForOtherCfd1=""
ForOtherCfd2=""
ForOtherCfd3=""
ForOtherCfd4=""
ForOtherCfd5=""
ForOtherCfd6=""


################################## 13. 定义环球挑战赛互助（选填） ##################################
## 具体填法及要求详见本文件最下方“互助码填法示例”
MyGlobal1=""
MyGlobal2=""
MyGlobal3=""
MyGlobal4=""
MyGlobal5=""
MyGlobal6=""
MyGlobalA=""
MyGlobalB=""

ForOtherGlobal1=""
ForOtherGlobal2=""
ForOtherGlobal3=""
ForOtherGlobal4=""
ForOtherGlobal5=""
ForOtherGlobal6=""


##################################################################################################


# ---------------------------------- 控 制 脚 本 功 能 环 境 变 量 ----------------------------------

################################## 1. 定义京东多合一签到延迟签到（选填） ##################################
## 默认分批并发无延迟，自定义延迟签到，单位毫秒，延迟作用于每个签到接口
## 详见此处说明：https://github.com/NobyDa/Script/blob/master/JD-DailyBonus/JD_DailyBonus.js#L93
## 例: "2000" 则表示每个接口延迟2秒; "2000-5000" 则表示每个接口之间最小2秒至最大5秒内的随机延迟
## 如需填写建议输入数字 "1"，填入延迟则切换顺序签到（耗时较长）
export JD_BEAN_STOP=""


################################## 2. 定义京东多合一签到是否静默运行（选填） ##################################
## 默认推送签到结果通知，如想要静默不发送通知，填 "true" 表示不发送通知
export JD_BEAN_SIGN_STOP_NOTIFY=""


################################## 3. 定义京东多合一签到推送签到结果通知类型（选填） ##################################
## 默认推送签到简洁结果，填 "true" 表示推送简洁通知
## 具体效果查看效果图：https://gitee.com/lxk0301/jd_docker/blob/master/icon/bean_sign_simple.jpg
export JD_BEAN_SIGN_NOTIFY_SIMPLE=""


################################## 4. 定义东东萌宠是否静默运行（选填） ##################################
## 默认为 "false"，不静默，推送通知消息，如不想收到通知，请修改为 "true"
## 每次执行脚本通知太频繁了，改成只在周三和周六中午那一次运行时发送通知提醒
## 除掉上述提及时间之外，均设置为 true，静默不发通知
## 特别说明：针对北京时间有效。
if [ $(date "+%w") -eq 6 ] && [ $(date "+%H") -ge 9 ] && [ $(date "+%H") -lt 14 ]; then
  export PET_NOTIFY_CONTROL="false"
elif [ $(date "+%w") -eq 3 ] && [ $(date "+%H") -ge 9 ] && [ $(date "+%H") -lt 14 ]; then
  export PET_NOTIFY_CONTROL="false"
else
  export PET_NOTIFY_CONTROL="true"
fi


################################## 5. 定义东东农场是否静默运行（选填） ##################################
## 默认为 "false"，不静默，推送通知消息，如不想收到通知，请修改为 "true"
## 如果您不想完全关闭或者完全开启通知，只想在特定的时间发送通知，可以参考下面的 "定义东东萌宠推送开关" 部分，设定几个if判断条件
export FRUIT_NOTIFY_CONTROL=""


################################## 6. 定义京东领现金是否静默运行（选填） ##################################
## 默认为 "false"，不静默，推送通知消息，如不想收到通知，请修改为 "true"
export CASH_NOTIFY_CONTROL=""


################################## 7. 定义点点券是否静默运行（选填） ##################################
## 默认为 "false"，不静默，推送通知消息，如不想收到通知，请修改为 "true"
export DDQ_NOTIFY_CONTROL=""


################################## 8. 定义京东赚赚小程序是否静默运行（选填） ##################################
## 默认为 "false"，不静默，推送通知消息，如不想收到通知，请修改为 "true"
export JDZZ_NOTIFY_CONTROL=""


################################## 9. 定义宠汪汪兑换京豆是否静默运行（选填） ##################################
## 默认为 "false"，不静默，推送通知消息，如不想收到通知，请修改为 "true"
export JD_JOY_REWARD_NOTIFY=""


################################## 10. 定义宠汪汪喂食克数（选填） ##################################
## 您期望的宠汪汪每次喂食克数，只能填入10、20、40、80，默认为10
## 如实际持有食物量小于所设置的克数，脚本会自动降一档，直到降无可降
## 具体情况请自行在宠汪汪游戏中去查阅攻略
export JOY_FEED_COUNT=""


################################## 11. 定义宠汪汪是否自动给好友的汪汪喂食（选填） ##################################
## 默认 "false" 不会自动给好友的汪汪喂食，如想自动喂食，请修改为 "true"
export JOY_HELP_FEED=""


################################## 12. 定义宠汪汪是否自动报名参加赛跑（选填） ##################################
## 默认 "true" 参加双人赛跑，如需关闭，请修改为 "false"
export JOY_RUN_FLAG=""


################################## 13. 定义宠汪汪参加比赛级别（选填） ##################################
## 当JOY_RUN_FLAG不设置或设置为 "true" 时生效
## 可选值：2,10,50，其他值不可以。其中2代表参加双人PK赛，10代表参加10人突围赛，50代表参加50人挑战赛，不填时默认为2
## 各个账号间请使用 & 分隔，比如：JOY_TEAM_LEVEL="2&2&50&10"
## 如果您有5个账号但只写了四个数字，那么第5个账号将默认参加2人赛，账号如果更多，与此类似
export JOY_TEAM_LEVEL=""


################################## 14. 定义宠汪汪赛跑获胜后是否推送通知（选填） ##################################
## "flase" 为不推送通知消息，"true" 为发送推送通知消息
export JOY_RUN_NOTIFY=""


################################## 15. 定义宠汪汪赛跑是否开启本地账号内部互助（选填） ##################################
## 默认为 "flase" 不内部互助，如果您本地有多个账号则可开启此功能，如需启用请修改为 "true"
export JOY_RUN_HELP_MYSELF=""


################################## 16. 定义宠汪汪积分兑换京豆数量（选填） ##################################
## 目前的可用值包括：0、20、500，其中0表示为不自动兑换京豆，如不设置，将默认为"0"
## 不同等级可兑换不同数量的京豆，详情请见宠汪汪游戏中兑换京豆选项
## 500的京豆每天有总量限制，设置了并且您也有足够积分时，也并不代表就一定能抢到
export JD_JOY_REWARD_NAME=""


################################## 17. 定义东东超市兑换京豆数量（选填） ##################################
## 东东超市蓝币兑换，可用值包括：
## 一、0：表示不兑换京豆，这也是js脚本的默认值
## 二、20：表示兑换20个京豆
## 三、1000：表示兑换1000个京豆
## 四、可兑换清单的商品名称，输入能跟唯一识别出来的关键词即可，比如：MARKET_COIN_TO_BEANS="抽纸"
## 注意：有些比较贵的实物商品京东只是展示出来忽悠人的，即使您零点用脚本去抢，也会提示没有或提示已下架
export MARKET_COIN_TO_BEANS="0"


################################## 18. 定义东东超市兑换奖品成功后是否静默运行（选填） ##################################
## 默认 "false" 关闭（即:奖品兑换成功后会发出通知提示），如需要静默运行不发出通知，请修改为 "true"
export MARKET_REWARD_NOTIFY=""


################################## 19. 定义东东超市是否自动参加PK队伍（选填） ##################################
## 默认为 "true" ，每次PK活动参加脚本作者创建的PK队伍，若不想参加，请修改为 "false"
export JOIN_PK_TEAM=""


################################## 20. 定义东东超市是否自动使用金币去抽奖（选填） ##################################
## 是否用金币去抽奖，默认 "false" 关闭，如需开启，请修改为 "true"
export SUPERMARKET_LOTTERY=""


################################## 21. 定义东东农场是否使用水滴换豆卡（选填） ##################################
## 如果出现限时活动时100g水换20豆，此时比浇水划算，推荐换豆，"true" 表示换豆（不浇水），"false" 表示不换豆（继续浇水），默认是"false"
## 如需切换为换豆（不浇水），请修改为 "true"
export FRUIT_BEAN_CARD=""


################################## 22. 定义 unsubscribe 取关参数（选填） ##################################
## 具体教程：https://gitee.com/lxk0301/jd_docker/blob/master/githubAction.md#%E5%8F%96%E5%85%B3%E5%BA%97%E9%93%BAsecret%E7%9A%84%E8%AF%B4%E6%98%8E
## jd_unsubscribe这个任务是用来取关每天做任务关注的商品和店铺，默认在每次运行时取关20个商品和20个店铺
## 如果取关数量不够，可以根据情况增加，还可以设置 jdUnsubscribeStopGoods 和 jdUnsubscribeStopShop 
## 商品取关数量
goodPageSize=""
## 店铺取关数量
shopPageSize=""
## 遇到此商品不再取关此商品以及它后面的商品，需去商品详情页长按拷贝商品信息
jdUnsubscribeStopGoods=""
## 遇到此店铺不再取关此店铺以及它后面的店铺，请从头开始输入店铺名称
jdUnsubscribeStopShop=""


################################## 23. 定义疯狂的JOY是否循环助力（选填） ##################################
## 默认 "false" 不开启循环助力，如需开启循环助力，请修改为 "true"
export JDJOY_HELPSELF=""


################################## 24. 定义疯狂的JOY京豆兑换数量（选填） ##################################
## 目前最小值为 2000 京豆，默认为 "0" 不开启京豆兑换
export JDJOY_APPLYJDBEAN=""


################################## 25. 定义疯狂的JOY购买joy等级（选填） ##################################
## 疯狂的JOY自动购买什么等级的JOY，如需要使用请自行解除注释，可购买等级为 "1~30"
# export BUY_JOY_LEVEL=""


################################## 26. 定义摇钱树是否自动将金果卖出变成金币（选填） ##################################
## 金币有时效，默认为 "false"，不卖出金果为金币，如想希望自动卖出，请修改为 "true"
export MONEY_TREE_SELL_FRUIT=""


################################## 27. 定义东东工厂心仪的商品（选填） ##################################
## 只有在满足以下条件时，才自动投入电力：一是存储的电力满足生产商品所需的电力，二是心仪的商品有库存，如果没有输入心仪的商品，那么当前您正在生产的商品视作心仪的商品
## 如果您看不懂上面的话，请去东东工厂游戏中查阅攻略
## 心仪的商品请输入商品的全称或能唯一识别出该商品的关键字
export FACTORAY_WANTPRODUCT_NAME=""


################################## 28. 定义京喜工厂控制哪个京东账号不运行此脚本（选填） ##################################
## 输入"1"代表第一个京东账号不运行，多个使用 & 连接，例："1&3" 代表账号1和账号3不运行京喜工厂脚本，注：输入"0"，代表全部账号不运行京喜工厂脚本
## 如果使用了 “临时屏蔽某个Cookie” TempBlockCookie 功能，编号会发生变化
export DREAMFACTORY_FORBID_ACCOUNT=""


################################## 29. 定义东东工厂控制哪个京东账号不运行此脚本（选填） ##################################
## 输入"1"代表第一个京东账号不运行，多个使用 & 连接，例："1&3" 代表账号1和账号3不运行东东工厂脚本，注：输入"0"，代表全部账号不运行东东工厂脚本
## 如果使用了 “临时屏蔽某个Cookie” TempBlockCookie 功能，编号会发生变化
export JDFACTORY_FORBID_ACCOUNT=""


################################## 30. 定义京喜财富岛是否静默运行（选填） ##################################
## 默认为 "false"，不推送通知消息，如果想收到通知，请修改为 "true"
export CFD_NOTIFY_CONTROL=""


################################## 31. 定义京小兑是否将抽奖卷自动兑换为兑币（选填） ##################################
## 默认为 "false"，不兑换，如果想自动兑换，请修改为 "true"
export JD_JXD_EXCHANGE=""


################################## 32. 定义京喜农场控制通知推送级别（选填） ##################################
## 默认为 "1"，通知级别（0=只通知成熟；1=本次获得水滴>0；2=任务执行；3=任务执行+未种植种子）
export JXNC_NOTIFY_LEVEL=""


################################## 额外的环境变量（自定义） ##################################
## 请在下方补充您需要用到的额外的环境变量，格式：export 变量名="变量值"
## export


# ---------------------------------- 互 助 码 填 写 示 例 ----------------------------------

################################## 互助码填法示例 ##################################
## **互助码是填在My系列变量中的，ForOther系统变量中只要填入My系列的变量名即可，按注释中的例子拼接，以东东农场为例，如下所示。**
## **实际上东东农场一个账号只能给别人助力3次，我多写的话，只有前几个会被助力。但如果前面的账号获得的助力次数已经达到上限了，那么还是会尝试继续给余下的账号助力，所以多填也是有意义的。**
## **ForOther系列变量必须从1开始编号，依次编下去。**

# MyFruit1="e6e04602d5e343258873af1651b603ec"  # 这是Cookie1这个账号的互助码
# MyFruit2="52801b06ce2a462f95e1d59d7e856ef4"  # 这是Cookie2这个账号的互助码
# MyFruit3="e2fd1311229146cc9507528d0b054da8"  # 这是Cookie3这个账号的互助码
# MyFruit4="6dc9461f662d490991a31b798f624128"  # 这是Cookie4这个账号的互助码
# MyFruit5="30f29addd75d44e88fb452bbfe9f2110"  # 这是Cookie5这个账号的互助码
# MyFruit6="1d02fc9e0e574b4fa928e84cb1c5e70b"  # 这是Cookie6这个账号的互助码
# MyFruitA="5bc73a365ff74a559bdee785ea97fcc5"  # 这是我和别人交换互助，另外一个用户A的互助码
# MyFruitB="6d402dcfae1043fba7b519e0d6579a6f"  # 这是我和别人交换互助，另外一个用户B的互助码
# MyFruitC="5efc7fdbb8e0436f8694c4c393359576"  # 这是我和别人交换互助，另外一个用户C的互助码

# ForOtherFruit1="${MyFruit2}@${MyFruitB}@${MyFruit4}"   # Cookie1这个账号助力Cookie2的账号的账号、Cookie4的账号以及用户B
# ForOtherFruit2="${MyFruit1}@${MyFruitA}@${MyFruit4}"   # Cookie2这个账号助力Cookie1的账号的账号、Cookie4的账号以及用户A
# ForOtherFruit3="${MyFruit1}@${MyFruit2}@${MyFruitC}@${MyFruit4}@${MyFruitA}@${MyFruit6}"  # 解释同上，东东农场实际上只能助力3次
# ForOtherFruit4="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruitC}@${MyFruit6}@${MyFruitA}"  # 解释同上，东东农场实际上只能助力3次
# ForOtherFruit5="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruitB}@${MyFruit4}@${MyFruit6}@${MyFruitC}@${MyFruitA}"
# ForOtherFruit6="${MyFruit1}@${MyFruit2}@${MyFruit3}@${MyFruitA}@${MyFruit4}@${MyFruit5}@${MyFruitC}"
