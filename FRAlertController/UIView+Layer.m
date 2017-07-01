//
//  UIView+Layer.m
//  sugeOnlineMart
//
//  Created by 1860 on 16/9/6.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  https://github.com/fanrongQu/FRAlertController-master
//

#import "UIView+Layer.h"

@implementation UIView (Layer)


/**
 *  设置View的layer属性
 *
 *  @param cornerRadius 圆角半径
 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius {
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:cornerRadius];
}

/**
 *  设置View的layer属性
 *
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)setLayerWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setBorderColor:borderColor.CGColor];
}

/**
 *  设置View的layer属性
 *
 *  @param cornerRadius 圆角半径
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setBorderColor:borderColor.CGColor];
}

@end
