# FRAlertController-master
模仿系统UIAlertController实现的一个FRAlertController

Alert![](https://github.com/fanrongQu/FRAlertController-master/blob/master/alert.gif) ActionSheet ![](https://github.com/fanrongQu/FRAlertController-master/blob/master/ActionSheet.gif)  


## FRAlertController

```Objective-C
/**
 类方法展示日期选择器
 
 @param title 标题
 @param message 描述
 @param preferredStyle alertController类型
 
 @return alertController
 */
+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle;

@property (nullable, nonatomic, copy) NSString *message;

@property (nonatomic, readonly) FRAlertControllerStyle preferredStyle;
```
##### 添加按钮
```Objective-C
- (void)addAction:(nonnull FRAlertAction *)action;

@property (nonatomic, readonly, nullable) NSArray<FRAlertAction *> *actions;
```
##### 添加TextFiled
```Objective-C
- (void)addTextFieldConfigurationHandler:(nonnull FRAlertTextFieldBlock)configurationHandler;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;
```
##### 日期选择器（仅支持Alert类型），建议使用类方法展示，一步实现效果
```Objective-C
/**
 类方法展示日期选择器

 @param controller 当前控制器
 @param title 标题
 @param message 描述
 @param preferredStyle alertController类型
 @param color 确定按钮颜色
 @param style 确定按钮类型
 @param configurationHandler 日期选择器回调
 
 @return alertController
 */
+ (nonnull FRAlertController *)showAlertDatePickerController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle datePickerColor:(nullable UIColor *)color datePickerStyle:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler;
/**
 添加日期选择器(默认选中日期为今天  最小日期默认为1900/01/01  最大日期默认为当前日期)
 
 @param color 确定按钮颜色
 @param style 确定按钮类型
 @param configurationHandler 日期选择器回调
 */
- (void)addDatePickerWithColor:(nullable UIColor *)color style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler;

/**  日期选择器  */
@property (nonatomic, strong, nullable) UIDatePicker *datePicker;
```
##### 数组选择器（仅支持Alert类型），建议使用类方法展示，一步实现效果
```Objective-C
/**
 类方法展示数组选择器
 
 @param controller 当前控制器
 @param title 标题
 @param message 描述
 @param preferredStyle alertController类型
 @param array 待选数组
 @param configurationHandler 选中数组的序号
 
 @return AlertController
 */
+ (nonnull FRAlertController *)showAlertSelectArrayController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle selectArray:(nonnull NSArray *)array configurationHandler:(nonnull FRAlertArrayBlock)configurationHandler;

/**
 数组选择
 
 @param array 待选数组
 @param configurationHandler 选中数组的序号
 */
- (void)addSelectArray:(nonnull NSArray *)array configurationHandler:(nonnull FRAlertArrayBlock)configurationHandler;

```
##### 展示密码输入框（Alert类型仿微信支付、ActionSheet仿支付宝），建议使用类方法展示，一步实现效果
```Objective-C
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
+ (nonnull FRAlertController *)showAlertPassWardController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle payMoney:(nonnull NSString *)payMoney configurationHandler:(nonnull FRAlertPassWardBlock)configurationHandler;

/**
 支付密码

 @param payMoney 付款金额
 @param configurationHandler 支付密码回调
 */
- (void)addPassWardWithPayMoney:(nonnull NSString *)payMoney configurationHandler:(nonnull FRAlertPassWardBlock)configurationHandler;
```

## FRAlertAction

```Objective-C
typedef NS_ENUM(NSInteger, FRAlertActionStyle) {
    FRAlertActionStyleDefault = 0,//普通按钮
    FRAlertActionStyleColor,//背景色
    FRAlertActionStyleBorder//边框
};

+ (nonnull FRAlertAction *)actionWithTitle:(nullable NSString *)title style:(FRAlertActionStyle)style color:(nullable UIColor *)color handler:(nullable FRAlertActionBlock)handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) UIColor *color;
@property (nonatomic, assign) FRAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

```
