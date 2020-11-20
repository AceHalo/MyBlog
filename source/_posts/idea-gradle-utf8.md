title: IDEA使用Gradle构建Java项目中文乱码问题解决
description: 在Windows下使用IDEA创建Gradle的Java项目后，Run的时候遇到乱码。记录下解决方式。
categories:
  - other
tags:
  - other
date: 2020-02-23 12:30:00
---
今天用Java写个工具的时候，遇到了中文乱码问题，记录下解决方式，改了两个地方。

1. gradle.build文件增加：

    ```
    tasks.withType(JavaCompile) {
        options.encoding = "UTF-8"
    }  
    ```

1. IDEA配置，Help->Edit Custom VM Options 增加
   ```
   -Dfile.encoding=utf-8
   ```