title: 通过微博API发送微博
description: 闲着无聊研究了下怎么通过微博的API发送微博。
categories:
  - 其他
date: 2018-10-14 20:00:00
---
首先到 http://open.weibo.com/development 创建一个微连接，应用类型选择其他，之后应用分类选择桌面客户端。  
之后会自动跳到应用的详情页。  
因为新的发微博的接口必须要带个URL，所以应用基本信息里有个安全域名，需要选择是，之后填上自己的域名，这个域名就是每次发微博需要带的那个URL的域名。如果没有可以填 weibo.com ，之后发微博的时候带上自己的微博主页地址。  
其他信息随便填一填。  
发微博的接口文档是这个 http://open.weibo.com/wiki/2/statuses/share  
这个接口需要一个access_token。  
我们可以通过这个地址获得 http://open.weibo.com/tools/console  
因为是自己的应用，同时是自己的账号，所以这个access_token有五年的有效期。  
下面就是发微博的代码了，我用python写的，用别的语言也可以，access_token作为参数放到url后面，消息体用form表单urlencode方式：  
```
#coding:utf-8
import requests

status = "测试内容 >_自动发布 https://weibo.com/friendlykai"
params = { "access_token" : "your_access_token" }
data = { "status" : status }
url = "https://api.weibo.com/2/statuses/share.json"
r = requests.post(url=url,params=params,data=data)
print(r.text)
```
到这里就可以成功发送微博了。