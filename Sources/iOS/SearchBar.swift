/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit

open class SearchBar: Bar {
	/// The UITextField for the searchBar.
	open private(set) lazy var textField = UITextField()
	
	/// Reference to the clearButton.
	open private(set) var clearButton: IconButton!
	
	/// Handle the clearButton manually.
	@IBInspectable
    open var isClearButtonAutoHandleEnabled = true {
		didSet {
			clearButton.removeTarget(self, action: #selector(handleClearButton), for: .touchUpInside)
			if isClearButtonAutoHandleEnabled {
				clearButton.addTarget(self, action: #selector(handleClearButton), for: .touchUpInside)
			}
		}
	}
	
	/// TintColor for searchBar.
	@IBInspectable
    open override var tintColor: UIColor? {
		get {
			return textField.tintColor
		}
		set(value) {
			textField.tintColor = value
		}
	}
	
	/// TextColor for searchBar.
	@IBInspectable
    open var textColor: UIColor? {
		get {
			return textField.textColor
		}
		set(value) {
			textField.textColor = value
		}
	}
	
	/// Sets the textField placeholder value.
	@IBInspectable
    open var placeholder: String? {
		didSet {
			if let v: String = placeholder {
				textField.attributedPlaceholder = NSAttributedString(string: v, attributes: [NSForegroundColorAttributeName: placeholderColor])
			}
		}
	}
	
	/// Placeholder textColor.
	@IBInspectable
    open var placeholderColor = Color.darkText.others {
		didSet {
			if let v: String = placeholder {
				textField.attributedPlaceholder = NSAttributedString(string: v, attributes: [NSForegroundColorAttributeName: placeholderColor])
			}
		}
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
        guard willLayout else {
            return
        }
        
        textField.frame = contentView.bounds
        layoutClearButton()
	}
	
	/**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	/**
     An initializer that initializes the object with a CGRect object.
     If AutoLayout is used, it is better to initilize the instance
     using the init() initializer.
     - Parameter frame: A CGRect instance.
     */
	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	/**
     A convenience initializer with parameter settings.
     - Parameter leftViews: An Array of UIViews that go on the left side.
     - Parameter rightViews: An Array of UIViews that go on the right side.
     */
	public override init(leftViews: [UIView]? = nil, rightViews: [UIView]? = nil) {
		super.init(leftViews: leftViews, rightViews: rightViews)
	}
	
	/**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepare method
     to initialize property values and other setup operations.
     The super.prepare method should always be called immediately
     when subclassing.
     */
	open override func prepare() {
		super.prepare()
        prepareTextField()
		prepareClearButton()
	}
	
	/// Layout the clearButton.
	open func layoutClearButton() {
		let h = textField.frame.height
        clearButton.frame = CGRect(x: textField.frame.width - h, y: 0, width: h, height: h)
	}
	
	/// Clears the textField text.
	@objc
    internal func handleClearButton() {
		textField.text = nil
	}
	
	/// Prepares the textField.
	private func prepareTextField() {
		textField.contentScaleFactor = Device.scale
		textField.font = RobotoFont.regular(with: 17)
		textField.backgroundColor = Color.clear
		textField.clearButtonMode = .whileEditing
		tintColor = placeholderColor
		textColor = Color.darkText.primary
		placeholder = "Search"
		contentView.addSubview(textField)
	}
	
	/// Prepares the clearButton.
	private func prepareClearButton() {
        clearButton = IconButton(image: Icon.cm.close, tintColor: placeholderColor)
		clearButton.contentEdgeInsets = .zero
		isClearButtonAutoHandleEnabled = true
		textField.clearButtonMode = .never
		textField.rightViewMode = .whileEditing
		textField.rightView = clearButton
	}
}
