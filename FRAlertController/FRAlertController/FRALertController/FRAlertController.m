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
@property (nonatomic, strong) UIView *backgroundView;

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
    
    self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.4);
    [self backgroundView];
}


+ (nonnull FRAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    FRAlertController *alertController = [[FRAlertController alloc] init];
    alertController.title = title;
    alertController.message = message;
    alertController.preferredStyle = preferredStyle;
    
    return alertController;
}

#pragma mark - 懒加载
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
        [self.view addSubview:_backgroundView];
        //创建距中的约束
        [_backgroundView setAutoLayoutCenterToViewCenter:self.view];
        //创建距左边的约束
        [_backgroundView setAutoLayoutLeftToViewLeft:self.view constant:30];
        //创建距右边的约束
        [_backgroundView setAutoLayoutRightToViewRight:self.view constant:-30];
        [_backgroundView setAutoLayoutHeightToView:self.view height:80];
        
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [_backgroundView setLayerWithCornerRadius:5.0];
    }
    return _backgroundView;
}

#pragma mark - 测试
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
