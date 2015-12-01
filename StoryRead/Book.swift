// 
// Book.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/25.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Foundation
import SQLite

class Book {
	static let me = Table("Book")
	static let bookId = Expression<Int>("bookId")
	static let book_webId = Expression<Int>("webId")
	static let bookUrl = Expression<String>("bookUrl")
	static let bookName = Expression<String>("bookName")

    static let chapterCount = Expression<Int>("chapterCount")

	static let readLine = Expression<Int>("readLine")
	static let readChapterId = Expression<Int>("readChapterId")

}