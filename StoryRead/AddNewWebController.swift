// 
// AddNewWebController.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/29.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Cocoa

class AddNewWebController: NSViewController {

	var params : Dictionary<String, String>!

	@IBOutlet weak var name : NSTextField!
	@IBOutlet weak var catalogRegex: NSTextField!
	@IBOutlet weak var catalogIndex: NSTextField!
	@IBOutlet weak var chapterRegex: NSTextField!
	@IBOutlet weak var chapterIndex: NSTextField!
	@IBOutlet weak var titleRegex: NSTextField!
	@IBOutlet weak var titleIndex: NSTextField!
	@IBOutlet weak var contentRegex: NSTextField!
	@IBOutlet weak var contentIndex: NSTextField!


	@IBOutlet weak var submit: NSButton!

	init?(nibName: String?, bundle : NSBundle? , params : Dictionary<String, String> ) {
		// self.name = name
		// self.catalogRegex = catalogRegex
		// self.catalogIndex = catalogIndex
		// self.chapterRegex = chapterRegex
		// self.chapterIndex = chapterIndex
		// self.titleRegex = titleRegex
		// self.titleIndex = titleIndex
		// self.contentRegex = contentRegex
		// self.contentIndex = contentIndex

		self.params = params

		super.init(nibName: nibName, bundle: bundle)
	}
	init() {
		super.init(nibName: "AddNewWebController", bundle: nil)!
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		if params != nil {
			name.stringValue = self.params["name"]!
			catalogRegex.stringValue = self.params["catalogRegex"]!
			catalogIndex.stringValue = self.params["catalogIndex"]!
			chapterRegex.stringValue = self.params["chapterRegex"]!
			chapterIndex.stringValue = self.params["chapterIndex"]!
			titleRegex.stringValue = self.params["titleRegex"]!
			titleIndex.stringValue = self.params["titleIndex"]!
			contentRegex.stringValue = self.params["contentRegex"]!
			contentIndex.stringValue = self.params["contentIndex"]!
		}


		// Do view setup here.
	}

	@IBAction func addOrEditWeb(sender: AnyObject) {
		let id = try! DataBase.db.run(DataBase.webConfig.i)
        
        //DataBase.webName <- "妙笔阁", DataBase.catalogRegex <- "http://www.miaobige.com/read/(.*?)/", DataBase.catalogIndex <- 0
	}

}
