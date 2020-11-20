---

title: 通过Telegram Bot向Wordpress博客发送文章
date: 2020/07/19 23:00:00
description: 记录下通过Telegram Bot向Wordpress博客发送文章。
categories:
- 其他
tags:
- 教程

---

博主有个万年不更新的自建Wordpress博客，主要是没啥写的，想着利用一下，以后就不发微博了，改用博客，但是如果只是发表一些想法的话，打开文章发布页面太麻烦了，索性就利用Telegram Bot功能，直接通过Telegram Bot发送。  

如何创建一个Telegram Bot就不在这里细说了，百度一堆，其他的其实也没啥要说的。

启动之后，从Telegram上找到自己的Bot，然后/w空格之后写想要发布的内容就可以了。

直接上代码：

```
import logging
from telegram.ext import Updater, CommandHandler
import xmlrpc.client
import arrow

logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)


def start(update, context):
    context.bot.send_message(chat_id=update.effective_chat.id, text="I'm a bot, please talk to me!")


def w(update, context):
    print(update)
    if update.message.chat.username != '你的Telegram用户名':
        print("not admin")
        return

    user_says = " ".join(context.args)
    wp_url = "https://你的Wordpress博客的地址/xmlrpc.php"
    server = xmlrpc.client.ServerProxy(wp_url)
    post = {
        "title": "动态 | "+str(arrow.utcnow()),
        "description": user_says
    }

    result = server.metaWeblog.newPost(0, "你的Wordpress博客登录名", "你的Wordpress博客密码", post, True)
    update.message.reply_text("sent:" + str(result))


# 你的Http代理地址，主要用于本地调试
request_kwargs = {
    "proxy_url": "http://localhost:3000"
}

updater = Updater(token='你的Telegram Bot的Token', use_context=True,
                  request_kwargs=request_kwargs)

dispatcher = updater.dispatcher
dispatcher.add_handler(CommandHandler('start', start))
dispatcher.add_handler(CommandHandler("w", w))

updater.start_polling()

```