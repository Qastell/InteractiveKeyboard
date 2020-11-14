//
//  BaseCellExtension.swift
//  101group
//
//  Created by max on 10.04.2018.
//  Copyright © 2018 101 GROUP. All rights reserved.
//

import Eureka

enum RowSeparator {
	case sectionTop
	case sectionBottom
	case row
}

extension BaseCell {
	func addSeparators(_ separators: Set<RowSeparator>) {
		if separators.contains(.sectionTop) {
			addSectionTopBorder()
		}
		if separators.contains(.sectionBottom) {
			addSectionBottomBorder()
		}
		if separators.contains(.row) {
			addCellSeparator(insets: separatorInset)
		}
	}

	private func addSectionTopBorder() {
		if backgroundView == nil {
			backgroundView = UIView(frame: contentView.bounds)
		}
		let borderView = UIView()
		borderView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView?.addSubview(borderView)
		borderView.backgroundColor = .grpPinkishGrey
		var constraints = [NSLayoutConstraint]()
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": borderView])
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[view(0.5)]", options: [], metrics: nil, views: ["view": borderView])
		NSLayoutConstraint.activate(constraints)
	}

	private func addSectionBottomBorder() {
		if backgroundView == nil {
			backgroundView = UIView(frame: contentView.bounds)
		}
		let borderView = UIView()
		borderView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView?.addSubview(borderView)
		borderView.backgroundColor = .grpPinkishGrey
		var constraints = [NSLayoutConstraint]()
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": borderView])
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[view(0.5)]|", options: [], metrics: nil, views: ["view": borderView])
		NSLayoutConstraint.activate(constraints)
	}

	func addCellSeparator(insets: UIEdgeInsets, lineWidth: CGFloat = 0.5, color: UIColor? = .grpPinkishGrey) {
		if backgroundView == nil {
			backgroundView = UIView(frame: contentView.bounds)
		}
		let borderView = UIView()
		borderView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView?.addSubview(borderView)
		borderView.backgroundColor = color
		var constraints = [NSLayoutConstraint]()
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[view]-(right)-|",
													  options: [],
													  metrics: ["left": insets.left, "right": insets.right],
													  views: ["view": borderView])
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[view(\(lineWidth))]|",
			options: [],
			metrics: nil,
			views: ["view": borderView])
		NSLayoutConstraint.activate(constraints)
	}
}
