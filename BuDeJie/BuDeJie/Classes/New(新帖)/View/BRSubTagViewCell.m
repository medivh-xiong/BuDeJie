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
#import "UIImage+BRCategory.h"

@interface BRSubTagViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *userCount;

@end


@implementation BRSubTagViewCell



- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    
    [super setFrame:frame];
}



//- (void)awakeFromNib
//{
////    /** iOS9之后设置imageView的圆角属性不会影响性能！！！*/
////    self.iconImageView.layer.cornerRadius  = 4.0f;
////
////    self.iconImageView.layer.masksToBounds = YES;
//    
////    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
////        
////        [self setLayoutMargins:UIEdgeInsetsZero];
////    }
//}



- (void)setItem:(BRSubTagModel *)item
{
    _item               = item;

    
    // ----设置标签名字
    self.title.text     = _item.theme_name;
    
    
    // ----设置标签的订阅人数
    [self setTagUserCount];
    

    // ----设置标签的图片
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.iconImageView.image = [UIImage imageWithCornerRadius:8.0 image:image];
        
    } ];
    
}



- (void)setTagUserCount
{
    if (_item.sub_number >= 10000) {
        
        CGFloat num         = _item.sub_number * 1.0 / 10000;

        NSString *numstr    = [NSString stringWithFormat:@"%.1f万人订阅", num];

        // ----替换掉整数万的.0
        numstr              = [numstr stringByReplacingOccurrencesOfString:@".0" withString:@""];

        self.userCount.text = numstr;
        
    }else {
        self.userCount.text = [NSString stringWithFormat:@"%li人订阅", _item.sub_number];
    }
}

@end

