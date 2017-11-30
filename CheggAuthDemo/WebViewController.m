//
//  ViewController.m
//  CheggAuthDemo
//
//  Created by Victor Borshak on 11/30/17.
//  Copyright © 2017 Victor Borshak. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <WKUIDelegate, WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation WebViewController

- (instancetype) initWithWebView:(WKWebView *)wv
{
    self = [[WebViewController alloc] initWithNibName:nil bundle:nil];
    if (self) {
        self.webView = wv;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"WKViewView";
    
    if (!self.webView) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    
    [self.view addSubview:self.webView];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor grayColor];
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    [self open];
}

- (void) open
{
    NSURL *url = [NSURL URLWithString:self.pageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.activityIndicator stopAnimating];
}

// This method can intercept custom scheme redirect for WKWebView
// Here I simply forward it to UIApplication's delegate. But basically anything can be done here
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = [[navigationAction request] URL];
    
    if ([[url scheme] isEqualToString:@"cheggereader"])
    {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app.delegate respondsToSelector:@selector(application:openURL:options:)]) {
            [app.delegate application:app openURL:url options:[NSDictionary dictionary]];
        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    CGRect frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    WKWebView *popup = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    WebViewController *newViewController = [[WebViewController alloc] initWithWebView:popup];
    [self.navigationController pushViewController:newViewController animated:YES];
    
    return popup;
}

// Please note: this is supported only iOS 9.0 and higher
- (void)webViewDidClose:(WKWebView *)webView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
