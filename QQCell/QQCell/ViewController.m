//
//  ViewController.m
//  QQCell
//
//  Created by MengZhiqi on 2017/8/3.
//  Copyright © 2017年 MengZhiqi. All rights reserved.
//

#import "ViewController.h"
#import "QQTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *dataSource;
    QQTableViewCell *qqCell;
    UITableView *tableview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNotificationbar];
    [self initData];
    [self initTableView];
}

- (void)setNotificationbar {
    self.title = @"QQ";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initData {
    dataSource = @[@"李一", @"李二", @"李三", @"李四"].mutableCopy;
}

- (void)initTableView {
    if (tableview == nil) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:tableview];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"QQCell";
    NSArray *nib = [[NSArray alloc] init];
    qqCell = [tableview dequeueReusableCellWithIdentifier:cellId];
    if (qqCell == nil) {
        nib = [[NSBundle mainBundle] loadNibNamed:@"QQTableViewCell" owner:nil options:nil];
    }
    qqCell = [nib objectAtIndex:0];
    qqCell.person.text = dataSource[indexPath.row];
    return qqCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *_Nonnull action, NSIndexPath *_Nonnull indexpath) {
            [dataSource removeObjectAtIndex:indexPath.row];
            [tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        UITableViewRowAction *cancelTopAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消置顶" handler:^(UITableViewRowAction *_Nonnull action, NSIndexPath *_Nonnull indexPath) {
            NSInteger arc = arc4random() % dataSource.count;
            [dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:arc];
            [tableview exchangeSubviewAtIndex:indexPath.row withSubviewAtIndex:arc];
            [tableview reloadData];
            [tableView reloadData];
        }];
        
        cancelTopAction.backgroundColor = [UIColor darkGrayColor];
        return @[editAction, cancelTopAction];
    } else {
        UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *_Nonnull action, NSIndexPath *_Nonnull indexpath){
            [dataSource removeObjectAtIndex:indexPath.row];
            [tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        UITableViewRowAction *topAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *_Nonnull action, NSIndexPath *_Nonnull indexPath){
            [dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [tableview exchangeSubviewAtIndex:indexPath.row withSubviewAtIndex:0];
            [tableview reloadData];
        }];
        
        topAction.backgroundColor = [UIColor darkGrayColor];
        return @[editAction, topAction];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleNone;
}

//补全分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

//补全分割线
- (void)viewDidLayoutSubviews {
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
