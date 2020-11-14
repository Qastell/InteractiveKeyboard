import UIKit
import SnapKit

// MARK: - Methods
extension UITextView {
	
	/// Scroll to the bottom of text view
	func scrollToBottom() {
		let range = NSMakeRange((text as NSString).length - 1, 1)
		scrollRangeToVisible(range)
	}
	
	/// Scroll to the top of text view
	func scrollToTop() {
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}
}

extension UITextView {

    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap({ $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: frame)
            label.font = font
            label.textColor = .grpSteel
            addSubview(label)
            return label
        }
    }
    var placeholder: String {
        get {
            return subviews.compactMap({ $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 1
            textStorage.delegate = self
            setPlaceholderInset()
        }
    }
    
    private func setPlaceholderInset() {
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(textContainerInset.top)
            $0.bottom.equalToSuperview().offset(-textContainerInset.bottom)
            $0.leading.equalToSuperview().offset(textContainerInset.left + 5)
            $0.trailing.equalToSuperview().offset(-textContainerInset.right)
        }
    }
}

extension UITextView: NSTextStorageDelegate {

    public func textStorage(_ textStorage: NSTextStorage,
                            didProcessEditing editedMask: NSTextStorage.EditActions,
                            range editedRange: NSRange,
                            changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

}
