//
//  JZLSliderMenuView.h
//  JZLSliderMenu
//
//  Created by allenjzl on 2017/10/11.
//  Copyright © 2017年 jzl.sliderMenu. All rights reserved.
//

@class JZLSliderMenuView;

#import <UIKit/UIKit.h>

@protocol JZLSliderMenuDelegate <NSObject>


/**
 跳转的代理方法
 
 @param index index
 */
- (void)sliderMenu:(JZLSliderMenuView *)sliderMenuView selectItemAtIndex: (NSInteger)index;

@end

@interface JZLSliderMenuView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
//scrollview
@property (nonatomic, strong) UIScrollView *mainView;
/** 默认选中的按钮 */
@property (nonatomic, assign) NSInteger selectedIndex;
//子控制器数组
@property (nonatomic, strong) NSMutableArray *childViewControllers;

//标题数组
@property (nonatomic, strong) NSArray *titleArray;


@property (nonatomic, weak) id<JZLSliderMenuDelegate> delegate;




/**
 实例化

 @param frame frame
 @param childViewControllers 联动控制器(确保标签的数量和控制器的数量数量一致)
 @param titleArray 标签数组
 @param selectedIndex 默认选中的标签
 @return 实例
 */
+ (instancetype) initWithFrame: (CGRect)frame  childViewControllers: (NSArray <UIViewController *>*)childViewControllers titleArray: (NSArray *)titleArray selectedIndex: (NSInteger)selectedIndex;
@end

