// 
// AddNewWebController.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/29.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Cocoa
import SQLite

class AddNewWebController: NSViewController {

	var params : Dictionary<String, String>!

	@IBOutlet weak var name : NSTextField!
    @IBOutlet weak var webSiteUrl: NSTextField!
    @IBOutlet weak var bookNamePath: NSTextField!
	@IBOutlet weak var catalogRegex: NSTextField!
	@IBOutlet weak var chapterUrlPath: NSTextField!
    @IBOutlet weak var chapterNamePath: NSTextField!
	@IBOutlet weak var contentPath: NSTextField!

    var popover :NSPopover!
    
	@IBOutlet weak var submit: NSButton!

    init?(nibName: String?, bundle : NSBundle? , params : Dictionary<String, String>? ) {

		self.params = params

		super.init(nibName: nibName, bundle: bundle)
	}
    init?(nibName: String?, bundle : NSBundle? , params : Dictionary<String, String>? ,popover:NSPopover ) {

        self.params = params
        self.popover = popover
        super.init(nibName: nibName, bundle: bundle)
        
    }
	init() {
		super.init(nibName: "AddNewWebController", bundle: nil)!
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidAppear() {
        if params != nil {
            name.stringValue = self.params["name"]!
            catalogRegex.stringValue = self.params["catalogRegex"]!
            webSiteUrl.stringValue = self.params["webSiteUrl"]!
            chapterUrlPath.stringValue = self.params["chapterUrlPath"]!
            chapterNamePath.stringValue = self.params["chapterNamePath"]!
            bookNamePath.stringValue = self.params["bookNamePath"]!
            contentPath.stringValue = self.params["contentPath"]!
        }
        super.viewDidAppear()
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}

	@IBAction func addOrEditWeb(sender: AnyObject) {

		if name.stringValue.isEmpty || catalogRegex.stringValue.isEmpty || chapterUrlPath.stringValue.isEmpty || contentPath.stringValue.isEmpty || webSiteUrl.stringValue.isEmpty || chapterNamePath.stringValue.isEmpty {
            CommonKit.getAlert("Warning Message", message: "Some Fields can not be empty").runModal()
            return
		}
        //format
        if !webSiteUrl.stringValue.hasSuffix("/") {
            webSiteUrl.stringValue = webSiteUrl.stringValue + "/"
        }
        

		let id = try! DataBase.db.run(WebConfig.me.insert(WebConfig.webName <- name.stringValue, WebConfig.catalogRegex <-  catalogRegex.stringValue, WebConfig.chapterUrlPath <- chapterUrlPath.stringValue ,WebConfig.contentPath <- contentPath.stringValue , WebConfig.webSiteUrl <- webSiteUrl.stringValue ,WebConfig.bookNamePath <- bookNamePath.stringValue ,WebConfig.chapterNamePath <- chapterNamePath.stringValue ))
        if id > 0 {
            CommonKit.getAlert("Success Message", message: "Web Config Saved").runModal()
            popover.performClose(nil)
        }else{
            CommonKit.getAlert("Failed Message", message: "Add Web Config Failed, please check the info you filled").runModal()
            return
        }
	}

}
