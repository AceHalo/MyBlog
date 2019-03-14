---

title: 每天几道Leetcode系列day3
date: 2019/03/15 02:15:00
description: 每天刷几道leetcode题目系列，解法不一定是最优的 【146. LRU Cache】
categories:
- leetcode
tags:
- leetcode
---


### 146. LRU Cache

[题目链接](https://leetcode.com/problems/lru-cache/)

这题做的心态崩了，写的时候总是有问题，最后选择了保证可读性。虽然代码看起来操作比较复杂耗时，其实它还是O(1)的复杂度。

解题思路：  
1.数据用哈希表存  
2.访问次序的话需要保存一个最近访问的节点指针，和一个最早访问的节点指针，因为要O(1)的复杂度，所以肯定不能用纯链表保存，如果访问到链表中间的数据，时间复杂度肯定不是O(1)

3.因为心态崩了，所以把Get操作分解成先获取值，然后执行Delete操作，然后再执行Add操作。  
4.因为心态崩了，所以做Add操作前先执行Delete操作。  
5.之所以像上面提到的那么做，是因为，这样就可以把精力集中到处理Add和Delete操作上，只要这两个操作处理好两个头尾指针就好


code：

```
# coding:utf-8
class LRUCache:

    def __init__(self, capacity: int):
        self.cap = capacity
        self.node_wrap = NodeWrap()

    def get(self, key: int) -> int:
        return self.node_wrap.get(key)

    def put(self, key: int, value: int) -> None:
        self.node_wrap.add(key, value)
        if self.node_wrap.get_len() > self.cap:
            self.node_wrap.delete_oldest()


class Node:
    def __init__(self, key, val, older, newer):
        self.key = key
        self.val = val
        self.older = older
        self.newer = newer


class NodeWrap:
    def __init__(self):
        self.newest = None
        self.oldest = None
        self.dic = {}

    def get(self, key):
        if key not in self.dic:
            return -1

        val = self.dic[key].val
        self.delete(key)
        self.add(key, val)
        return val

    def add(self, key, val):
        self.delete(key)
        node = Node(key, val, None, None)
        self.dic[key] = node

        if self.newest is not None:
            self.newest.newer = node
            node.older = self.newest

        self.newest = node
        if self.oldest is None:
            self.oldest = node

    def delete(self, key):
        if key not in self.dic:
            return

        node = self.dic[key]

        if self.newest is not None and self.newest.key == node.key:
            self.newest = node.older
            if self.newest is not None:
                self.newest.newer = None

        if self.oldest is not None and self.oldest.key == node.key:
            self.oldest = node.newer
            if self.oldest is not None:
                self.oldest.older = None

        if node.newer is not None:
            node.newer.older = node.older

        if node.older is not None:
            node.older.newer = node.newer

        del self.dic[key]

    def delete_oldest(self):
        if self.oldest is not None:
            self.delete(self.oldest.key)

    def get_len(self):
        return len(self.dic)

'''
cache = LRUCache(2)

cache.put(1, 1)
cache.put(2, 2)
print(cache.get(1))
cache.put(3, 3)
print(cache.get(2))
cache.put(4, 4)
print(cache.get(1))
print(cache.get(3))
print(cache.get(4))
'''
cache = LRUCache(2)

cache.put(2, 1)
cache.put(1, 1)
cache.put(2, 3)
cache.put(4, 1)
print(cache.get(1))
print(cache.get(2))

```

