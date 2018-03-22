//
//  LotteryGuideViewController.swift
//  Lottery
//
//  Created by DTY on 2017/5/4.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryGuideViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!;
    var imageArray: Array<UIImage>!;
    var pageControl: UIPageControl!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //StatusBar
        UIApplication.shared.setStatusBarHidden(true, with: .fade);
        
        //网络请求
        UIWebView().loadRequest(URLRequest(url: URL(string: "https://www.baidu.com")!));
        
        //image
        self.imageArray = [UIImage(named: "initial_guide_1")!, UIImage(named: "initial_guide_2")!, UIImage(named: "initial_guide_3")!];
        
        //ScrollView
        let rect = UIScreen.main.bounds;
        self.scrollView = UIScrollView(frame: rect);
        self.scrollView.contentSize = CGSize(width:rect.size.width*CGFloat(self.imageArray.count),height:0);
        self.scrollView.backgroundColor = UIColor.white;
        self.scrollView.isPagingEnabled = true;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.view.addSubview(self.scrollView);
        self.scrollView.delegate = self;
        
        for i in 0..<self.imageArray.count {
            let imageView = UIImageView(frame: CGRect(x: rect.width*CGFloat(i), y: 0, width: rect.width, height: rect.height));
            imageView.image = self.imageArray[i];
            imageView.contentMode = .scaleAspectFill;
            self.scrollView.addSubview(imageView);
        }
        
        //PageControl
        self.pageControl = UIPageControl(frame: CGRect(x: self.view.frame.width/2-300/2, y: SCREEN_HEIGHT-40, width: 300, height: 0));
        self.pageControl.backgroundColor = COLOR_WHITE;
        self.pageControl.numberOfPages = self.imageArray.count;
        self.pageControl.currentPageIndicatorTintColor = COLOR_RED;
        self.pageControl.pageIndicatorTintColor = COLOR_BROWN;
        self.view.addSubview(self.pageControl);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageInt = Int(scrollView.contentOffset.x/scrollView.frame.width);
        self.pageControl.currentPage = pageInt;
        
        if (self.scrollView.contentOffset.x > SCREEN_WIDTH*CGFloat(self.imageArray.count-1) + 10) {
            self.exitGuide();
        }
    }
    
    func exitGuide() {
        UIApplication.shared.setStatusBarHidden(false, with: .slide);
        let tabBarViewController = LotteryTabBarViewController();
        KEY_WINDOW.rootViewController = tabBarViewController;
        AppDelegate.applicationInitial(launchOptions: nil);
    }
    
}
