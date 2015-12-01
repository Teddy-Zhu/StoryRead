// 
// Charpter.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/26.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Foundation
import SQLite

class Chapter {
	static let me = Table("Chapter")

	static let chapterId = Expression<Int>("chapterId")

	static let chapter_bookId = Expression<Int>("chapter_bookId")

	static let chapterUrl = Expression<String>("chapterUrl")

	static let chapterName = Expression<String>("chapterNname")

	static let chapterContent = Expression<String>("chapterContent")
}