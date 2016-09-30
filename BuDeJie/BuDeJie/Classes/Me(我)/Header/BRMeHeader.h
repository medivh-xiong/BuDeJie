//
//  BRMeHeader.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/28.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#ifndef BRMeHeader_h
#define BRMeHeader_h

#import "UIBarButtonItem+BRBarButtonItem.h"
#import "BRSettingViewController.h"
#import "BRMeCollectionViewCell.h"
#import "BRNetTools.h"
#import "BRMeSquareListModel.h"
#import "YYModel.h"


#define BRME_URL @"http://api.budejie.com/api/api_open.php"


/** cell的id*/
static NSString * const cellID = @"BRMeCell";

/** collocationView几列*/
static NSInteger  const col    = 4;

/** collocationViewCell的间距*/
static CGFloat    const margin = 0.5;

/** collectionView的Cell的宽高*/
#define CellWH    (BRSCREEN_WIDTH - (col - 1)) / (col)


#endif /* BRMeHeader_h */
