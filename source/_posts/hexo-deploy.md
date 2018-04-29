---

title: 使用Hexo搭建博客  
date: 2018-04-23 00:53:14  
tags:  
description: 又使用Hexo搭建了一个博客，关于使用Hexo搭建博客的教程，网上一搜一大片。在这也写一篇文章简单记录下自己的搭建过程。

---

# 0x01 闲聊  

这篇文章并不准备写成一个从零开始搭建的教程。

关于使用Hexo搭建博客的教程，网上一搜一大片。

所以这篇文章只是对自己搭建过程的总结。

成品可以参考这两个GitHub库：

- 博客源码库 [https://github.com/AceHalo/MyBlog](https://github.com/AceHalo/MyBlog "blog")
- 发布库 [https://github.com/FutureGazer/futuregazer.github.io](https://github.com/FutureGazer/futuregazer.github.io "blog")




# 0x02 环境准备

- Windows，主要是在Windows上操作的。不过后面有用到Travis CI做自动构建，所以也用到了Ubuntu。

- GitHub Pages，这个博客就是放在GitHub上，关于GitHub Pages可以根据官方的这个文档创建一个[https://pages.github.com/](https://pages.github.com/ "GitHub Pages")

- Git，[https://git-scm.com/](https://git-scm.com/ "Git")

- Node.js，[https://nodejs.org](https://nodejs.org "Node.js")

# 0x03 Hexo博客搭建

Hexo官网[https://hexo.io](https://hexo.io "Hexo")有详细的教程。

这里需要注意的是Hexo向GitHub推的时候，需要配置ssh key，具体教程百度吧。

GitHub上需要建立两个代码库，一个是username.github.io的库，用来发布生成的博客，这个库的地址参考着Hexo的文档配置到Hexo里。还有一个库是用来存放博客源码的。

# 0x04 利用Travis CI自动构建部署

这部分就需要用到Ubuntu了，因为需要装个Travis CI客户端。

具体教程参考这里[https://segmentfault.com/a/1190000004667156](https://segmentfault.com/a/1190000004667156 "Hexo Travis CI")

不过有一点需要注意，就是创建新的ssh key的时候要放到另一个文件里，以免把之前推GitHub的那个ssh key覆盖了。

# 0x05 其他

博客发布用的GitHub代码仓库的设置里的Integrations & services可以配置个Email，这样博客发布成功了会有个邮件通知。