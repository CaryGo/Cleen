//
//  MainCell.h
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import "BaseTableViewCell.h"

#import "Data.h"
#import "JSAttributeLabel.h"

//屏幕的高度
#define SCREEN_H ([[UIScreen mainScreen] bounds].size.height)
//屏幕宽度
#define SCREEN_W ([[UIScreen mainScreen] bounds].size.width)
//间距  用于约束
#define DEFAULT_PADDING 10
#define CONTENT_PADDING 5
#define CONTENT_SIZE 14
#define IMAGE_MAX_WIDTH 120
#define TITLE_WIDTH (SCREEN_W - 2 * DEFAULT_PADDING)
#define DESC_WIDTH (SCREEN_W - 3*DEFAULT_PADDING - IMAGE_MAX_WIDTH)

@interface MainCell : BaseTableViewCell

typedef void(^ImageLoadSuccess) (UIImage * image);

/**
 图片下载成功回调
 */
@property(nonatomic, weak)ImageLoadSuccess imageBlock;

/**
 rowData
 */
@property(nonatomic, strong)RowType *row;

/**
 计算cell高度

 @param row data
 @return height
 */
+ (CGFloat)cellHeightWithModel:(RowType *)row;

@end
