// 
// LoadBookController.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/29.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Cocoa

class LoadBookController: NSViewController {

	@IBOutlet weak var bookList : NSComboBox!

	@IBOutlet weak var submit : NSButton!

	var loadChapter: NSButton!
    
    var booksDic :Dictionary<Int ,Int>!

	var popover : NSPopover!

	var bookId : Int = 0
    
    var changed: Bool = false

	init?(nibName: String?, bundle : NSBundle? , popover: NSPopover , loadChapter : NSButton) {
		self.popover = popover
		self.loadChapter = loadChapter
		super.init(nibName: nibName, bundle: bundle)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidAppear() {
		submit.enabled = true
		bookList.removeAllItems()
        booksDic = Dictionary<Int ,Int>()
		var has = false
        var bookIndex = 0
		for book in try! DataBase.db.prepare(Book.me) {
			has = true
            let bid = book[Book.bookId]
            if bid == bookId {
                bookIndex = booksDic.count
            }
            booksDic.updateValue(bid, forKey: booksDic.count)
			bookList.addItemWithObjectValue(book[Book.bookName])
		}

		if has {
            bookList.selectItemAtIndex(bookIndex)
		}else {
			CommonKit.getAlert("Warnning Message", message: "Please add book first").runModal()
			popover.performClose(nil)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
	}


	@IBAction func loadBook(sender: NSButton) {
		sender.enabled = false
		if bookList.objectValueOfSelectedItem == nil {
			CommonKit.getAlert("Error", message: "You must select a book").runModal()
			sender.enabled = true
			return
		}
        let cbId = booksDic[bookList.indexOfSelectedItem]
        if bookId != cbId {
            changed = true
        }
        bookId = cbId!
        if bookId == 0 {
			CommonKit.getAlert("Error", message: "You must select a book").runModal()
			sender.enabled = true
			return
		}
        loadChapter.hidden = false
		popover.performClose(nil)
		sender.enabled = false
	}

}
