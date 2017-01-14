//
//  Data.h
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

/**
 json数据建模
 */
@interface Data : NSObject

//标题  navigationBar的标题
@property(nonatomic, copy)NSString *title;

//数据集合 列表数据
@property(nonatomic, strong)NSArray *rows;


@end

/**
 行数据
 */
@interface RowType : NSObject

//行标题
@property(nonatomic, copy)NSString *title;
//描述信息
@property(nonatomic, copy)NSString *desc;
//图片信息 (url)
@property(nonatomic, copy)NSString *imageHref;

@end
