//
//  RecommendCellLayout.h
//  Headlines
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#define CellViewHeight 60
#define SpaceWidth 10
#define ImageViewWidth 40
#define ImageViewSpace 5
@interface RecommendCellLayout : NSObject
@property (nonatomic, strong)RecommendModel *recommend;

//---------------数据输入----------------
+(instancetype)layoutWithWeiboModel:(RecommendModel *)recommend;




@property (nonatomic, strong, readonly)NSArray *ImageFrameArray;
-(CGFloat)cellhight;

@end
