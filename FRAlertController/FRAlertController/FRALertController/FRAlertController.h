//
//  FRAlertController.h
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

/** 颜色 */
#define FRUIColor_RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

#import <UIKit/UIKit.h>
#import "FRAlertAction.h"


typedef NS_ENUM(NSInteger, FRAlertControllerStyle) {
    FRAlertControllerStyleActionSheet = 0,
    FRAlertControllerStyleAlert
};

typedef void (^FRAlertDatePickerBlock)(UIDatePicker *__nonnull datePicker);

typedef void (^FRAlertArrayBlock)(NSInteger row);

@interface FRAlertController : UIViewController

+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;

@property (nullable, nonatomic, copy) NSString *message;

@property (nonatomic, readonly) UIAlertControllerStyle preferredStyle;

- (void)addAction:(nonnull FRAlertAction *)action;

@property (nonatomic, readonly, nullable) NSArray<FRAlertAction *> *actions;
//
//@property (nonatomic, strong, nullable) FRAlertAction *preferredAction ;


- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *__nonnull textField))configurationHandler;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;


/**
 添加日期选择器(默认选中日期为今天  最小日期默认为1900/01/01  最大日期默认为当前日期)
 
 @param color 确定按钮颜色
 @param style 确定按钮样式
 @param configurationHandler 日期选择器回调
 */
- (void)addDatePickerWithColor:(nullable UIColor *)color style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler;

/**  日期选择器  */
@property (nonatomic, strong, nullable) UIDatePicker *datePicker;


/**
 数组选择
 
 @param array 待选数组
 @param configurationHandler 选中数组的序号
 */
- (void)addSelectArray:(nonnull NSArray *)array configurationHandler:(nonnull FRAlertArrayBlock)configurationHandler;



@end
