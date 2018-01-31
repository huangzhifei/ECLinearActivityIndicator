# ECLinearActivityIndicator
一个针对iPhoneX定制的网络加载动画

## cocoapod

支持 cocoapod，目前版本是 0.0.5

## 更新记录

0.0.5 增加线程安全、增加 Indicator 计数

当我们使用 networkActivityIndicatorVisible 来控制显示与隐藏的时候，由于他只是一个 Bool 值，只能标记两种状态，对于像我们同时有多个异步请求发起时，什么时候控制他消失就变得很麻烦了。

我们借鉴一下  Objective-C 中的引用计数思想：

1、给菊花绑定一个计数值，就像引用计数一样

2、每当 networkActivityIndicatorVisible 被赋值为 YES 时，给计数值加 1

3、每当 networkActivityIndicatorVisible 被赋值为 NO 时，给计数值减 1

4、小菊花的计数值大于 0 时，则让小菊花显现，否则让小菊花消失

5、全部操作都切回主线程处理，这样能保证线程安全



