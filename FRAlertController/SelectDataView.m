//
//  SelectDataView.m
//  kikuu_iphone
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 ld. All rights reserved.
//

#import "SelectDataView.h"

@interface SelectDataView()<
UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic, strong)UIButton *closeBtn;

/**
 实际高度
 */
@property (nonatomic, assign)CGFloat contentH;

@end

@implementation SelectDataView

- (instancetype)init {
    if(self = [super init]){
        [self tableView];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/**
 动画显示SelectDataView

 @param title SelectDataView标题
 @param realHeight SelectDataView中tableView的高度（cell的总高度）
 */
- (void)showSelectDataViewWithTitle:(NSString *)title realHeight:(CGFloat)realHeight {
    
    self.titleLabel.text = title;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat screenW = screenSize.width;
    CGFloat screenH = screenSize.height;
    
    self.frame = CGRectMake(0, 0, screenW, screenH);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    CGFloat safeAreaH = screenH - FR_SafeArea_T - FR_SafeArea_B;
    CGFloat minH = safeAreaH * 0.5 - 56;
    CGFloat maxH = safeAreaH - 44 - 20;//导航栏 间距
    realHeight = MAX(minH, realHeight);
    realHeight = MIN(maxH, realHeight);
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(realHeight);
    }];
    //动画效果
    CGFloat contentH = realHeight + FR_SafeArea_B + 56;
    self.contentH = contentH;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(contentH);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAnimation];
    });
    
    [self.tableView reloadData];
}

- (void)showAnimation {
    typeof(self) __weak weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
        }];
        [weakSelf layoutIfNeeded];
        
        [weakSelf.contentView setLayerWithRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:16];
    }];
}

- (void)closeBtnClick {
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(self.contentH);
        }];
        [weakSelf layoutIfNeeded];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.dataSource respondsToSelector:@selector(numberOfSectionsInSelectDataView:)]) return [self.dataSource numberOfSectionsInSelectDataView:tableView];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource selectDataView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource selectDataView:tableView cellForRowAtIndexPath:indexPath];
}
#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(selectDataView:heightForRowAtIndexPath:)]) return [self.delegate selectDataView:tableView heightForRowAtIndexPath:indexPath];
    return _tableView.rowHeight ?: 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(selectDataView:didSelectRowAtIndexPath:)]) [self.delegate selectDataView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self.tableView reloadData];
    [self closeBtnClick];
}

#pragma mark - lazy load
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithWhite:34/255.0 alpha:1];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(56);
            make.right.mas_offset(-56);
            make.height.mas_offset(56);
        }];
    }
    return _titleLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self.contentView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8);
            make.right.mas_offset(-8);
            make.size.mas_offset(40);
        }];
    }
    return _closeBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.contentView addSubview:_tableView];
        typeof(self) __weak weakSelf = self;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom);
            make.left.right.mas_offset(0);
            make.bottom.mas_offset(-FR_SafeArea_B);
            make.height.mas_offset(100);
        }];
    }
    return _tableView;
}


@end
