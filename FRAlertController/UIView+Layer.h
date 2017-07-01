//
//  UIView+Layer.h
//  sugeOnlineMart
//
//  Created by 1860 on 16/9/6.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  https://github.com/fanrongQu/FRAlertController-master
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)


/**
 *  设置View的layer属性
 *
 *  @param cornerRadius 圆角半径
 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius;

/**
 *  设置View的layer属性
 *
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)setLayerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  设置View的layer属性
 *
 *  @param cornerRadius 圆角半径
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
