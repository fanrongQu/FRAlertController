//
//  FRAlertController.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRAlertController.h"

@interface FRAlertController ()<UITableViewDataSource,UITableViewDelegate>

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

/**  alertArray  */
@property (nonatomic, strong) NSArray *alertArray;
/**  关闭按钮  */
@property (nonatomic, strong) UIButton *closeBtn;
/**  滚动选项视图  */
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) FRAlertDatePickerBlock alertDatePickerBlock;

@property (nonatomic, copy) FRAlertTextFieldBlock alertTextFieldBlock;

@property (nonatomic, copy) FRAlertArrayBlock alertArrayBlock;

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
    if (_datePicker != nil) _datePicker = nil;
    if (_textFields != nil) _textFields = nil;
    if (_alertArray != nil) _alertArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self alertView];
    if (self.title.length > 0) self.titleLabel.text = self.title;
    
    if (self.alertArray.count > 0) {
        
        CGFloat height = self.view.frame.size.height - 160;
        CGFloat tableViewH = self.alertArray.count * 44 + 60;
        
        height = height > tableViewH ? tableViewH : height;
        //根据数组的长度设置alertView的高度
        [self.alertView setAutoLayoutHeight:height];
        
        [self.tableView reloadData];
        
        [self.closeBtn addTarget:self action:@selector(closeDataPicker) forControlEvents:UIControlEventTouchUpInside];
    }else if (self.message.length > 0) self.messageLabel.text = self.message;
    
    if (_alertPreferredStyle == FRAlertControllerStyleActionSheet) {
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.3);
            }];
        });
    }else {
        self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.35);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //布局button
    [self layoutButtons];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!(self.buttons.count > 1 || self.alertArray.count > 0)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    __weak typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0);
//    }];
}


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

- (void)addAction:(nonnull FRAlertAction *)action {
    
    [self.mutableActions addObject:action];
    
    // 创建 button，设置它的属性
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTag:[self.actions indexOfObject:action]];
    [actionButton setTitle:action.title forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [actionButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
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
        if (action.color) {
            [actionButton setTitleColor:color forState:UIControlStateNormal];
            [actionButton setLayerWithCornerRadius:5.0 borderWidth:1.0 borderColor:color];
        }
    }
    [actionButton addTarget:self action:@selector(actionButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到 button数组
    [self.buttons addObject:actionButton];
    
    // 添加到父视图
    [self.alertView addSubview:actionButton];
}

- (void)addTextFieldWithPlaceholder:(nonnull NSString *)placeholder configurationHandler:(nonnull FRAlertTextFieldBlock)configurationHandler {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    
    self.alertTextFieldBlock = configurationHandler;
}

/**
 添加日期选择器
 
 @param color 确定按钮颜色
 @param style 确定按钮样式
 @param configurationHandler 日期选择器回调
 */
- (void)addDatePickerWithColor:(nullable UIColor *)color style:(FRAlertActionStyle)style configurationHandler:(nonnull FRAlertDatePickerBlock)configurationHandler {
    
    __weak typeof(self) weakSelf = self;
    FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:@"取消" style:FRAlertActionStyleColor color:[UIColor redColor] handler:nil];
    
    FRAlertAction *makeSureAction = [FRAlertAction actionWithTitle:@"确定" style:style color:color handler:^(FRAlertAction * _Nonnull action) {
        NSLog(@"%s",__func__);
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
    self.alertDatePickerBlock = configurationHandler;
}


/**
 数组选择

 @param array 待选数组
 @param configurationHandler 选中数组的序号
 */
- (void)addSelectArray:(nonnull NSArray *)array configurationHandler:(nonnull FRAlertArrayBlock)configurationHandler {
    
    self.alertArray = array;
    self.alertArrayBlock = configurationHandler;
}

/** 点击按钮事件 */
- (void)actionButtonDidClicked:(UIButton *)sender {
    
    // 根据 tag 取到 handler
    FRAlertActionBlock actionBlock = self.actions[sender.tag].actionBlock;
    if (actionBlock) {
        actionBlock(self.actions[sender.tag]);
    }
    
    // 点击button后自动dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)layoutButtons {
    // 根据当前button的数量来布局
    switch (self.buttons.count) {
        case 2:{
            if (_alertPreferredStyle == FRAlertControllerStyleActionSheet) {
                //垂直布局
                [self layoutButtonsVertical];
            }else {
                //水平布局
                [self layoutButtonsHorizontal];
            }
        }
            break;
        default:{
            //垂直布局
            [self layoutButtonsVertical];
        }
            break;
    }
}


/** 两个 button 时的水平布局 */
- (void)layoutButtonsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    if (_datePicker) {
        
        [leftButton setAutoLayoutTopToViewBottom:self.datePicker constant:12];
    }else if (self.message) {
        [leftButton setAutoLayoutTopToViewBottom:self.messageLabel constant:12];
    }else if (self.title) {
        
        [leftButton setAutoLayoutTopToViewBottom:self.titleLabel constant:12];
    }else {
        
        [leftButton setAutoLayoutTopToViewBottom:self.alertView constant:12];
    }
    [leftButton setAutoLayoutLeftToViewLeft:self.alertView constant:15];
    [leftButton setAutoLayoutBottomToViewBottom:self.alertView constant:-12];
    [leftButton setAutoLayoutHeight:40];
    
    
    [rightButton setAutoLayoutTopToViewTop:leftButton constant:0];
    [rightButton setAutoLayoutLeftToViewRight:leftButton constant:10];
    [rightButton setAutoLayoutBottomToViewBottom:leftButton constant:0];
    [rightButton setAutoLayoutRightToViewRight:self.alertView constant:-15];
    [rightButton setAutoLayoutWidthToView:leftButton constant:0];
    
    [self.alertView setNeedsLayout];
}


/** 垂直布局 */
- (void)layoutButtonsVertical {
    // 记录最下面的一个view
    UIView *lastView;
    
    // 遍历在数组中的button，添加到alert上
    NSInteger count = self.buttons.count;
    for (NSInteger n = 0; n < count; n++) {
        
        UIButton *button = self.buttons[n];
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
            [button setAutoLayoutTopToViewBottom:lastView constant:12];
            
            //添加分割线
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = FRUIColor_RGB(192, 190, 197, 1);
            [self.alertView insertSubview:lineView belowSubview:button];
            [lineView setAutoLayoutTopToViewTop:button constant:-0.5];
            [lineView setAutoLayoutBottomToViewBottom:self.alertView constant:0];
            [lineView setAutoLayoutWidthToView:button constant:0];
            [lineView setAutoLayoutCenterXToViewCenterX:button constant:0];
        }else {
            [button setAutoLayoutTopToViewBottom:lastView constant:0.5];
        }
        [button setAutoLayoutLeftToViewLeft:self.alertView constant:0];
        [button setAutoLayoutRightToViewRight:self.alertView constant:0];
        [button setAutoLayoutHeight:40];
        if (n == count - 1) {
            [button setAutoLayoutBottomToViewBottom:self.alertView constant:0];
        }
        //修改按钮样式
        [button setLayerWithCornerRadius:0 borderWidth:0 borderColor:nil];
        
        lastView = button;
    }
}



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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 数据处理
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

- (FRAlertControllerStyle)preferredStyle {
    return _alertPreferredStyle;
}

#pragma mark - 视图懒加载
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        [self.view addSubview:_alertView];
        if (_alertPreferredStyle == FRAlertControllerStyleActionSheet) {
            //创建距底部的约束
            [_alertView setAutoLayoutBottomToViewBottom:self.view constant:-10];
        }else {
            //创建距中的约束
            [_alertView setAutoLayoutCenterToViewCenter:self.view];
        }
        //创建距左边的约束
        [_alertView setAutoLayoutLeftToViewLeft:self.view constant:20];
        //创建距右边的约束
        [_alertView setAutoLayoutRightToViewRight:self.view constant:-20];
        
        _alertView.backgroundColor = [UIColor whiteColor];
        [_alertView setLayerWithCornerRadius:5.0];
//        _alertView.alpha = 0.9;
    }
    return _alertView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.alertView addSubview:_titleLabel];
        [_titleLabel setAutoLayoutTopToViewTop:self.alertView constant:12];
        [_titleLabel setAutoLayoutLeftToViewLeft:self.alertView constant:15];
        [_titleLabel setAutoLayoutRightToViewRight:self.alertView constant:-15];
        if (self.buttons.count < 1 && !self.message && self.alertArray.count < 1) {
            [_titleLabel setAutoLayoutBottomToViewBottom:self.alertView constant:-12];
        }
        
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
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
            
            [_messageLabel setAutoLayoutTopToViewBottom:self.titleLabel constant:5];
        }else {
            [_messageLabel setAutoLayoutTopToViewTop:self.alertView constant:12];
        }
        [_messageLabel setAutoLayoutLeftToViewLeft:self.alertView constant:15];
        [_messageLabel setAutoLayoutRightToViewRight:self.alertView constant:-15];
        
        if (self.buttons.count < 1) {
            [_messageLabel setAutoLayoutBottomToViewBottom:self.alertView constant:-12];
        }
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _messageLabel;
}


- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        [self.alertView addSubview:_datePicker];
        if (self.message) {
            [_datePicker setAutoLayoutTopToViewBottom:self.messageLabel constant:0];
        }else if (self.title) {
            [_datePicker setAutoLayoutTopToViewBottom:self.titleLabel constant:0];
        }else {
            [_datePicker setAutoLayoutTopToViewBottom:self.alertView constant:0];
        }
        [_datePicker setAutoLayoutLeftToViewLeft:self.alertView constant:0];
        [_datePicker setAutoLayoutRightToViewRight:self.alertView constant:0];
        [_datePicker setAutoLayoutHeight:180];
        
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];

    }
    return _datePicker;
}


- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        
        [self.alertView addSubview:_closeBtn];
        [_closeBtn setAutoLayoutTopToViewTop:self.alertView constant:10];
        [_closeBtn setAutoLayoutRightToViewRight:self.alertView constant:-10];
        [_closeBtn setAutoLayoutSize:CGSizeMake(25, 25)];
        
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
            [_tableView setAutoLayoutTopToViewBottom:self.titleLabel constant:12];
        }else {
            [_tableView setAutoLayoutTopToViewTop:self.alertView constant:30];
        }
        [_tableView setAutoLayoutLeftToViewLeft:self.alertView constant:0];
        [_tableView setAutoLayoutBottomToViewBottom:self.alertView constant:-12];
        [_tableView setAutoLayoutRightToViewRight:self.alertView constant:-15];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}


@end
