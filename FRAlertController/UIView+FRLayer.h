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

typedef enum {
    //上
    UIViewBorderDirectTop = 0,
    
    //左
    UIViewBorderDirectLeft,
    
    //下
    UIViewBorderDirectBottom,
    
    //右
    UIViewBorderDirectRight,
    
}UIViewBorderDirect;


@interface UIView (FRLayer)


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

/**
 *  设置View的layer属性
 *
 *  @param corners 圆角类型
 *  @param radius 圆角半径
 */
- (void)setLayerWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 *  添加边框：注给scrollView添加会出错
 *
 *  @param direct 方向
 *  @param color  颜色
 *  @param width  线宽
 */
- (void)setSingleBorder:(UIViewBorderDirect)direct color:(UIColor*)color width:(CGFloat)width;
@end
