// 
// LoadChapterController.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/29.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Cocoa
import SQLite

class LoadChapterController: NSViewController {

	@IBOutlet weak var chapterList : NSComboBox!

	@IBOutlet weak var submit : NSButton!

	var bookId : Int!

	var chapterId : String!

	var popover : NSPopover!

	var textView: NSTextView!

	var configContent : String!

	init?(nibName: String?, bundle : NSBundle? , popover: NSPopover , bookId : Int, textView : NSTextView) {
		self.bookId = bookId
		self.textView = textView
		self.popover = popover
		super.init(nibName: nibName, bundle: bundle)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidAppear() {
        submit.enabled = true
		chapterList.removeAllItems()
		let book = try! DataBase.db.pluck(Book.me.filter(Book.bookId == bookId))
		if book == nil {
			CommonKit.getAlert("Error Message", message: "Can not find the book ").runModal()
			popover.performClose(nil)
			return
		}else {
			let bookId = book![Book.book_webId]
			let config = try! DataBase.db.pluck(WebConfig.me.filter(WebConfig.webId == book![Book.book_webId]))
			if config == nil {
				CommonKit.getAlert("Error Message", message: "Can not find the book ").runModal()
				popover.performClose(nil)
				return
			}
			configContent = config![WebConfig.contentPath]
			let chapterId = book![Book.readChapterId]
			for chapter in try! DataBase.db.prepare(Chapter.me.filter(Chapter.chapter_bookId == bookId)) {
				chapterList.addItemWithObjectValue(NSLocalizedString(String(chapter[Chapter.chapterId]), comment: chapter[Chapter.chapterName]))
			}

			if chapterId != 0 {
				chapterList.selectItemWithObjectValue(chapterId)
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}

	@IBAction func loadChapter(sender: NSButton) {
		sender.enabled = false
		if chapterList.objectValueOfSelectedItem == nil {
			CommonKit.getAlert("Error", message: "You must select a chapter").runModal()
			sender.enabled = true
			return
		}
		let chapterId = (chapterList.objectValueOfSelectedItem as! NSString).integerValue
		if chapterId == 0 {
			CommonKit.getAlert("Error", message: "You must select a chapter").runModal()
			sender.enabled = true
			return
		}
		let chapter = try! DataBase.db.pluck(Chapter.me.filter(Chapter.chapterId == chapterId))
		if chapter == nil {
			CommonKit.getAlert("Error", message: "can not find chapter").runModal()
			sender.enabled = true
			return
		}
		if chapter![Chapter.chapterContent].isEmpty {
			let dom = CommonKit.getHtmlDom(chapter![Chapter.chapterUrl])
			let content = dom.xPath(configContent)?.first?.content
			try! DataBase.db.run(Chapter.me.filter(Chapter.chapterId == chapterId).update(Chapter.chapterContent <- content! ))
			textView.string = content
		} else {
			textView.string = chapter![Chapter.chapterContent]
		}
		popover.performClose(nil)
		sender.enabled = false
	}
}
