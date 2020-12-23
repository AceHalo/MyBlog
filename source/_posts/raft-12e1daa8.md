---
title: 【草稿】Raft协议简述
date: 2020-12-22 17:51:41
tags:
description: Raft协议简述。文章还未完成，还是草稿状态，等博主有时间了再好好写写。。。
---

# Raft协议简述

Raft是工程上使用较为广泛的强一致性、去中心化、高可用的分布式协议。

Raft协议相对于Paxos协议更易于理解。

Raft协议主要有两部分需要了解，一是Leader选举，二是日志同步。

先贴两个参考链接吧，有时间再来完善这篇文章。

https://raft.github.io/raft.pdf

http://thesecretlivesofdata.com/raft/
