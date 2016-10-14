//
//  PassageCellLayout.h
//  Headlines
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassageCellLayout : NSObject
@property (strong, nonatomic)PassageModel *passage;
+(instancetype)layoutWithModel:(PassageModel *)passage;

-(CGFloat)cellhight;
@end
