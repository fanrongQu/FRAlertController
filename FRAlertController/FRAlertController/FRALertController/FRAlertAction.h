//
//  FRAlertAction.h
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+AutoLayout.h"
#import "UIView+Layer.h"

typedef NS_ENUM(NSInteger, FRAlertActionStyle) {
    FRAlertActionStyleDefault = 0,
    FRAlertActionStyleCancel,
    FRAlertActionStyleDestructive
};

@interface FRAlertAction : NSObject

+ (nonnull FRAlertAction *)actionWithTitle:(nullable NSString *)title style:(FRAlertActionStyle)style handler:(void (^ __nullable)(FRAlertAction *__nonnull action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) FRAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end
