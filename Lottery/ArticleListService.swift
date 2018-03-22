//
//  NewsListService.swift
//  Lottery
//
//  Created by zhaohuan on 2017/7/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Paginator: BaseModel {
    
    var page : String?
    var limit: String?
    var nextPage: String?
    var hasNextPage: Bool = true
    
    
    
}

class ArticleListService: BaseService {

    var articleList : Array<ArticleModel>!
    var paginator : Paginator?
    var title: String?

    
    func getArticleList(page:String?,limit:String?,category:Int?){
        var parameters = Dictionary<String, Any>();
        if let page = page {
            parameters["page"] = page
            
        }
        if let limit = limit {
            parameters["limit"] = limit

        }
        if let category = category{
            parameters["category"] = category
        }
        self.get(HTTPConstants.NEWS, parameters: parameters, success: { (json) in
            self.articleList = [ArticleModel].deserialize(from: json["articleList"].rawString()!) as? Array<ArticleModel>
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString())
            self.title = json["title"].string;
            self.onCompleteSuccess();

            
        }) { (json) -> Bool in
            return false
        }

    }
    
}


