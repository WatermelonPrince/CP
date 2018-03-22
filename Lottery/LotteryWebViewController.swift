//
//  LotteryWebViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//


import WebKit

class LotteryWebViewController: LotteryBaseViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate, ServiceDelegate {
    var webView: WKWebView!;
    var urlContent: String!;
    var userService: UserService!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.webView = WKWebView(frame: self.view.frame);
        self.webView.navigationDelegate = self;
        self.webView.uiDelegate = self;
        self.webView.allowsBackForwardNavigationGestures = true;
        self.view.addSubview(self.webView);
        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil);
        
        self.userService = UserService(delegate: self);
        self.userService.getTempToken();
        
        self.navigationItem.title = "加载中...";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        self.webView.removeObserver(self, forKeyPath: "title");
    }
    
    func loadWebView() {
        UserDefaults.standard.register(defaults: ["UserAgent":"honghongcai_client_ios"]);
        UserDefaults.standard.synchronize();
        let request = URLRequest(url: URL(string: self.urlContent!)!);
        self.webView.load(request);
    }
    
    //TempToken
    func onCompleteSuccess(service: BaseService) {
        if (self.userService.tempToken != nil && self.userService.tempToken != "") {
            self.urlContent = self.addUrlTempToken(self.urlContent, tempToken: self.userService.tempToken!);
        }
        self.loadWebView();
    }
    
    func onCompleteFail(service: BaseService) {
        self.loadWebView();
    }
    
    func addUrlTempToken(_ urlContent: String, tempToken: String) -> String {
        if (urlContent.contains("?")) {
            return urlContent + "&token=" + tempToken;
        } else {
            return urlContent + "?token=" + tempToken;
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "title") {
            if (object as? WKWebView == self.webView) {
                self.setNavigationBar();
            }
        }
    }
    
    func setNavigationBar() {
        if (self.webView.canGoBack == true) {
            //左侧
            let backButtonItem = UIBarButtonItem(title: "＜返回", style: .plain,target: self, action: #selector(backAction));
            let closeButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(dismissAction));
            let spaceButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil);
            spaceButtonItem.width = -10.0;
            self.navigationItem.leftBarButtonItems = [spaceButtonItem, backButtonItem, closeButtonItem];
        } else {
            self.navigationItem.leftBarButtonItems = nil;
        }
        self.title = self.webView.title;
    }
    func backAction() {
        if (self.webView.canGoBack) {
            self.webView.goBack();
        } else {
            _ = self.navigationController?.popViewController(animated: true);
        }
        
    }
    
    func dismissAction() {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.setNavigationBar();
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let message = message.body as? String;
        if (message == nil) {
            return;
        }
    }
    
    //跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = (navigationAction.request.url)!;
        let scheme = url.scheme;
        let app = UIApplication.shared;
        if (url.absoluteString.contains("itunes.apple.com") || scheme == "tel") {
            decisionHandler(.cancel);
            if (app.canOpenURL(url)) {
                app.openURL(url);
            }
        } else if (url.absoluteString.contains("alipays://") ) {
            ViewUtil.dismissToast();
            decisionHandler(.allow);
            self.view.isHidden = false;
            app.openURL(url);
        } else if(url.absoluteString.contains("mobile.alipay")){
            decisionHandler(.cancel);
            app.openURL(URL(string: self.urlContent!)!);


            
        }else if (url.absoluteString.hasPrefix(HostRouter.JUMP_HOST)) {
            decisionHandler(.cancel);
            LotteryRoutes.routeURLString(url.absoluteString, withParameters: [routeViewControllerKey : self]);
        } else {
            decisionHandler(.allow);
        }
    }
    
    //Alert
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "确定", style: .cancel, handler: { (action) in
            completionHandler();
        }));
        alertController.show();
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(true);
        }));
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            completionHandler(false);
        }));
        alertController.show();
    }
}
