//
//  ViewController.m
//  JZLSliderMenu
//
//  Created by allenjzl on 2017/10/11.
//  Copyright © 2017年 jzl.sliderMenu. All rights reserved.
//

#import "ViewController.h"
#import "JZLSliderMenuView.h"
#import "ListViewController.h"

@interface ViewController ()<JZLSliderMenuDelegate>
@property (nonatomic, strong) JZLSliderMenuView *sliderMenuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titleArr = @[@"新闻",@"科技",@"汽车",@"游戏",@"美容",@"体育",@"金融",@"互联网",@"手机",@"音乐"];
    
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i =0; i < titleArr.count ; i ++) {
        ListViewController *vc = [[ListViewController alloc] init];
        [vcArr addObject:vc];
    }

    self.sliderMenuView = [JZLSliderMenuView initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 667 - 20) childViewControllers:vcArr titleArray:titleArr selectedIndex:2];
    self.sliderMenuView.delegate = self;
    [self.view addSubview:self.sliderMenuView];
    
    //模拟控制器数据处理
    ListViewController *vc = vcArr[2];
    vc.index = 2;
    [vc.tableView reloadData];
    
    
    
    
}



- (void)sliderMenu:(JZLSliderMenuView *)sliderMenuView selectItemAtIndex:(NSInteger)index {
    ListViewController *vc = self.sliderMenuView.childViewControllers[index];
    vc.index = index;
    [vc.tableView reloadData];
    
}





@end
