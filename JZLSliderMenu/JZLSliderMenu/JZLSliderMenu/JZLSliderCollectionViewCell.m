//
//  JZLSliderCollectionViewCell.m
//  JZLSliderMenu
//
//  Created by allenjzl on 2017/10/11.
//  Copyright © 2017年 jzl.sliderMenu. All rights reserved.
//

#import "JZLSliderCollectionViewCell.h"

@implementation JZLSliderCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];;
        [self.contentView addSubview:self.titleLbl];
        self.titleLbl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
    }
    return self;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    
    return _titleLbl;
    
}






@end
