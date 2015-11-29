// 
// Tool.swift
// StoryRead
// 
// Created by teddyzhu on 15/11/25.
// Copyright © 2015年 teddyzhu. All rights reserved.
// 


import Foundation

class ToolKit {
    
    static let UrlPrefix = ["http://", "https://"]
    
    static let GB2312 = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))

    static let UTF8 = NSUTF8StringEncoding

	static func getRegexString(string: String, pattern: String, index: Int) -> String {

		let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)

		let res = regex.matchesInString(string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
		return (string as NSString).substringWithRange(res[index].range)
	}

	static func getRegexString(string: String, pattern: String, index: Int, option: NSRegularExpressionOptions) -> String {

		let regex = try! NSRegularExpression(pattern: pattern, options: option)

		let res = regex.matchesInString(string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
		return (string as NSString).substringWithRange(res[index].range)
	}

	static func getRegexString(string: String, pattern: String) -> [NSTextCheckingResult] {
		let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)

		let res = regex.matchesInString(string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
		return res
	}

	static func getRegexString(string: String, pattern: String, index: Int) -> NSTextCheckingResult {

		let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)

		let res = regex.matchesInString(string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
		return res[index]
	}

	static func getRegexString(string: String, pattern: String, option: NSRegularExpressionOptions) -> [NSTextCheckingResult] {
		let regex = try! NSRegularExpression(pattern: pattern, options: option)

		let res = regex.matchesInString(string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
		return res
	}

	static func getRegexString(string: String, pattern: String, index: Int, option: NSRegularExpressionOptions) -> NSTextCheckingResult {

		let regex = try! NSRegularExpression(pattern: pattern, options: option)

		let res = regex.matchesInString(string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, string.characters.count))
		return res[index]
	}
}