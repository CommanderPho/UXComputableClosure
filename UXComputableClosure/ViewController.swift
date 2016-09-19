//
//  ViewController.swift
//  UXComputableClosure
//
//  Created by Pho Hale on 9/16/16.
//  Copyright © 2016 Pho Hale. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet var renderedPairArrayController: NSArrayController!
	@IBOutlet weak var txtMain: NSTextField!
	@IBOutlet weak var tblMain: NSTableView!
	
	var computeableClosure: ComputableClosure = ComputableClosure()
	
	dynamic var dataArray = [RenderedPair]()
	
	
	@IBOutlet weak var predCompute: NSPredicateEditor!
	var computeCustomRow: UXComputingRowTemplate?
	
	@IBOutlet weak var btnAdd: NSButton!
	@IBAction func addPred(_ sender: NSButton) {
		debugPrint("addPred")
		guard let validComputeCustomRow = self.computeCustomRow else {
			fatalError("invalid computeCustomRow!")
		}
		
		self.predCompute.objectValue = validComputeCustomRow
		self.predCompute.setNeedsDisplay()
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupPredicate()
		//self.predCompute.delegate = self
		
		let sampleX: [Double] = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]
		self.computeableClosure.X = sampleX
		
		debugPrint("viewDidLoad: \(self.computeableClosure.rendered.Y)")
		
		for aPair in self.computeableClosure.renderedPairs {
			self.dataArray.append(aPair)
		}
		// Do any additional setup after loading the view.
	}
	
	var predicateBindingDictionary: [String : Any]? {
		var newDict: [String: Any] = [:]
		newDict["compute"] = {(xEntry: Any, i: Int) -> Double in return Double(i)}
		newDict["xRender"] = {(xEntry: Any) -> String in return "\(xEntry)"}
		newDict["yRender"] = {(yEntry: Double) -> String in return "\(yEntry)"}
		newDict["X"] = [0, 2, 4, 6, 8, 10]
		return newDict
	}
	
	func setupPredicate() {
		//let mainPredicate = NSPredicateEditorRowTemplate(leftExpressions: [NSExpression(forConstantValue: "Y[i]")], rightExpressionAttributeType: NSAttributeType.stringAttributeType, modifier: NSComparisonPredicate.Modifier.all, operators: [NSNumber(value: NSComparisonPredicate.Operator.equalTo.rawValue)], options: 0)
		
		let newRow = UXComputingRowTemplate(variableList: ["Y[i]"], optionsList: ["T0", "T1", "T2"])
		self.computeCustomRow = newRow
		
		//self.predCompute
		
		
		//newRow.setPredicate(<#T##predicate: NSPredicate##NSPredicate#>)
		//let subpredicates = newRow
		//newRow.predicate(withSubpredicates: <#T##[NSPredicate]?#>)
		
		//let computationPredicate = NSPredicate(value: true)
		//self.computeCustomRow.setPredicate(computationPredicate)
		//self.computeCustomRow.match(for: computationPredicate)
		
		
		self.predCompute.rowTemplates = [self.computeCustomRow!]
		
		
		//let ComputeCompoundRow = NSPredicateEditorRowTemplate(compoundTypes: [NSNumber(value: NSCompoundPredicate.LogicalType.and.rawValue)])
		
		/**
		var predicateBindingBlock: (Any?, [String : Any]?) -> Bool = { (evaluatedObject: Any?, bindings: [String : Any]?) -> Bool in
			guard let validComputableClosure = evaluatedObject as? ComputableClosure else {
				fatalError("evaluatedObject isn't ComputableClosure")
			}
			
			bindings.s
			validComputableClosure.compute
			
			
		}
		*/
		
		//var computationPredicate = NSPredicate(block: predicateBindingBlock)
		
		
		//var compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [computationPredicate])
		
		//self.predCompute.objectValue = computationPredicate
		//self.predCompute.rowClass = UXComputingRowTemplate.self
		//self.predCompute.predicate = computationPredicate
		
		//self.predCompute.row(forDisplayValue: <#T##Any#>)
		
		//self.predCompute.rowTemplates = [self.ComputeCustomRow]
		//self.predCompute.objectValue = computationPredicate
		//self.predCompute.insertRow(at: 0, with: .simple, asSubrowOfRow: 0, animate: true)
		
		self.predCompute.reloadCriteria()
		self.predCompute.reloadPredicate()
		self.predCompute.setNeedsDisplay()
		
		
	}

	override func viewWillAppear() {
		super.viewWillAppear()
		self.tblMain.reloadData()
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	
	var ruleArray: [NSRuleEditorRowType] = [NSRuleEditorRowType]()
}

/**
extension ViewController: NSRuleEditorDelegate {
	
	func ruleEditor(_ editor: NSRuleEditor, child index: Int, forCriterion criterion: Any?, with rowType: NSRuleEditorRowType) -> Any {
		guard let nonRootCriterion = criterion else {
			//Otherwise this is the root criterion
			return self.ComputeCustomRow
		}
		
		return self.ComputeCustomRow
	}
	
	func ruleEditor(_ editor: NSRuleEditor, numberOfChildrenForCriterion criterion: Any?, with rowType: NSRuleEditorRowType) -> Int {
		guard let nonRootCriterion = criterion else {
			//Otherwise this is the root criterion
			return 1
		}
		return 0
	}
	
	func ruleEditor(_ editor: NSRuleEditor, displayValueForCriterion criterion: Any, inRow row: Int) -> Any {
		return self.ComputeCustomRow
	}
}
*/
