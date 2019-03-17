---

title: 每天几道Leetcode系列day5
date: 2019/03/17 23:50:00
description: 每天刷几道leetcode题目系列，解法不一定是最优的 【832. Flipping an Image】 && 【657. Robot Return to Origin】
categories:
- leetcode
tags:
- leetcode
---

### 832. Flipping an Image

[题目链接](https://leetcode.com/problems/flipping-an-image/)

解题思路：  
无

code：

```
class Solution:
    def flipAndInvertImage(self, A: List[List[int]]) -> List[List[int]]:
        rows = []
        for row in A:
            items = []
            row.reverse()
            for item in row:
                items.append(1 - item)
            rows.append(items)
        return rows
```


### 657. Robot Return to Origin

[题目链接](https://leetcode.com/problems/robot-return-to-origin/)

解题思路：  
无

code：

```
class Solution:
    def judgeCircle(self, moves: str) -> bool:
        up_count = 0
        down_count = 0
        left_count = 0
        right_count = 0
        for step in moves:
            if step == "U":
                up_count = up_count + 1
            elif step == "D":
                down_count = down_count + 1
            elif step == "L":
                left_count = left_count + 1
            elif step == "R":
                right_count = right_count + 1
        return (up_count == down_count) and (left_count == right_count)
        
```

刷了两道简单的题，然后睡觉，晚安。