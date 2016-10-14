//
//  RecommendCell.h
//  Headlines
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface RecommendCell : UITableViewCell
@property (nonatomic, strong)RecommendModel *recommend;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@property (nonatomic, strong)NSArray *imagesArray;//1-3个图片的数据
@end
