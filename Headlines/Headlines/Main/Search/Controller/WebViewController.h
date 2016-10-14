//
//  WebViewController.h
//  Headlines
//
//  Created by mac12 on 16/9/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property (nonatomic, strong)NSURL *url;

-(instancetype)initWithURL:(NSURL *)url;

@end
