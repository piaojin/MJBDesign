//
//  MJBBaseTableViewCell.m
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "MJBBaseTableViewCell.h"

@implementation MJBBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    NSString *ID = className;
    MJBBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = (MJBBaseTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:className owner:self options:nil]  lastObject];
        [cell initView];
    }
    return cell;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 44.0;
}

- (id)model{
    return nil;
}

//子类重写,更新cell数据
- (void)setModel:(id)model{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initView];
    }
    return self;
}

- (void)initView {
    
}


//消除重用造成的数据重复显示(子类重写)
- (void)clearData{
    
}

@end
