//
//  CommomKit.swift
//  StoryRead
//
//  Created by teddyzhu on 15/11/26.
//  Copyright © 2015年 teddyzhu. All rights reserved.
//

import Foundation
import Ji

class CommonKit {
    
//    func getHtmlDom(url: String) -> Ji {
//        let filteredUrl = filterUrl(url)
//        return catalog != nil && catalog[filteredUrl] != nil ? Ji(htmlString:catalog[filteredUrl]! as String,encoding:ToolKit.UTF8)! : createDom(filteredUrl)
//    }
//    
//    func createDom(url : String) -> Ji {
//        let data = NSData(contentsOfURL: NSURL(string: url)!)
//        var str = NSString(data: data!, encoding: ToolKit.GB2312)?.capitalizedString;
//        var isGBK = true
//        if str == nil {
//            isGBK = false
//            str = NSString(data: data!, encoding: ToolKit.UTF8 )?.capitalizedString;
//        }
//        if(isGBK){
//            str = str!.stringByReplacingOccurrencesOfString("charset=gbk", withString: "charset=utf-8", options: NSStringCompareOptions.CaseInsensitiveSearch)
//            str = str!.stringByReplacingOccurrencesOfString("charset=gbk2312", withString: "charset=utf-8", options: NSStringCompareOptions.CaseInsensitiveSearch)
//        }
//        let dom = Ji(htmlString : str! , encoding: ToolKit.UTF8)
//        return dom!
//    }
//    
//    func filterUrl(url: String) -> String {
//        return url.hasPrefix(ToolKit.UrlPrefix[0]) ? url : url.hasPrefix(ToolKit.UrlPrefix[1]) ? url : (ToolKit.UrlPrefix[0] + url)
//    }

}