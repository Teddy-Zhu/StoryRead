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

	static let webConfig = Table(String(Mirror(reflecting: WebConfig()).subjectType).componentsSeparatedByString(".").first!)
	static let webId = Expression<Int>("webId")
	static let webName : Expression<String> = Expression<String>("webName")
	static let catalogRegex = Expression<String>("catalogRegex")
	static let catalogIndex = Expression<Int>("catalogIndex")
	static let chapterRegex = Expression<String>("chapterRegex")
	static let chapterIndex = Expression<Int>("chapterIndex")
	static let titleRegex = Expression<String>("titleRegex")
	static let titleIndex = Expression<Int>("titleIndex")
	static let contentRegex = Expression<String>("contentRegex")
	static let contentIndex = Expression<Int>("contentIndex")

	static let chapter = Table(String(Mirror(reflecting: Chapter()).subjectType).componentsSeparatedByString(".").first!)

	static let chapterId = Expression<Int>("chapterId")

	static let chapterUrl = Expression<String>("chapterUrl")

	static let chapteName = Expression<String>("chapteNname")

	static let chapterContent = Expression<String>("chapterContent")

	// create book table
	static let book = Table(String(Mirror(reflecting: Book()).subjectType).componentsSeparatedByString(".").first!)

	static let bookId = Expression<Int>("bookId")
	static let book_webId = Expression<Int>("webId")
	static let bookUrl = Expression<String>("bookUrl")
	static let bookName = Expression<String>("bookName")
	static let readLine = Expression<Int>("readLine")
	static let readChapterId = Expression<Int>("readChapterId")

	static func createTable() {

		try! db.run(webConfig.drop(ifExists: true))
		try! db.run(webConfig.create {
				t in
				t.column(webId, primaryKey: .Autoincrement)
				t.column(webName, unique: true)
				t.column(catalogRegex)
				t.column(catalogIndex)
				t.column(chapterRegex)
				t.column(chapterIndex)
				t.column(titleRegex)
				t.column(titleIndex)
				t.column(contentRegex)
				t.column(contentIndex)
			})


		try! db.run(chapter.drop(ifExists: true))
		try! db.run(chapter.create {
				t in
				t.column(chapterId, primaryKey: .Autoincrement)
				t.column(chapteName, unique: true)
				t.column(chapterUrl)
				t.column(chapterContent)
			})

		try! db.run(book.drop(ifExists: true))
		try! db.run(book.create {
				t in
				t.column(bookId, primaryKey: .Autoincrement)
				t.column(book_webId, references: webConfig , webId)
				t.column(bookUrl)
				t.column(bookName , unique : true)
				t.column(readLine)
				t.column(readChapterId , references: chapter , chapterId)
			})


	}
}