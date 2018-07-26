# Flutter Study Demo

 `Flutter` 学习时的练习项目，记录 _*页面说明*_ 及 _*遇到的问题点*_。

## 页面说明：

1. `首页` --> 以列表形式展示知识点列表，点击相应的 `item` 进入对应的界面；
2. `首页 --> English List page` --> 学习列表控件、了解布局、第三方库 - 英文单词随机展示、点击操作、滑动删除及路由跳转；
3. `首页 --> Lake Page` --> 学习 Row、Column、crossAxisAlignment、mainAxisAlignment、mainAxisSize 等属性的使用，进行布局排列练习；
4. `首页 --> Basic AppBar` --> 学习 AppBar 上添加菜单，及菜单点击事件处理；
5. `首页 --> TabBar & AppBar` --> 学习 AppBar 与 TabBar、TabBarView 结合使用，进行布局排列练习，


## 遇到的问题点：

1. Q: Android 启动白屏问题优化？<br/> A: 修改 `drawable/launch_background.xml` 文件，可以在启动时直接进行展示，解决白屏时间过长问题。
2. 路由方式：<br/> ① 在程序入口配置 `routes` 集合，通过 `pushNamed` 方法进行跳转；<br/> ② 通过 `push` 方法直接跳转；
