//
//  UIView+AutoLayout.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)


/**
 相对于依赖的视图view居中

 @param view 依赖的视图
 */
- (void)setAutoLayoutCenterToViewCenter:(UIView *)view {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint *constraintCentetX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *constraintCenterY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [view addConstraints:@[constraintCentetX,constraintCenterY]];
}

/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [view addConstraint:constraintLeft];
}



/**
 视图的左边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutLeftToViewRight:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
    
    [view addConstraint:constraintLeft];
}


/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [view addConstraint:constraintRight];
}


/**
 视图的右边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutRightToViewRight:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
    
    [view addConstraint:constraintRight];
}


/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (void)setAutoLayoutWidthToView:(UIView *)view width:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [view addConstraint:constraintWidth];
}


/**
 视图的高度约束
 
 @param constant 高度
 */
- (void)setAutoLayoutHeightToView:(UIView *)view height:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [view addConstraint:constraintHeight];
}


@end
