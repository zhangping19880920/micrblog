//
//  OauthViewController.m
//  micrblog
//
//  Created by zhangping on 14-2-17.
//  Copyright (c) 2014年 zhangping. All rights reserved.
//

#import "OauthViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "MainViewController.h"


@interface OauthViewController (){
    UIWebView *_webView;
}

@end

@implementation OauthViewController

- (void)loadView{
    _webView = [[UIWebView alloc] init];
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:kOauthURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:webView animated:YES];
    hud.labelText = @"web view loading";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    Loger(@"url = %@", request);
    NSString *url = request.URL.absoluteString;
    NSRange rang = [url rangeOfString:@"access_token"];
    if (rang.length != 0) {
        NSString *paramStr = [url substringFromIndex:rang.location];
        NSArray *params = [paramStr componentsSeparatedByString:@"&"];
        
        Account *acc = [[Account alloc] init];
        
        for (NSString *par in params) {
            NSArray *keyValue = [par componentsSeparatedByString:@"="];
            NSString *key = keyValue[0];
            NSString *value = keyValue[1];
            if ([key isEqualToString:kAccessToken]) {
                acc.accessToken = value;
            }else if ([key isEqualToString:KUid]){
                acc.uid = value;
            }
        }
        [AccountTool sharedAccountTool].currentAccount = acc;
        
        NSURLRequest *request = [NSURLRequest requestWithPath:@"users/show.json" params:@{@"uid" : acc.uid}];
        Loger(@"request = %@", request);
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            Loger(@"return json = success");
            acc.screenName = JSON[kScreenName];
            [[AccountTool sharedAccountTool] addAccount:acc];
            
            [AccountTool sharedAccountTool].currentAccount = acc;
            MainViewController *main = [[MainViewController alloc] init];
            self.view.window.rootViewController = main;
            
            [MBProgressHUD hideHUDForView:webView animated:YES];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            Loger(@"return error = %@", error);
            [MBProgressHUD hideHUDForView:webView animated:YES];
        }];

        [operation start];
        return NO;
    }
    

    return YES;
}
@end
