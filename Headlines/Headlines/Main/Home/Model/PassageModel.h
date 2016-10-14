//
//  PassageModel.h
//  Headlines
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassageModel : NSObject
@property (nonatomic, copy)NSString *PassageId;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *channel;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, assign)NSInteger height;
@property (nonatomic, assign)NSInteger width;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, assign)NSInteger up;
@property (nonatomic, assign)NSInteger down;
@property (nonatomic, assign)NSInteger integral;
@property (nonatomic, assign)NSInteger coin;
@property (nonatomic, assign)NSInteger orderNo;
@property (nonatomic, assign)BOOL isFav;
@property (nonatomic, assign)NSInteger cmtNum;
@property (nonatomic, assign)NSInteger userlevel;
@end
