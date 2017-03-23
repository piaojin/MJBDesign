//
//  PJExperienceTableViewCell.m
//  MJBDesign
//
//  Created by piaojin on 16/12/12.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJExperienceCell.h"
#import "PJExperienceModel.h"

@interface PJExperienceCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneAndTimeLabel;
@property (strong, nonatomic)PJExperienceModel *experienceModel;

@end

@implementation PJExperienceCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)model{
    PJExperienceModel *experienceModel = (PJExperienceModel *)model;
    
    NSMutableAttributedString *addressString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"地址:%@",experienceModel.address]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3.0];
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    [addressString addAttributes:attributes range:NSMakeRange(0, [experienceModel.address length])];
    
    UILabel *tempLabel = [[UILabel alloc] init];
    [tempLabel setAttributedText:addressString];
    
    CGSize addressSize = [tempLabel.text boundingRectWithSize:CGSizeMake(SCREENWITH - 30, MAXFLOAT) options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]} context:nil].size;
    
    NSString *str = [NSString stringWithFormat:@"电话:%@   营业时间:%@",experienceModel.phone,experienceModel.work_time];
    CGSize phoneSize = [str boundingRectWithSize:CGSizeMake(SCREENWITH - 30, MAXFLOAT) options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]} context:nil].size;
    CGFloat scale = UIScale;
    return (51 + 20 + 9 + 25) * scale + addressSize.height + phoneSize.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(id)model{
    _experienceModel = (PJExperienceModel *)model;
    self.titleLabel.text = _experienceModel.name;
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",_experienceModel.address];
    self.phoneAndTimeLabel.text = [NSString stringWithFormat:@"电话:%@   营业时间:%@",_experienceModel.phone,_experienceModel.work_time];
    
    NSMutableAttributedString *addressString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"地址:%@",_experienceModel.address]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3.0];
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    [addressString addAttributes:attributes range:NSMakeRange(0, [_experienceModel.address length])];
    [self.addressLabel setAttributedText:addressString];
}

@end
