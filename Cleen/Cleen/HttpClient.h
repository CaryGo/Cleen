//
//  HttpClient.h
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径,只要在一定宏定义的 例如 GE_URL_Chats
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
