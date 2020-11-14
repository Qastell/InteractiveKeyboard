//
//  UIViewExtension.swift
//  101group
//
//  Created by Max Petrenko on 28.11.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//

import UIKit

public extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }

    func setDashedHorizontalLineLayer(color: UIColor?, insets: UIEdgeInsets? = nil) {
        guard tag != 6662 else { return }

        if tag == 6663 {
            layer.sublayers?.last?.removeFromSuperlayer()
        }
        tag = 6663

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color?.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 4]
        let path = CGMutablePath()
        path.addLines(between: [.zero, .init(x: bounds.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

public extension UITableViewCell {
    func setUnderlineLayer(color: UIColor?, insets: UIEdgeInsets? = nil) {
        guard tag != 6662 else { return }

        if contentView.tag == 6663 {
            layer.sublayers?.last?.removeFromSuperlayer()
        }
        contentView.tag = 6663

        let lineWidth: CGFloat = 1.0 / UIScreen.main.scale
        let leftInset = insets?.left ?? separatorInset.left
        let rightInset = insets?.right ?? separatorInset.right
        let frame = CGRect(x: leftInset,
                           y: bounds.height - lineWidth,
                           width: bounds.width - leftInset - rightInset,
                           height: lineWidth)

        let lineLayer = CALayer()
        lineLayer.frame = frame
        lineLayer.backgroundColor = color?.cgColor
        layer.addSublayer(lineLayer)
    }

    func setDashedUnderline(color: UIColor) {
        layer.sublayers?.first(where: { $0 is CAShapeLayer })?.removeFromSuperlayer()

    }

//	func setVerticalDashedBorder(view: UIView?, cellHeight: CGFloat) {
//		view?.addDashedBorder(lineWidth: 1,
//							  step: 4,
//                              color: Settings.shared.colorDashLine,
//                              isHorizontal: false,
//							  height: cellHeight - 28) // TODO: refactor height param to remove magic number
//	}
}

extension UITableView {
    func reloadDataAnimated(duration: TimeInterval = 0.2) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }, completion: nil)
    }

    func registerCell(_ type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.className)
    }

    func registerNib(_ type: UITableViewCell.Type) {
        register(UINib(nibName: type.className, bundle: .main), forCellReuseIdentifier: type.className)
    }

    func registerHeaderFooterView(_ type: UIView.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T
    }
}

protocol Dao {}

extension UIView: Dao {}

extension Dao where Self: UIView {
    init(closure: (Self) -> Void) {
        self.init()
        closure(self)
    }
}

extension NSObject {
    class var className: String {
        return String(describing: classForCoder())
    }
}

final class BasicSectionHeaderReusableView: UITableViewHeaderFooterView {
    var title = "" {
        didSet {
            let attrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grpBlack,
                                                        .font: UIFont.grpSemi15]
            label.attributedText = title.attributed(attrs)
        }
    }

    let imageView = UIImageView()

    private let label = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .grpPaleGrey2

        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(12)-[label]-(8)-[imageView(44)]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["label": label, "imageView": imageView])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(12)-[label]-(4)-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["label": label])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[imageView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["imageView": imageView])
        NSLayoutConstraint.activate(constraints)

        _ = UIView { sepView in
            sepView.backgroundColor = .grpSeparatorGrey
            contentView.addSubview(sepView)
            sepView.constraintsToSuperview(heightFromTop: 1)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

final class BasicSectionHeaderView: UIView {
    convenience init(title: String,
                     attrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grpBattleshipGrey,
                                                             .font: UIFont.grp13],
                     prependingImage: UIImage? = nil) {
        self.init()
        backgroundColor = .grpPaleGrey
        let label = UILabel()
        var attributedText = title.attributed(attrs)

        if let image = prependingImage {
            attributedText = attributedText.prependingImage(image, yOffset: -4, spaces: "  ")
        }
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(12)-[label]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["label": label])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(12)-[label]-(4)-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["label": label])
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIView {
    class var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        }
        return false
    }

    class var hasBottomSafeAreaInsets: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with home indicator: 34.0 on iPhone X, XS, XS Max, XR.
            // with home indicator: 20.0 on iPad Pro 12.9" 3rd generation.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }

	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}

	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}

	@IBInspectable var borderColor: UIColor? {
		get {
			return UIColor(cgColor: layer.borderColor!)
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}

	func addDashedBorder(lineWidth: CGFloat, step: NSNumber, color: UIColor, isHorizontal: Bool, height: CGFloat? = nil) {
        layer.sublayers?.first(where: { $0 is CAShapeLayer })?.removeFromSuperlayer()

        let shapeLayer = CAShapeLayer()
		shapeLayer.strokeColor = color.cgColor
		shapeLayer.lineWidth = lineWidth
		shapeLayer.lineDashPattern = [step, step]
		let path = CGMutablePath()
		var endPoint = CGPoint.zero
		if isHorizontal {
			endPoint = CGPoint(x: frame.size.width, y: 0)
		} else {
			endPoint = CGPoint(x: 0, y: height ?? frame.size.height)
		}
		path.addLines(between: [CGPoint(x: 0, y: 0), endPoint])
		shapeLayer.path = path
		layer.addSublayer(shapeLayer)
	}

    func constraintsWithVFL(h: String, v: String) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [h, v].flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: String(format: $0, Self.className),
                                               options: [],
                                               metrics: nil,
                                               views: [Self.className: self])
            }
        )
    }

    func constraintsCenteredToSuperview(xOffset: CGFloat = 0, yOffset: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
		guard let superview = superview else { return }
		translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xOffset),
			centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yOffset)
		])

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
	}

    @discardableResult
    func constraintsToSuperview(insets: UIEdgeInsets = .zero, heightFromTop: CGFloat? = nil, heightFromBottom: CGFloat? = nil) -> [NSLayoutConstraint.Attribute: NSLayoutConstraint] {
		guard let superview = superview else { return [:] }
		translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint.Attribute: NSLayoutConstraint] =
            [.left: leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
             .right: rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right)]

        if let heightFromTop = heightFromTop {
            constraints[.height] = heightAnchor.constraint(equalToConstant: heightFromTop)
        } else {
            constraints[.bottom] = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        }
        if let heightFromBottom = heightFromBottom {
            constraints[.height] = heightAnchor.constraint(equalToConstant: heightFromBottom)
        } else {
            constraints[.top] = topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
        }
        NSLayoutConstraint.activate(constraints.compactMap { $0.value })
        return constraints
	}

    func setGradient(colors: [UIColor], locations: [NSNumber]?) {
        let gradient = layer.sublayers?.first as? CAGradientLayer ?? CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        layer.insertSublayer(gradient, at: 0)
    }
}
