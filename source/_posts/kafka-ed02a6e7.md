---
title: 【草稿】Kafka简介
date: 2020-12-22 17:50:45
tags:
description: Kafka简介。文章还未完成，还是草稿状态，等博主有时间了再好好写写。。。
---

# Kafka简介

这里主要先讲下Kafka的高可用机制吧。主要是ISR。

## ISR

在Kafka 中备份日志文件被称为replica，replica 又分为leader replica 和follower replica，而follower replica存在的唯一目的就是防止消息丢失，并不参与具体的业务逻辑的交互。只有leader 才参与服务，follower的作用就是充当leader的候补，平时的操作也只有信息同步。ISR （in-sync replica）也就是这组与leader保持同步的replica集合，我们要保证不丢消息，首先要保证ISR的存活（至少有一个备份存活），并且消息提交成功。那存活的概念是什么呢，就是说不仅需要机器正常，还需要跟上leader的消息进度，当达到一定程度的时候就会认为“非存活”状态。
