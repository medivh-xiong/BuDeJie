
//  BREssenceViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//  精华控制器

#import "BREssenceViewController.h"
#import "BREssence_Header.h"


@interface BREssenceViewController()<UIScrollViewDelegate>

/** 标题栏*/
@property (nonatomic, readwrite, weak) UIView   *titleView;

/** 标题栏被选中的btn*/
@property (nonatomic, readwrite, weak) UIButton *selectedBtn;

@property (nonatomic, readwrite, weak) UIView   *lineView;

/** 内容滚动视图*/
@property (nonatomic, readwrite, weak) UIScrollView *contentScrollView;

@end


@implementation BREssenceViewController


#pragma mark - 设置UI
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----0.添加子控制器
    [self addChildViewControllers];
    
    // ----1.设置导航栏的样式
    [self setNavBarItem];
    
    
    // ----2.添加内容滚动视图
    [self setContentView];
    
    
    // ----3.添加标题栏视图
    [self setTitleView];
    
    
    // ----添加全部界面View为第一个显示的View
    [self addChildViewToScrollView:0];
    
}



- (void)addChildViewControllers
{
    [self addChildViewController:[[BRAllTableViewController alloc] init]];
    
    [self addChildViewController:[[BRVideoTableViewController alloc] init]];
    
    [self addChildViewController:[[BRPhotoTableViewController alloc] init]];
    
    [self addChildViewController:[[BRJokeTableViewController alloc] init]];
    
    [self addChildViewController:[[BRSoundTableViewController alloc] init]];
    
}



- (void)setNavBarItem
{
    /** 设置左item*/
    UIBarButtonItem *leftButtonItem        = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(touchu)];
    
    self.navigationItem.leftBarButtonItem  = leftButtonItem;
    
    
    
    /** 设置右item*/
    UIBarButtonItem *randomBtnItem         = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = randomBtnItem;
    
    
    
    /** 设置中间titleview*/
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}



- (void)setContentView
{
    UIScrollView *contentView = ({
        
        UIScrollView *contentView                  = [[UIScrollView alloc] init];

        contentView.frame                          = self.view.bounds;

        contentView.showsVerticalScrollIndicator   = NO;

        contentView.showsHorizontalScrollIndicator = NO;
        
        contentView.pagingEnabled                  = YES;

        contentView.contentSize                    = CGSizeMake(titleBtnCount * contentView.width, 0);
        
        [self.view addSubview:contentView];
        
        contentView;
    });

    self.contentScrollView                    = contentView;

    self.contentScrollView.delegate           = self;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
}



- (void)setTitleView
{
    UIView *titleView = ({

        UIView *titleView         = [[UIView alloc] init];

        titleView.frame           = CGRectMake(0, BRTopBarHeight, BRSCREEN_WIDTH, titleViewH);

        titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        [self.view addSubview:titleView];
        
        titleView;
    });
    
    self.titleView = titleView;
    
    
    // ----添加按钮
    [self addTitleViewBtn];
    
    
    // ----添加下划线
    [self addBtnUnderLine];
    
}



/** 添加标题栏的按钮*/
- (void)addTitleViewBtn
{
    NSArray *textArray = @[@"全部", @"视频", @"图片", @"段子", @"声音"];
    
    CGFloat btnW       = BRSCREEN_WIDTH / titleBtnCount;
    
    for (NSUInteger i = 0; i < titleBtnCount; i++) {
        
        UIButton *btn = ({
            
            UIButton *btn       = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.tag             = i;

            btn.frame           = CGRectMake(i * btnW, 0, btnW, titleViewH);
            
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [btn setTitle:textArray[i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            
            [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            btn;
                             
        });
        
        [self.titleView addSubview:btn];
    
    }
    
}


/** 添加标题栏的横线*/
- (void)addBtnUnderLine
{
    UIButton *firstBtn = self.titleView.subviews.firstObject;
    
    /** 设置第一个btn默认是选中状态*/
    [self setTitleBtnState:firstBtn];
    
    
    // ----设置横线
    CGFloat lineViewY = titleViewH - btnLineHeight;
    
    CGFloat lineW = [firstBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:firstBtn.titleLabel.font}].width;

    UIView *lineView = ({
    
        UIView *lineView = [[UIView alloc] init];
        
        lineView.frame   = CGRectMake(0, lineViewY, lineW + 15, btnLineHeight);
        
        lineView.centerX = firstBtn.centerX;
        
        lineView.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
        
        [self.titleView addSubview:lineView];
        
        lineView;
    
    });
    
    self.lineView = lineView;
    
}



#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIButton *btn   = self.titleView.subviews[index];
    
    [self titleBtnClick:btn];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


#pragma mark - 监听点击事件
- (void)touchu
{
  
}



- (void)random
{
  
}



- (void)titleBtnClick:(UIButton *)titleBtn
{
    // ----如果是重复点击，就添加通知
    if (titleBtn == self.selectedBtn) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BRTitleBtnRepatClickNotification object:nil];
    }
    
    // ----设置btn点击后的状态属性
    [self setTitleBtnState:titleBtn];
    
    CGFloat lineW   = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:titleBtn.titleLabel.font}].width;
    
    NSInteger index = titleBtn.tag;
    
    // ----设置横线的动画效果
    [UIView animateWithDuration:0.25f animations:^{
        
        self.lineView.width   = lineW + 15;
        
        self.lineView.centerX = titleBtn.centerX - 1.5f;
        
        /** 滚动视图当前显示的View*/
        CGFloat scrollOffSetX = self.contentScrollView.width * titleBtn.tag;
        
        self.contentScrollView.contentOffset = CGPointMake(scrollOffSetX, self.contentScrollView.contentOffset.y);
        
    }completion:^(BOOL finished) {
        
        [self addChildViewToScrollView:index];
        
    }];
    
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIViewController *childVC = self.childViewControllers[i];
       
        if (![childVC isViewLoaded] ) continue;
        
        UIScrollView *scrollV = (UIScrollView *)childVC.view;
        
        if (![scrollV isKindOfClass:[UIScrollView class]]) continue;
        
        scrollV.scrollsToTop = (i == index);
        
    }
    
}


/** 设置标题栏按钮选中时候的样式*/
- (void)setTitleBtnState:(UIButton *)titleBtn
{
    self.selectedBtn.selected        = NO;
    
    self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:normalTitleFont];
    
    titleBtn.selected                = YES;
    
    titleBtn.titleLabel.font         = [UIFont boldSystemFontOfSize:selectedTitleFont];
    
    self.selectedBtn                 = titleBtn;
    
}



#pragma mark - 其他
- (void)addChildViewToScrollView:(NSInteger)index
{
    // ----添加子控制器的view
    UIView *childView = self.childViewControllers[index].view;
    
    if (childView.superview) return;
    
    
    /** 这里有2种写法*/
    childView.frame   = self.contentScrollView.bounds;
//    childView.frame   = CGRectMake(index * self.contentScrollView.width, 0, self.contentScrollView.width, self.contentScrollView.height);
    
    [self.contentScrollView addSubview:childView];
}


@end
