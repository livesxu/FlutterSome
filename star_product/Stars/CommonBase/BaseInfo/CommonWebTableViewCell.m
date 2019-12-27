//
//  CommonWebTableViewCell.m
//  Stars
//
//  Created by livesxu on 2018/9/25.
//  Copyright © 2018年 ShuJin. All rights reserved.
//

#import "CommonWebTableViewCell.h"

#import <WebKit/WebKit.h>

@interface CommonWebTableViewCell ()

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL isLoadFlag;

@property (nonatomic, assign) CGFloat heightStore;

@end

@implementation CommonWebTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.webView];
        
        __weak typeof(self) weakSelf = self;
        [RACObserve(self.webView.scrollView, contentSize) subscribeNext:^(id x) {
            
            if (weakSelf.heightStore == weakSelf.webView.scrollView.contentSize.height) {
                
                return ;
            }
            weakSelf.heightStore = weakSelf.webView.scrollView.contentSize.height;
            weakSelf.webView.height = weakSelf.heightStore;
            
            if (weakSelf.webHeight) {
                
                weakSelf.webHeight(weakSelf.webView.height);
            }
        }];
    }
    return self;
}

- (WKWebView *)webView {
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    }
    return _webView;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    
    if (_url && [_url isKindOfClass:[NSString class]] && !_isLoadFlag) {
        _isLoadFlag = YES;
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

@end
