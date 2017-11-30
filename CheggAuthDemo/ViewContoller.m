//
//  ViewController.m
//  CheggAuthDemoWKWebView
//
//  Created by Victor Borshak on 11/30/17.
//  Copyright © 2017 Victor Borshak. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

// redirect_uri should be ideally set to 'cheggereader://'
// but since currently we don't have profiles set up with such value on back end,
// we use https://www.chegg.com/auth/external/vst/mobilecallback as a workaround, which internally redirects to 'cheggereader://'.
// It demonstrates that it's possible to intercept cheggereader:// redirect using WKWebView delegate's method

#define AUTH_URL @"https://www.chegg.com/oidc/authorize?client_id=VST&response_type=token&redirect_uri=https://www.chegg.com/auth/external/vst/mobilecallback&action=login"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated  {
    UINavigationController *nc = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    WebViewController *vc = [[WebViewController alloc] initWithNibName:nil bundle:nil];
    vc.pageURL = AUTH_URL;
    [nc pushViewController:vc animated:NO];
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
