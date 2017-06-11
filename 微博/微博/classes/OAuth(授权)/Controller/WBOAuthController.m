//
//  WBOAuthController.m
//  微博
//
//  Created by BJT on 17/5/18.
//  Copyright © 2017年 BJT. All rights reserved.
//


#import "MBProgressHUD+MJ.h"

#import "WBOAuthController.h"
#import "WBAccount.h"
#import "WBTabbarController.h"
#import "WBNewFeatureController.h"
#import "WBAccountTool.h"
#import "WBHttpTool.h"


@interface WBOAuthController ()<UIWebViewDelegate>

@end

@implementation WBOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    // APP key
    NSString *client_id = WBAppKey;
    NSString *redirect_uri = WBAppRedirectUri;
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",client_id,redirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    [self.view addSubview:webView];
}

#pragma mark -UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"Loading"];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    WBLog(@"%@",request.URL.absoluteString);
    
    NSString *urlStr = request.URL.absoluteString;
    NSRange  range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) { // got authorized request_token
        
        NSInteger index =  range.location + range.length;
        NSString *code = [urlStr substringFromIndex:index];
        
//        WBLog(@"%@, %@",code,request.URL.absoluteString);
        
        // get access_token with authorized request_token
        [self accessTokenWithcode:code];
        
        // don't load call-back address
        return  NO;
        
    }
    
    
    return YES;
}

#pragma mark - get access_token
/**
 *  get access_token with authorized request_token
 *
 *  @param code authorized request_token
 */
- (void)accessTokenWithcode:(NSString *)code
{
  /*
   
   URL
   https://api.weibo.com/oauth2/access_token
   HTTP请求方式
   POST
   请求参数
   必选	类型及范围	说明
   client_id	true	string	申请应用时分配的AppKey。
   client_secret	true	string	申请应用时分配的AppSecret。
   grant_type	true	string	请求的类型，填写authorization_code
   
   grant_type为authorization_code时
   必选	类型及范围	说明
   code	true	string	调用authorize获得的code值。
   redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
   
   */
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"client_id"] = WBAppKey; // app key
    paras[@"client_secret"] = WBAppSecret; // app secret
    paras[@"grant_type"] = @"authorization_code";
    paras[@"code"] = code;
    paras[@"redirect_uri"] = WBAppRedirectUri;
    
    [WBHttpTool POST:urlStr parameters:paras success:^(id responseObject) {
        
        [MBProgressHUD hideHUD];
        //        WBLog(@"success , %@-%@",[responseObject class],responseObject);
        
        // create account model with responseObject
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        
        // save account to sandBox
        [WBAccountTool saveAccount:account];
        
        /*switch window.rootViewController */
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        WBLog(@"failure , %@",error);
        
    }];
    
}



@end
