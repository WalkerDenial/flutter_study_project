# Flutter Study Demo

 Flutter 学习练习项目，记录子页面说明及遇到的问题。

## 页面路径：

1. 首页


## 遇到的问题点：

1. Q: Android 启动白屏问题优化？<br/> A: 修改 drawable/launch_background.xml 文件，可以在启动时直接进行展示，解决白屏时间过长问题。
2. 路由方式：<br/>一、在程序入口配置 `routes` 集合，通过 `pushNamed` 方法进行跳转；<br/>二、通过 `push` 方法直接跳转。
