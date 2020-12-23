---
title: 【草稿】Select,Poll,Epoll简介
date: 2020-12-22 17:53:40
tags:
description: Select,Poll,Epoll简介。文章还未完成，还是草稿状态，等博主有时间了再好好写写。。。
---

# Select,Poll,Epoll简介

Select,Poll,Epoll这三个都是同步IO，为什么这么说呢，因为在网络IO处理过程中，把数据从内核缓冲区复制到应用程序缓冲区这步是阻塞的，真正的异步IO，应该是操作系统把数据拷贝到应用程序的缓冲区后再通知应用程序处理。


具体内容，有篇文章写的挺好，我就先不在这里写了，等有时间再补上，可以先参考：https://cloud.tencent.com/developer/article/1005481