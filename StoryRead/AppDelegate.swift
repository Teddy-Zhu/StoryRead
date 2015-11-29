// 
// AppDelegate.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/24.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 
import AppKit
import Cocoa
import SQLite


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	let debug = true

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		// Insert code here to initialize your application
		if debug {
			DataBase.path = "/Users/teddyzhu/Library/Developer/Xcode/DerivedData/StoryRead-enqpckycpuqwmqfucwvvjpzkiraz/Build/Products/Debug/"
		}
		if NSFileManager.defaultManager().fileExistsAtPath(DataBase.path, isDirectory: nil) {
			try! NSFileManager.defaultManager().createDirectoryAtPath(DataBase.path, withIntermediateDirectories: true, attributes: nil);
		}
		DataBase.db = try! Connection("\(DataBase.path)/storyRead.sqlite3")

	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application

	}


}

