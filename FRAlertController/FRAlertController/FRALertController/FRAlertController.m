//
//  FRAlertController.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRAlertController.h"

@interface FRAlertController ()

/**  alert类型  */
@property (nonatomic, assign) UIAlertControllerStyle preferredStyle;

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
        //弹出动画
        [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.35);
    [self alertView];
    if (self.title.length > 0) self.titleLabel.text = self.title;
    if (self.message.length > 0) self.messageLabel.text = self.message;
    
}



+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.preferredStyle = preferredStyle;
    
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
    
    UIColor *color = action.color;
    if (action.style == FRAlertActionStyleDefault) {
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
    //布局button
    [self layoutButtons];
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
        case 2:
            [self layoutButtonsHorizontal];
            break;
        default:
            [self layoutButtonsVertical];
            break;
    }
}


/** 两个 button 时的水平布局 */
- (void)layoutButtonsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    if (self.message) {
        [leftButton setAutoLayoutTopToViewBottom:self.messageLabel constant:10];
    }else if (self.title) {
        
        [leftButton setAutoLayoutTopToViewBottom:self.titleLabel constant:10];
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
    [rightButton setAutoLayoutToViewWidth:leftButton constant:0];
    
    [self.alertView setNeedsLayout];
}


/** 垂直布局 */
- (void)layoutButtonsVertical {
    
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

#pragma mark - 视图懒加载
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        [self.view addSubview:_alertView];
        //创建距中的约束
        [_alertView setAutoLayoutCenterToViewCenter:self.view];
        //创建距左边的约束
        [_alertView setAutoLayoutLeftToViewLeft:self.view constant:30];
        //创建距右边的约束
        [_alertView setAutoLayoutRightToViewRight:self.view constant:-30];
        
        _alertView.backgroundColor = [UIColor whiteColor];
        [_alertView setLayerWithCornerRadius:5.0];
        _alertView.alpha = 0.9;
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
        if (self.buttons.count < 1 && !self.message) {
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

//#pragma mark - 测试
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
