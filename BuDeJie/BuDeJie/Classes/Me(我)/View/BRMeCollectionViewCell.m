//
//  BRMeCollectionViewCell.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/28.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRMeCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface BRMeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameText;

@end


@implementation BRMeCollectionViewCell


- (void)setModel:(BRMeSquareListModel *)model
{
    _model             = model;

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];

    self.nameText.text = model.name;
}


@end
