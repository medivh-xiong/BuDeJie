//
//  BRTopicCell.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/19.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRTopicCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+BRCategory.h"


@interface BRTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;

@property (weak, nonatomic) IBOutlet UIButton *caiBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end


@implementation BRTopicCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}



- (void)setTopicModel:(BRTopicModel *)topicModel
{
    // ----1.设置公有的头部内容
    _topicModel         = topicModel;

    _myTextLabel.text   = _topicModel.text;

    _nameLabel.text     = _topicModel.name;

    _passtimeLabel.text = _topicModel.passtime;
    
    
    // ----设定用户圆形头像
    UIImage *placeHolderImage = [UIImage imageWithCircle:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.profileImageView.image = placeHolderImage;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:placeHolderImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        if (!image) return;
        
        self.profileImageView.image = [UIImage imageWithCircle:image];
        
    }];
   
    
    // ----2.设置公有的底部内容
    [self setBotterBtnTitle:_dingBtn number:_topicModel.ding placeholder:@"顶"];
    
    [self setBotterBtnTitle:_caiBtn number:_topicModel.cai placeholder:@"踩"];
    
    [self setBotterBtnTitle:_shareBtn number:_topicModel.repost placeholder:@"分享"];
    
    [self setBotterBtnTitle:_commentBtn number:_topicModel.comment placeholder:@"评论"];
    
}



/*!
 *  @author 熊欣, 16-10-19 17:10:28
 *
 *  @brief 设置公有底部btn的内容
 *
 *  @param btn    传过来的btn
 *  @param number 数量
 *  @param title  占位文字
 */
- (void)setBotterBtnTitle:(UIButton *)btn number:(NSInteger)number placeholder:(NSString *)title
{
    if (number > 1000) {
        [btn setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0) {
        [btn setTitle:[NSString stringWithFormat:@"%li", number] forState:UIControlStateNormal];
    }else {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}



- (void)setFrame:(CGRect)frame
{
    frame.size.height -= BRMargin;
    
    [super setFrame:frame];
}


@end
