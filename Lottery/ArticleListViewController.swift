//
//  NewListViewController.swift
//  Lottery
//
//  Created by zhaohuan on 2017/7/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
class ArticleListViewController: LotteryRefreshTableViewController,ServiceDelegate {
    let articleListCellId = "cellId"
    var articleListService : ArticleListService!
    var articleList = Array<ArticleModel>()
    var category : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取存储咨询数据
        
        if (LotteryUtil.articleListAticleList(category:category!) != nil) {
            self.articleList = LotteryUtil.articleListAticleList(category:category!)!
        }
        self.navigationItem.title = "彩票资讯"
        self.tableView .register(ArticleListTableViewCell.classForCoder(), forCellReuseIdentifier: self.articleListCellId)
        self.tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        self.tableView.separatorStyle = .none
        self.hasNoMoreData = false
        self.tableView.mj_footer.isHidden = false
        self.articleListService = ArticleListService(delegate: self)
        self.headerRefresh();
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.articleListCellId, for: indexPath)as! ArticleListTableViewCell
        if self.articleList.count > 0 {
            cell .reloadCell(model: self.articleList[indexPath.row],indexPath:indexPath)
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    // MARK:cell点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.articleList[indexPath.row]
        let apendUrl = HTTPConstants.ARTICLE + article.articleId!;
        let vc = LotteryWebViewController()
        vc.urlContent = apendUrl
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func headerRefresh() {
        self.articleListService.getArticleList(page: "0", limit: "10", category: self.category)
        
    }
    override func footerRefresh() {
        if self.articleListService.paginator?.hasNextPage == false {
            self .loadComplete(isSuccess: true)
            return
        }
        self.articleListService.getArticleList(page: self.articleListService.paginator?.nextPage, limit: self.articleListService.paginator?.limit, category:  self.category)
    }
    
    override func loadComplete(isSuccess: Bool) {
        if (self.tableView.mj_header.isRefreshing()) {
            self.tableView.mj_header.endRefreshing();
        }
        
        if (self.tableView.mj_footer.isRefreshing()) {
            if (self.hasNoMoreData == false) {
                self.tableView.mj_footer.endRefreshing();
            } else {
                self.tableView.mj_footer.endRefreshingWithNoMoreData();
            }
        }
        
        //        self.tableView.mj_footer.isHidden = !((self.newsListService.paginator?.hasNextPage)!);
        
        self.setEmptyButton(isSuccess: isSuccess);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func onCompleteSuccess(service: BaseService) {
        //如果返回有页数且不等于nil
        
        self.hasNoMoreData = !((self.articleListService.paginator?.hasNextPage)!)
        if let page = self.articleListService.paginator?.page {
            self.title = self.articleListService.title!;
            if let arr = self.articleListService.articleList {
                if Int(page)! > 1 {
                    self.articleList.append(contentsOf: arr)
                }else{
                    self.articleList = self.articleListService.articleList
                    LotteryUtil.saveArticleList(articleList: arr, category: category!)
                }
            }
        }
        
        self.loadSuccess();
    }
    
    override func loadSuccess(){
        self.tableView.reloadData()
        self.loadComplete(isSuccess: true);
        
    }
    
}
