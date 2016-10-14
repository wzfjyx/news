//
//  RecommendCellLayout.m
//  Headlines
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "RecommendCellLayout.h"

@implementation RecommendCellLayout{
    CGFloat _cellHeight;
}
+(instancetype)layoutWithWeiboModel:(RecommendModel *)recommend{
    RecommendCellLayout *layout = [[RecommendCellLayout alloc]init];
    if (layout) {
        layout.recommend = recommend;
    }
    return layout;
}
- (void)setRecommend:(RecommendModel *)recommend{
    _cellHeight = 0;
    _cellHeight += CellViewHeight;
    _cellHeight += SpaceWidth;
    if (recommend.haveImg == true) {
        CGFloat ImageHeight = [self layoutThreeImangeVIewFrameWithImageCount:recommend.imgSids.count viewWidth:(KScreenWidth - SpaceWidth * 2) top:CellViewHeight];
        _cellHeight += ImageHeight;
        _cellHeight += SpaceWidth;
        
    }
}

-(CGFloat)layoutThreeImangeVIewFrameWithImageCount:(NSInteger )imageCount
                                         viewWidth:(CGFloat )viewWidth
                                               top:(CGFloat )top
{
    if (imageCount <= 0) {
        _ImageFrameArray = nil;
        return 0;
    }
    CGFloat imageWidth;
    CGFloat viewHeight;
    NSInteger numberOfLines = 2;
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
                                                   
    //布局：
    if (imageCount == 1) {
        
        numberOfLines = 1;
        imageWidth = viewWidth;
        viewHeight = viewWidth;
        
    }else if(imageCount == 2){
        
        imageWidth = (viewWidth - ImageViewSpace *3) /2 ;
        viewHeight = imageWidth;
        
    }else{
        
        numberOfLines = 3;
        imageWidth = (viewWidth - ImageViewSpace * 4)/3;
        viewHeight = imageWidth;
    }

    for (int i = 0; i < 3; i++) {
        
        if (i >= imageCount) {
            //添加空的frame到数组中去，表示此视图不用显示
            CGRect frame = CGRectZero;
            [mArray addObject:[NSValue valueWithCGRect:frame]];
            
        }else{
            
            //计算当前视图是第几行第几列
            NSInteger row = i / numberOfLines;
            NSInteger column = i % numberOfLines;
            //计算frame值
            //x ＝ 列号 ＊（图片宽度 ＋ 空隙宽度）
            //y ＝ 行号 ＊（图片宽度 ＋ 空隙宽度）
            CGFloat width = imageWidth + ImageViewSpace;
            CGFloat left = (KScreenWidth - viewWidth)/2;
            CGRect frame = CGRectMake(column * width + left, row * width + top, imageWidth, imageWidth);
            [mArray addObject:[NSValue valueWithCGRect:frame]];
            
        }
        
        
        
    }
    
    
    
    _ImageFrameArray = [mArray mutableCopy];
    
    
    return viewHeight;
    
}
-(CGFloat)cellhight{
    return _cellHeight;
}
@end
