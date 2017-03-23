//
//  PJMoreCellTableViewCell.m
//  MJBDesign
//
//  Created by piaojin on 16/12/8.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJMoreCellTableViewCell.h"

@interface PJMoreCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation PJMoreCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(id)model{
    NSDictionary *dic = model;
    NSString *icon = [dic valueForKey:@"icon"];
    NSString *title = [dic valueForKey:@"title"];
    self.icon.image = [UIImage imageNamed:icon];
    self.title.text = title;
}

@end
