//
//  ViewController.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AutoLayout.h"
#import "AlertViewController.h"
#import "ActionSheetViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

/**  tableView  */
@property (nonatomic, strong) UITableView *tableView;
/**  弹框类型  */
@property (nonatomic, strong) NSArray *alertArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FRAlertController   DEMO";
    [self tableView];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.alertArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"tableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *alertType = self.alertArray[indexPath.row];
    cell.textLabel.text = alertType;
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    switch (row) {
        case 0: {
            AlertViewController *alertVC = [[AlertViewController alloc] init];
            [self.navigationController pushViewController:alertVC animated:YES];
        }
            break;
        case 1: {
            
            ActionSheetViewController *actionSheetVC = [[ActionSheetViewController alloc] init];
            [self.navigationController pushViewController:actionSheetVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        
        [_tableView setAutoLayoutTopToViewTop:self.view constant:0];
        [_tableView setAutoLayoutLeftToViewLeft:self.view constant:0];
        [_tableView setAutoLayoutRightToViewRight:self.view constant:0];
        [_tableView setAutoLayoutBottomToViewBottom:self.view constant:0];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)alertArray {
    if (!_alertArray) {
        _alertArray = @[@"Alert样式",@"ActionSheet样式"];
    }
    return _alertArray;
}


@end
