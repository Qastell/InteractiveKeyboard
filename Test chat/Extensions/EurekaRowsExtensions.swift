//
//  EurekaRowsExtensions.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 31.08.2018.
//  Copyright © 2018 101 GROUP. All rights reserved.
//

import Eureka
import ViewRow

extension ViewRow {
    convenience init(uniqueTag: String, image: UIImage?, isViewMode: Bool, cornerRadius: CGFloat? = nil) {
        self.init(uniqueTag)

        cell.view = UIView() as? ViewType
        cell.backgroundColor = .grpPaleGrey
        cell.contentView.addSubview(cell.view!)
        cell.height = { 104 }

        let b = UIButton {
            $0.cornerRadius = cornerRadius ?? (80 / 2)
            $0.setBackgroundImage(image, for: .normal)

            if !isViewMode {
                $0.setImage(#imageLiteral(resourceName: "ic_avatar_empty").withRenderingMode(.alwaysTemplate), for: .normal)
                $0.imageView?.tintColor = .grpWhite
                $0.backgroundColor = .grpDarkGrey
            }
        }
        cell.view?.addSubview(b)
        b.constraintsCenteredToSuperview(width: 80, height: 80)
    }
}

extension TextRow {
	convenience init(uniqueTag: String?, title: String, value: String, emptyMessage: String?) {
		self.init(uniqueTag) { row in
			if let msg = emptyMessage {
				row.add(rule: RuleRequired(msg: msg))
				row.validationOptions = .validatesOnDemand
			}
			row.value = value
		}
	}
}

extension LabelRow {
	convenience init(uniqueTag: String?, title: String, value: (id: String?, title: String?), emptyMessage: String?) {
		self.init(uniqueTag) { row in
			if let msg = emptyMessage {
				row.add(rule: RuleRequired(msg: msg))
				row.validationOptions = .validatesAlways
			}
			row.cellStyle = .default
		}

		setData(title: title, valueId: value.id, valueTitle: value.title)
	}

	func setData(title: String, valueId: String?, valueTitle: String?) {
		if let valueId = valueId, let valueTitle = valueTitle {
			self.title = valueTitle
			value = valueId
		} else {
			self.title = title
		}
	}
}

extension DateRow {
	convenience init(uniqueTag: String?, title: String, value: Date? = Date(), emptyMessage: String?) {
		self.init(uniqueTag) { row in
			if let msg = emptyMessage {
				row.add(rule: RuleRequired(msg: msg))
				row.validationOptions = .validatesOnDemand
			}
			row.title = title
			row.value = value
			row.cell.datePicker.backgroundColor = .grp90White
		}
	}

	func updateStyle() {
		cell.textLabel?.font = .grp17
		cell.textLabel?.textColor = .grpSteel
		cell.detailTextLabel?.font = cell.textLabel?.font
		cell.detailTextLabel?.textColor = .grpBlack
		cell.selectionStyle = .none
        cell.datePicker.backgroundColor = .grpPaleGrey
	}
}

extension DecimalRow {
	convenience init(uniqueTag: String?, title: String, value: Double, emptyMessage: String?) {
		self.init(uniqueTag) { row in
			if let msg = emptyMessage {
				row.add(rule: RuleGreaterThan(min: 0, msg: msg))
				row.validationOptions = .validatesOnDemand
			}
			row.formatter = NumberFormatter.decimalWithSpaces
			row.title = title
			row.value = value
		}
	}
}

extension DecimalCell {
//    func setRightButton(isDiscount: Bool = false) -> UIButton {
//        let rightSpacing: CGFloat = 50
//        let b = UIButton(frame: CGRect(x: bounds.width - (isDiscount ? 100 + 68 : rightSpacing),
//                                       y: 0,
//                                       width: isDiscount ? 100 : rightSpacing,
//                                       height: Settings.shared.formRowHeight))
//		b.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
//        b.setImage(#imageLiteral(resourceName: "ic_copy_paste_up"), for: .normal)
//		contentView.layoutMargins.right = isDiscount ? 0 : rightSpacing
//		textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
//		textField.rightViewMode = .always
//		textField.rightView?.isUserInteractionEnabled = false
//		b.tag = 1856
//
//		if contentView.subviews.first(where: { $0.tag == 1856 }) == nil {
//			contentView.addSubview(b)
//		}
//		return b
//	}
}
