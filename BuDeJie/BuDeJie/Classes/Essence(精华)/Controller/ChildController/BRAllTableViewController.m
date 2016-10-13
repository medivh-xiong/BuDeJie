//
//  BRAllTableViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/10.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRAllTableViewController.h"

@interface BRAllTableViewController ()

@end

@implementation BRAllTableViewController

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



#pragma mark - Table view data source

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
        
        cell.textLabel.text = @"123";
        
        cell.backgroundColor = [UIColor grayColor];
        
        cell.detailTextLabel.text = @"234";
        
    }
    

    
    return cell;
}



@end
