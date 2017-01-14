//
//  Data.m
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import "Data.h"

@implementation Data

@end

@implementation RowType

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc"  : @"description"};
}

@end
