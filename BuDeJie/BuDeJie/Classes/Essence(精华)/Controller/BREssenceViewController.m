//
//  BREssenceViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//  精华控制器

#import "BREssenceViewController.h"
#import "BREssence_Header.h"


@interface BREssenceViewController()

/** 标题栏*/
@property (nonatomic, readwrite, weak) UIView   *titleView;

/** 标题栏被选中的btn*/
@property (nonatomic, readwrite, weak) UIButton *selectedBtn;

@property (nonatomic, readwrite, weak) UIView   *lineView;

@end


@implementation BREssenceViewController


#pragma mark - 设置UI
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----1.设置导航栏的样式
    [self setNavBarItem];
    
    
    // ----2.添加内容滚动视图
    [self setContentView];
    
    
    // ----3.添加标题栏视图
    [self setTitleView];
    
    
    // ----4.添加子控制器
    [self addChildViewControllers];
    
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
        
        UIScrollView *contentView   = [[UIScrollView alloc] init];
        
        contentView.frame           = self.view.bounds;
        
        contentView.backgroundColor = [UIColor greenColor];
        
        contentView;
    });
    
    [self.view addSubview:contentView];
    
    
    /** 添加子控制器的view*/
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIView *childView = self.childViewControllers[i].view;
        
        [contentView addSubview:childView];
    }
    
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



- (void)addChildViewControllers
{
    [self addChildViewController:[[BRAllTableViewController alloc] init]];
    
    [self addChildViewController:[[BRVideoTableViewController alloc] init]];
    
    [self addChildViewController:[[BRPhotoTableViewController alloc] init]];
    
    [self addChildViewController:[[BRJokeTableViewController alloc] init]];
    
    [self addChildViewController:[[BRSoundTableViewController alloc] init]];
    
}



/** 添加标题栏的按钮*/
- (void)addTitleViewBtn
{
    NSArray *textArray = @[@"全部", @"视频", @"图片", @"段子", @"声音"];
    
    CGFloat btnW       = BRSCREEN_WIDTH / titleBtnCount;
    
    for (NSUInteger i = 0; i < titleBtnCount; i++) {
        
        UIButton *btn = ({
            
            UIButton *btn       = [UIButton buttonWithType:UIButtonTypeCustom];

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



#pragma mark - 监听点击事件
- (void)touchu
{
  
}



- (void)random
{
  
}



- (void)titleBtnClick:(UIButton *)titleBtn
{
    /** 设置btn点击后的状态属性*/
    [self setTitleBtnState:titleBtn];
    
    CGFloat lineW = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:titleBtn.titleLabel.font}].width;
    
    
    // ----设置横线的动画效果
    [UIView animateWithDuration:0.25f animations:^{
        
        self.lineView.width   = lineW + 15;
        
        self.lineView.centerX = titleBtn.centerX - 1.5f;
        
    }];
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





@end
