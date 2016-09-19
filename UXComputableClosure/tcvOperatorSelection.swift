//
//  tcvOperatorSelection.swift
//  UXComputableClosure
//
//  Created by Pho Hale on 9/16/16.
//  Copyright © 2016 Pho Hale. All rights reserved.
//

import Cocoa

open class tcvOperatorSelection: NSTableCellView {
	
	@IBOutlet open weak var comboOperatorSelect: NSComboBox!
	@IBOutlet open weak var txtOperatorField: NSTextField!
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	open func getStringIndex(stringOperation: String) -> Int? {
		let rawValues: [Any] = self.comboOperatorSelect.objectValues
		let strValues = rawValues.map({ return ($0 as! String) })
		/**
		guard let strValues = self.comboOperatorSelect.objectValues as? String else {
			fatalError("couldn't get objectValues as string \(self.comboOperatorSelect)")
		}
		*/
		for (index, aStringOp) in strValues.enumerated() {
			if (stringOperation == aStringOp) {
				return index
			}
		}
		return nil
	}
	
	open func setSelection(stringOperation: String) {
		guard let validIndex = self.getStringIndex(stringOperation: stringOperation) else {
			fatalError("invalid! \(stringOperation)")
		}
		self.comboOperatorSelect.selectItem(at: validIndex)
		self.comboOperatorSelect.reloadData()
	}
    
}
