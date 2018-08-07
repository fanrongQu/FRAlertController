//
//  FRAlertController.h
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  https://github.com/fanrongQu/FRAlertController-master
//

/** 颜色 */
#define FRUIColor_RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
#define FR_IPHONE_X ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
//顶部安全域
#define FR_SafeArea_T (FR_IPHONE_X ? 44 : 20)
//底部安全域
#define FR_SafeArea_B (FR_IPHONE_X ? 34 : 0)

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "FRAlertAction.h"

typedef NS_ENUM(NSInteger, FRAlertControllerStyle) {
    FRAlertControllerStyleActionSheet = 0,
    FRAlertControllerStyleAlert
};

typedef void (^ FRAlertDatePickerBlock)(UIDatePicker *__nonnull datePicker);
typedef void (^ FRAlertPickerViewBlock)(NSArray<NSIndexPath *> *__nonnull indexPathArray);
typedef void (^ FRAlertTextFieldBlock)(UITextField *__nonnull textField);
typedef void (^FRAlertPassWardBlock)(NSString *__nonnull passWord);

@interface FRAlertController : UIViewController

/**  弹框样式  */
@property (nonatomic, readonly) FRAlertControllerStyle preferredStyle;
/**  标题Label  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  描述Label  */
@property (nonatomic, strong) UILabel *messageLabel;
/**  描述  */
@property (nullable, nonatomic, copy) NSString *message;

/**
 创建FRAlertController
 
 @param title 标题
 @param message 描述
 @param preferredStyle alertController类型
 
 @return alertController
 */
+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle;

- (void)show;


#pragma mark - 按钮
- (void)addAction:(nonnull FRAlertAction *)action;

@property (nonatomic, readonly, nullable) NSArray<FRAlertAction *> *actions;
/**  设置弹框按钮文字大小  */
- (void)setButtonsFont:(UIFont *)font;

#pragma mark - TextField
- (void)addTextFieldConfigurationHandler:(nonnull FRAlertTextFieldBlock)configurationHandler;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

#pragma mark - DatePicker
/**
 类方法展示日期选择器

 @param controller 当前控制器
 @param title 标题
 @param message 描述
 @param preferredStyle alertController类型
 @param color 确定按钮颜色
 @param cancleTitle 取消按钮标题
 @param makeSureTitle 确认按钮标题
 @param style 确定按钮类型
 @param configurationHandler 日期选择器回调
 
 @return alertController
 */
+ (nonnull FRAlertController *)showDatePickerController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle datePickerColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle datePickerStyle:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler;
/**
 添加日期选择器(默认选中日期为今天  最小日期默认为1900/01/01  最大日期默认为当前日期)
 
 @param color 确定按钮颜色
 @param cancleTitle 取消按钮标题
 @param makeSureTitle 确认按钮标题
 @param style 确定按钮类型
 @param configurationHandler 日期选择器回调
 */
- (void)addDatePickerWithColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler;

/**  日期选择器  */
@property (nonatomic, strong, nullable) UIDatePicker *datePicker;

#pragma mark - PickerView
/**  ----- 为alertController添加选择器（PickerView） -----  */


/**
 类方法展示PickerView

 @param title 标题
 @param message 描述
 @param preferredStyle 显示样式
 @param pickerArray 选择数组(二维数组奥)
 @param color 确认按钮颜色
 @param cancleTitle 取消按钮标题
 @param makeSureTitle 确认按钮标题
 @param style 按钮样式
 @param configurationHandler 回调
 @return FRAlertController对象
 */
+ (nonnull FRAlertController *)showPickerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle  pickerArray:(NSArray *_Nullable)pickerArray pickerButtonColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle pickerViewStyle:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertPickerViewBlock)configurationHandler;


/**
 添加PickerView
 
 @param pickerArray 选择数组
 @param color 确认按钮颜色
 @param cancleTitle 取消按钮标题
 @param makeSureTitle 确认按钮标题
 @param style 按钮样式
 @param configurationHandler 回调
 */
- (void)addPickerViewWithPickerArray:(NSArray *_Nullable)pickerArray pickerButtonColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertPickerViewBlock)configurationHandler;

/**  选择器  */
@property (nonatomic, strong, nullable) UIPickerView *pickerView;


#pragma mark - PassWard
/**
 类方法展示密码输入框
 
 @param controller 当前控制器
 @param title 标题
 @param message 描述
 @param preferredStyle alertController类型
 @param payMoney 付款金额
 @param configurationHandler 支付密码回调
 
 @return AlertController
 */
+ (nonnull FRAlertController *)showPassWardController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle payMoney:(nonnull NSString *)payMoney configurationHandler:(nonnull FRAlertPassWardBlock)configurationHandler;

/**
 支付密码

 @param payMoney 付款金额
 @param configurationHandler 支付密码回调
 */
- (void)addPassWardWithPayMoney:(nonnull NSString *)payMoney configurationHandler:(nonnull FRAlertPassWardBlock)configurationHandler;


@end
