// 
// CommomKit.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/26.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Foundation
import Ji

class CommonKit {

	static func getHtml(url: String, complete: (String) -> Bool) {
		let filteredUrl = filterUrl(url)

		let request: NSURLRequest = NSURLRequest(URL: NSURL(string: filteredUrl)!)

		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
				(response, data, error) -> Void in

				if error != nil {
					// Handle Error here
				}else {
					var originStr = NSString(data: data!, encoding: ToolKit.GB2312);
					var isGBK = true
					if originStr == nil {
						isGBK = false
						originStr = NSString(data: data!, encoding: ToolKit.UTF8);
					}
					var str: String = originStr as! String
					if (isGBK) {
						str = str.stringByReplacingOccurrencesOfString("charset=gbk", withString: "charset=utf-8", options: NSStringCompareOptions.CaseInsensitiveSearch)
						str = str.stringByReplacingOccurrencesOfString("charset=gbk2312", withString: "charset=utf-8", options: NSStringCompareOptions.CaseInsensitiveSearch)
					}

					complete(str)
					// Handle data in NSData type
				}

			})
	}


	static func getHtml(url: String) -> String {
		let filteredUrl = filterUrl(url)
		let data = NSData(contentsOfURL: NSURL(string: filteredUrl)!)
		var originStr = try! NSString(data: data!, encoding: ToolKit.GB2312);
		var isGBK = true
		if originStr == nil {
			isGBK = false
			originStr = NSString(data: data!, encoding: ToolKit.UTF8);
		}
		var str: String = originStr as! String
		if (isGBK) {
			str = str.stringByReplacingOccurrencesOfString("charset=gbk", withString: "charset=utf-8", options: NSStringCompareOptions.CaseInsensitiveSearch)
			str = str.stringByReplacingOccurrencesOfString("charset=gbk2312", withString: "charset=utf-8", options: NSStringCompareOptions.CaseInsensitiveSearch)
		}
		return str
	}

	static func getHtmlDom(url: String) -> Ji {
		return Ji(htmlString : getHtml(url), encoding: ToolKit.UTF8)!
	}

	static func getDom(htmlString: String) -> Ji {
		return Ji(htmlString : htmlString , encoding: ToolKit.UTF8)!
	}
    
	static func filterUrl(url: String) -> String {
		return url.hasPrefix(ToolKit.UrlPrefix[0]) ? url : url.hasPrefix(ToolKit.UrlPrefix[1]) ? url : (ToolKit.UrlPrefix[0] + url)
	}

	static func getAlert(title: String, message: String) -> NSAlert {
		let alertView = NSAlert()
		alertView.messageText = title
		alertView.informativeText = message
		alertView.alertStyle = NSAlertStyle.InformationalAlertStyle
		return alertView
	}

}