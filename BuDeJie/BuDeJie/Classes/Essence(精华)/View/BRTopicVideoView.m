//
//  BRTopicVideoView.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/24.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRTopicVideoView.h"


@interface BRTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end


@implementation BRTopicVideoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (void)setVideoModel:(BRVideoModel *)videoModel
{
    _videoModel = videoModel;
    
    _playCountLabel.text = [NSString stringWithFormat:@"%li播放", _videoModel.playcount];
    
    _playTimeLabel.text = [self timeFormatted:_videoModel.duration];
    
    [_bgImage BRSetOriginImage:[_videoModel.thumbnail firstObject] thumbnailImage:[_videoModel.thumbnail_small firstObject] placeHolder:nil];
    
}


@end
