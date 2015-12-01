// 
// StoryWebConfig.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/25.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Foundation
import SQLite

class WebConfig {
    
    static let me = Table("WebConfig")
    
    static let webId = Expression<Int>("webId")
    static let webName = Expression<String>("webName")
    static let webSiteUrl = Expression<String>("webSiteUrl")
    static let catalogRegex = Expression<String>("catalogRegex")
    static let bookNamePath = Expression<String>("bookNamePath")
    static let chapterUrlPath = Expression<String>("chapterUrlPath")
    static let chapterNamePath = Expression<String>("chapterNamePath")
    static let titlePath = Expression<String>("titlePath")
    static let contentPath = Expression<String>("contentPath")
    
}


