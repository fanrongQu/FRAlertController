//
//  ViewController.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ViewController.h"
#import "FRAlertController.h"

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
            FRAlertController *alertController = [FRAlertController alertControllerWithTitle:@"标题" message:@"副标题" preferredStyle:UIAlertControllerStyleAlert];
          
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 1: {
        }
            break;
        case 2: {
        }
            break;
        case 3: {
        }
            break;
        case 4: {
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
        
        //使用代码布局 需要将这个属性设置为NO
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        //创建距顶部的约束
        NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:20];
        //创建距左边的约束
        NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        //创建距底部的约束
        NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        //创建距右边的约束
        NSLayoutConstraint * constraintRight = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        //添加约束之前，必须将视图加在父视图上
        [self.view addConstraints:@[constraintTop,constraintLeft,constraintBottom,constraintRight]];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)alertArray {
    if (!_alertArray) {
        _alertArray = @[@"提醒",@"带按钮的提醒",@"多选择的提醒"];
    }
    return _alertArray;
}


@end
