//
//  UIView+AutoLayout.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

#pragma mark - 中心点的约束
/**
 视图的中心点横坐标相对于依赖的视图view中心点横坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutCenterXToViewCenterX:(UIView *)view constant:(CGFloat)constant {
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint *constraintCentetX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintCentetX];
}

/**
 视图的中心点纵坐标相对于依赖的视图view中心点纵坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutCenterYToViewCenterY:(UIView *)view constant:(CGFloat)constant {
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint *constraintCentetY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintCentetY];
}


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
    
    [self.superview addConstraints:@[constraintCentetX,constraintCenterY]];
}

#pragma mark - 顶部的约束
/**
 视图的顶部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutTopToViewTop:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
}



/**
 视图的顶部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutTopToViewBottom:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
}

#pragma mark - 左边的约束
/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
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
    
    [self.superview addConstraint:constraintLeft];
}


#pragma mark - 底部的约束
/**
 视图的底部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutBottomToViewBottom:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
}



/**
 视图的底部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutBottomToViewTop:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
}


#pragma mark - 右边的约束
/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
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
    
    [self.superview addConstraint:constraintRight];
}


#pragma mark - 尺寸的约束
/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (void)setAutoLayoutWidth:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintWidth];
}

/**
 视图的宽度约束
 
 @param view 依赖的视图
 @param constant 宽度
 */
- (void)setAutoLayoutToViewWidth:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintWidth];
}


/**
 视图的高度约束
 
 @param constant 高度
 */
- (void)setAutoLayoutHeight:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintHeight];
}


/**
 视图的高度约束
 
 @param view 依赖的视图
 @param constant 高度
 */
- (void)setAutoLayoutToViewHeight:(UIView *)view constant:(CGFloat)constant {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintHeight];
}


/**
 视图的大小约束
 
 @param size 尺寸
 */
- (void)setAutoLayoutSize:(CGSize)size {
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.width];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.height];
    
    [self.superview addConstraints:@[constraintWidth,constraintHeight]];
}


@end
