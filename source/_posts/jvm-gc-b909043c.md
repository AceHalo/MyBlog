---
title: 【草稿】JAVA垃圾回收器ParNew，CMS和G1简介
date: 2020-12-22 17:48:33
tags:
description: JAVA垃圾回收器ParNew，CMS和G1简介。文章还未完成，还是草稿状态。。。
---

# JAVA垃圾回收器ParNew，CMS和G1简介

## ParNew

年轻代的垃圾收集器，使用复制清除算法。

## CMS

CMS（Concurrent Mark Sweep）收集器是一种以获取最短回收停顿时间为目标的收集器。这是因为CMS收集器工作时，GC工作线程与用户线程可以并发执行，以此来达到降低收集停顿时间的目的。

CMS收集器仅作用于老年代的收集，是基于标记-清除算法的，它的运作过程分为4个步骤：

初始标记（CMS initial mark）    
并发标记（CMS concurrent mark）  
重新标记（CMS remark）  
并发清除（CMS concurrent sweep）  

其中，初始标记、重新标记这两个步骤仍然需要Stop-the-world。初始标记仅仅只是标记一下GC Roots能直接关联到的对象，速度很快，并发标记阶段就是进行GC Roots Tracing的过程，而重新标记阶段则是为了修正并发标记期间因用户程序继续运作而导致标记产生变动的那一部分对象的标记记录，这个阶段的停顿时间一般会比初始阶段稍长一些，但远比并发标记的时间短。

CMS以流水线方式拆分了收集周期，将耗时长的操作单元保持与应用线程并发执行。只将那些必需STW才能执行的操作单元单独拎出来，控制这些单元在恰当的时机运行，并能保证仅需短暂的时间就可以完成。这样，在整个收集周期内，只有两次短暂的暂停（初始标记和重新标记），达到了近似并发的目的。

CMS收集器优点：

并发收集、低停顿。

CMS收集器缺点：

CMS收集器对CPU资源非常敏感。
CMS收集器无法处理浮动垃圾（Floating Garbage）。
CMS收集器是基于标记-清除算法，该算法的缺点都有。
CMS收集器之所以能够做到并发，根本原因在于采用基于“标记-清除”的算法并对算法过程进行了细粒度的分解

## G1

G1重新定义了堆空间，打破了原有的分代模型，将堆划分为一个个区域。这么做的目的是在进行收集时不必在全堆范围内进行，这是它最显著的特点。区域划分的好处就是带来了停顿时间可预测的收集模型：用户可以指定收集操作在多长时间内完成。即G1提供了接近实时的收集特性。

G1具备如下特点：

并行与并发：G1能充分利用多CPU、多核环境下的硬件优势，使用多个CPU来缩短Stop-the-world停顿的时间，部分其他收集器原来需要停顿Java线程执行的GC操作，G1收集器仍然可以通过并发的方式让Java程序继续运行。

分代收集

空间整合：与CMS的标记-清除算法不同，G1从整体来看是基于标记-整理算法实现的收集器，从局部（两个Region之间）上来看是基于“复制”算法实现的。但无论如何，这两种算法都意味着G1运作期间不会产生内存空间碎片，收集后能提供规整的可用内存。这种特性有利于程序长时间运行，分配大对象时不会因为无法找到连续内存空间而提前触发下一次GC。

可预测的停顿：这是G1相对于CMS的一个优势，降低停顿时间是G1和CMS共同的关注点。

在G1之前的其他收集器进行收集的范围都是整个新生代或者老年代，而G1不再是这样。在堆的结构设计时，G1打破了以往将收集范围固定在新生代或老年代的模式，G1将堆分成许多相同大小的区域单元，每个单元称为Region。Region是一块地址连续的内存空间。

G1收集器将整个Java堆划分为多个大小相等的独立区域（Region），虽然还保留有新生代和老年代的概念，但新生代和老年代不再是物理隔离的了，它们都是一部分Region（不需要连续）的集合。Region的大小是一致的，数值是在1M到32M字节之间的一个2的幂值数，JVM会尽量划分2048个左右、同等大小的Region。其实这个数字既可以手动调整，G1也会根据堆大小自动进行调整。

G1收集的运作过程大致如下：

初始标记（Initial Marking）：仅仅只是标记一下GC Roots能直接关联到的对象，并且修改TAMS（Next Top at Mark Start）的值，让下一阶段用户程序并发运行时，能在正确可用的Region中创建新对象，这阶段需要停顿线程，但耗时很短。

并发标记（Concurrent Marking）：是从GC Roots开始堆中对象进行可达性分析，找出存活的对象，这阶段耗时较长，但可与用户程序并发执行。

最终标记（Final Marking）：是为了修正并发标记期间因用户程序继续运作而导致标记产生变动的那一部分标记记录，虚拟机将这段时间对象变化记录在线程Remembered Set Logs里面，最终标记阶段需要把Remembered Set Logs的数据合并到Remembered Set中，这阶段需要停顿线程，但是可并行执行。

筛选回收（Live Data Counting and Evacuation）：首先对各个Region的回收价值和成本进行排序，根据用户所期望的GC停顿时间来制定回收计划。这个阶段也可以做到与用户程序一起并发执行，但是因为只回收一部分Region，时间是用户可控制的，而且停顿用户线程将大幅提高收集效率。