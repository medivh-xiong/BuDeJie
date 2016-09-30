//
//  BRAdViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/18.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRAdViewController.h"
#import "Advertisement_Header.h"

@interface BRAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *launchImage;

/** 广告视图的占位视图*/
@property (weak, nonatomic) IBOutlet UIView *adView;

/** 数据模型*/
@property (nonatomic, readwrite, strong) BRAdDataModel *dataModel;

/** 获得到的广告的图片*/
@property (nonatomic, readwrite, strong) UIImageView *adImageView;

/** 跳过Btn*/
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;

/** 定时器*/
@property (nonatomic, readwrite, weak) NSTimer *timer;

@end


@implementation BRAdViewController


#pragma mark - 懒加载
- (UIImageView *)adImageView
{
    if (!_adImageView) {
        
        _adImageView                        = [[UIImageView alloc] init];

        [self.adView addSubview:_adImageView];

        // ----添加手势事件
        UITapGestureRecognizer *tapGes      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd)];

        [_adImageView addGestureRecognizer:tapGes];

        _adImageView.userInteractionEnabled = YES;
    
    }
    
    return _adImageView;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----添加启动视图
    [self setLuanchImageView];
    
    
    // ----开启定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    

    // ----加载广告数据
    [self loadAdData];
    
}



#pragma mark - 添加启动界面图片
- (void)setLuanchImageView
{
    /** 根据屏幕不同设置相应的图片*/
    if (IS_IPHONE6P) {
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (IS_IPHONE6) {
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (IS_IPHONE5) {
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if (IS_IPHONE4) {
        self.launchImage.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
}



#pragma mark - 获得广告数据
- (void)loadAdData
{
    BRNetTools *tools = [BRNetTools sharedNetTools];
    
    tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSString *urlString = @"http://mobads.baidu.com/cpro/ui/mads.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"code2"] = Url_Parameters;
    
    
    [tools httpRequest:RequsetGET urlString:urlString parameters:parameters success:^(id responseObject) {
        
        NSDictionary *adInfo = (NSDictionary *)[responseObject[@"ad"] lastObject];

        self.dataModel       = [BRAdDataModel yy_modelWithDictionary:adInfo];
        
        
        // ----设置广告图片
        [self setAdvertisement:self.dataModel];
     
        
    } failue:^(NSError *error) {
        BRLog(@"error = %@",error);
    }];
}



/** 设置广告图片*/
- (void)setAdvertisement:(BRAdDataModel *)model
{
//    CGFloat height = BRSCREEN_WIDTH / model.w * model.h;
    
    self.adImageView.frame       = CGRectMake(0, 0, BRSCREEN_WIDTH, BRSCREEN_HEIGHT);

    self.adImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.w_picurl]];
}



#pragma mark - 点击广告的跳转事件
- (void)tapAd
{
    NSURL *url = [NSURL URLWithString:self.dataModel.ori_curl];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    if ([application canOpenURL:url]) {
        [application openURL:url];
    }
    
}



#pragma mark - 定时器事件
- (void)timeChange
{
    static NSInteger count = 5;
    
    count --;
    
    [self.skipBtn setTitle:[NSString stringWithFormat:@"跳过（%li）", count] forState:UIControlStateNormal];
    
    if (count == 0) {
        [self jumpAD:nil];
    }
}


#pragma mark - 点击跳过按钮事件
/** 跳过广告进入主界面*/
- (IBAction)jumpAD:(id)sender
{
    BRMainViewController *mainVC = [[BRMainViewController alloc] init];
   
    [UIApplication sharedApplication].statusBarHidden = NO;
    // ----这里要把定时器销毁
    [_timer invalidate];
    
    /** 这里置为空,是因为在timeChange方法里使用self调用了点击方法，导致没有释放掉*/
    _timer = nil;
    
    BRAPPLICATION.keyWindow.rootViewController = mainVC;
}




@end
