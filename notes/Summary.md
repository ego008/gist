#### 稳定性

* 架构上任何一个进程都能够随时重启
* 单元测试和性能测试，跑负载，测功能，边界条件

#### 可监控性

* 调试方便
* 运维方便，给市场人员提供便利
* 监控体现在日志功能的设计上，一些重要的玩家行为（购买、任务）都要要日志记录，防止跟玩家扯皮

#### 好维护

* 做好整个系统上下层之间的模块化，底层应该提供什么，底层不应该提供什么
* 系统逻辑功能之间的模块化，任务系统、物品系统、战斗系统，系统之间的数据交互不能做成剪不断理还乱的样子
* 某个系统出问题数据乱套了，它的设计应该是很容易纠正过来，通过GM工具或者修改数据库，（小心数据冗余）


具体的技术细节
------

底层应该做什么
-----

* 通讯协议怎么实现，基于消息，基于RPC(这点可以单独详细阐述)
* 提供TCP套接字服务器器，HTTP和HTTPS客户端连接(接对应的平台)
* 定时器（一些需要计时的任务需求）



上层应该做什么
-----

* Lua的语法要点
* 如何使用Lua来构建游戏系统（怎么抽象数据结构、怎么模拟class和object的设计）（这个可以单独详细阐述）
* 新系统与老系统的兼容，新增加的字段，老系统不再使用的字段


数据存盘/落地
------

* 数据存盘格式, mysql or mongodb ?
* 存盘思路，离线存盘，定时存盘



团队开发
======

* 核心是怎么保证版本的质量，从整个游戏系统来看如何证明你的代码是正确的
* bug追踪系统
* 版本管理