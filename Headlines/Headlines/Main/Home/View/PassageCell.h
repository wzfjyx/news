//
//  PassageCell.h
//  Headlines
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassageCell : UITableViewCell
@property (strong, nonatomic)PassageModel *passage;
@property (weak, nonatomic) IBOutlet UIButton *goodReception;
@property (weak, nonatomic) IBOutlet UIButton *badReception;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *shareTo;


@property (strong, nonatomic)UILabel *label;
@property (strong, nonatomic)UILabel *label1;
@property (strong, nonatomic)UIImageView *imageView1;
@property (strong, nonatomic)UIImageView *imageView2;
@property (strong, nonatomic)UIImageView *imageView3;
@property (strong, nonatomic)UIImageView *imageView4;
@property (strong, nonatomic)UILabel *label2;
@end
