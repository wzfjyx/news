//
//  RecommendModel.h
//  Headlines
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

@property (nonatomic, copy)NSString *recommendId;
@property (nonatomic, assign)NSUInteger state;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)BOOL fav;
@property (nonatomic, assign)BOOL allHot;
@property (nonatomic, copy)NSString *site;
@property (nonatomic, assign)BOOL haveImg;
@property (nonatomic, copy)NSArray *imgSids;
@property (nonatomic, copy)NSString *detailPath;
@end
