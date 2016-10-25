//
//  BRTopicModel.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/17.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRTopicModel.h"
#import "BRTopicCommentModel.h"
#import "NSObject+YYModel.h"
#import "UILabel+BRCategory.h"


@implementation BRTopicModel


- (NSString *)description
{
    return [self yy_modelDescription];
}


+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"top_comments": [BRTopicCommentModel class]
             };
}


- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    
    // ----计算行高->cell的公有的顶部高度+公有底部高度+间距+文字label的高度+其他分支模块的高度+cell减去的边距的高度
    
    // ----1.先加上公有的head的高度和间距
    _cellHeight += 55 + BRMargin * 0.5;
    
    
    // ----2.计算文字的内容和上下的边距，然后加上
    CGFloat textMaxWidth = BRSCREEN_WIDTH - 2 * BRMargin;
    
    /** 这个方法是计算文字的高度  字体大小在cell的xib中设置的，不能乱写*/
//    CGFloat textHeight  = [self.text boundingRectWithSize:CGSizeMake(textMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size.height;
    
    CGFloat textHeight = [UILabel text:self.text heightWithFontSize:17 width:textMaxWidth lineSpacing:3.5f];
    
    
    _cellHeight += (textHeight + BRMargin);
    
    // ----4 加上中间view的高度
    // ----4.1 如果帖子类型不是文字类型才需要计算
    if (![self.type isEqualToString:@"text"]) {
        
        // ----4.2 取出对应的模型里的高度和宽度
        CGFloat width  = 0;
        CGFloat height = 0;
        
        
        if ([self.type isEqualToString:@"video"]) {
            width  = self.video.width;
            height = self.video.height;
        }else if ([self.type isEqualToString:@"gif"]) {
            width  = self.gif.width;
            height = self.gif.height;
        }else if ([self.type isEqualToString:@"image"]) {
            width  = self.image.width;
            height = self.image.height;
        }
        
        
        // ----4.3 图片和视频宽度和文字的宽度一样，然后计算缩放大小
        if (height == 0) {
            height = textMaxWidth;
        }
        
        CGFloat h = textMaxWidth * height / width;
        
        _middleViewFrame = CGRectMake(BRMargin, _cellHeight, textMaxWidth, h);

        _cellHeight      += (h + BRMargin);
        
    }
    
    
    // ----5.加上公有bottom的高度和之前CELL减去的高度
    _cellHeight += (35 + BRMargin);
    
    return _cellHeight;
}





@end
