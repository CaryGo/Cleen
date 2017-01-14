//
//  UIImage+JSAdditions.h
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JSAdditions)

/**
 颜色生成图片

 @param color color
 @param size size
 @return imageObject
 */
+ (UIImage*)createImageWithColor:(UIColor *)color
                            size:(CGSize)size;

/**
 *  压缩图片
 *
 *  @param sourceImage image对象
 *  @param defineWidth 将图片压缩后图片的宽度，高度自动计算
 *
 *  @return image对象
 */
+ (UIImage *) imageCompressWithSourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
