// 
// DataBase.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/26.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Foundation
import SQLite
import Cocoa

class DataBase {

	static var path = NSSearchPathForDirectoriesInDomains(
		.ApplicationSupportDirectory, .UserDomainMask, true
	).first! + "/" + NSBundle.mainBundle().bundleIdentifier!

	static var db: Connection!

	static func createTable(createNew : Bool) {

		if createNew {
			try! db.run(WebConfig.me.drop(ifExists: true))
		}
		try! db.run(WebConfig.me.create(ifNotExists: true) {
				t in
				t.column(WebConfig.webId, primaryKey: .Autoincrement)
				t.column(WebConfig.webName, unique: true)
				t.column(WebConfig.webSiteUrl)
				t.column(WebConfig.catalogRegex)
				t.column(WebConfig.bookNamePath)
				t.column(WebConfig.chapterUrlPath)
				t.column(WebConfig.chapterNamePath)
				t.column(WebConfig.contentPath)

			})
		if createNew {
			try! db.run(Book.me.drop(ifExists: true))
		}
		try! db.run(Book.me.create(ifNotExists: true) {
				t in
				t.column(Book.bookId, primaryKey: .Autoincrement)
				t.column(Book.book_webId, references: WebConfig.me , WebConfig.webId)
				t.column(Book.bookUrl)
				t.column(Book.chapterCount)
				t.column(Book.bookName)
				t.column(Book.readLine)
				t.column(Book.readChapterId)
			})

		if createNew {
			try! db.run(Chapter.me.drop(ifExists: true))
		}
		try! db.run(Chapter.me.create(ifNotExists: true) {
				t in
				t.column(Chapter.chapterId, primaryKey: .Autoincrement)
				t.column(Chapter.chapter_bookId, references : Book.me, Book.bookId)
				t.column(Chapter.chapterName)
				t.column(Chapter.chapterUrl)
				t.column(Chapter.chapterContent)
			})

		if createNew {
			try! db.run(Config.me.drop(ifExists: true))
		}
		try! db.run(Config.me.create(ifNotExists: true) {
				t in
				t.column(Config.configId, primaryKey: .Autoincrement)
				t.column(Config.readBookId, references: Book.me , Book.bookId)
			})


	}
}