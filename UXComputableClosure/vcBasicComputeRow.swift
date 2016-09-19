//
//  vcBasicComputeRow.swift
//  UXComputableClosure
//
//  Created by Pho Hale on 9/16/16.
//  Copyright © 2016 Pho Hale. All rights reserved.
//

import Foundation
import AppKit
import Cocoa

class vcBasicComputeRow: NSViewController {

	@IBOutlet weak var veView: NSVisualEffectView!
	@IBOutlet weak var tblMain: NSTableView!
	
	var operationRows: [OperationClosure] = [OperationClosure]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.operationRows.append(OperationClosure(variable: "X[i]", operation: "*", constantValue: "2.0", extra: "aString"))
        // Do view setup here.
		
	}
	
	override func viewWillAppear() {
		super.viewWillAppear()
		self.tblMain.reloadData()
	}
	
	let colIDs: [String] = ["colVariable", "colOperator", "colConstant", "colExtra"]
    let cellIDs = ["cellLabelVariable", "cellComboOperator", "cellTextConstant", "cellTextExtra"]
}

struct OperationClosure {
	var variable: String
	var operation: String
	var constantValue: String
	var extra: String
}


extension vcBasicComputeRow: NSTableViewDataSource, NSTableViewDelegate {
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		//var cellView: NSView
		
		guard let validColumn = tableColumn else {
			debugPrint("Invalid column \(tableColumn); row \(row)")
			fatalError("INVALID COLUMN")
		}
		
		let opRowEntry = self.operationRows[row]
		
		switch validColumn.identifier {
		case "colVariable":
			let cellView = tableView.make(withIdentifier: "cellLabelVariable", owner: self) as! NSTableCellView
			cellView.textField?.stringValue = opRowEntry.variable
			return cellView
		case "colOperator":
			let cellView = tableView.make(withIdentifier: "cellComboOperator", owner: self) as! tcvOperatorSelection
			cellView.setSelection(stringOperation: opRowEntry.operation)
			return cellView
		case "colConstant":
			let cellView = tableView.make(withIdentifier: "cellTextConstant", owner: self) as! NSTableCellView
			cellView.textField?.stringValue = opRowEntry.constantValue
			cellView.textField?.isEditable = true
			return cellView
		case "colExtra":
			let cellView = tableView.make(withIdentifier: "cellTextExtra", owner: self) as! NSTableCellView
			cellView.textField?.stringValue = opRowEntry.extra
			return cellView
		default:
			fatalError("ERROR")
		}
		
		return nil
	}
	/**
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		
		guard let validColumn = tableColumn else {
			debugPrint("Invalid column \(tableColumn); row \(row)")
			return "INVALID COLUMN"
		}
		
		let opRowEntry = self.operationRows[row]
		
		switch validColumn.identifier {
		case "colVariable":
			return opRowEntry.variable
		case "colOperator":
			return opRowEntry.operation
		case "colConstant":
			return opRowEntry.constantValue
		case "colExtra":
			return opRowEntry.extra
		default:
			return "ERROR"
		}
	}
	
	func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
		
		guard let validColumn = tableColumn else {
			debugPrint("Invalid column \(tableColumn); row \(row)")
			return
		}
	
		guard let validStringValue = object as? String else {
			fatalError("couldn't cast object as string \(object)")
		}
		
		switch validColumn.identifier {
		case "colVariable":
			self.operationRows[row].variable = validStringValue
		case "colOperator":
			self.operationRows[row].operation = validStringValue
		case "colConstant":
			self.operationRows[row].constantValue = validStringValue
		case "colExtra":
			self.operationRows[row].extra = validStringValue
		default:
			fatalError("Invalid row")
		}
	}
	
	func tableView(_ tableView: NSTableView, shouldTrackCell cell: NSCell, for tableColumn: NSTableColumn?, row: Int) -> Bool {
		guard let validColumn = tableColumn else {
			debugPrint("Invalid column \(tableColumn); row \(row)")
			return false
		}
		
		guard let validCell = validColumn.dataCell(forRow: row) as? NSCell else {
			debugPrint("Invalid cell \(validColumn)")
			return false
		}
		
		guard let validCellID = validCell.identifier else {
			debugPrint("Invalid cellID \(validCell)")
			return false
		}
		
		switch validCellID {
		case "cellLabelVariable":
			return false
		case "cellComboOperator":
			return false
		case "cellTextConstant":
			return true
		case "cellTextExtra":
			return false
		default:
			fatalError("Invalid row")
		}
	}
	
	
	func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
		
		guard let validColumn = tableColumn else {
			debugPrint("Invalid column \(tableColumn); row \(row)")
			let cell = tableColumn?.dataCell as! NSCell
			return cell
			//fatalError("Invalid column!")
		}
		
		
		let opRowEntry = self.operationRows[row]
		
		switch validColumn.identifier {
		case "colVariable":
			let cell = tableColumn?.dataCell as! NSTextFieldCell
			cell.stringValue = opRowEntry.variable
			return cell
		case "colOperator":
			let cell = tableColumn?.dataCell as! NSComboBoxCell
			let potentialIndex = cell.indexOfItem(withObjectValue: opRowEntry.operation)
			cell.selectItem(at: potentialIndex)
			cell.reloadData()
			return cell
		case "colConstant":
			let cell = tableColumn?.dataCell as! NSTextFieldCell
			cell.stringValue = opRowEntry.constantValue
			return cell
		default:
			let cell = tableColumn?.dataCell as! NSCell
			cell.backgroundStyle = .dark
			return cell
		}
	}
*/
	/**
	func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
		
		guard let validColumn = tableColumn else {
			debugPrint("Invalid column \(tableColumn); row \(row)")
			return
		}
		
		var activeCell: NSCell!
		
		if let validCell = cell as? NSCell {
			activeCell = validCell
		}
		else {
			debugPrint("Invalid cell \(cell)")
			let validCell = validColumn.dataCell as! NSCell
			activeCell = validCell
		}
		
		guard let validCellID = activeCell.identifier else {
			debugPrint("Invalid cellID \(activeCell)")
			return
		}
		
		switch validCellID {
		case "cellLabelVariable":
			let finalCell = activeCell as! NSTextFieldCell
		case "cellComboOperator":
			let finalCell = activeCell as! NSComboBoxCell
		case "cellTextConstant":
			let finalCell = activeCell as! NSTextFieldCell
			finalCell.isEditable = true
		case "cellTextExtra":
			let finalCell = activeCell as! NSTextFieldCell
		default:
			fatalError("Invalid row")
		}

	}
	*/
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return self.operationRows.count
	}
	
}
