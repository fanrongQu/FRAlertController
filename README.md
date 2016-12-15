# FRAlertController-master
模仿系统UIAlertController实现的一个FRAlertController

![](https://github.com/fanrongQu/FRAlertController-master/blob/master/alert.gif)![](https://github.com/fanrongQu/FRAlertController-master/blob/master/ActionSheet.gif)  


## FRAlertController

```Objective-C
+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle;

@property (nullable, nonatomic, copy) NSString *message;

@property (nonatomic, readonly) FRAlertControllerStyle preferredStyle;

- (void)addAction:(nonnull FRAlertAction *)action;

@property (nonatomic, readonly, nullable) NSArray<FRAlertAction *> *actions;


- (void)addTextFieldWithPlaceholder:(nonnull NSString *)placeholder configurationHandler:(nonnull FRAlertTextFieldBlock)configurationHandler;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;


/**
 添加日期选择器(默认选中日期为今天  最小日期默认为1900/01/01  最大日期默认为当前日期)
 
 @param color 确定按钮颜色
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
