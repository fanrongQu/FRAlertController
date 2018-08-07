//
//  SelectDataView.h
//  kikuu_iphone
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIView+FRLayer.h"

#define FR_IPHONE_X ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
//顶部安全域
#define FR_SafeArea_T (FR_IPHONE_X ? 44 : 20)
//底部安全域
#define FR_SafeArea_B (FR_IPHONE_X ? 34 : 0)

@protocol SelectDataViewDataSource<NSObject>

@required

- (NSInteger)selectDataView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)selectDataView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInSelectDataView:(UITableView *)tableView;

@end

@protocol SelectDataViewDelegate<NSObject>

@optional

- (CGFloat)selectDataView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)selectDataView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface SelectDataView : UIView

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, weak)id<SelectDataViewDataSource> dataSource;

@property(nonatomic, weak)id<SelectDataViewDelegate> delegate;


/**
 动画显示SelectDataView
 
 @param title SelectDataView标题
 @param realHeight SelectDataView中tableView的高度（cell的总高度）
 */
- (void)showSelectDataViewWithTitle:(NSString *)title realHeight:(CGFloat)realHeight;

@end
