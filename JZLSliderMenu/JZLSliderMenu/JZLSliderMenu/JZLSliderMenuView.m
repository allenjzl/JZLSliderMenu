//
//  JZLSliderMenuView.m
//  JZLSliderMenu
//
//  Created by allenjzl on 2017/10/11.
//  Copyright © 2017年 jzl.sliderMenu. All rights reserved.
//

#define SCREEN_WIDTH                       ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                      ([UIScreen mainScreen].bounds.size.height)


#import "JZLSliderMenuView.h"
#import "JZLSliderCollectionViewCell.h"
#import "ListViewController.h"

@interface JZLSliderMenuView()
/** 标签和控制器的分割线 */
@property (nonatomic, strong) UIView *lineView;




@end


@implementation JZLSliderMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



+ (instancetype) initWithFrame: (CGRect)frame  childViewControllers: (NSArray <UIViewController *>*)childViewControllers titleArray: (NSArray *)titleArray selectedIndex: (NSInteger)selectedIndex {
    JZLSliderMenuView *sliderMenuView = [[self alloc] initWithFrame:frame];
    sliderMenuView.selectedIndex = selectedIndex;
    sliderMenuView.titleArray = titleArray;
    sliderMenuView.childViewControllers = [childViewControllers mutableCopy];
    [sliderMenuView setupUI];
    
    

    
    
    
    
    return sliderMenuView;
}







//布局UI
- (void)setupUI {
    //标签
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [self addSubview:self.collectionView];
    //分割线
    self.lineView.frame = CGRectMake(5, 30, SCREEN_WIDTH - 10, 1);
    [self addSubview:self.lineView];
    
    
    //控制器的父视图scrollview
    self.mainView.frame = CGRectMake(0, 31, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - 31 );
    self.mainView.contentSize = CGSizeMake(SCREEN_WIDTH * 10, self.frame.size.height - 31);
    [self addSubview:self.mainView];
    [self creatChlidViewController];
    self.mainView.contentOffset = CGPointMake(SCREEN_WIDTH * self.selectedIndex, 0);
    
    

}




//创建子控制器
- (void)creatChlidViewController {
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        UIViewController *viewController = self.childViewControllers[i];
        viewController.view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.frame.size.height - 30);
        [self.mainView addSubview:viewController.view];
        
    }
    
    
    
}



#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JZLSliderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JZLSliderCollectionViewCell" forIndexPath:indexPath];
    cell.titleLbl.text = self.titleArray[indexPath.item];
    cell.titleLbl.textColor = [UIColor blackColor];
    cell.titleLbl.font = [UIFont systemFontOfSize:14];
    
    if (self.selectedIndex == indexPath.item) {
            cell.titleLbl.textColor = [UIColor redColor];
            cell.titleLbl.font = [UIFont systemFontOfSize:16];
    }
    

    

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.item;
    [self.collectionView reloadData];
//    JZLSliderCollectionViewCell *cell = (JZLSliderCollectionViewCell *)[self.collectionView cellForItemAtIndexPath: indexPath];
    //选中的按钮滚动到中间位置
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
    self.mainView.contentOffset = CGPointMake(SCREEN_WIDTH * indexPath.item, 0);
    if ([self.delegate respondsToSelector:@selector(sliderMenu:selectItemAtIndex:)]) {
        [self.delegate sliderMenu:self selectItemAtIndex:indexPath.item];
    }
}




#pragma mark - scrollview代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.mainView]) {
        NSInteger index = floor(self.mainView.contentOffset.x / SCREEN_WIDTH) ;
        self.selectedIndex = index;
        [self.collectionView reloadData];
        //选中的按钮滚动到中间位置
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        if ([self.delegate respondsToSelector:@selector(sliderMenu:selectItemAtIndex:)]) {
            [self.delegate sliderMenu:self selectItemAtIndex:index];
        }
    }

    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float newx = 0;
    static float oldx = 0;
    newx= scrollView.contentOffset.x ;
    if (newx != oldx ) {
        //Left-YES,Right-NO
        if (newx > oldx) {
            
        }else {
            
        }
        oldx = newx;
    }
    
    
    
    
}





#pragma mark - lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
        flowOut.itemSize = CGSizeMake(50, 30);
        flowOut.minimumLineSpacing = 0;
        flowOut.minimumInteritemSpacing = 0;
        flowOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowOut];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[JZLSliderCollectionViewCell class] forCellWithReuseIdentifier:@"JZLSliderCollectionViewCell"];
    }
    return _collectionView;
}

- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] init];
        _mainView.pagingEnabled = YES;
        _mainView.delegate = self;
        _mainView.bounces = NO;
        _mainView.backgroundColor =  [UIColor whiteColor];
        
    }
    return _mainView;
    
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)childViewControllers {
    if (!_childViewControllers) {
        _childViewControllers =[NSMutableArray array];
    }
    
    return _childViewControllers;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}



@end


















