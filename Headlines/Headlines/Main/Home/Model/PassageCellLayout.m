//
//  PassageCellLayout.m
//  Headlines
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PassageCellLayout.h"

@implementation PassageCellLayout{
    CGFloat _cellHeight;
}
+(instancetype)layoutWithModel:(PassageModel *)passage{
    PassageCellLayout *layout = [[PassageCellLayout alloc] init];
    if (layout) {
        layout.passage = passage;
    }
    return layout;
}

- (void)setPassage:(PassageModel *)passage{
    _passage = passage;
    _cellHeight = 0;
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
    CGRect rect = [_passage.content boundingRectWithSize:CGSizeMake(kScreenWidth - 2 * SpaceWidth, 1000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];
    _cellHeight += SpaceWidth;
    _cellHeight += rect.size.height;
    _cellHeight += SpaceWidth * 2;
    _cellHeight += 19;
    _cellHeight += SpaceWidth;
    
    
}

- (CGFloat)cellhight{
    return _cellHeight;
}
@end
