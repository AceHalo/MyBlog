---

title: 每天几道Leetcode系列day4
date: 2019/03/15 23:53:00
description: 每天刷几道leetcode题目系列，解法不一定是最优的 【771. Jewels and Stones】
categories:
- leetcode
tags:
- leetcode
---

### 771. Jewels and Stones

[题目链接](https://leetcode.com/problems/jewels-and-stones/)

解题思路：  
无

code：

```
class Solution:
    def numJewelsInStones(self, J: str, S: str) -> int:
        c = 0
        for i in S:
            if i in J:
                c = c + 1
        return c

```

今天困了，简单刷一道题就睡了