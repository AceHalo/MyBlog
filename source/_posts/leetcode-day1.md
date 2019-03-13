---

title: 每天几道Leetcode系列day1
date: 2019/03/13 00:28:00
description: 每天刷几道leetcode题目系列，解法不一定是最优的 【3. Longest Substring Without Repeating Characters】
categories:
- leetcode
tags:
- leetcode
---


### 3. Longest Substring Without Repeating Characters

[题目链接](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

解题思路：  
1.需要一个空list用于保存遍历到的字符  
2.每当遍历到的字符在list里出现时，从出现这个字符的后一个位置截取这个list  
3.每次加入字符后记录这个list的长度，取最大的值

code:

```
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        input_str = s
        mx = 0

        strs = []
        for s in input_str:
            try:
                idx = strs.index(s)
            except:
                idx = -1
            if idx >=0:
                if idx == len(strs)-1:
                    strs = []
                else:
                    strs = strs[idx+1:]
            strs.append(s)
            if len(strs) > mx:
                mx = len(strs)

        return mx
```
