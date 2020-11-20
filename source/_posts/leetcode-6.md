title: 每天几道Leetcode系列6
description: >-
  时隔好久，我又回来更新了。。。每天刷几道leetcode题目系列，解法不一定是最优的 【938. Range Sum of BST】【709. To
  Lower Case】【807. Max Increase to Keep City Skyline】
categories:
  - leetcode
tags:
  - leetcode
date: 2019-05-18 19:14:00
---
时隔好久，我又回来更新了。。。  


### 938. Range Sum of BST

[题目链接](https://leetcode.com/problems/range-sum-of-bst/)

解题思路：  
直接递归遍历就好

code：

```
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def rangeSumBST(self, root: TreeNode, L: int, R: int) -> int:
        result = 0
        val = root.val;
        if L <= val <= R:
            result = val

        l = 0
        if root.left is not None:
            l = self.rangeSumBST(root.left, L, R)

        r = 0
        if root.right is not None:
            r = self.rangeSumBST(root.right, L, R)

        return result + l + r

```

### 709. To Lower Case

[题目链接](https://leetcode.com/problems/to-lower-case/)

解题思路：  
无

code：

```
class Solution:
    def toLowerCase(self, str: str) -> str:
        return str.lower()
        
```

### 807. Max Increase to Keep City Skyline

[题目链接](https://leetcode.com/problems/max-increase-to-keep-city-skyline/)

解题思路：  
遍历二维数组，选出每列的最小值，和每行的最小值，然后再遍历二维数组，计算每个位置与min(当前行最小值，当前列最小值)的差值

code：

```
class Solution:
    def maxIncreaseKeepingSkyline(self, grid: List[List[int]]) -> int:
        max_top_bottom = [0 for i in range(len(grid[0]))]
        for j in range(len(grid[0])):
            lst = []
            for i in range(len(grid)):
                lst.append(grid[i][j])
            max_top_bottom[j] = max(lst)

        max_left_right = [0 for i in range(len(grid))]
        for i in range(len(grid)):
            lst = []
            for j in range(len(grid[0])):
                lst.append(grid[i][j])
            max_left_right[i] = max(lst)

        result = 0;
        for i in range(len(grid)):
            for j in range(len(grid[i])):
                h = grid[i][j]
                r = min(max_top_bottom[j], max_left_right[i]) - h
                result = result + r

        return result
        
```