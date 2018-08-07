//
//  FRArrayAlertController.m
//  FRAlertController-demo
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 FanrongQu. All rights reserved.
//

#import "FRArrayAlertController.h"

@interface FRArrayAlertController ()<
UITableViewDataSource,
UITableViewDelegate>

/**  alert类型  */
@property (nonatomic, assign) FRAlertControllerStyle alertPreferredStyle;
/**  背景  */
@property (nonatomic, strong) UIView *contentView;

@property(nonatomic, strong)UIButton *closeBtn;
/**
 实际高度
 */
@property (nonatomic, assign)CGFloat contentH;

@end

@implementation FRArrayAlertController


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


+ (nonnull FRArrayAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle {
    FRArrayAlertController *alertController = [[FRArrayAlertController alloc] init];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0);
    
    self.titleLabel.text = self.title;
    
    self.messageLabel.text = self.message;
    
    [self tableView];
    [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //显示视图时背景色渐显
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.3);
            }];
        });
    }else {
        self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0.3);
    }
    
    //布局button
    [self layoutBaseView];
    [self showArrayView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.view.backgroundColor = FRUIColor_RGB(0, 0, 0, 0);
}

/**
 布局contentView、title、message
 */
- (void)layoutBaseView {
    
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
        CGFloat bottomOffset = -10 - FR_SafeArea_B;//普通
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(bottomOffset);
        }];
    }else {
        //创建距中的约束
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.centerY.mas_offset(-FR_SafeArea_T + 22);
            make.width.mas_equalTo(280);
        }];
    }
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16);
        make.left.mas_offset(_closeBtn?44:16);
        make.right.mas_offset(_closeBtn?-44:-16);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset((self.title && self.message)?10:0);
        make.left.mas_offset(16);
        make.right.mas_equalTo(-16);
    }];
}


- (void)showArrayView {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenH = screenSize.height;
    CGFloat realHeight = [self.dataSource arrayAlertScrollViewHeight];
    
    CGFloat safeAreaH = screenH - FR_SafeArea_T - FR_SafeArea_B;
    CGFloat minH = safeAreaH * 0.5 - 80;
    CGFloat maxH = safeAreaH - 44 - 20;//导航栏 间距
    realHeight = MAX(minH, realHeight);
    realHeight = MIN(maxH, realHeight);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(realHeight);
    }];
    
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
        //动画效果
        CGFloat contentH = realHeight + FR_SafeArea_B + 80;
        self.contentH = contentH;
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.bottom.mas_offset(contentH);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showAnimation];
        });
    }
    
    [self.tableView reloadData];
}

- (void)showAnimation {
    typeof(self) __weak weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
        }];
        [weakSelf.view layoutIfNeeded];
        
        [weakSelf.contentView setLayerWithRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:16];
    }];
}

- (void)closeBtnClick {
    if (self.alertPreferredStyle == FRAlertControllerStyleActionSheet) {
        typeof(self) __weak weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(self.contentH);
            }];
            [weakSelf.view layoutIfNeeded];
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.dataSource respondsToSelector:@selector(numberOfSectionsInArrayAlertView:)]) return [self.dataSource numberOfSectionsInArrayAlertView:tableView];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource arrayAlertView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource arrayAlertView:tableView cellForRowAtIndexPath:indexPath];
}
#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(arrayAlertView:heightForRowAtIndexPath:)]) return [self.delegate arrayAlertView:tableView heightForRowAtIndexPath:indexPath];
    return _tableView.rowHeight ?: 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(arrayAlertView:didSelectRowAtIndexPath:)]) [self.delegate arrayAlertView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self.tableView reloadData];
    [self closeBtnClick];
}

#pragma mark - lazy load
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self.view addSubview:_contentView];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.alpha = 0.95;
        [_contentView setLayerWithCornerRadius:6.0];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        BOOL isAlertStyle = self.alertPreferredStyle == FRAlertControllerStyleAlert;
        [self.contentView addSubview:_tableView];
        typeof(self) __weak weakSelf = self;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(12);
            make.left.mas_offset(isAlertStyle?6:0);
            make.right.mas_offset(isAlertStyle?-16:0);
            make.bottom.mas_offset(isAlertStyle?-16:-FR_SafeArea_B);
            make.height.mas_offset(100);
        }];
    }
    return _tableView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        
        [self.contentView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(0);
            make.size.mas_offset(44);
        }];
        
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _closeBtn;
}

@end
