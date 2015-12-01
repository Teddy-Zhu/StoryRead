// 
// Config.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/30.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 

import Foundation
import SQLite

class Config {
	static let me = Table("Config")
	static let configId = Expression<Int>("configId")

	static let readBookId = Expression<Int>("readBookId")
}