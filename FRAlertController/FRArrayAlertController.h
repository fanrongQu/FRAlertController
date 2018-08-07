//
//  FRArrayAlertController.h
//  FRAlertController-demo
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 FanrongQu. All rights reserved.
//

#import "FRAlertController.h"

@protocol FRArrayAlertViewDataSource<NSObject>

@required

- (CGFloat)arrayAlertScrollViewHeight;

- (NSInteger)arrayAlertView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)arrayAlertView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInArrayAlertView:(UITableView *)tableView;

@end

@protocol FRArrayAlertViewDelegate<NSObject>

@optional

- (CGFloat)arrayAlertView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)arrayAlertView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface FRArrayAlertController : UIViewController

/**  标题Label  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  描述Label  */
@property (nonatomic, strong) UILabel *messageLabel;
/**  描述  */
@property (nullable, nonatomic, copy) NSString *message;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, weak)id<FRArrayAlertViewDataSource> dataSource;

@property(nonatomic, weak)id<FRArrayAlertViewDelegate> delegate;

+ (nonnull FRArrayAlertController *)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(FRAlertControllerStyle)preferredStyle;

- (void)show;

@end
