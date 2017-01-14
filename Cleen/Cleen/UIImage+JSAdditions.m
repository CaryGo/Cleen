//
//  UIImage+JSAdditions.m
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import "UIImage+JSAdditions.h"

@implementation UIImage (JSAdditions)

+ (UIImage*)createImageWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *) imageCompressWithSourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    NSData * data = UIImageJPEGRepresentation(newImage,0.8);
    //    UIImage * image = [[UIImage alloc] initWithData:data];
    //    data = UIImageJPEGRepresentation(newImage,1.0);
    return newImage;
}

@end
