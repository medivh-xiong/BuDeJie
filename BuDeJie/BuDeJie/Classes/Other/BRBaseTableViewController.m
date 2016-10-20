//
//  BRBaseTableViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/10.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRBaseTableViewController.h"

@interface BRBaseTableViewController ()

@end

@implementation BRBaseTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset          = UIEdgeInsetsMake(BRTopBarHeight + 35, 0, BRTabBarHeight, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundColor       = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


@end
