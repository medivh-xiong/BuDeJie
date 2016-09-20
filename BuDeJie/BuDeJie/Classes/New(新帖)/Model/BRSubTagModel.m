//
//  BRSubTagModel.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/20.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRSubTagModel.h"

@implementation BRSubTagModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"image_list = %@, theme_name = %@, sub_number = %ld", self.image_list, self.theme_name, (long)self.sub_number];
}

@end
