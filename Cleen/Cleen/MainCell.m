//
//  MainCell.m
//  Cleen
//
//  Created by Cary on 2017/1/14.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import "MainCell.h"

#import "UIImage+JSAdditions.h"

@interface MainCell ()

@property(nonatomic, strong)JSAttributeLabel * titleL;

@property(nonatomic, strong)JSAttributeLabel * descL;

@property(nonatomic, strong)UIImageView *imgHref;

@end

@implementation MainCell

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[JSAttributeLabel alloc] initWithFrame:CGRectZero labelFont:[UIFont systemFontOfSize:CONTENT_SIZE] lineSpace:CONTENT_PADDING maxWidth:TITLE_WIDTH];
        _titleL.textColor = [UIColor blueColor];
    }
    return _titleL;
}
- (UILabel *)descL{
    if (!_descL) {
        _descL = [[JSAttributeLabel alloc] initWithFrame:CGRectZero labelFont:[UIFont systemFontOfSize:CONTENT_SIZE] lineSpace:CONTENT_PADDING maxWidth:DESC_WIDTH];
        _descL.textColor = [UIColor blackColor];
    }
    return _descL;
}
- (UIImageView *)imgHref{
    if (!_imgHref) {
        _imgHref = [[UIImageView alloc] init];
    }
    return _imgHref;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.descL];
        [self.contentView addSubview:self.imgHref];
    }
    return self;
}

- (void)setRow:(RowType *)row{
    _row = row;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    RowType *row = self.row;
    
    self.titleL.labelText = row.title;
    CGSize titleLSize = self.titleL.getLabelSize;
    self.titleL.frame = CGRectMake(DEFAULT_PADDING, DEFAULT_PADDING, TITLE_WIDTH, titleLSize.height);
    
    self.descL.labelText = row.desc;
    CGSize descLSize = self.descL.getLabelSize;
    self.descL.frame = CGRectMake(DEFAULT_PADDING, self.titleL.bottom+DEFAULT_PADDING, DESC_WIDTH, descLSize.height);
    
    self.imgHref.frame = CGRectMake(SCREEN_W-DEFAULT_PADDING-IMAGE_MAX_WIDTH, self.descL.top, IMAGE_MAX_WIDTH, IMAGE_MAX_WIDTH);
    UIImage * placeholderImage = [UIImage createImageWithColor:[UIColor grayColor] size:CGSizeMake(1.0f, 1.0f)];
    //使用SDWebImage加载图片
    __weak __typeof (&*self) weakSelf = self;
    [self.imgHref sd_setImageWithURL:[NSURL URLWithString:row.imageHref] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && !error) {
            UIImage * newImage = [UIImage imageCompressWithSourceImage:image targetWidth:IMAGE_MAX_WIDTH];
            __strong __typeof (&*weakSelf)strongSelf = weakSelf;
            CGFloat imageHeight = MIN(newImage.size.height, IMAGE_MAX_WIDTH);
            strongSelf.imgHref.frame = CGRectMake(SCREEN_W-DEFAULT_PADDING-IMAGE_MAX_WIDTH, strongSelf.descL.top, IMAGE_MAX_WIDTH, imageHeight);
        }
    }];
}


+ (CGFloat)cellHeightWithModel:(RowType *)row {
    CGFloat height = 0.0;
    if (row) {
        CGSize titleLSize = [JSAttributeLabel getLabelSizeWithText:row.title labelFont:[UIFont systemFontOfSize:CONTENT_SIZE] lineSpace:CONTENT_PADDING maxWidth:TITLE_WIDTH];
        CGSize descLSize = [JSAttributeLabel getLabelSizeWithText:row.desc labelFont:[UIFont systemFontOfSize:CONTENT_SIZE] lineSpace:CONTENT_PADDING maxWidth:DESC_WIDTH];
        if (descLSize.height < IMAGE_MAX_WIDTH) {
            descLSize.height = IMAGE_MAX_WIDTH;
        }
        height += DEFAULT_PADDING + titleLSize.height + DEFAULT_PADDING + descLSize.height +DEFAULT_PADDING;
    }
    return height;
}





@end
