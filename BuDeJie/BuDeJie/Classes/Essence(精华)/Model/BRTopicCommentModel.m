//
//  BRTopicCommentModel.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/21.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRTopicCommentModel.h"

@implementation BRTopicCommentModel


- (CGFloat)contentHeight
{
    _contentHeight = [self.content boundingRectWithSize:CGSizeMake(BRSCREEN_WIDTH - 3 *BRMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
    
    return _contentHeight;
}


@end
