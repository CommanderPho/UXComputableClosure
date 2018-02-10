//
//  UXComputingRowTemplate.swift
//  UXComputableClosure
//
//  Created by Pho Hale on 9/16/16.
//  Copyright © 2016 Pho Hale. All rights reserved.
//

import Cocoa

open class vValidationView: NSView {
	var view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 22.0))
	var button = NSButton(frame: NSRect(x: 0, y: 2.0, width: 70.0, height: 18.0))
	var textField = NSTextField(frame: NSRect(x: 80.0, y: 2.0, width: 220.0, height: 18.0))
	
	public override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.setupControls()
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setupControls()
	}
	
	func setupControls() {
		self.button.title = "Validate"
		self.button.bezelStyle = .recessed
		self.button.target = self
		self.button.action = #selector(vValidationView.validationAction(sender:))
		
		self.textField.isBordered = false
		self.textField.stringValue = "This is a custom message"
		self.textField.drawsBackground = false
		self.textField.textColor = NSColor.red
		
		self.view.addSubview(self.button)
		self.view.addSubview(self.textField)
	}
	
	@IBAction func validationAction(sender: AnyObject) {
			debugPrint("validationAction: \(sender)")
	}
	
}


open class UXComputingRowTemplate: NSPredicateEditorRowTemplate {
	
	var validationView: vValidationView?
	var definedPredicate: NSCompoundPredicate? {
		didSet {
			guard let validDefinedPredicate = self.definedPredicate else {
				debugPrint("Couldn't build DefinedPredicate!")
				let fallbackPredicate = NSPredicate(value: true)
				self.setPredicate(NSCompoundPredicate(orPredicateWithSubpredicates: [fallbackPredicate]))
				//self.setPredicate(fallbackPredicate)
				return
			}
			self.setPredicate(validDefinedPredicate)
		}
	}
	
	/**
	public override init(leftExpressions: [NSExpression], rightExpressions: [NSExpression], modifier: NSComparisonPredicate.Modifier, operators: [NSNumber], options: Int) {
		let definedVariables: [NSExpression] = [NSExpression.init(forConstantValue: "X[i]")]
		let definedModifier = NSComparisonPredicate.Modifier.direct
		let definedOperators: [NSNumber] = [NSNumber(value: NSComparisonPredicate.Operator.equalTo.rawValue)]
		let definedOptionsList: [NSExpression] = [NSExpression.init(forConstantValue: "T0"), NSExpression.init(forConstantValue: "T1"), NSExpression.init(forConstantValue: "T2")]
		
		super.init(leftExpressions: definedVariables, rightExpressions: definedOptionsList, modifier: definedModifier, operators: definedOperators, options: 0)
	}
	*/
	/**
	open override func setPredicate(_ predicate: NSPredicate) {
		super.setPredicate(predicate)
		
		for aView in self.templateViews {
			aView.setP
		}
		
		
	}
	*/
	
	public override init() {
		super.init()
		self.validationView = vValidationView()
		self.definedPredicate = NSCompoundPredicate()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.validationView = vValidationView(coder: aDecoder)
		self.definedPredicate = NSCompoundPredicate(coder: aDecoder)
	}
	
	public init(variableList: [String], optionsList: [String]) {
		let definedVariables: [NSExpression] = variableList.map({ return NSExpression.init(forConstantValue: $0) })
		let definedModifier = NSComparisonPredicate.Modifier.direct
		let definedOperators: [NSNumber] = [NSNumber(value: NSComparisonPredicate.Operator.equalTo.rawValue)]
		let definedOptionsList: [NSExpression] = optionsList.map({ return NSExpression.init(forConstantValue: $0) })

		super.init(leftExpressions: definedVariables, rightExpressions: definedOptionsList, modifier: definedModifier, operators: definedOperators, options: 0)
		
		self.definedPredicate = self.buildPredicate(definedVariables: definedVariables, definedOperators: definedOperators, definedOptionsList: definedOptionsList)
		
		self.setPredicate(self.definedPredicate!)
		
	}
	
	func buildPredicate(definedVariables: [NSExpression], definedOperators: [NSNumber], definedOptionsList: [NSExpression]) -> NSCompoundPredicate {
		var newSubPredicateArray = [NSPredicate]()
		
		for aVariable in definedVariables {
			for anOption in definedOptionsList {
				let definedPredicate = NSComparisonPredicate(leftExpression: aVariable, rightExpression: anOption, modifier: NSComparisonPredicate.Modifier.direct, type: NSComparisonPredicate.Operator.equalTo, options: NSComparisonPredicate.Options.caseInsensitive)
				newSubPredicateArray.append(definedPredicate)
			}
		}
		
		let definedPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.or, subpredicates: newSubPredicateArray)
		return definedPredicate
	}
	
	override open var templateViews: [NSView] {
		var defaultViews: [NSView] = super.templateViews
		guard let validValidationView = self.validationView else {
			debugPrint("No validationView set yet!")
			return defaultViews
		}
		defaultViews.append(validValidationView)
		return defaultViews
	}
	
	
	open override func match(for predicate: NSPredicate) -> Double {
		
		let result = predicate.evaluate(with: self)
		debugPrint("match: \(predicate) \(result)")
		return 1.0
	}
	
	
	
}
