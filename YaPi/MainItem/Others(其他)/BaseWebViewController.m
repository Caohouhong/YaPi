//
//  BaseWebViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "PlayViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    WebViewJavascriptBridge *_bridge;
}
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"App与H5交互"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.mMainView addSubview:_webView];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:htmlPath];
    [_webView loadHTMLString:appHtml baseURL:baseUrl];
    
    //第一步开启日志
    //开启日志，方便调试
    [WebViewJavascriptBridge enableLogging];
    
    //第二步，建立桥梁
    //给webView建立起js与OC的沟通桥梁
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    
    //设置代理，如果不需要可以不设置
    [_bridge setWebViewDelegate:self];
    
    [self renderButtons:_webView];
    
    
    //第三步，注册HandleName，用于给JS端调用iOS端
    // JS主动调用OjbC的方法
    // 这是JS会调用getUserIdFromObjC方法，这是OC注册给JS调用的
    // JS需要回调，当然JS也可以传参数过来。data就是JS所传的参数，不一定需要传
    // OC端通过responseCallback回调JS端，JS就可以得到所需要的数据
    [_bridge registerHandler:@"getUserIdFromObjC"handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call getUserIdFromObjC, data from js is %@", data);
        if (responseCallback) {
            // 反馈给JS
            responseCallback(@{@"userId": @"123456"});
        }
    }];
    
    
    /*js按钮点击后，OC收到即可执行需要的操作*/
    [_bridge registerHandler:@"getBlogNameFromObjC"handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call getBlogNameFromObjC, data from js is %@", data);
        if (responseCallback) {
            // 反馈给JS
            responseCallback(@{@"from": @"Yapi"});
            
            //点击js界面按钮控制OC界面跳转
            PlayViewController *playVC = [[PlayViewController alloc] init];
            [self.navigationController pushViewController:playVC animated:YES];
        }
    }];
    
     
    
    [_bridge callHandler:@"getUserInfos" data:@{@"name": @"京金所"} responseCallback:^(id responseData) {
        NSLog(@"from js: %@", responseData);
    }];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)renderButtons:(UIWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"打开博文" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(onOpenBlogArticle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"刷新webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(110, 400, 100, 35);
    reloadButton.titleLabel.font = font;
}

- (void)onOpenBlogArticle:(id)sender {
    // 调用打开本demo的博文
    [_bridge callHandler:@"openWebviewBridgeArticle" data:nil];
}


@end
