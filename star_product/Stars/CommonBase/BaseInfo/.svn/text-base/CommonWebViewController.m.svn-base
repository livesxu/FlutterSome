//
//  CommonWebViewController.m
//  Stars
//
//  Created by Xu小波 on 2017/11/23.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "CommonWebViewController.h"

#import <WebKit/WebKit.h>

NSString *const kItunesKey = @"itunes";

@interface CommonWebViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CommonWebViewController

- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
//    /< 改动，防止崩溃
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)staticViewsWithoutNib {
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.progressView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)back {
    if ([self.webView canGoBack] && !_isBackToRoot) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - method (private)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        // Update title of the vc.
        self.title = self.webView.title;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - delegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    self.progressView.hidden = NO;
    [self.view bringSubviewToFront:self.progressView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = navigationAction.request.URL.absoluteString;
    
    if ([self judgeWithMethod:kItunesKey uriString:urlString]) {
        [self jumpToItunesDownloadWithURL:urlString];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}

#pragma mark - private method
- (BOOL)judgeWithMethod:(NSString *)method uriString:(NSString *)urlString {
    
    if (!method.length || !urlString.length) {
        return NO;
    }
    
    if ([urlString containsString:method]) {
        return YES;
    }
    
    return NO;
}


- (void)jumpToItunesDownloadWithURL:(NSString *)downUrl {
    NSURL *url = [NSURL URLWithString:downUrl];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - setter and getter
- (WKWebView *)webView {
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,kNaviH, kScreenWidth, kScreenHeight - kNaviH)];
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.backgroundColor = pageColor;
        _webView.scrollView.backgroundColor = pageColor;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kNaviH, kScreenWidth, Layout(10))];
        _progressView.progressTintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

@end

