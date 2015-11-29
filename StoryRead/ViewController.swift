// 
// ViewController.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/24.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Cocoa
import Ji

class ViewController: NSViewController, NSPopoverDelegate {


	@IBOutlet weak var showButton: NSButton!

	@IBOutlet weak var stroyTitle : NSTextField!

	@IBOutlet weak var stroyContent : NSScrollView!

	@IBOutlet weak var test: NSButton!

	@IBOutlet weak var read: NSButton!

	@IBOutlet weak var loadBook : NSButton!

	@IBOutlet weak var loadChapter: NSButton!

	@IBOutlet weak var addWeb : NSButton!

	@IBOutlet weak var addBook : NSButton!

	var textView : NSTextView!

	lazy var settingsPopover: NSPopover = {
		let popover = NSPopover()
		popover.behavior = .Semitransient
		popover.contentViewController = SettingsController(nibName: "SettingsController", bundle: nil, fontName: "", fontSize: 10)
		popover.delegate = self
		return popover
	}()

	lazy var addWebPopover: NSPopover = {
		let popover = NSPopover()
		popover.behavior = .Semitransient
		popover.contentViewController = AddNewWebController()
		popover.delegate = self
		return popover
	}()

	lazy var addBookPopover: NSPopover = {
		let popover = NSPopover()
		popover.behavior = .Transient
		popover.contentViewController = SettingsController(nibName: "SettingsController", bundle: nil, fontName: "", fontSize: 10)
		popover.delegate = self
		popover.appearance = NSAppearance(named: NSAppearanceNameAqua)

		return popover
	}()

	lazy var loadBookPopover: NSPopover = {
		let popover = NSPopover()
		popover.behavior = .Transient
		popover.contentViewController = SettingsController(nibName: "SettingsController", bundle: nil, fontName: "", fontSize: 10)
		popover.delegate = self
		popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
		return popover
	}()

	lazy var loadChapterPopover: NSPopover = {
		let popover = NSPopover()
		popover.behavior = .Transient
		popover.contentViewController = SettingsController(nibName: "SettingsController", bundle: nil, fontName: "", fontSize: 10)
		popover.delegate = self
		popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
		return popover
	}()

	@IBAction func showSettings(sender: NSButton) {
		print("the popover showing 😃")
		settingsPopover.showRelativeToRect(NSZeroRect, ofView: sender, preferredEdge: NSRectEdge.MaxY)
	}

	@IBAction func hideSettings(sender: NSButton) {
		if (popoverVisible) {
			settingsPopover.performClose(nil)
		}
	}

	@IBAction func ModifyContentFontSize(sender: AnyObject) {

	}

	@IBAction func test(sender: AnyObject) {
		print((settingsPopover.contentViewController as! SettingsController).fontSize)
	}

	private var popoverVisible: Bool {
		get {return settingsPopover.shown }
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		textView = (stroyContent.documentView as! NSTextView)

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "addWebPopoverWillClose:", name: NSPopoverWillCloseNotification, object: self.settingsPopover)
        
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "settingsPopoverWillClose:", name: NSPopoverWillCloseNotification, object: self.settingsPopover)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addBookPopoverWillClose:", name: NSPopoverWillCloseNotification, object: self.addWebPopover)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadBookPopoverWillClose:", name: NSPopoverWillCloseNotification, object: self.loadBookPopover)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadChapterPopoverWillClose:", name: NSPopoverWillCloseNotification, object: self.loadChapterPopover)
        


		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject? {
		didSet {
			// Update the view, if already loaded.
		}
	}

	@IBAction func loadHTML(sender: AnyObject) {
		// DataBase.createTable();
		// let book = Book()
		// let dom  = book.getHtmlDom("http://www.miaobige.com/read/8343/3613394.html")
		// let titleNode = dom.xPath("//head/title")?.first
		// print("title: \(titleNode?.content)")

		// /// 1、获得沙盒的根路径
		// let home = NSHomeDirectory() as NSString;
		// /// 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
		// let docPath = home.stringByAppendingPathComponent("Documents") as NSString;
		// /// 3、获取文本文件路径
		// let filePath = docPath.stringByAppendingPathComponent("datatest.plist")
		// let dataSource = NSMutableArray()
		// dataSource.addObject(book.getHtmlDom("http://www.miaobige.com/read/8343/3613394.html").data!)
		// 
		// print("\(filePath)");
		// print(dataSource.writeToFile(filePath, atomically: true))


	}

	@IBAction func read(sender: AnyObject) {
		// let dom  =
		// let titleNode = dom!.xPath("//head/title")?.first
		// print("title: \(titleNode?.content)")

		// /// 1、获得沙盒的根路径
		// let home = NSHomeDirectory() as NSString;
		// /// 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
		// let docPath = home.stringByAppendingPathComponent("Documents") as NSString;
		// /// 3、获取文本文件路径
		// let filePath = docPath.stringByAppendingPathComponent("datatest.plist")
		// let dataSource = NSMutableArray()
		// dataSource.addObject(book.getHtmlDom("http://www.miaobige.com/read/8343/3613394.html").data!)
		// 
		// print("\(filePath)");
		// print(dataSource.writeToFile(filePath, atomically: true))

	}

	@IBAction func loadBook(sender : AnyObject) {
		loadChapter.hidden = false
	}

	@IBAction func loadChapter(sender: AnyObject) {

	}

	@IBAction func addWebConfig(sender: NSButton) {
		addWebPopover.showRelativeToRect(NSZeroRect, ofView: sender, preferredEdge: NSRectEdge.MaxY)

	}

	@IBAction func addBook(sender: AnyObject) {

	}

	func addWebPopoverWillClose(notification: NSNotification) {
		print("web close")
	}

	func settingsPopoverWillClose(notification: NSNotification) {

		textView.textStorage?.font = NSFont.systemFontOfSize(CGFloat((settingsPopover.contentViewController as! SettingsController).fontSize))
		print("the popover closed 😂")
		(stroyContent.documentView as! NSTextView).string = "2222"
		print(textView.string)
		print(textView.textStorage?.string)
	}
    
    func addBookPopoverWillClose(notification: NSNotification) {
        print("add book close")
    }
    
    func loadBookPopoverWillClose(notification: NSNotification) {
        print("load book close")
    }
    
    func loadChapterPopoverWillClose(notification: NSNotification) {
        print("load chapter close")
    }

}

