//
//  PassageCell.m
//  Headlines
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PassageCell.h"
#import "PassageCellLayout.h"
@implementation PassageCell

- (void)setPassage:(PassageModel *)passage{
    _passage = passage;
    
    self.label1.text = [NSString stringWithFormat:@"%li", _passage.up];
    self.label2.text = [NSString stringWithFormat:@"%li", _passage.down];
    //    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(_goodReception.bounds.size.width / 2 + 4, 1, 16, 16)];
    PassageCellLayout *layout = [PassageCellLayout layoutWithModel:_passage];
    
    
    [self.imageView1 setImage:[UIImage imageNamed:@"list_xzan@3x.png"]];
    [self.imageView2 setImage:[UIImage imageNamed:@"list_ly@3x.png"]];
    [self.imageView3 setImage:[UIImage imageNamed:@"list_ly@3x.png"]];
    [self.imageView4 setImage:[UIImage imageNamed:@"list_xzan@3x.png"]];
    self.label.frame = CGRectMake(10, 10, kScreenWidth - 20, layout.cellhight - SpaceWidth * 2 - 19);
    self.label.text = _passage.content;
    
    
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_label];
    }
    
    return _label;
    
}

- (UILabel *)label1{
    if (_label1 == nil) {
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(_goodReception.bounds.size.width / 2 + 4, 1, 30, 16)];
        _label1.font = [UIFont systemFontOfSize:10];
        [_goodReception addSubview:_label1];
    }
    
    return _label1;
    
}

- (UILabel *)label2{
    if (_label2 == nil) {
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(_badReception.bounds.size.width / 2 + 4, 1, 30, 16)];
        _label2.font = [UIFont systemFontOfSize:10];
        [_badReception addSubview:_label2];
    }
    
    return _label2;
    
}


- (UIImageView *)imageView1{
    if (_imageView1 == nil) {
        _imageView1 = [[UIImageView alloc]initWithImage:nil];
        _imageView1.frame = CGRectMake(_goodReception.bounds.size.width / 2 - 20 , 1, 16, 16);
        _imageView1.userInteractionEnabled = YES;
        [_goodReception addSubview:_imageView1];
    }
    return _imageView1;
}

- (UIImageView *)imageView2{
    if (_imageView2 == nil) {
        _imageView2 = [[UIImageView alloc]initWithImage:nil];
        _imageView2.frame = CGRectMake(_goodReception.bounds.size.width / 2 - 20 , 1, 16, 16);
        [_badReception addSubview:_imageView2];
    }
    return _imageView2;
}

- (UIImageView *)imageView3{
    if (_imageView3 == nil) {
        _imageView3 = [[UIImageView alloc]initWithImage:nil];
        _imageView3.frame = CGRectMake(_goodReception.bounds.size.width / 2 - 20 , 1, 16, 16);
        [_comment addSubview:_imageView3];
    }
    return _imageView3;
}

- (UIImageView *)imageView4{
    if (_imageView4 == nil) {
        _imageView4 = [[UIImageView alloc]initWithImage:nil];
        _imageView4.frame = CGRectMake(_goodReception.bounds.size.width / 2 - 20 , 1, 16, 16);
        [_shareTo addSubview:_imageView4];
    }
    return _imageView4;
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
