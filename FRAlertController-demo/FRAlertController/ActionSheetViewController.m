//
//  ActionSheetViewController.m
//  FRAlertController
//
//  Created by 1860 on 2016/12/13.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//
//  https://github.com/fanrongQu/FRAlertController-master
//

#import "ActionSheetViewController.h"
#import "FRAlertController.h"
#import "FRArrayAlertController.h"

@interface ActionSheetViewController()<
UITableViewDataSource,
UITableViewDelegate,
FRArrayAlertViewDataSource,
FRArrayAlertViewDelegate>

/**  tableView  */
@property (nonatomic, strong) UITableView *tableView;
/**  弹框类型  */
@property (nonatomic, strong) NSArray *alertArray;

@end

@implementation ActionSheetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ActionSheet";
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
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"这是alertController的标题，是可以自动换行的" message:@"我是alertController的副标题🆚，也是可以自动换行的。并且我会根据是否有主标题改变我自身的位置奥" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *makesureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
                
            }];
            [alertController addAction:makesureAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 1: {
            
            FRAlertController *alertController = [FRAlertController alertControllerWithTitle:@"这是alertController的标题，是可以自动换行的" message:@"我是alertController的副标题🆚，也是可以自动换行的。并且我会根据是否有主标题改变我自身的位置奥" preferredStyle:FRAlertControllerStyleActionSheet];
            FRAlertAction *makesureAction = [FRAlertAction actionWithTitle:@"确定" style:FRAlertActionStyleBorder color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
            }];
            FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:@"取消" style:FRAlertActionStyleCancle color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
                
            }];
            [alertController addAction:makesureAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 2: {
            
            FRAlertController *alertController = [FRAlertController alertControllerWithTitle:@"这是alertController的标题，是可以自动换行的" message:nil preferredStyle:FRAlertControllerStyleActionSheet];
            FRAlertAction *makesureAction = [FRAlertAction actionWithTitle:@"确定" style:FRAlertActionStyleBorder color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
            }];
            FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:@"取消" style:FRAlertActionStyleCancle color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
                
            }];
            [alertController addAction:makesureAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 3: {
            
            FRAlertController *alertController = [FRAlertController alertControllerWithTitle:nil message:@"我是alertController的副标题🆚，也是可以自动换行的。并且我会根据是否有主标题改变我自身的位置奥" preferredStyle:FRAlertControllerStyleActionSheet];
            FRAlertAction *makesureAction = [FRAlertAction actionWithTitle:@"确定" style:FRAlertActionStyleBorder color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
            }];
            FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:@"取消" style:FRAlertActionStyleCancle color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
                
            }];
            [alertController addAction:makesureAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 4: {
            
            FRAlertController *alertController = [FRAlertController alertControllerWithTitle:@"这是alertController的标题，是可以自动换行的" message:@"我是alertController的副标题🆚，也是可以自动换行的。并且我会根据是否有主标题改变我自身的位置奥" preferredStyle:FRAlertControllerStyleActionSheet];
            FRAlertAction *makesureAction = [FRAlertAction actionWithTitle:@"确定" style:FRAlertActionStyleBorder color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
            }];
            FRAlertAction *seeAction = [FRAlertAction actionWithTitle:@"查看" style:FRAlertActionStyleBorder color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
                
            }];
            FRAlertAction *cancleAction = [FRAlertAction actionWithTitle:@"取消" style:FRAlertActionStyleCancle color:[self randomColor] handler:^(FRAlertAction * _Nonnull action) {
                NSLog(@"%s",__func__);
                
            }];
            [alertController addAction:makesureAction];
            [alertController addAction:seeAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        case 5: {
            /**
            FRAlertController *alertController = [FRAlertController alertControllerWithTitle:@"请输入支付密码" message:@"2016潮流男装爆款促销" preferredStyle:FRAlertControllerStyleActionSheet];
            [alertController addPassWardWithPayMoney:@"1000" configurationHandler:^(NSString * _Nonnull passWord) {
                NSLog(@"%@",passWord);
            }];
            [self presentViewController:alertController animated:YES completion:nil];
            */
            
            /**  建议使用  */
            [FRAlertController showPassWardController:self title:@"请输入支付密码" message:@"2016潮流男装爆款促销" preferredStyle:FRAlertControllerStyleActionSheet payMoney:@"1000" configurationHandler:^(NSString * _Nonnull passWord) {
                NSLog(@"%@",passWord);
            }];

        }
            break;
        case 6: {
            
            NSArray *pickArray = @[@[@"汉堡🍔",@"炸鸡",@"可乐",@"披萨",@"雪碧"],@[@"米饭",@"牛肉面",@"拉面",@"黄焖鸡",@"馄饨"]];
            /**
             FRAlertController *alertController = [FRAlertController alertControllerWithTitle:@"美食" message:nil preferredStyle:FRAlertControllerStyleAlert];
             [alertController addPickerViewWithPickerArray:pickArray pickerButtonColor:[self randomColor] style:FRAlertActionStyleColor configurationHandler:^(NSIndexPath * _Nonnull indexpath) {
             NSArray *sectionArray = pickArray[indexPath.section];
             NSLog(@"%@",sectionArray[indexPath.row]);
             }];
             [alertController show];
             */
            
            /**  建议使用  */
            [FRAlertController showPickerViewWithTitle:@"美食" message:nil preferredStyle:FRAlertControllerStyleAlert pickerArray:pickArray pickerButtonColor:[self randomColor]cancleTitle:@"取消" makeSureTitle:@"确定" pickerViewStyle:FRAlertActionStyleColor configurationHandler:^(NSArray<NSIndexPath *> * _Nonnull indexPathArray) {
                for (NSIndexPath *indexPath in indexPathArray) {
                    NSArray *sectionArray = pickArray[indexPath.section];
                    NSLog(@"%@",sectionArray[indexPath.row]);
                }
            }];
        }
            break;
        case 7: {
            FRArrayAlertController *alertController = [FRArrayAlertController alertControllerWithTitle:@"数组选择" message:@"自定义数组选择控件，点击对应的数据可以实现数组选择，数据设置方法及点击方法通过代理实现，和tableView设置方法相似" preferredStyle:FRAlertControllerStyleActionSheet];
            alertController.dataSource = self;
            alertController.delegate = self;
            [alertController show];
        }
            
        default:
            break;
    }
}


#pragma mark - FRArrayAlertController dataSource
- (CGFloat)arrayAlertScrollViewHeight {
    return self.alertArray.count * 44;
}

- (NSInteger)arrayAlertView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.alertArray.count;
}

- (UITableViewCell *)arrayAlertView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"tableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *alertType = self.alertArray[indexPath.row];
    cell.textLabel.text = alertType;
    
    return cell;
}

#pragma mark - FRArrayAlertController delegate
- (void)arrayAlertView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了section:%ld, row:%ld",indexPath.section,indexPath.row);
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(0);
        }];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)alertArray {
    if (!_alertArray) {
        _alertArray = @[@"系统样式",@"FRActionSheet",@"仅标题的FRActionSheet",@"仅描述的FRActionSheet",@"多按钮的FRActionSheet",@"密码样式FRActionSheet",@"pickView样式FRActionSheet",@"数组选择样式FRActionSheet"];
    }
    return _alertArray;
}


- (UIColor *)randomColor {
    NSInteger red = arc4random() % 256;
    NSInteger green = arc4random() % 256;
    NSInteger block = arc4random() % 256;
    return FRUIColor_RGB(red, green, block, 1);
}

@end
