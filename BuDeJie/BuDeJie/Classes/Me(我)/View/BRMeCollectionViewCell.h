//
//  BRMeCollectionViewCell.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/28.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRMeSquareListModel.h"

@interface BRMeCollectionViewCell : UICollectionViewCell

@property (nonatomic, readwrite, strong) BRMeSquareListModel *model;

@end
