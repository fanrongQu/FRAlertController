//
//  UIView+Layer.m
//  sugeOnlineMart
//
//  Created by 1860 on 16/9/6.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  https://github.com/fanrongQu/FRAlertController-master
//

#import "UIView+FRLayer.h"

@implementation UIView (FRLayer)


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


/**
 设置View的layer属性
 
 @param corners 圆角类型
 @param radius 圆角半径
 */
- (void)setLayerWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}


/**
 *  添加边框：注给scrollView添加会出错
 *
 *  @param direct 方向
 *  @param color  颜色
 *  @param width  线宽
 */
- (void)setSingleBorder:(UIViewBorderDirect)direct color:(UIColor*)color width:(CGFloat)width {
    
    UIView* line = [[UIView alloc] init];
    
    //设置颜色
    line.backgroundColor = color;
    
    //添加
    [self addSubview:line];
    
    //禁用ar
    line.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary* views = NSDictionaryOfVariableBindings(line);
    NSDictionary* metrics = @{ @"w" : @(width),
                               @"y" : @(self.frame.size.height - width),
                               @"x" : @(self.frame.size.width - width) };
    
    NSString* vfl_H = @"";
    NSString* vfl_W = @"";
    
    //上
    if (UIViewBorderDirectTop == direct) {
        vfl_H = @"H:|-0-[line]-0-|";
        vfl_W = @"V:|-0-[line(==w)]";
    }
    
    //左
    if (UIViewBorderDirectLeft == direct) {
        vfl_H = @"H:|-0-[line(==w)]";
        vfl_W = @"V:|-0-[line]-0-|";
    }
    
    //下
    if (UIViewBorderDirectBottom == direct) {
        vfl_H = @"H:|-0-[line]-0-|";
        vfl_W = @"V:[line(==w)]-0-|";
    }
    
    //右
    if (UIViewBorderDirectRight == direct) {
        vfl_H = @"H:[line(==w)]-0-|";
        vfl_W = @"V:|-0-[line]-0-|";
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_H options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_W options:0 metrics:metrics views:views]];
}

@end
