//
//  ViewController.h
//  CheggAuthDemo
//
//  Created by Victor Borshak on 11/30/17.
//  Copyright © 2017 Victor Borshak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSString *pageURL;
- (instancetype) initWithWebView:(WKWebView *)wv;

@end

