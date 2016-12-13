//
//  FRAlertAction.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRAlertAction.h"

@interface FRAlertAction ()

@property (nullable, nonatomic, copy) NSString *actionTitle;
@property (nullable, nonatomic, strong) UIColor *actionColor;

@end

@implementation FRAlertAction


+ (nonnull FRAlertAction *)actionWithTitle:(nullable NSString *)title style:(FRAlertActionStyle)style color:(nullable UIColor *)color handler:(nullable FRAlertActionBlock)handler {
    
    FRAlertAction *alertAction = [[FRAlertAction alloc] init];
    
    alertAction.actionTitle = title;
    alertAction.actionColor = color;
    
    alertAction.style = style;
    alertAction.actionBlock = handler;
    return alertAction;
}


#pragma mark - 数据处理
- (NSString *)title {
    return _actionTitle;
}

-(UIColor *)color {
    return _actionColor;
}


@end
