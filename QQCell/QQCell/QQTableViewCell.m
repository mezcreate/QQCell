//
//  QQTableViewCell.m
//  QQCell
//
//  Created by MengZhiqi on 2017/8/3.
//  Copyright © 2017年 MengZhiqi. All rights reserved.
//

#import "QQTableViewCell.h"

@implementation QQTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
