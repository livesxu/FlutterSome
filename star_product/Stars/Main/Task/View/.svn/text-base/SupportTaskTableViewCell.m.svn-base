//
//  SupportTaskTableViewCell.m
//  Stars
//
//  Created by livesxu on 2018/9/20.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "SupportTaskTableViewCell.h"

@interface SupportTaskTableViewCell ()
    
@property (nonatomic, strong) UIImageView *imgView;
    
@property (nonatomic, strong) UILabel *title_lb;
    
@property (nonatomic, strong) UILabel *target_lb;
    
@property (nonatomic, strong) UILabel *get_lb;
    
@property (nonatomic, strong) UILabel *progress_lb;
    
@property (nonatomic, strong) UILabel *endTime_lb;
    
@property (nonatomic, strong) UILabel *numbers_lb;
    
@property (nonatomic, strong) UIImageView *progress_bg;
    
@property (nonatomic, strong) UIImageView *progress_front;
    
@end

@implementation SupportTaskTableViewCell
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.title_lb];
        [self.contentView addSubview:self.target_lb];
        [self.contentView addSubview:self.get_lb];
        [self.contentView addSubview:self.progress_lb];
        [self.contentView addSubview:self.endTime_lb];
        [self.contentView addSubview:self.numbers_lb];
        [self.contentView addSubview:self.progress_bg];
    }
    return self;
}
    
- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(15), Layout(25), Layout(345), Layout(140))];
    }
    return _imgView;
}
    
- (UILabel *)title_lb {
    
    if (!_title_lb) {
        
        _title_lb = [[UILabel alloc]initWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.imgView.frame) + Layout(10), kScreenWidth - Layout(30), Layout(25))];
        _title_lb.font = Font(16);
        _title_lb.textColor = Color333;
        _title_lb.textAlignment = NSTextAlignmentLeft;
        _title_lb.numberOfLines = 1;
    }
    return _title_lb;
}
    
- (UILabel *)target_lb {
    
    if (!_target_lb) {
        
        _target_lb = [[UILabel alloc]initWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.title_lb.frame) + Layout(10), kScreenWidth - Layout(30), Layout(25))];
        _target_lb.font = Font(14);
        _target_lb.textColor = Color666;
        _target_lb.textAlignment = NSTextAlignmentLeft;
        _target_lb.numberOfLines = 1;
    }
    return _target_lb;
}
    
- (UILabel *)get_lb {
        
    if (!_get_lb) {
            
        _get_lb = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.title_lb.frame) + Layout(10), kScreenWidth - Layout(30), Layout(25)) Text:@"" TextFont:Font(14) TextColor:Color666];
        _get_lb.textAlignment = NSTextAlignmentCenter;
    }
        
    return _get_lb;
}
    
- (UILabel *)progress_lb {
    
    if (!_progress_lb) {
        
        _progress_lb = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.title_lb.frame) + Layout(10), kScreenWidth - Layout(30), Layout(25)) Text:@"" TextFont:Font(14) TextColor:Color666];
        _progress_lb.textAlignment = NSTextAlignmentRight;
    }
    
    return _progress_lb;
}
    
- (UIImageView *)progress_bg {
    
    if (!_progress_bg) {
        
        _progress_bg = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.progress_lb.frame) + Layout(5), kScreenWidth - Layout(30), Layout(20))];
        _progress_bg.image = [Image(@"support_schedule_outer_n") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
        
        _progress_front = [[UIImageView alloc]initWithFrame:_progress_bg.bounds];
        _progress_front.image = [Image(@"support_schedule_inner_n") resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
        _progress_front.width = 0;
        [_progress_bg addSubview:_progress_front];
    }
    return _progress_bg;
}

- (UILabel *)endTime_lb {
    
    if (!_endTime_lb) {
        
        _endTime_lb = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.progress_bg.frame) + Layout(10), kScreenWidth - Layout(30), Layout(20)) Text:@"" TextFont:Font(14) TextColor:Color666];
    }
    return _endTime_lb;
}

- (UILabel *)numbers_lb {
    
    if (!_numbers_lb) {
        
        _numbers_lb = [UILabel labelWithFrame:CGRectMake(Layout(15), CGRectGetMaxY(self.progress_bg.frame) + Layout(10), kScreenWidth - Layout(30), Layout(20)) Text:@"" TextFont:Font(14) TextColor:Color666];
        _numbers_lb.textAlignment = NSTextAlignmentRight;
    }
    return _numbers_lb;
}
    
- (void)setModel:(SupportTaskModel *)model {
    _model = model;
    
    if (_model.isMain) {
        
        self.imgView.frame = CGRectMake(0, 0, Layout(375), Layout(140)*(375/345.0));
    } else {
        self.imgView.frame = CGRectMake(Layout(15), Layout(25), Layout(345), Layout(140));
    }
    
    [self.imgView yy_setImageWithURL:[NSURL URLWithString:model.imgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    self.title_lb.text = model.supportTitle;
    self.target_lb.text = [NSString stringWithFormat:@"目标：%@%@",model.supportTarget,model.supportUnit];
    self.get_lb.text = [NSString stringWithFormat:@"已筹：%@%@",model.supportGet,model.supportUnit];
    if (model.supportTarget.floatValue > 0 && model.supportTarget.floatValue > model.supportGet.floatValue) {
        
        self.progress_lb.text = [NSString stringWithFormat:@"进度：%ld%%",(NSInteger)(model.supportGet.floatValue/model.supportTarget.floatValue *100)];
        
        self.progress_front.width = (model.supportGet.floatValue/model.supportTarget.floatValue) * (kScreenWidth - Layout(30));
    }
    self.endTime_lb.text = [NSString stringWithFormat:@"众筹结束时间 %@",model.supportEndTime];
    self.numbers_lb.text = [NSString stringWithFormat:@"参与 %@人",model.supportNumbers];
    
    NSMutableAttributedString *msTarget = [[NSMutableAttributedString alloc]initWithString:self.target_lb.text];
    [msTarget addAttributes:@{NSFontAttributeName:Font(16)} range:[self.target_lb.text rangeOfString:model.supportTarget]];
    [msTarget addAttributes:@{NSFontAttributeName:Font(12)} range:NSMakeRange(self.target_lb.text.length-2, 2)];
    [msTarget addAttributes:@{NSForegroundColorAttributeName:mainColor} range:NSMakeRange([self.target_lb.text rangeOfString:model.supportTarget].location, [self.target_lb.text rangeOfString:model.supportTarget].length +2)];
    self.target_lb.attributedText = msTarget;
    
    NSMutableAttributedString *msEnd = [[NSMutableAttributedString alloc]initWithString:self.endTime_lb.text];
    [msEnd addAttributes:@{NSForegroundColorAttributeName:mainColor} range:[self.endTime_lb.text rangeOfString:model.supportEndTime]];
    self.endTime_lb.attributedText = msEnd;
}
    
@end
