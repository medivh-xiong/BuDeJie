//
//  BRVideoTableViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/10.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRVideoTableViewController.h"

@interface BRVideoTableViewController ()

@end

@implementation BRVideoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick) name:BRTabBarBtnRepatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidRepeatClick) name:BRTitleBtnRepatClickNotification object:nil];
    
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRTabBarBtnRepatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRTitleBtnRepatClickNotification object:nil];
}



- (void)tabBarBtnDidRepeatClick
{
    if (!self.view.window) return;
    
    if (!self.tableView.scrollsToTop) return;
    
    BRFUNC
}



- (void)titleBtnDidRepeatClick
{
    [self tabBarBtnDidRepeatClick];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.textLabel.text = @"234";
        
        cell.backgroundColor = [UIColor blueColor];
        
    }
    
    
    return cell;
}


@end
