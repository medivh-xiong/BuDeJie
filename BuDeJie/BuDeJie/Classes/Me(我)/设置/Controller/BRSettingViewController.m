//
//  BRSettingViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/14.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRSettingViewController.h"


@interface BRSettingViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end


@implementation BRSettingViewController


+ (void)load
{
    UITableViewCell *cell = [UITableViewCell appearance];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}



#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = ({
        
        UILabel *titleLabel  = [[UILabel alloc] init];

        titleLabel.frame     = CGRectMake(16, 0, BRSCREEN_WIDTH, 44);

        titleLabel.font      = [UIFont systemFontOfSize:13.0f];

        titleLabel.textColor = [UIColor darkGrayColor];
        
        titleLabel;
    
    });
    
    
    UIView *contentView = ({
    
        UIView *contentView = [[UIView alloc] init];
        
        contentView.frame = CGRectZero;
        
        [contentView addSubview:titleLabel];
        
        contentView;
    
    });
        
    
    switch (section) {
        case 0:
            titleLabel.text = @"功能设置";
            break;
        case 1:
            titleLabel.text = @"其他";
            break;
        default:
            break;
    }
    
    
    return contentView;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
