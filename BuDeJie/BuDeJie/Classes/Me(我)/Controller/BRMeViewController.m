//
//  BRMeViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRMeViewController.h"
#import "BRMeHeader.h"
#import "BRWebViewController.h"


@interface BRMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, readwrite, strong) BRMeSquareListModel *model;

@property (nonatomic, readwrite, strong) NSArray *dataArray;

@property (nonatomic, readwrite, weak) UICollectionView *collectionV;

@end


@implementation BRMeViewController


#pragma mark - 懒加载
- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // ----设置导航栏的样式
    [self setNavBarItem];
    
    
    // ----设置tableview的footview
    [self setUpFooterView];
    
    
    // ----获取数据
    [self loadData];
    
    
    // ----因为分组的cell默认第一个距离顶部35，因此需要把表格整体往上移
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}



#pragma mark - 设置导航栏的样式
- (void)setNavBarItem
{
    /** 设置右边items*/
    UIBarButtonItem *settingItem            = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];

    UIBarButtonItem *nightItem              = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImg:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];


    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];

    /** 设置中间titleview*/
    self.navigationItem.title               = @"我的";
    
}



#pragma mark - 导航栏按钮的事件
/** 设置按钮的事件*/
- (void)setting
{
    UIStoryboard *setStroyboard = [UIStoryboard storyboardWithName:NSStringFromClass([BRSettingViewController class]) bundle:nil];
    
    
    BRSettingViewController *settingVC = [setStroyboard instantiateInitialViewController];

    settingVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVC animated:YES];
}



/** 切换夜间模式*/
- (void)night:(UIButton *)nightBtn
{
    nightBtn.selected = !nightBtn.selected;
    
    [self changeNight:nightBtn.selected];
}



#pragma mark - 设置footview
- (void)setUpFooterView
{
    // ----设置collectionView的流水布局
    UICollectionViewFlowLayout *flowLayout = ({
    
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

        CGFloat cellWH                         = CellWH;

        flowLayout.itemSize                    = CGSizeMake(cellWH, cellWH);

        flowLayout.minimumInteritemSpacing     = margin;

        flowLayout.minimumLineSpacing          = margin;
        
        flowLayout;
        
    });
    
    // ----设定collectionView
    UICollectionView *collecitonV = ({
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];

        collection.dataSource        = self;
        collection.delegate          = self;

        [collection registerNib:[UINib nibWithNibName:NSStringFromClass([BRMeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];

        collection.scrollEnabled     = NO;

        collection.backgroundColor   = self.tableView.backgroundColor;
        
        collection;
    
    });
    
    // ----设定tablieview的footview
    self.collectionV               = collecitonV;

    self.tableView.tableFooterView = collecitonV;
    
}



#pragma mark - collecionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BRMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    cell.model                   = self.dataArray[indexPath.row];
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BRMeSquareListModel *model = self.dataArray[indexPath.row];

    if (![model.url containsString:@"http"]) return;


    BRWebViewController *webVC = [[BRWebViewController alloc] init];

    webVC.url                  = model.url;
    
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - 获取数据
- (void)loadData
{
    BRNetTools *tool            = [BRNetTools sharedNetTools];

    // ----拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"a"]                = @"square";
    params[@"c"]                = @"topic";
    
    [tool httpRequest:RequsetGET urlString:BRME_URL parameters:params success:^(id responseObject) {
        
//        BRLog(@"%@", responseObject);
        
        NSArray *dictArray = responseObject[@"square_list"];

        self.dataArray     = [NSArray yy_modelArrayWithClass:[BRMeSquareListModel class] json:dictArray];
        
        // ----处理数据
        [self resloveData];
   
        // ----刷新数据
        [self.collectionV reloadData];
        
    } failue:^(NSError *error) {
        BRLog(@"%@", error);
    }];
    
    
}



- (void)resloveData
{
    // ----去掉重复的数据
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:self.dataArray];
    
    for (NSInteger i = 0; i < mutArray.count; i++) {
        
        BRMeSquareListModel *firstMode = mutArray[i];
        
        for (NSInteger j = i + 1; j < mutArray.count; j++) {
           
             BRMeSquareListModel *secondModel = mutArray[j];
            
            if ([firstMode.name isEqualToString:secondModel.name]) {
                [mutArray removeObject:secondModel];
            }
            
        }
        
    }
    
    self.dataArray = mutArray;
    
    // ----1.重新设置collectionView的高度
    NSInteger rows                 = (self.dataArray.count - 1) / col + 1;

    CGFloat height                 = rows * CellWH;

    self.collectionV.height        = height;

    self.tableView.tableFooterView = self.collectionV;


    // ----添加空白cell，为了美观
    NSInteger count                = self.dataArray.count % col;

    NSInteger exter                = col - count;
    
    NSMutableArray *tempArray      = [NSMutableArray arrayWithArray:self.dataArray];
    
    
    for (NSInteger i = 0; i < exter; i++) {
        
        BRMeSquareListModel *model = [[BRMeSquareListModel alloc] init];
        
        [tempArray addObject:model];
    }
    
    self.dataArray                 = tempArray;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 处理夜间模式
- (void)changeNight:(BOOL)night
{
//    UINavigationBar *bar   = [UINavigationBar appearance];
//
//    UITableViewCell *cell  = [UITableViewCell appearance];
//    
//    if (night) {
//        
//        [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundBlack"] forBarMetrics:UIBarMetricsDefault];
//        
//        cell.backgroundColor = [UIColor darkGrayColor];
//        
//        cell.tintColor      = [UIColor whiteColor];
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        
//        
//    }else {
//        [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    }
//    
//    
//    UIWindow* window = [UIApplication sharedApplication].keyWindow;
//    for (UIView* view in window.subviews) {
//        [view removeFromSuperview];
//        [window addSubview:view];
//    }
//    [window makeKeyWindow];
    
}



@end
