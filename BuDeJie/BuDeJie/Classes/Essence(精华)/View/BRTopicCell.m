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
#import "BRTopicPersonModel.h"
#import "BRTopicCommentModel.h"
#import "BRTopicModel.h"
#import "BRTopicVideoView.h"
#import "BRTopicImageView.h"
#import "UILabel+BRCategory.h"


@interface BRTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;

@property (weak, nonatomic) IBOutlet UIButton *caiBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/** 最热评论的View*/
@property (weak, nonatomic) IBOutlet UIView *commentView;

/** 最热评论距离bottomView的底部的约束，用来控制当没有最热评论的时候，让bottomView距离底部距离变短*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewTop;

/** 热门评论界面的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentH;

/** 中间videoView*/
@property (nonatomic, readwrite, strong) BRTopicVideoView *topicVideo;

/** 中间图片View*/
@property (nonatomic, readwrite, strong) BRTopicImageView *topicImage;


@end


@implementation BRTopicCell


#pragma mark - 懒加载
- (BRTopicVideoView *)topicVideo
{
    if (!_topicVideo) {
        
        _topicVideo = [BRTopicVideoView viewWithNib];
        
        [self.contentView addSubview:_topicVideo];
    }
   
    return _topicVideo;
    
}



- (BRTopicImageView *)topicImage
{
    if (!_topicImage) {
        
        _topicImage = [BRTopicImageView viewWithNib];
        
        [self.contentView addSubview:_topicImage];
    }
    
    return _topicImage;
    
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}



- (void)setTopicModel:(BRTopicModel *)topicModel
{
    _topicModel         = topicModel;
    
    // ----1.设置公有的头部内容
    BRTopicPersonModel *personModel = _topicModel.u;
    
    [_myTextLabel setText:_topicModel.text lineSpacing:3.5];

    _nameLabel.text     = personModel.name;

    _passtimeLabel.text = _topicModel.passtime;
    
    
    // ----设定用户圆形头像
    [_profileImageView BRSetHeaderImage:[personModel.header firstObject] placeHolder:[UIImage imageNamed:@"defaultUserIcon"]];
   
    
    // ----2.设置公有的底部内容
    [self setBotterBtnTitle:_dingBtn number:_topicModel.up placeholder:@"顶"];
    
    [self setBotterBtnTitle:_caiBtn number:_topicModel.down placeholder:@"踩"];
    
    [self setBotterBtnTitle:_shareBtn number:_topicModel.forward placeholder:@"分享"];
    
    [self setBotterBtnTitle:_commentBtn number:_topicModel.comment placeholder:@"评论"];
    
    
    // ----3.添加中间部分的view
    if ([_topicModel.type isEqualToString:@"video"]) {
        
        self.topicVideo.hidden = NO;

        self.topicImage.hidden = YES;
        
        self.topicVideo.videoModel = _topicModel.video;

    }else if ([_topicModel.type isEqualToString:@"image"] ) {
        
        self.topicVideo.hidden = YES;
        
        self.topicImage.hidden = NO;
        
    }else if ([_topicModel.type isEqualToString:@"gif"]) {
       
        self.topicVideo.hidden = YES;
        
        self.topicImage.hidden = NO;
        
    }else {
        
        self.topicVideo.hidden = YES;
        
        self.topicImage.hidden = YES;
    }
    
    
    
//    // ----3.设置最热评论
//    
//    // ----3.0 先清除之前设定的label
//    for (UIView *subView in _commentView.subviews) {
//        [subView removeFromSuperview];
//    }
//    
//    // ----3.1 如果没有热门评论，则设置botoomView距离底部为10，这样就是去掉热门评论距离bottomView的约束
//    if (!_topicModel.top_comments || _topicModel.top_comments.count == 0) {
//        
        _commentViewTop.constant = 0;
//
//        _commentH.constant       = 0;
//        
//        return;
//    }
//    
//    // ----3.2.2 添加热门评论label
//    [self setCommentLabel];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_topicModel.type isEqualToString:@"video"]) {
        _topicVideo.frame = _topicModel.middleViewFrame;
    }else if ([_topicModel.type isEqualToString:@"gif"] || [_topicModel.type isEqualToString:@"image"]) {
        _topicImage.frame = _topicModel.middleViewFrame;
    }
    
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
    if (number > 10000) {
        [btn setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0) {
        [btn setTitle:[NSString stringWithFormat:@"%li", number] forState:UIControlStateNormal];
    }else {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}



- (void)setFrame:(CGRect)frame
{
    frame.origin.y    += BRMargin;
    
    frame.size.height -= BRMargin;
    
    [super setFrame:frame];
}



/** 添加热门评论label*/
- (void)setCommentLabel
{
    NSMutableArray *mutArray = [NSMutableArray array];
    
    
    // ----3.2 开始设置热门评论界面
    for (NSInteger i = 0; i < _topicModel.top_comments.count; i++) {
        
        BRTopicCommentModel *model = _topicModel.top_comments[i];
        
        CGFloat contentSizeH       = model.contentHeight;
        
        [mutArray addObject:[NSNumber numberWithFloat:contentSizeH]];
        
        
        // ----有多少评论就设置多少几个label
        UILabel *label = [[UILabel alloc] init];
        
        label.numberOfLines = 0;
        
        label.font = [UIFont systemFontOfSize:14.0];
        
        [self. commentView addSubview:label];
        
        
        // ----设置label的frame
        CGFloat preOrginY = BRMargin;
        
        for (NSInteger j = 1; j < mutArray.count; j++) {
            
            preOrginY += ([mutArray[j - 1] floatValue] + BRMargin);
        }
        
        label.frame = CGRectMake(BRMargin, preOrginY, BRSCREEN_WIDTH - 3 * BRMargin, contentSizeH);
        
        
        // ----设置热门评论view的高度
        if (i == _topicModel.top_comments.count - 1) {
            _commentH.constant = preOrginY + contentSizeH + 10;
        }
        
        
        // ----设置文字内容
        [self setLabelContent:label content:model];
    }

}
                               


/** 设置热门评论的显示的内容*/
- (void)setLabelContent:(UILabel *)label content:(BRTopicCommentModel *)model
{
    NSString *contentText = [NSString stringWithFormat:@"%@: %@", model.u.name, model.content];
    
    label.text = contentText;
}


@end
