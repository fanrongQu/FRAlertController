//
//  UIView+AutoLayout.h
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

/**
 相对于依赖的视图view居中
 
 @param view 依赖的视图
 */
- (void)setAutoLayoutCenterToViewCenter:(UIView *)view;

/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (void)setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant;


/**
 视图的左边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (void)setAutoLayoutLeftToViewRight:(UIView *)view constant:(CGFloat)constant;


/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (void)setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant;


/**
 视图的右边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (void)setAutoLayoutRightToViewRight:(UIView *)view constant:(CGFloat)constant;


/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (void)setAutoLayoutWidthToView:(UIView *)view width:(CGFloat)constant;


/**
 视图的高度约束
 
 @param constant 高度
 */
- (void)setAutoLayoutHeightToView:(UIView *)view height:(CGFloat)constant;


@end
