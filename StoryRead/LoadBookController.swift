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

	var popover : NSPopover!

	var bookId : Int!

	init?(nibName: String?, bundle : NSBundle? , popover: NSPopover , loadChapter : NSButton) {
		self.popover = popover
		self.loadChapter = loadChapter
		super.init(nibName: nibName, bundle: bundle)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidAppear() {
		bookId = 0
		submit.enabled = true
		bookList.removeAllItems()

		var has = false
		for book in try! DataBase.db.prepare(Book.me) {
			has = true
			bookList.addItemWithObjectValue(NSLocalizedString(String(book[Book.bookId]), comment: book[Book.bookName]))
		}

		if has {
			if bookId != nil {
				bookList.selectText(bookId)
			}else {
				bookList.selectItemAtIndex(0)
			}
		}else {
			CommonKit.getAlert("Warnning Message", message: "Please add book first")
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
		bookId = (bookList.objectValueOfSelectedItem as! NSString).integerValue
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
