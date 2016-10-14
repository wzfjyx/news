//
//  WebRecViewController.h
//  Headlines
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseViewController.h"

@interface WebRecViewController : BaseViewController
@property (nonatomic, strong)NSURL *url;

- (instancetype)initWithUrl:(NSURL *)url;
@end
