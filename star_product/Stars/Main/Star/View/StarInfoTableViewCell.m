//
//  StarInfoTableViewCell.m
//  Stars
//
//  Created by livesxu on 2018/10/8.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "StarInfoTableViewCell.h"

@interface StarInfoTableViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
    
@property (nonatomic, strong) UILabel *name_lb;
    
@property (nonatomic, strong) UIButton *level_btn;

@property (nonatomic, strong) UILabel *time_lb;

@property (nonatomic, strong) UIView *activeTags;

@property (nonatomic, strong) UILabel *textContent_lb;

@property (nonatomic, strong) UIView *imgs;

@property (nonatomic, strong) UIView *bottomShows;

@end

@implementation StarInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.name_lb];
        [self.contentView addSubview:self.level_btn];
        [self.contentView addSubview:self.time_lb];
        [self.contentView addSubview:self.activeTags];
        [self.contentView addSubview:self.textContent_lb];
        [self.contentView addSubview:self.imgs];
        [self.contentView addSubview:self.bottomShows];
    }
    return self;
}
    
- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(15), Layout(20), Layout(40), Layout(40))];
        [_imgView setClearRadius:Layout(20)];
    }
    return _imgView;
}
    
- (UILabel *)name_lb {
    
    if (!_name_lb) {
        
        _name_lb = [[UILabel alloc]initWithFrame:CGRectMake(Layout(65), Layout(20), Layout(230), Layout(20))];
        _name_lb.font = Font(16);
        _name_lb.textColor = Color333;
        _name_lb.textAlignment = NSTextAlignmentLeft;
        _name_lb.numberOfLines = 1;
    }
    return _name_lb;
}
    
- (UIButton *)level_btn {
    
    if (!_level_btn) {
        
        _level_btn = [UIButton buttonWithNomalFrame:CGRectMake(Layout(65), Layout(44), Layout(40), Layout(16)) Title:@"Lv." TitleFont:Font(12) TitleColor:Colorfff BackgroundImage:Image(@"star_levelbutton_n")];
        _level_btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _level_btn;
}

- (UILabel *)time_lb {
    
    if (!_time_lb) {
        
        _time_lb = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - Layout(15) - Layout(70), Layout(30), Layout(70), Layout(20))];
        _time_lb.font = Font(14);
        _time_lb.textColor = Color777;
        _time_lb.textAlignment = NSTextAlignmentRight;
        _time_lb.numberOfLines = 1;
    }
    return _time_lb;
}

- (UILabel *)textContent_lb {
    
    if (!_textContent_lb) {
        
        _textContent_lb = [[UILabel alloc]initWithFrame:CGRectMake(Layout(15), Layout(70),kScreenWidth - Layout(30), Layout(60))];
        _textContent_lb.font = Font(14);
        _textContent_lb.textColor = Color484848;
        _textContent_lb.numberOfLines = 3;
    }
    return _textContent_lb;
}

- (UIView *)activeTags {
    
    if (!_activeTags) {
        
        _activeTags = [[UIView alloc]initWithFrame:CGRectMake(Layout(15), Layout(65), kScreenWidth - Layout(30), Layout(16))];
    }
    return _activeTags;
}

-(UIView *)imgs {
    
    if (!_imgs) {
        
        _imgs = [[UIView alloc]initWithFrame:CGRectZero];//216*200
        
    }
    return _imgs;
}

- (UIView *)bottomShows {
    
    if (!_bottomShows) {
        
        _bottomShows = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Layout(44))];
        
        UIButton *typeSign = [UIButton buttonWithNomalFrame:CGRectMake(Layout(15), Layout(5), Layout(80), Layout(18)) Image:Image(@"mytopic_mark_n")];
        [typeSign setTitleColor:Color777 forState:UIControlStateNormal];
        typeSign.titleLabel.font = Font(14);
        [typeSign setTitle:@" 星动态" forState:UIControlStateNormal];
        [_bottomShows addSubview:typeSign];
        
        UIButton *talk = [UIButton buttonWithNomalFrame:CGRectMake(0, 0, Layout(80), Layout(18)) Image:Image(@"detail_bottom_comment_n")];
        [talk setTitleColor:Color777 forState:UIControlStateNormal];
        talk.titleLabel.font = Font(12);
        [talk setTitle:@"  99" forState:UIControlStateNormal];
        [_bottomShows addSubview:talk];
        
        UIButton *like = [UIButton buttonWithNomalFrame:CGRectMake(0, 0, Layout(80), Layout(18)) Image:Image(@"detail_bottom_like_n")];
        [like setImage:Image(@"detail_bottom_like_p") forState:UIControlStateSelected];
        [like setTitleColor:Color777 forState:UIControlStateNormal];
        like.titleLabel.font = Font(12);
        [like setTitle:@"  8" forState:UIControlStateNormal];
        [_bottomShows addSubview:like];
        
        UIButton *dislike = [UIButton buttonWithNomalFrame:CGRectMake(0, 0, Layout(80), Layout(18)) Image:Image(@"detail_bottom_dislike_n")];
        [dislike setImage:Image(@"detail_bottom_dislike_p") forState:UIControlStateSelected];
        [dislike setTitleColor:Color777 forState:UIControlStateNormal];
        dislike.titleLabel.font = Font(12);
        [dislike setTitle:@"  88" forState:UIControlStateNormal];
        [_bottomShows addSubview:dislike];
        
        [dislike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomShows).offset(Layout(5));
            make.right.equalTo(_bottomShows).offset(Layout(-15));
        }];
        [like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(dislike);
            make.right.equalTo(dislike.mas_left).offset(Layout(-10));
        }];
        [talk mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(like);
            make.right.equalTo(like.mas_left).offset(Layout(-10));
        }];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Layout(34), kScreenWidth, Layout(10))];
        line.backgroundColor = pageColor;
        [_bottomShows addSubview:line];
        
    }
    return _bottomShows;
}
    
- (void)setModel:(StarInfoModel *)model {
    _model = model;
    
    [self.imgView yy_setImageWithURL:[NSURL URLWithString:_model.imgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    self.name_lb.text = _model.name;
    [self.level_btn setTitle:[@"Lv." stringByAppendingString:_model.level] forState:UIControlStateNormal];
    self.time_lb.text = _model.time;
    
    self.textContent_lb.text = _model.textContent;
    
    _bottomShows.y = _model.cellHeight - _bottomShows.height;
}
    
@end
