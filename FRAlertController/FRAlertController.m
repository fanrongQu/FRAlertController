//
//  FRAlertController.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  https://github.com/fanrongQu/FRAlertController-master
//

#import "FRAlertController.h"

#define FR_IPHONE_X ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)

@interface FRAlertController ()<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
UIPickerViewDataSource,
UIPickerViewDelegate>

/**  alert类型  */
@property (nonatomic, assign) FRAlertControllerStyle alertPreferredStyle;

/**  背景  */
@property (nonatomic, strong) UIView *alertView;
/**  标题  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  描述  */
@property (nonatomic, strong) UILabel *messageLabel;
/**  actions  */
@property (nonatomic, strong) NSMutableArray *mutableActions;
/**  按钮数组  */
@property (nonatomic, strong) NSMutableArray *buttons;
/**  取消按钮  */
@property (nonatomic, strong) UIButton *cancleButton;

/**  alertArray  */
@property (nonatomic, strong) NSArray *alertArray;
/**  关闭按钮  */
@property (nonatomic, strong) UIButton *closeBtn;

/** pickerArray */
@property(nonatomic, strong)NSArray *pickerArray;
/** 选中pickerArray的序号 */
@property(nonatomic, strong)NSMutableArray<NSIndexPath *> *pickerIndexPathArray;

/**  滚动选项视图  */
@property (nonatomic, strong) UITableView *tableView;

/**  textfield数组  */
@property (nonatomic, strong) NSMutableArray *mutableTextFields;


/**  密码Textfield  */
@property (nonatomic, strong) UITextField *pwdTextField;
/**  付款金额  */
@property (nonatomic, copy) NSString *payMoney;
/**  付款金额  */
@property (nonatomic, strong) UILabel *payMoneyLabel;
/**  密码输入视图  */
@property (nonatomic, strong) UIView *pwdInputView;
/**  密码遮盖数组  */
@property (nonatomic, strong) NSMutableArray *pwdIndicatorArray;



@property (nonatomic, copy) FRAlertDatePickerBlock alertDatePickerBlock;

@property (nonatomic, copy) FRAlertPickerViewBlock alertPickerViewBlock;

@property (nonatomic, copy) FRAlertArrayBlock alertArrayBlock;

@property (nonatomic, copy) FRAlertPassWardBlock passWardBlock;

@end

@implementation FRAlertController

- (instancetype)init {
    if (self = [super init]) {
        
        //弹出的视图透明
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }else{
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
    }
    return self;
}

- (void)dealloc {
    if (_alertView != nil) _alertView = nil;
    if (_titleLabel != nil) _titleLabel = nil;
    if (_messageLabel != nil) _messageLabel = nil;
    if (_mutableActions != nil) _mutableActions = nil;
    if (_buttons != nil) _buttons = nil;
    
    if (_alertArray != nil) _alertArray = nil;
    if (_closeBtn != nil) _closeBtn = nil;
    if (_tableView != nil) _tableView = nil;
    if (_mutableTextFields != nil) _mutableTextFields = nil;
    
    if (_pwdTextField!= nil) _pwdTextField = nil;
    if (_payMoneyLabel != nil) _payMoneyLabel = nil;
    if (_pwdInputView != nil) _pwdInputView = nil;
    if (_pwdIndicatorArray != nil) _pwdIndicatorArray = nil;
    
    if (_datePicker != nil) _datePicker = nil;
    if (_pickerView != nil) _pickerView = nil;
    if (_pickerArray != nil) _pickerArray= nil;
    if (_pickerIndexPathArray != nil) _pickerIndexPathArray= nil;
    if (_mutableTextFields != nil) _mutableTextFields = nil;
    if (_alertArray != nil) _alertArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self alertView];
    if (self.title.length > 0) self.titleLabel.text = self.title;
    
    if (self.alertArray.count > 0) {
        
        CGFloat height = self.view.frame.size.height - 160;
        CGFloat tableViewH = self.alertArray.count * 44 + 60;
        
        height = height > tableViewH ? tableViewH : height;
        //根据数组的长度设置alertView的高度
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(height);
        }];
        
        [self.tableView reloadData];
        
        [self.closeBtn addTarget:self action:@selector(closeDataPicker) forControlEvents:UIControlEventTouchUpInside];
    }else if (self.message.length > 0) self.messageLabel.text = self.message;
    
    
    if (_payMoney.length > 0) {//密码输入框
        
        self.payMoneyLabel.text = [NSString stringWithFormat:@"￥%@  ",_payMoney];
        [self pwdInputView];
        [self.pwdTextField becomeFirstResponder];
        
        [self.closeBtn addTarget:self action:@selector(closeDataPicker) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
        
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.3);
            }];
        });
    }else {
        self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.35);
    }
    //布局button
    if (self.alertArray.count < 1||_payMoney.length > 0) [self layoutViews];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    __weak typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0);
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.textFields.count > 0) {
        for (UITextField *textField in _mutableTextFields) {
            [textField resignFirstResponder];
        }
    }
}

#pragma 创建alertController类方法
/**  ----- 参考系统创建alertController -----  */
+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.alertPreferredStyle = preferredStyle;
    
    if (preferredStyle == FRAlertControllerStyleActionSheet) {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }else {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    return alertController;
}
/**  ----- 参考系统创建alertController -----  */
- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
    });
}


#pragma mark - AlertAction
/**  ----- 为alertController添加按钮（action） -----  */
- (void)addAction:(nonnull FRAlertAction *)action {
    
    [self.mutableActions addObject:action];
    
    // 创建 button，设置它的属性
    UIButton *actionButton = [[UIButton alloc] init];
    [actionButton setTag:[self.actions indexOfObject:action]];
    [actionButton setTitle:action.title forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    actionButton.titleLabel.numberOfLines = 2;
    actionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [actionButton setBackgroundColor:[UIColor whiteColor]];
    actionButton.enabled = action.isEnabled;
    
    UIColor *color = action.color;
    if (action.style == FRAlertActionStyleDefault) {
        if (color) {
            [actionButton setTitleColor:color forState:UIControlStateNormal];
            [actionButton setBackgroundColor:[UIColor whiteColor]];
            [actionButton setLayerWithCornerRadius:5.0];
        }
    }else if (action.style == FRAlertActionStyleColor) {
        if (color) {
            [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [actionButton setBackgroundColor:color];
            [actionButton setLayerWithCornerRadius:5.0];
        }
    } else if (action.style == FRAlertActionStyleBorder) {
        if (color) {
            [actionButton setTitleColor:color forState:UIControlStateNormal];
            [actionButton setLayerWithCornerRadius:5.0 borderWidth:1.0 borderColor:color];
        }
    } else if (action.style == FRAlertActionStyleCancle) {
        if (color) {
            [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [actionButton setBackgroundColor:color];
            [actionButton setLayerWithCornerRadius:5.0];
            self.cancleButton = actionButton;
        }
    }
    [actionButton addTarget:self action:@selector(actionButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到 button数组
    [self.buttons addObject:actionButton];
    
    // 添加到父视图
    [self.alertView addSubview:actionButton];
}

/** 点击按钮事件 */
- (void)actionButtonDidClicked:(UIButton *)sender {
    
    // 根据 tag 取到 handler
    FRAlertActionBlock actionBlock = self.actions[sender.tag].actionBlock;
    if (actionBlock) {
        actionBlock(self.actions[sender.tag]);
    }
    if (self.textFields.count > 0) {
        for (UITextField *textField in _mutableTextFields) {
            [textField resignFirstResponder];
        }
    }
    // 点击button后自动dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)layoutViews {
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet && self.cancleButton) {
        [self.buttons removeObject:self.cancleButton];
    }
    // 根据当前button的数量来布局
    switch (self.buttons.count) {
        case 2:{
            if (self.alertPreferredStyle == FRAlertControllerStyleAlert || _datePicker || _pickerView) {
                //水平布局
                [self layoutViewsHorizontal];
            }else {
                //垂直布局
                [self layoutViewsVertical];
            }
        }
            break;
        default:{
            //垂直布局
            [self layoutViewsVertical];
        }
            break;
    }
}


/** 两个 button 时的水平布局 */
- (void)layoutViewsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    
    UIView *topView;
    CGFloat topOffset = 12;
    if (_datePicker) {
        topView = _datePicker;
    }else if (_pickerView) {
        topView = _pickerView;
    }else if (self.textFields.count > 0) {
        
        [self layoutTextField];
        UITextField *view = self.mutableTextFields[_mutableTextFields.count - 1];
        topView = view;
    }else if (self.message) {
        topView = self.messageLabel;
        topOffset = 14;
    }else if (self.title) {
        topView = self.titleLabel;
        topOffset = 14;
    }else {
        topView = self.alertView;
        topOffset = 16;
    }
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(topOffset);
        make.left.mas_offset(16);
        make.bottom.mas_offset(-12);
        make.height.mas_offset(44);
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftButton.mas_right).offset(10);
        make.right.mas_offset(-16);
        make.centerY.mas_equalTo(leftButton);
        make.size.mas_equalTo(leftButton);
    }];
    
    //创建距底部的约束
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(FR_IPHONE_X ? -44 : -10);
        }];
    }
    
    [self.alertView setNeedsLayout];
}


/** 垂直布局 */
- (void)layoutViewsVertical {
    // 记录最下面的一个view
    UIView *lastView;
    
    // 遍历在数组中的textField，添加到alert上
    
    
    // 遍历在数组中的button，添加到alert上
    NSInteger count = self.buttons.count;
    for (NSInteger n = 0; n < count; n++) {
        
        UIButton *button = self.buttons[n];
        if(!lastView) {
            
            CGFloat topOffset = 12;
            if (_datePicker) {
                lastView = self.datePicker;
            }else if (_pickerView) {
                lastView = self.pickerView;
            }else if (self.textFields.count > 0) {
                [self layoutTextField];
                lastView = self.mutableTextFields[_mutableTextFields.count - 1];
            }else if (self.message) {
                lastView = self.messageLabel;
                topOffset = 14;
            }else if (self.title) {
                lastView = self.titleLabel;
                topOffset = 14;
            }else {
                lastView = self.alertView;
                topOffset = 16;
            }
            if (lastView == self.alertView) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView).offset(topOffset);
                }];
            }else {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(topOffset);
                }];
            }
        }else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(0.5);
            }];
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_offset(44);
            if (n == count - 1) make.bottom.mas_offset(0);
        }];
        //添加分割线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = FRUIColor_RGB(192, 190, 197, 1);
        [self.alertView insertSubview:lineView belowSubview:button];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button).offset(-0.5);
            make.left.right.mas_offset(0);
            make.height.mas_offset(0.5);
        }];
        
        //修改按钮样式
        [button setLayerWithCornerRadius:0 borderWidth:0 borderColor:nil];
        
        lastView = button;
    }
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet && self.cancleButton) {
        
        if (FR_IPHONE_X) {
            //修改alertView距底部的约束
            [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-94);
            }];
        }else {
            //修改alertView距底部的约束
            [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-60);
            }];
        }
        
        [self.buttons removeObject:self.cancleButton];
        [self.cancleButton removeFromSuperview];
        [self.view addSubview:self.cancleButton];
        
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.alertView.mas_bottom).offset(10);
            make.left.right.mas_equalTo(self.alertView);
            make.height.mas_offset(44);
        }];
    }
    if(self.passWardBlock && self.alertPreferredStyle == FRAlertControllerStyleActionSheet){
        if (FR_IPHONE_X) {
            //修改alertView距底部的约束
            [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-34);
            }];
        }else {
            //修改alertView距底部的约束
            [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(0);
            }];
        }
    }
}
/**  ----- 为alertController添加按钮（action） -----  */

#pragma mark - AlertTextField
/**  ----- 为alertController添加文本输入框（TextField） -----  */
- (void)addTextFieldConfigurationHandler:(nonnull FRAlertTextFieldBlock)configurationHandler {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:13];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 10)];
    [textField setLeftView:leftView];
    textField.leftViewMode = UITextFieldViewModeAlways;
    [textField setLayerWithCornerRadius:3.0 borderWidth:0.5 borderColor:[UIColor colorWithWhite:0.0 alpha:0.4]];
    textField.delegate = self;
    //添加到mutableTextFields数组
    [self.mutableTextFields addObject:textField];
    
    // 添加到父视图
    [self.alertView addSubview:textField];
    
    //仅支持FRAlertControllerStyleAlert
    self.alertPreferredStyle = FRAlertControllerStyleAlert;
    //弹出动画
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    configurationHandler(textField);
}

- (void)layoutTextField {
    // 记录最下面的一个view
    UIView *lastView;
    
    // 遍历在数组中的textField，添加到alert上
    NSInteger count = self.mutableTextFields.count;
    for (int n = 0; n < count; n++) {
        
        UITextField *textField = self.mutableTextFields[n];
        CGFloat topOffset = 10;
        if(!lastView) {
            if (_datePicker) {
                lastView = self.datePicker;
            }else if (self.message) {
                lastView = self.messageLabel;
            }else if (self.title) {
                lastView = self.titleLabel;
            }else {
                lastView = self.alertView;
            }
            topOffset = 12;
        }
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastView.mas_bottom).offset(topOffset);
            make.left.mas_offset(20);
            make.right.mas_offset(-20);
            make.height.mas_offset(32);
            if ((n == count - 1)&&self.buttons.count == 0) make.bottom.mas_offset(-14);
        }];

        lastView = textField;
    }
}
/**  ----- 为alertController添加文本输入框（TextField） -----  */



#pragma mark - AlertDatePicker
/**  ----- 为alertController添加日期选择器（DatePicker） -----  */
+ (nonnull FRAlertController *)showDatePickerController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle datePickerColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle datePickerStyle:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.alertPreferredStyle = preferredStyle;
    
    if (preferredStyle == FRAlertControllerStyleActionSheet) {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }else {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    [alertController addDatePickerWithColor:color cancleTitle:cancleTitle makeSureTitle:makeSureTitle style:style configurationHandler:configurationHandler];
    
    [alertController show];
    
    return alertController;
}


- (void)addDatePickerWithColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler {
    
    __weak typeof(self) weakSelf = self;
    FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:cancleTitle?cancleTitle:@"取消" style:FRAlertActionStyleColor color:[UIColor redColor] handler:nil];
    
    FRAlertAction *makeSureAction = [FRAlertAction actionWithTitle:makeSureTitle?makeSureTitle:@"确定" style:style color:color handler:^(FRAlertAction * _Nonnull action) {
        
        if(weakSelf.alertDatePickerBlock) weakSelf.alertDatePickerBlock(self.datePicker);
    }];
    [self addAction:cancleAction];
    [self addAction:makeSureAction];
    
    //    /** 日期选择 -2209017600 = 1900/01/01 */
    //    if(!minimumDate) minimumDate = [NSDate dateWithTimeIntervalSince1970:-2209017600];
    //    if(!maximumDate) maximumDate = [NSDate date];
    //    [self.datePicker setMinimumDate:minimumDate];
    //    [self.datePicker setMaximumDate:maximumDate];
    //    if (defaultDate) [self.datePicker setDate:defaultDate animated:NO];
    [self datePicker];
    
    //弹出动画
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    self.alertDatePickerBlock = configurationHandler;
}
/**  ----- 为alertController添加日期选择器（DatePicker） -----  */


#pragma mark - PickerView

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
+ (nonnull FRAlertController *)showPickerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle  pickerArray:(NSArray *_Nullable)pickerArray pickerButtonColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle pickerViewStyle:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertPickerViewBlock)configurationHandler {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.alertPreferredStyle = preferredStyle;
    
    if (preferredStyle == FRAlertControllerStyleActionSheet) {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }else {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    [alertController addPickerViewWithPickerArray:pickerArray pickerButtonColor:color cancleTitle:cancleTitle makeSureTitle:makeSureTitle style:style configurationHandler:configurationHandler];
    
    [alertController show];
    
    return alertController;
}


- (void)addPickerViewWithPickerArray:(NSArray *_Nullable)pickerArray pickerButtonColor:(nullable UIColor *)color cancleTitle:(NSString *_Nullable)cancleTitle makeSureTitle:(NSString *_Nullable)makeSureTitle style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertPickerViewBlock)configurationHandler {
    
    __weak typeof(self) weakSelf = self;
    FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:cancleTitle?cancleTitle:@"取消" style:FRAlertActionStyleColor color:[UIColor redColor] handler:nil];
    
    FRAlertAction *makeSureAction = [FRAlertAction actionWithTitle:makeSureTitle?makeSureTitle:@"确定" style:style color:color handler:^(FRAlertAction * _Nonnull action) {
        
        if(weakSelf.alertPickerViewBlock) weakSelf.alertPickerViewBlock(self.pickerIndexPathArray);
    }];
    [self addAction:cancleAction];
    [self addAction:makeSureAction];
    self.pickerArray = pickerArray;
    //初始化pickerIndexPathArray
    NSInteger arrayCount = pickerArray.count;
    for (int n = 0; n < arrayCount; n++) {
        [self.pickerIndexPathArray addObject:[NSIndexPath indexPathForRow:0 inSection:n]];
    }
    [self pickerView];
    
    //弹出动画
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    self.alertPickerViewBlock = configurationHandler;
}
/**  ----- 为alertController添加选择器（PickerView） -----  */



#pragma mark - AlertArray
/**  ----- 为alertController添加数组选择器（SelectArray） -----  */
+ (nonnull FRAlertController *)showSelectArrayController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle selectArray:(nonnull NSArray *)array configurationHandler:(nonnull FRAlertArrayBlock)configurationHandler {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.alertPreferredStyle = preferredStyle;
    
    if (preferredStyle == FRAlertControllerStyleActionSheet) {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }else {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    [alertController addSelectArray:array configurationHandler:configurationHandler];
    
    [alertController show];
    
    return alertController;
}

- (void)addSelectArray:(nonnull NSArray *)array configurationHandler:(nonnull FRAlertArrayBlock)configurationHandler {
    
    self.alertArray = array;
    
    //仅支持FRAlertControllerStyleAlert
    self.alertPreferredStyle = FRAlertControllerStyleAlert;
    //弹出动画
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    self.alertArrayBlock = configurationHandler;
}
/**  ----- 为alertController添加数组选择器（SelectArray） -----  */


#pragma mark - AlertPassWard
/**  ----- 为alertController添加密码输入框（PassWard） -----  */
+ (nonnull FRAlertController *)showPassWardController:(nonnull UIViewController *)controller title:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle payMoney:(nonnull NSString *)payMoney configurationHandler:(nonnull FRAlertPassWardBlock)configurationHandler {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.alertPreferredStyle = preferredStyle;
    
    if (preferredStyle == FRAlertControllerStyleActionSheet) {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }else {
        //弹出动画
        [alertController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    [alertController addPassWardWithPayMoney:payMoney configurationHandler:configurationHandler];
    
    [alertController show];
    
    return alertController;
}

- (void)addPassWardWithPayMoney:(nonnull NSString *)payMoney configurationHandler:(nonnull FRAlertPassWardBlock)configurationHandler {
    
    self.payMoney = payMoney;
    
    self.passWardBlock = configurationHandler;
}
/**  ----- 为alertController添加密码输入框（PassWard） -----  */



#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.alertArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"FRAlertControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.alertArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}


#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.alertArrayBlock) {
        self.alertArrayBlock(indexPath.row);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeDataPicker {
    if(_pwdTextField) [self.pwdTextField resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - pickerView dataSource
//UIPickerView中有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerArray.count;
}
//每列有多少行`
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *componentArray =self.pickerArray[component];
    return  componentArray.count;
}
#pragma mark - pickerView delegate
//每行每列显示的内容
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *componentArray =self.pickerArray[component];
    NSString *rowString = componentArray[row];
    return  rowString;
}
//选中UIPickerView中的哪行哪列
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.pickerIndexPathArray setObject:[NSIndexPath indexPathForRow:row inSection:component] atIndexedSubscript:component];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

#pragma mark - textField delegate
/**  ----- 为alertController添加文本输入框（TextField） -----  */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //弹出键盘后需要立即修改textField的位置
    CGFloat alertViewH = CGRectGetHeight(self.alertView.frame);
    //alertView居中时最大的Y值
    CGFloat alertViewMaxY = (screenSize.height + alertViewH) * 0.5;
    CGFloat textFieldMaxY = CGRectGetMaxY(textField.frame);
    //textField距底部的高度
    CGFloat textFieldBottomDistance = screenSize.height - alertViewMaxY + alertViewH - textFieldMaxY;
    /**  键盘高度
    5.5吋271
    4.7吋258
    4.0吋253
     */
    CGFloat keyboardHeight = 0;
    // 如果是iPhone
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        // 竖屏情况
        if (screenSize.height > screenSize.width) {
            if (screenSize.height == 568) {//4.0"
                keyboardHeight = 253;
            }else if (screenSize.height == 667) {//4.7"
                keyboardHeight = 258;
            }else if (screenSize.height == 736) {//5.5"
                keyboardHeight = 271;
            }else if (screenSize.height == 812) {//5.8"
                keyboardHeight = 333;
            }else {//3.5"
                keyboardHeight = 253;
            }
        }
        // 横屏情况
        if (screenSize.width > screenSize.height) {
            if (screenSize.width == 568) {//4.0"
                keyboardHeight = 253;
            }else if (screenSize.width == 667) {//4.7"
                keyboardHeight = 258;
            }else if (screenSize.width == 736) {//5.5"
                keyboardHeight = 271;
            }else if (screenSize.width == 812) {//5.8"
                keyboardHeight = 333;
            }else {//3.5"
                keyboardHeight = 253;
            }
        }
    }
    //textFiled距键盘高度,如果小于20上移textFiled背景
    CGFloat distance = textFieldBottomDistance - keyboardHeight;
    if (distance < 20) {//需要移动textFiled的背景视图
        //需要移动键盘的距离
        CGFloat moveDistance = 20 - distance;
        NSArray* constrains = self.view.constraints;
        
        for (NSLayoutConstraint* constraint in constrains) {
            if (constraint.firstItem == self.alertView){
                if (constraint.firstAttribute == NSLayoutAttributeCenterY) {
                    constraint.constant = - moveDistance;
                    [UIView animateWithDuration:0.1 animations:^{
                        [self.view layoutIfNeeded];
                    }];
                }
            }
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //移动键盘到原来的位置
    NSArray* constrains = self.view.constraints;
    
    for (NSLayoutConstraint* constraint in constrains) {
        if (constraint.firstItem == self.alertView){
            if (constraint.firstAttribute == NSLayoutAttributeCenterY) {
                constraint.constant = 0;
                [UIView animateWithDuration:0.1 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
        }
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
/**  ----- 为alertController添加文本输入框（TextField） -----  */


/**  ----- 为alertController添加密码输入框（PassWard） -----  */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // _pwdTextField不能使用self.pwdTextField,因为self会调用pwdTextField的懒加载方法，在视图上创建pwdTextField会导致密码输入框显示
    if (![textField isEqual:_pwdTextField]) return YES;
    
    if (textField.text.length >= 6 && string.length) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    [self setDotWithCount:totalString.length];
    
    if (totalString.length == 6) {
        if (_passWardBlock) {
            self.passWardBlock(totalString);
        }
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [textField resignFirstResponder];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
    return YES;
}

- (void)setDotWithCount:(NSInteger)count {
    for (UILabel *dot in _pwdIndicatorArray) {
        dot.hidden = YES;
    }
    
    for (int i = 0; i< count; i++) {
        ((UILabel*)[_pwdIndicatorArray objectAtIndex:i]).hidden = NO;
    }
}
/**  ----- 为alertController添加密码输入框（PassWard） -----  */



#pragma mark - 数据处理
- (FRAlertControllerStyle)preferredStyle {
    return self.alertPreferredStyle;
}

/**  ----- 为alertController添加按钮（action） -----  */
- (NSMutableArray *)mutableActions {
    if (!_mutableActions) {
        _mutableActions = [[NSMutableArray alloc]init];
    }
    return _mutableActions;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (NSArray<FRAlertAction *> *)actions {
    
    return _mutableActions;
}
/**  ----- 为alertController添加按钮（action） -----  */


/**  ----- 为alertController添加文本输入框（TextField） -----  */
- (NSMutableArray *)mutableTextFields {
    if (!_mutableTextFields) {
        _mutableTextFields = [[NSMutableArray alloc]init];
    }
    return _mutableTextFields;
}


- (NSArray<UITextField *> *)textFields {
    return _mutableTextFields;
}
/**  ----- 为alertController添加文本输入框（TextField） -----  */


/**  ----- 为alertController添加密码输入框（PassWard） -----  */
- (NSMutableArray *)pwdIndicatorArray {
    if (!_pwdIndicatorArray) {
        _pwdIndicatorArray = [[NSMutableArray alloc]init];
    }
    return _pwdIndicatorArray;
}
/**  ----- 为alertController添加密码输入框（PassWard） -----  */


#pragma mark - 视图懒加载
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        [self.view addSubview:_alertView];
        if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
            
            if(self.payMoney) {
                [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_offset(0);
                }];
            }else {
                [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.right.mas_offset(-10);
                }];
                [_alertView setLayerWithCornerRadius:5.0];
            }
        }else {
            
            //创建距中的约束
            [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_offset(0);
                make.centerY.mas_offset(self.payMoney?-60:0);
                make.width.mas_equalTo(280);
            }];
            
            [_alertView setLayerWithCornerRadius:5.0];
        }
        
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.alpha = 0.95;
    }
    return _alertView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.alertView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(16);
            make.right.mas_offset(-16);
            if (self.buttons.count < 1 && !self.message && self.alertArray.count < 1 && self.mutableTextFields.count < 1 && !self.payMoney) make.bottom.mas_offset(-16);
        }];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        [self.alertView addSubview:_messageLabel];
        if (self.title.length > 0) {
            [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(16);
            }];
        }else {
            [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(16);
            }];
        }
        
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.right.mas_equalTo(-16);
            if (self.buttons.count < 1 && self.alertArray.count < 1 && self.mutableTextFields.count < 1 && !self.payMoney) make.bottom.mas_offset(-16);
        }];
        
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}


/**  ----- 为alertController添加日期选择器（DatePicker） -----  */
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        [self.alertView addSubview:_datePicker];
        if (self.message) {
            [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageLabel.mas_bottom);
            }];
        }else if (self.title) {
            [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom);
            }];
        }else {
            [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(12);
            }];
        }
        [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_offset(180);
        }];
        
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        
    }
    return _datePicker;
}
/**  ----- 为alertController添加日期选择器（DatePicker） -----  */


/**  ----- 为alertController添加选择器（PickerView） -----  */
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.alertView addSubview:_pickerView];
        if (self.message) {
            [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel.mas_bottom);
        }];
        }else if (self.title) {
            [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom);
            }];
        }else {
            [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(12);
            }];
        }
        
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_offset(162);
        }];
    }
    return _pickerView;
}
/**  ----- 为alertController添加选择器（PickerView） -----  */


/**  ----- 为alertController添加数组选择器（SelectArray） -----  */
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        
        [self.alertView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.size.mas_offset(24);
        }];
        
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _closeBtn;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        
        [self.alertView addSubview:_tableView];
        if (self.title) {
            [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
            }];
        }else {
            [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(30);
            }];
        }
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(1);
            make.bottom.mas_offset(-12);
            make.right.mas_equalTo(-16);
        }];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}
/**  ----- 为alertController添加数组选择器（SelectArray） -----  */

/**  ----- 为alertController添加密码输入框（PassWard） -----  */
- (UILabel *)payMoneyLabel {
    if (!_payMoneyLabel) {
        _payMoneyLabel = [[UILabel alloc]init];
        [self.alertView addSubview:_payMoneyLabel];
        
        if (self.message) {
            [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(8);
            }];
        }else if (self.title) {
            [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
            }];
        }else {
            [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(8);
            }];
        }
        [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
        }];
        _payMoneyLabel.font = [UIFont systemFontOfSize:36];
        _payMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _payMoneyLabel;
}


- (UIView *)pwdInputView {
    if (!_pwdInputView) {
        _pwdInputView = [[UIView alloc]init];
        [self.alertView addSubview:_pwdInputView];
        
        CGFloat bottomOffset;
        
        CGFloat height = 40;
        CGFloat width = height;
        if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            bottomOffset = FR_IPHONE_X ? -294 : -260;
            width = (screenSize.width - 80)/6;
        }else {
            bottomOffset = -20;
        }
        
        [_pwdInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.payMoneyLabel.mas_bottom).offset(10);
            make.bottom.mas_offset(bottomOffset);
            make.centerX.mas_offset(0);
            make.width.mas_offset(width * 6);
            make.height.mas_offset(height);
        }];
        
        _pwdInputView.backgroundColor = [UIColor whiteColor];
        [_pwdInputView setLayerWithCornerRadius:3.0 borderWidth:0.5 borderColor:[UIColor blackColor]];
        
        CGFloat dotW = height - 20;
        for (int i = 0; i < 6; i ++) {
            UIView *dot = [[UIView alloc]initWithFrame:CGRectMake((width-dotW)/2.f + i*width, (height-dotW)/2.f, dotW, dotW)];
            dot.backgroundColor = [UIColor blackColor];
            dot.layer.cornerRadius = dotW/2;
            dot.clipsToBounds = YES;
            dot.hidden = YES;
            [_pwdInputView addSubview:dot];
            [self.pwdIndicatorArray addObject:dot];
            
            if (i == 6-1) {
                continue;
            }
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake((i+1)*width, 0, 0.5f, height)];
            line.backgroundColor = [UIColor blackColor];
            [_pwdInputView addSubview:line];
        }

    }
    return _pwdInputView;
}


- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc]init];
        _pwdTextField.hidden = YES;
        _pwdTextField.delegate = self;
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.pwdInputView addSubview:_pwdTextField];
    }
    return _pwdTextField;
}
/**  ----- 为alertController添加密码输入框（PassWard） -----  */

- (NSMutableArray *)pickerIndexPathArray {
    if (!_pickerIndexPathArray) {
        _pickerIndexPathArray = [[NSMutableArray alloc] init];
    }
    return _pickerIndexPathArray;
}



@end
