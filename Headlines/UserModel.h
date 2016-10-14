//
//  UserModel.h
//  Headlines
//
//  Created by mac12 on 16/9/21.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,strong)NSString *gender;//性别
@property (nonatomic,copy)NSURL *profile_image_url; //用户头像地址
@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)NSString *location;//用户所在地址
@property (nonatomic,copy)NSString *created_at;


@end
