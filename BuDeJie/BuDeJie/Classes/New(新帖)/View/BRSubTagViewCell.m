//
//  BRSubTagViewCell.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/20.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRSubTagViewCell.h"
#import "BRSubTagModel.h"
#import "UIImageView+WebCache.h"

@interface BRSubTagViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *userCount;

@end


@implementation BRSubTagViewCell



- (void)setItem:(BRSubTagModel *)item
{
    _item               = item;

    self.title.text     = _item.theme_name;

    CGFloat num         = [self calculateNumber: _item.sub_number];

    self.userCount.text = [NSString stringWithFormat:@"%.1f万人订阅", num];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}



/** 以万人为单位做转换*/
- (CGFloat)calculateNumber:(NSInteger)number
{
    CGFloat num = number * 1.0 / 10000;
    
    return num;
}

@end

