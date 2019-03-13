---

title: 每天几道Leetcode系列day2
date: 2019/03/13 22:58:00
description: 每天刷几道leetcode题目系列，解法不一定是最优的 【4. Median of Two Sorted Arrays】&& 【2. Add Two Numbers】
categories:
- leetcode
tags:
- leetcode
---


### 4. Median of Two Sorted Arrays

[题目链接](https://leetcode.com/problems/median-of-two-sorted-arrays/)

解题思路:  
1.对两个列表进行归并排序  
2.找到中间位置即可

对两个列表进行归并排序的思路:  
1.获取每个列表的第一个元素  
2.将小的那个值放入新的列表中，指针向后移一位

code:

```
class Solution:
    def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:
        nums = []
        nums1_i = 0
        nums2_i = 0
        nums1_first = None
        nums2_first = None

        while True:
            if nums1_i < len(nums1) and nums1_first is None:
                nums1_first = nums1[nums1_i]
                nums1_i = nums1_i+1

            if nums2_i < len(nums2) and nums2_first is None:
                nums2_first = nums2[nums2_i]
                nums2_i = nums2_i+1

            if nums1_first is None and nums2_first is None:
                break

            if nums1_first is None:
                nums.append(nums2_first)
                nums2_first = None
            elif nums2_first is None:
                nums.append(nums1_first)
                nums1_first = None
            elif nums1_first<nums2_first:
                nums.append(nums1_first)
                nums1_first = None
            elif nums2_first<nums1_first:
                nums.append(nums2_first)
                nums2_first = None
            else:
                nums.append(nums1_first)
                nums.append(nums2_first)
                nums1_first=None
                nums2_first=None

        if len(nums) % 2 ==0:
            idx = len(nums)//2
            r = (nums[idx]+nums[idx-1])/2
        else:
            idx = (len(nums)-1)//2
            r = nums[idx]
        
        return r
```



### 2. Add Two Numbers

[题目链接](https://leetcode.com/problems/add-two-numbers/)

这里利用了Python的一些特性，比如int本身就是大整数类型

解题思路：  
1.把链表弄成数字
2.数字相加
3.将结果转换会链表

code：

```
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:
        lst1 = []
        lst1.append(str(l1.val))
        while l1.next is not None:
            l1 = l1.next
            lst1.append(str(l1.val))
            
        lst2 = []
        lst2.append(str(l2.val))
        while l2.next is not None:
            l2 = l2.next
            lst2.append(str(l2.val))
            
        lst1.reverse()
        lst2.reverse()

        num1 = "".join(lst1)
        num2 = "".join(lst2)

        num = int(num1)+int(num2)

        lst = []
        for i in str(num):
            lst.append(i)

        lst.reverse()

        first_node = None
        pre_node = None

        for i in lst:
            node = ListNode(i)
            if pre_node is not None:
                pre_node.next = node
            else:
                first_node = node
            pre_node = node

        return first_node

```
