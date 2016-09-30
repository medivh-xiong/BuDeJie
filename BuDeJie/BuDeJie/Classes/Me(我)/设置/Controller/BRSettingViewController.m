//
//  BRSettingViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/14.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRSettingViewController.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
#import "BRFileTools.h"


@interface BRSettingViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@property (nonatomic, readwrite, assign) NSUInteger fileSize;

@end


@implementation BRSettingViewController


+ (void)load
{
    UITableViewCell *cell = [UITableViewCell appearanceWhenContainedIn:self, nil];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.2f];
    
    [SVProgressHUD setCornerRadius:8];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存数据,请稍后"];

    [BRFileTools getCacheSize:BRCachePath compleion:^(NSUInteger size) {
       
        [SVProgressHUD dismiss];
        
        _fileSize = size;
        
        // ----设置缓存label的信息
        [self setCacheLabelInfo];
        
    }];
}



- (void)setCacheLabelInfo
{
    NSString *cacheStr = [BRFileTools getCacheSizeStr:_fileSize];
    
    if ([cacheStr isEqualToString:@""]) {
        self.cacheLabel.text = @"清除缓存";
    }else {
       self.cacheLabel.text  = [NSString stringWithFormat:@"清除缓存:(已使用%@)", cacheStr];
    }
    
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
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        [SVProgressHUD showWithStatus:@"正在清除缓存，请稍后。。。"];
       
        [BRFileTools removeCacheAtDirectory:BRCachePath compleion:^{
            
            // ----清空数据
            _fileSize = 0;
            
            [self setCacheLabelInfo];
            
           [SVProgressHUD showSuccessWithStatus:@"清除缓存成功"];
            
        }];
        
    }
}



@end
