//
//  vCursorOverlay.swift
//  UXComputableClosure
//
//  Created by Pho Hale on 9/18/16.
//  Copyright © 2016 Pho Hale. All rights reserved.
//


import Foundation
import QuartzCore
import Cocoa

extension NSBezierPath {
	
	public var cgPath: CGPath {
		let path = CGMutablePath()
		var points = [CGPoint](repeating: .zero, count: 3)
		
		for i in 0 ..< self.elementCount {
			let type = self.element(at: i, associatedPoints: &points)
			switch type {
			case .moveToBezierPathElement:
				path.move(to: points[0])
			case .lineToBezierPathElement:
				path.addLine(to: points[0])
			case .curveToBezierPathElement:
				path.addCurve(to: points[2], control1: points[0], control2: points[1])
			case .closePathBezierPathElement:
				path.closeSubpath()
			}
		}
		
		return path
	}
}

@IBDesignable
open class vCursorOverlay: NSView {


	var indicatorSize: NSSize { return NSSize(width: self.indicatorWidth, height: self.frame.height) }
	
	func buildIndicator(atPosition: NSPoint) {
		var newIndicator = CAShapeLayer()
		
		let spawnPoint = NSPoint(x: atPosition.x, y: 0.0)
		let newRect = NSRect(origin: spawnPoint, size:  self.indicatorSize)
		
		
		newIndicator.path = NSBezierPath(rect: newRect).cgPath
		newIndicator.fillColor = NSColor.red.cgColor
		
		self.layer?.addSublayer(newIndicator)
	}
	
	
	@IBInspectable public var indicatorWidth: CGFloat = 4.0
	
	open override func mouseDown(with event: NSEvent) {
		let clickPositionFrameRelative = event.locationInWindow
		
		self.buildIndicator(atPosition: clickPositionFrameRelative)
	
	}
	
	@IBInspectable public var backgroundColor: NSColor = NSColor.clear {
		didSet {
			self.layer!.backgroundColor = backgroundColor.cgColor
		}
	}
	
	@IBInspectable public var cornerRadius: CGFloat = 2 {
		didSet {
			self.layer?.cornerRadius = cornerRadius
		}
	}
	
	@IBInspectable public var borderWidth: CGFloat = 1 {
		didSet {
			self.layer?.borderWidth = borderWidth
		}
	}
	
	@IBInspectable public var borderColor: NSColor = NSColor.black {
		didSet {
			self.layer?.borderColor = borderColor.cgColor
		}
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		self.wantsLayer = true
		
		//        TODO: All subview will be drawn in parent views layer
		//        self.canDrawSubviewsIntoLayer = true
		self.buildMouseTrackingRectangle()
	}
	
	


	// MARK: Overrides
	
	open override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
		return true
	}
	
	

	override open var acceptsFirstResponder: Bool {
		get {
			return true
		}
	}

	func buildMouseTrackingRectangle() {
		
		//let options = [NSTrackingAreaOptions.mouseMoved, NSTrackingAreaOptions.activeInKeyWindow] as NSTrackingAreaOptions
		let options: NSTrackingAreaOptions = [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow]
		
		let trackingArea = NSTrackingArea(rect: self.frame, options: options, owner: self, userInfo: nil)
		
		//let trackingArea = NSTrackingArea(rect: self.view.frame, options: options,owner:self,userInfo:nil)
		//self.view.addTrackingArea(trackingArea)
		self.addTrackingArea(trackingArea)
	}
	
	override open func mouseEntered(with event: NSEvent) {
		//debugPrint("mouse entered")
		self.layer?.backgroundColor = NSColor.red.withAlphaComponent(0.2).cgColor
		
	}
	override open func mouseMoved(with event: NSEvent) {
		//debugPrint("mouse moved")
	}
	
	override open func mouseExited(with event: NSEvent) {
		//debugPrint("mouse exited")
		self.layer?.backgroundColor = NSColor.clear.cgColor
	}
	
	
}
