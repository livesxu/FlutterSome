//
//  StarItemsCollectionViewCell.m
//  Stars
//
//  Created by livesxu on 2018/9/27.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "StarItemsCollectionViewCell.h"

@interface StarItemsCollectionViewCell ()

@property (nonatomic, strong) UIImageView *starImg;

@property (nonatomic, strong) UIImageView *addView;//添加view

@property (nonatomic, strong) UILabel *addTitle;

@end

@implementation StarItemsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.starImg];
        [self.contentView addSubview:self.addView];
    }
    return self;
}

- (UIImageView *)starImg {
    
    if (!_starImg) {
        
        _starImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.width)];
        [_starImg setRoundedCorners:UIRectCornerAllCorners radius:Layout(6)];
        _starImg.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
        _starImg.layer.shadowOpacity = .5f;//阴影的透明度
        _starImg.layer.shadowOffset = CGSizeMake(0, 2);//设置阴影的偏移量
    }
    return _starImg;
}

- (UIImageView *)addView {
    
    if (!_addView) {
        
        _addView = [[UIImageView alloc]initWithFrame:CGRectMake(Layout(2), Layout(2), self.contentView.width - Layout(4), self.contentView.width - Layout(4))];
        
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = Colorccc.CGColor;
        border.fillColor = [UIColor clearColor].CGColor;

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_addView.bounds cornerRadius:Layout(6)];
        border.path = path.CGPath;
        border.frame = _addView.bounds;
        border.lineWidth = Layout(2);
        border.lineDashPattern = @[@6, @3];
        [_addView.layer addSublayer:border];
        
        UIImageView *add = [[UIImageView alloc]initWithFrame:CGRectMake((_addView.width - Layout(30))/2, (_addView.width - Layout(50))/2, Layout(30), Layout(30))];
        add.image = Image(@"home_addstar_n");
        [_addView addSubview:add];
        
        _addTitle = [UILabel labelWithFrame:CGRectMake(0, add.bottomPosition + Layout(5), _addView.width, Layout(15)) Text:@"添加明星" TextFont:Font(12) TextColor:Color666];
        _addTitle.textAlignment = NSTextAlignmentCenter;
        
        [_addView addSubview:_addTitle];
    }
    return _addView;
}

- (void)setModel:(StarsListModel *)model {
    _model = model;
    
    if ([model.starId isEqual:@"-1"]) {
        
        self.addView.hidden = NO;
        _addTitle.text = _model.starNoTitle;
        
    } else {
        
        self.addView.hidden = YES;
        [self.starImg yy_setImageWithURL:[NSURL URLWithString:_model.starImgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    }
}

@end
