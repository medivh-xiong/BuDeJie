//
//  BRSubTagViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/19.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRSubTagViewController.h"
#import "BRNetTools.h"
#import "BRSubTagModel.h"
#import "YYModel.h"
#import "BRSubTagViewCell.h"
#import "SVProgressHUD.h"



@interface BRSubTagViewController ()

/** 模型数组*/
@property (nonatomic, readwrite, strong) NSArray *modelArray;

@end


static NSString * const cellID = @"BRSubTagCell";


@implementation BRSubTagViewController


#pragma mark - 懒加载
- (NSArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}



#pragma mark - 视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** 初始设定*/
    [self baseSetting];
    
    /** 加载数据*/
    [self loadTagData];
    
}


#pragma mark - 视图将要消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];

     BRNetTools *sharedTools         = [BRNetTools sharedNetTools];
    
    [sharedTools.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}


#pragma mark - 对界面初始化设定
- (void)baseSetting
{
    /** 设定标题*/
    self.title = @"推荐标签";
    
    /** 注册自定义Cell*/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BRSubTagViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    /** 去掉表格横线的margin*/
    
    // ----方法1
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
    
    // ----方法2
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:221 / 255.0 alpha:1.0];
    
    // ----显示hud
    [SVProgressHUD showWithStatus:@"正在加载ing....."];
    
}



#pragma mark - 获取标签界面的数据
- (void)loadTagData
{
    BRNetTools *sharedTools         = [BRNetTools sharedNetTools];

    NSMutableDictionary *paramaters = ({
        
        NSMutableDictionary *paramaters = [NSMutableDictionary dictionary];
        
        paramaters[@"a"]                = @"tag_recommend";
        
        paramaters[@"action"]           = @"sub";
        
        paramaters[@"c"]                = @"topic";
    
        paramaters;
    });
    
    
    [sharedTools httpRequest:RequsetGET urlString:@"http://api.budejie.com/api/api_open.php" parameters:paramaters success:^(id responseObject) {
        
//        BRLog(@"%@", responseObject);
        
        [SVProgressHUD dismiss];
        
        self.modelArray = [NSArray yy_modelArrayWithClass:[BRSubTagModel class] json:responseObject];
        
//        BRLog(@"%@", self.modelArray);
        
        [self.tableView reloadData];
        
    } failue:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
        BRLog(@"%@", error);
    }];
    
}



#pragma mark - tableView的数据源和方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



#pragma mark - tableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRSubTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    BRSubTagModel *item    = self.modelArray[indexPath.row];

    cell.item              = item;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235 / 255.0 alpha:1.0];
    
    return  cell;
}






@end
