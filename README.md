# JZLSliderMenu
仿今日头条导航条
稍微封装了一下,直接调用API即可,设置了一个代理,可以在对不同的标签处理不同的界面的时候调用去处理相关事情

使用反法:
1.demo中JZLSliderMenu拖入自己的项目,导入头文件即可
2.下面方法实例化实例化,设置代理,然后添加到自己相应的控制器即可
3.注意两个数组的传值,一个是标签的名称的数组,一个是子控制器的数组,要保证两者数量一致,对应起来
4.详见demo,没什么难点
```
    self.sliderMenuView = [JZLSliderMenuView initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 667 - 20) childViewControllers:vcArr titleArray:titleArr selectedIndex:2];
    self.sliderMenuView.delegate = self;
```
