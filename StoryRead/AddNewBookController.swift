// 
// AddNewBookController.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/29.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Cocoa
import SQLite

class AddNewBookController: NSViewController {

	@IBOutlet weak var bookUrl : NSTextField!

	@IBOutlet weak var submit : NSButton!

	var popover : NSPopover!

	init?(nibName: String?, bundle : NSBundle? , popover: NSPopover ) {

		self.popover = popover
		super.init(nibName: nibName, bundle: bundle)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    override func viewDidAppear() {
        bookUrl.stringValue = ""
        submit.enabled = true
        super.viewDidAppear()
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do view setup here.
	}

	@IBAction func add(sender: NSButton) {
        sender.enabled = false
		if bookUrl.stringValue.isEmpty {
            CommonKit.getAlert("Warning Message", message: "Some Fields can not be empty").runModal()
            sender.enabled = true
			return
		}
        
        bookUrl.stringValue = CommonKit.filterUrl(bookUrl.stringValue)
		// do match url 
		// get all web config
        var find = false
		for config in try! DataBase.db.prepare(WebConfig.me) {
			print("id:\(config[WebConfig.webId]),name:\(config[WebConfig.webName]),namepath:\(config[WebConfig.bookNamePath]),catalogRegex:\(config[WebConfig.catalogRegex]),chapterRegex:\(config[WebConfig.chapterUrlPath]),webSiteUrl:\(config[WebConfig.webSiteUrl]),title:\(config[WebConfig.chapterNamePath]),content:\(config[WebConfig.contentPath])")
			let result = ToolKit.getRegexString(bookUrl.stringValue, pattern: config[WebConfig.catalogRegex])
			if result.count > 0 {
                find = true
                let html = CommonKit.getHtml(bookUrl.stringValue)
                let dom = CommonKit.getDom(html)
                let webSiteUrl = config[WebConfig.webSiteUrl].hasSuffix("/") ? (config[WebConfig.webSiteUrl] as NSString).substringToIndex((config[WebConfig.webSiteUrl] as NSString).length - 1) : config[WebConfig.webSiteUrl]
                let bookName = dom.xPath(config[WebConfig.bookNamePath])!.first?.content
                let chapterUrlResult = dom.xPath(config[WebConfig.chapterUrlPath])
                let chapterNameResult = dom.xPath(config[WebConfig.chapterNamePath])

                
                let firstUrl : String = (chapterUrlResult?.first?.attributes["href"])!
                var suffix = ""
                if firstUrl.hasPrefix("/") {
                    suffix =  webSiteUrl
                } else if firstUrl.hasPrefix(ToolKit.UrlPre) {
                  suffix = ""
                } else {
                   suffix = bookUrl.stringValue.hasSuffix("/") ? bookUrl.stringValue : (bookUrl.stringValue + "/")
                }
              
                if chapterUrlResult == nil || chapterNameResult == nil || chapterUrlResult?.count != chapterNameResult?.count {
                    CommonKit.getAlert("Error Message", message: "chapter url path does not match chapter name path").runModal()
                    break;
                }
                var bookId : Int64 = 0
                try! DataBase.db.transaction {
                    bookId = try! DataBase.db.run(Book.me.insert(Book.bookUrl <- self.bookUrl.stringValue, Book.bookName <- bookName! , Book.book_webId <- config[WebConfig.webId] , Book.chapterCount <- (chapterUrlResult?.count)!, Book.readLine <- 0, Book.readChapterId <- 0 ))
 
                    for index in chapterUrlResult!.startIndex..<chapterUrlResult!.endIndex {
                        try! DataBase.db.run(Chapter.me.insert(Chapter.chapter_bookId <- Int(bookId) , Chapter.chapterName <- (chapterUrlResult?[index].content)! ,Chapter.chapterUrl <- (suffix + (chapterUrlResult?[index].attributes["href"])!) , Chapter.chapterContent <- ""))
                        print((chapterUrlResult?[index].content)!)
                    }

                }
                
                if bookId > 0 {
                    CommonKit.getAlert("Success Message", message: "Add Book [" + bookName! + "]").runModal()
                    self.popover.performClose(nil)
                    break;
                } else {
                    CommonKit.getAlert("Failed Message", message: "Add Book failed").runModal()
                    break;
                }
                sender.enabled = true
                break;
            }
		}
        if !find {
            CommonKit.getAlert("Failed Message", message: "The url do not match any rules").runModal()
            self.popover.performClose(nil)
            sender.enabled = true
        }
	}

}
