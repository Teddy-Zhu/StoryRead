//
//  SettingsController.swift
//  StroyRead
//
//  Created by teddyzhu on 15/11/23.
//  Copyright © 2015年 teddyzhu. All rights reserved.
//

import Cocoa

class SettingsController: NSViewController {

    var fontName = "Courier"
    var fontSize = 0
    
    @IBOutlet weak var fontNameSelect:NSComboBox!
    
    @IBOutlet weak var fontSizeText:NSTextField!
    
    @IBOutlet weak var add:NSButton!
    
    @IBOutlet weak var min:NSButton!
    
    init?(nibName: String?, bundle : NSBundle? , fontName: String , fontSize : Int) {
        self.fontName = fontName
        self.fontSize = fontSize
        super.init(nibName: nibName, bundle: bundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fontName.isEmpty{
            fontNameSelect.selectItemAtIndex(0)
        }else{
            fontNameSelect.selectText(fontName)
        }
        resetFont()
        // Do view setup here.
    }
    
    @IBAction func ADD(sender:AnyObject){
        self.fontSize += 1
        resetFont()
    }
    
    @IBAction func Minus(sender:AnyObject){
        if(self.fontSize > 1){
            self.fontSize -= 1
            resetFont()
        }
    }
    
    @IBAction func fontChange(sender:AnyObject){
        self.fontName = fontNameSelect.stringValue
        resetFont()
    }
    func resetFont(){
        print(fontSize)
        fontSizeText.font = NSFont.systemFontOfSize(CGFloat(fontSize))
        //fontSizeText.stringValue = "test"
    }
}
