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

    var chaptersDic : Dictionary<Int,Int>!
    
	var chapterId : Int!

	var popover : NSPopover!

	var textView: NSTextView!

	var configContent : String!
    
    var storyTitle :NSTextField!

    init?(nibName: String?, bundle : NSBundle? , popover: NSPopover , bookId : Int, textView : NSTextView,title:NSTextField){
		self.bookId = bookId
		self.textView = textView
		self.popover = popover
        self.storyTitle = title
		super.init(nibName: nibName, bundle: bundle)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidAppear() {
        
        submit.enabled = true
		
        if chaptersDic == nil || chaptersDic.count == 0 {
            chapterList.removeAllItems()
            chaptersDic = Dictionary<Int ,Int>()
            
            let book = try! DataBase.db.pluck(Book.me.filter(Book.bookId == bookId))
            if book == nil {
                CommonKit.getAlert("Error Message", message: "Can not find the book ").runModal()
                popover.performClose(nil)
                return
            }else {
                let bookId = book![Book.bookId]
                let config = try! DataBase.db.pluck(WebConfig.me.filter(WebConfig.webId == book![Book.book_webId]))
                if config == nil {
                    CommonKit.getAlert("Error Message", message: "Can not find the book ").runModal()
                    popover.performClose(nil)
                    return
                }
                configContent = config![WebConfig.contentPath]
                chapterId = book![Book.readChapterId] as Int
                var chapterIndex = 0
                for chapter in try! DataBase.db.prepare(Chapter.me.filter(Chapter.chapter_bookId == bookId)) {
                    let cid = chapter[Chapter.chapterId]
                    if chapterId == cid {
                        chapterIndex = chaptersDic.count
                    }
                    chaptersDic.updateValue(cid , forKey: chaptersDic.count)
                    chapterList.addItemWithObjectValue(chapter[Chapter.chapterName])
                }
                chapterList.selectItemAtIndex(chapterIndex)

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
        chapterId = chaptersDic[chapterList.indexOfSelectedItem]
		if chapterId == 0 {
			CommonKit.getAlert("Error", message: "You must select a chapter").runModal()
			sender.enabled = true
			return
		}
		let chapter = try! DataBase.db.pluck(Chapter.me.filter(Chapter.chapterId == chapterId!))
		if chapter == nil {
			CommonKit.getAlert("Error", message: "can not find chapter").runModal()
			sender.enabled = true
			return
		}
		if chapter![Chapter.chapterContent].isEmpty {
			let dom = CommonKit.getHtmlDom(chapter![Chapter.chapterUrl])
			var content = dom.xPath(configContent)?.first?.description
            content = content?.replaceRegex("<(?!br\\s*)[^>]+>", with: "").replaceRegex("</(?!\\s*br)[^>]+>", with: "").replaceRegex("\n", with: "\n   ").replaceRegex("<br\\s*>", with: "\n   ").replaceRegex("</\\s*br>", with: "\n   ")
			try! DataBase.db.run(Chapter.me.filter(Chapter.chapterId == chapterId!).update(Chapter.chapterContent <- content! ))
			textView.string = content
		} else {
			textView.string = chapter![Chapter.chapterContent]
		}
        storyTitle.stringValue = chapter![Chapter.chapterName]
        try! DataBase.db.run(Book.me.filter(Book.bookId == bookId).update(Book.readChapterId <- chapterId!))
        if popover.shown {
            popover.performClose(nil)
        }
		sender.enabled = true
	}
}
