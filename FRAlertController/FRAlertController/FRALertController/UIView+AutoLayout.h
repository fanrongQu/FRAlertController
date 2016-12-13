//
//  UIView+AutoLayout.h
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)


#pragma mark - 中心点的约束
/**
 视图的中心点横坐标相对于依赖的视图view中心点横坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutCenterXToViewCenterX:(UIView *)view constant:(CGFloat)constant;

/**
 视图的中心点纵坐标相对于依赖的视图view中心点纵坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutCenterYToViewCenterY:(UIView *)view constant:(CGFloat)constant;

/**
 相对于依赖的视图view居中
 
 @param view 依赖的视图
 */
- (void)setAutoLayoutCenterToViewCenter:(UIView *)view;

#pragma mark - 顶部的约束
/**
 视图的顶部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutTopToViewTop:(UIView *)view constant:(CGFloat)constant;

/**
 视图的顶部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutTopToViewBottom:(UIView *)view constant:(CGFloat)constant;

#pragma mark - 左边的约束
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

#pragma mark - 底部的约束
/**
 视图的底部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutBottomToViewBottom:(UIView *)view constant:(CGFloat)constant;

/**
 视图的底部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (void)setAutoLayoutBottomToViewTop:(UIView *)view constant:(CGFloat)constant;


#pragma mark - 右边的约束
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


#pragma mark - 尺寸的约束
/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (void)setAutoLayoutWidth:(CGFloat)constant;

/**
 视图的宽度约束
 
 @param view 依赖的视图
 @param constant 宽度
 */
- (void)setAutoLayoutWidthToView:(UIView *)view constant:(CGFloat)constant;


/**
 视图的高度约束
 
 @param constant 高度
 */
- (void)setAutoLayoutHeight:(CGFloat)constant;

/**
 视图的高度约束
 
 @param view 依赖的视图
 @param constant 高度
 */
- (void)setAutoLayoutHeightToView:(UIView *)view constant:(CGFloat)constant;

/**
 视图的大小约束
 
 @param size 尺寸
 */
- (void)setAutoLayoutSize:(CGSize)size;


@end
