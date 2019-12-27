//
//  DayTaskTableViewCell.m
//  Stars
//
//  Created by livesxu on 2018/9/20.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "DayTaskTableViewCell.h"

@interface DayTaskTableViewCell ()
    
@property (nonatomic, strong) UIImageView *imgView;
    
@property (nonatomic, strong) UILabel *title_lb;
    
@property (nonatomic, strong) UILabel *desc_lb;
    
@property (nonatomic, strong) UILabel *progress_lb;
    
@end

@implementation DayTaskTableViewCell
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.title_lb];
        [self.contentView addSubview:self.desc_lb];
        [self.contentView addSubview:self.progress_lb];
    }
    return self;
}
    
- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(15), Layout(15), Layout(40), Layout(40))];
    }
    return _imgView;
}
    
- (UILabel *)title_lb {
    
    if (!_title_lb) {
        
        _title_lb = [[UILabel alloc]initWithFrame:CGRectMake(Layout(75), Layout(10), kScreenWidth - Layout(100), Layout(20))];
        _title_lb.font = Font(14);
        _title_lb.textColor = Color333;
        _title_lb.textAlignment = NSTextAlignmentLeft;
        _title_lb.numberOfLines = 1;
    }
    return _title_lb;
}
    
- (UILabel *)desc_lb {
    
    if (!_desc_lb) {
        
        _desc_lb = [[UILabel alloc]initWithFrame:CGRectZero];
        _desc_lb.font = Font(12);
        _desc_lb.textColor = Color666;
        _desc_lb.textAlignment = NSTextAlignmentLeft;
        _desc_lb.numberOfLines = 1;
    }
    return _desc_lb;
}
    
- (UILabel *)progress_lb {
    
    if (!_progress_lb) {
        
        _progress_lb = [UILabel labelWithFrame:CGRectMake(Layout(75), Layout(40), Layout(200), Layout(15)) Text:@"" TextFont:Font(12) TextColor:Color666];
    }
    
    return _progress_lb;
}
    
- (void)setModel:(DayTaskModel *)model {
    _model = model;
    
    [self.imgView yy_setImageWithURL:[NSURL URLWithString:model.imgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    self.title_lb.text = [NSString stringWithFormat:@"%@  %@",model.missionTitle,model.missionRewardDesc];
    
    self.progress_lb.text = [NSString stringWithFormat:@"完成%@",model.missionProgress];
    
    NSMutableAttributedString *ms = [[NSMutableAttributedString alloc]initWithString:self.title_lb.text];
    [ms addAttributes:@{NSFontAttributeName:Font(12),NSForegroundColorAttributeName:Color666} range:[self.title_lb.text rangeOfString:model.missionRewardDesc]];
    self.title_lb.attributedText = ms;
}

@end
