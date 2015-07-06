## CYCustomAlertView
---
`CYCustomAlertView`是一个简单的自定义对话框，主要用于在弹出比较多的文字时，会居左滚动显示。

### 一、说明
---
* `CYCustomAlertView`是一个简单且实用的自定义对话框，主要是弥补系统对话框在显示多行文本消息时样式不好控的不足。
* `CYCustomAlertView` V1.0版本实现的功能：
	1. 显示对话框
	2. 设置对话框中相关属性
* 具体用法主要参考Demo程序

### 二、使用方法
---
1. 将`CustomAlertView`文件夹添加到项目中
2. 导入主头文件`#import "CYCustomAlertView.h"`

### 三、部分API的使用方法
---
* 实例化`CYAlertView`对象

``` objc
CYAlertView *alert = [[CYAlertView alloc]initWithTitle:@"我的提示" message:@"消息正文" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
```
* 设置对话框中间显示的部分

``` objc
- (UIView *)createDemoView
{
    UITextView *textView = [[UITextView alloc]init];
    textView.text = @"非强制，v1.0.4，250服务器\n1、今天早上\n2、打开电脑\n3、泡了一杯茶\n4、浏览了一会儿网页\n5、写了几条评论\n6、开了个小会\n7、打开Xcode\n8、修改bug\n9、提交代码";
    textView.editable = NO;
    return textView;
}

alert.containerView = [self createDemoView];
```
* 显示对话框

``` objc
[alert show];
```

* 设置消息内容

``` objc
alert.message = @"消息正文";
```
* 设置对话框标题

``` objc
alert.title = @"提示标题";
```
* 设置按钮

``` objc
alert.buttonTitles = [NSMutableArray arrayWithArray:@[@"取消", @"提示"]];
```

### 四、效果截图
---
* 正常的提示文本

 <img src="http://img.blog.csdn.net/20150706182747519" width = "320" height = "568" alt="正常的提示文本" align=center />
<br/><br/>

* 提示很多文本

 <img src="http://img.blog.csdn.net/20150706182807287" width = "320" height = "568" alt="提示很多文本" align=center />