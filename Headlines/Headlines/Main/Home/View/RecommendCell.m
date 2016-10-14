//
//  RecommendCell.m
//  Headlines
//
//  Created by apple on 16/9/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "RecommendCell.h"
#import "RecommendCellLayout.h"
@implementation RecommendCell


- (void)setRecommend:(RecommendModel *)recommend{
    
    _recommend = recommend;
    _titleLabel.text = _recommend.title;
    _timeLabel.text = _recommend.time;
    _siteLabel.text = _recommend.site;
    RecommendCellLayout *layout = [RecommendCellLayout layoutWithWeiboModel:_recommend];

    if (_recommend.haveImg) {
        
        for (int i = 0; i < 3; i++) {
            
            UIImageView *iv = self.imagesArray[i];
            
            NSValue *value = layout.ImageFrameArray[i];
            CGRect frame = [value CGRectValue];
            iv.frame = frame;
            
            if (i < _recommend.imgSids.count) {
                
                NSURL *url = [NSURL URLWithString:_recommend.imgSids[i]];
                [iv sd_setImageWithURL:url];
                
            }
            
        }
        
        
    }else{
        for (UIImageView *iv in _imagesArray) {
            
            iv.frame = CGRectZero;
        }
    }
    
    
}

#pragma mark - cell 图片
- (NSArray *)imagesArray{

    
    if (_imagesArray == nil) {
        
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectZero];
            [self.contentView addSubview:iv];
            [mArray addObject:iv];
            iv.tag = i;
            iv.userInteractionEnabled = YES;
        }
        _imagesArray = [mArray copy];
    }
    
    
    return _imagesArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
