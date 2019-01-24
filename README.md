# Flutter Study Demo

 `Flutter` 学习时的练习项目，记录 _*页面说明*_ 及 _*遇到的问题点*_。

## 页面说明：

1. `首页` --> 以列表形式展示知识点列表，点击相应的 `item` 进入对应的界面；
2. `首页 --> English List page` --> 学习列表控件、了解布局、第三方库 - 英文单词随机展示、点击操作、滑动删除及路由跳转；
3. `首页 --> Lake Page` --> 学习 Row、Column、crossAxisAlignment、mainAxisAlignment、mainAxisSize 等属性的使用，进行布局排列练习；
4. `首页 --> Basic AppBar` --> 学习 AppBar 上添加菜单，及菜单点击事件处理；
5. `首页 --> TabBar & AppBar` --> 学习 AppBar 与 TabBar、TabBarView 结合使用，进行布局排列练习；
6. `首页 --> Container Test` --> 学习 Container 使用及边框添加、圆角的实现；
7. `首页 --> GrideView Test` --> 学习 GrideView 使用，添加底部说明模块，及点击事件的处理；
8. `首页 --> Colors Page` --> 学习 TabBar、TabBarView、ListView、AppBar 的联动处理及界面展示；
9. `首页 --> BottomAppBar Page` --> 扩展 AppBar，添加 bottom，以及 action 操作；
10. `首页 --> AnimateList Page` --> 扩展 AppBar，添加/删除子页面内容，以及添加/删除动画；
11. `首页 --> Expansion Page` --> 学习 Expansion 控件的使用；
12. `首页 --> FadeAnimation Page` --> 学习淡入、淡出动画的使用，了解 AnimationController、CurvedAnimation；
13. `首页 --> Signature Page` --> 学习 Painter、Paint、Canvas 的使用，以达到自定义控件及效果的目的；
14. `首页 --> DataLoader Page` --> 学习 ProgressIndicator 和 http 的使用；
15. `首页 --> InputTest Page` -->  学习 TextFiled 的使用；
16. `首页 --> SelfProgressBar Page` -->  自定义 ProgressBar；


## 遇到的问题点：

1. Q: Android 启动白屏问题优化？

	A: 修改 `drawable/launch_background.xml` 文件，可以在启动时直接进行展示，解决白屏时间过长问题。

2. Q: 路由方式有哪些？

	A: ① 在程序入口配置 `routes` 集合，通过 `pushNamed` 方法进行跳转；② 通过 `push` 方法直接跳转；


3. Q: `TabBar`、`TabBarView` 滑动切换事件如何处理?

	A: 需要自定义 `TabController`，设置给 `controller`，即可实现效果；


4. Q: 由于数据缓存而导致界面数据紊乱如何处理？

	A: 在页面 `dispose()` 的时候，要释放掉页面变量，避免下次进入时候，由于变量资源没有及时回收而造成数据紊乱；


5. Q: GestureDetector 作为 child 时，界面无任何响应是原因？

	A: GestureDetector 没有宽度和高度，默认会变成 0，如果要自定义大小，需要父控件设置内容区域，可参考容器 `SizedBox`；

6. Q: 使用 painter 的时候，触摸返回的 y 轴的值有偏移是什么原因？

	A: 由于有状态栏和 AppBar 的存在，会导致 y 轴的值向下偏移，偏移量为状态栏高度与 AppBar 高度之和，拿到得到的 y 值以后，减掉偏移量就能得到正确的坐标了；