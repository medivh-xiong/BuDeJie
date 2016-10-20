//
//  BRAllTableViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/10.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRAllTableViewController.h"
#import "BRTopicModel.h"
#import "YYModel.h"
#import "SVProgressHUD.h"
#import "BRTopicCell.h"

@interface BRAllTableViewController ()

@property (nonatomic, readwrite, strong) NSMutableArray *modelArray;

/** 当前最后一条帖子的描述信息，用来加载下一页数据*/
@property (nonatomic, readwrite, strong) NSString *maxtime;

@end

@implementation BRAllTableViewController


static NSString * const topickCellID = @"topicCell";


#pragma mark - 懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // ----添加监听
    [self addRepeatClickNotification];

    
    // ----添加下拉刷新和上拉加载的控件
    [self addMJHeaderFooterView];
    
    
    // ----提前注册cell
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([BRTopicCell class]) bundle:nil];
    
    [self.tableView registerNib:cellNib forCellReuseIdentifier:topickCellID];
    
    
    // ----开始下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.rowHeight = 200;
    
}



#pragma mark - 添加按钮重复点击的监听
- (void)addRepeatClickNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick) name:BRTabBarBtnRepatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidRepeatClick) name:BRTitleBtnRepatClickNotification object:nil];
}



#pragma mark - 页面销毁时候摧毁监听
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRTabBarBtnRepatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRTitleBtnRepatClickNotification object:nil];
}


#pragma mark - 添加上拉加载和下拉刷新控件
- (void)addMJHeaderFooterView
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
            
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}



#pragma mark - 监听事件
- (void)tabBarBtnDidRepeatClick
{
    if (!self.view.window) return;
    
    if (!self.tableView.scrollsToTop) return;
    
    [self.tableView.mj_header beginRefreshing];
   
    BRFUNC
}



- (void)titleBtnDidRepeatClick
{
    [self tabBarBtnDidRepeatClick];
}



#pragma mark - tablieview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topickCellID];
    
    cell.topicModel   = self.modelArray[indexPath.row];
    
    return cell;
}



#pragma mark - 加载数据
- (void)refreshData
{
    // ----拼接参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"a"]                = @"list";
    dic[@"c"]                = @"data";
    dic[@"type"]             = @"1";
   
    BRNetTools *tools        = [BRNetTools sharedNetTools];
    
    [tools httpRequest:RequsetGET urlString:BRBaseUrl parameters:dic success:^(id responseObject) {
       
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *arr = [NSArray yy_modelArrayWithClass:[BRTopicModel class] json:responseObject[@"list"]];
        
        self.modelArray = [NSMutableArray arrayWithArray:arr];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failue:^(NSError *error) {
        
        BRLog(@"%@", error);
        
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
	
}



- (void)loadMoreData
{
    // ----拼接参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"a"]                = @"list";
    dic[@"c"]                = @"data";
    dic[@"type"]             = @"1";
    dic[@"maxtime"]          = self.maxtime;
    
    BRNetTools *tools        = [BRNetTools sharedNetTools];
    
    [tools httpRequest:RequsetGET urlString:BRBaseUrl parameters:dic success:^(id responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *arr = [NSArray yy_modelArrayWithClass:[BRTopicModel class] json:responseObject[@"list"]];
        
        [self.modelArray addObjectsFromArray:arr];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failue:^(NSError *error) {
        
        BRLog(@"%@", error);
        
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


@end
