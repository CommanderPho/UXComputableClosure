//
//  ComputableClosure.swift
//  UXComputableClosure
//
//  Created by Pho Hale on 9/16/16.
//  Copyright © 2016 Pho Hale. All rights reserved.
//

import Foundation
import Cocoa
import QuartzCore


open class RenderedPair: NSObject {
	open var x: String = "x"
	open var y: String = "y"
	
	public init(x: String, y: String) {
		super.init()
		self.x = x
		self.y = y
	}
	
}


open class ComputableClosure: NSObject {
	
	open var X: [Any] = [Any]() {
		didSet {
			self.performComputations()
		}
	}
	
	private var Y: [Double] = [Double]()
	
	//Closures which render x and y values
	open var xRender: (_ xEntry: Any) -> String = {(xEntry: Any) -> String in return "\(xEntry)"}
	open var yRender: (_ yEntry: Double) -> String = {(yEntry: Double) -> String in return "\(yEntry)"}
	//Closure which computes output
	open var compute: (_ xEntry: Any, _ i: Int) -> Double = {(xEntry: Any, i: Int) -> Double in return Double(i)} {
		didSet {
			self.performComputations()
		}
	}
	
	var rendered: (X: [String], Y: [String]) {
		let xRendered = self.X.map({ return self.xRender($0) })
		let yRendered = self.Y.map({ return self.yRender($0) })
		return (xRendered, yRendered)
	}
	
	var renderedPairs: [RenderedPair] {
		var newPairs = [RenderedPair]()
		
		for i in 0..<self.rendered.X.count {
			newPairs.append(RenderedPair(x: self.rendered.X[i], y: self.rendered.Y[i]))
		}
		return newPairs
	}
	
	override init() {
		super.init()
		self.performComputations()
	}
	
	init(compute: @escaping (Any, Int) -> Double) {
		super.init()
		self.compute = compute
	}
	
	//Initialize from string
	init(computeString: String) {
		super.init()
	}
	
	private func performComputations() {
		self.Y.removeAll(keepingCapacity: true)
		
		for (idx, x) in self.X.enumerated() {
			let yVal = self.compute(x, idx)
			self.Y.append(yVal)
		}
	}
}

