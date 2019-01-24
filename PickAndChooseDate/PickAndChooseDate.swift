//
//  PickAndChooseDate.swift
//  PickAndChooseDate
//
//  Created by Brent Michalski on 1/24/19.
//  Copyright © 2019 Perlguy, Inc. All rights reserved.
//

import UIKit
import DateToolsSwift


@IBDesignable
public class PickAndChooseDate: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickerLabel: PaddedLabel!
    @IBOutlet weak var pickerImageView: UIImageView!
    
    @IBOutlet weak var pickerImageViewHeightConstraint: NSLayoutConstraint! {
        didSet {
            pickerImageView.size = CGSize(width: pickerImageViewHeightConstraint.constant, height: pickerImageViewHeightConstraint.constant)
        }
    }
    
    @IBOutlet weak var pickerImageViewLeadingConstraint: NSLayoutConstraint!
    
    
    @IBInspectable
    public var myImage: UIImage? {
        didSet {
            if let image = myImage {
                pickerImageViewLeadingConstraint.constant = 8.0
                pickerImageView.image                     = image
            }
            else {
                pickerImageViewHeightConstraint.constant  = 0
                pickerImageViewLeadingConstraint.constant = 0
            }
        }
    }
    
    
    @IBInspectable
    public var minDateYears: Int = 1

    @IBInspectable
    public var maxDateYears: Int = 1

    
    // MARK: - Setup The View
    func setupView() {
        pickerLabel.leftInset = 8.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tap.numberOfTapsRequired = 1
        
        self.containerView.addGestureRecognizer(tap)
        pickerImageView.clipsToBounds            = true
        pickerImageViewHeightConstraint.constant = 0
        
        pickerImageView.backgroundColor = .clear
        placeholderText                 = "Placeholder Text"
    }

    
    
    @objc func viewTapped(_ sender: Any) {
        let minDate = minDateYears.years.earlier
        let maxDate = maxDateYears.years.later
        let nowDate = Date()
        
        let alert = UIAlertController(style: .actionSheet, title: "Select date")
        
        alert.addDatePicker(mode: .dateAndTime, date: nowDate, minimumDate: minDate, maximumDate: maxDate) { date in
            // action with selected date
            print("\nDATE SELECTED: \(date)\n")
            
            self.setText(text: date.dateTimeString())
        }

        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }
    
    
    public var currentValue: String? {
        return pickerLabel.text
    }
    
    public func setText(text: String) {
        pickerLabel.textColor = fontColor?.withAlphaComponent(1)
        pickerLabel.text = text
    }
    
    
    @IBInspectable
    public var bgColor: UIColor = .white {
        didSet {
            containerView.backgroundColor = bgColor
        }
    }
    
    
    @IBInspectable
    public var placeholderText: String? {
        didSet {
            pickerLabel.textColor = fontColor?.withAlphaComponent(0.6)
            pickerLabel.text      = placeholderText
        }
    }

    
    @IBInspectable
    public var fontSize: CGFloat = 16 {
        didSet {
            pickerLabel.font = pickerLabel.font.withSize(fontSize)
        }
    }
    
    
    @IBInspectable
    public var fontColor: UIColor? {
        didSet {
            pickerLabel.textColor = fontColor
        }
    }
    
    
    
    // Outer border
    @IBInspectable
    public var outerBorder: UIColor? {
        didSet {
            containerView.borderColor = outerBorder
        }
    }
    
    @IBInspectable
    public var outerBorderWidth: CGFloat = 0 {
        didSet {
            containerView.borderWidth = outerBorderWidth
        }
    }
    
    @IBInspectable
    public var outerBorderCornerRadius: CGFloat = 0 {
        didSet {
            containerView.layer.cornerRadius = outerBorderCornerRadius
        }
    }
    
    
    // Image border
    @IBInspectable
    public var imageBorderColor: UIColor? {
        didSet {
            pickerImageView.borderColor = imageBorderColor
        }
    }
    
    @IBInspectable
    public var imageBorderWidth: CGFloat = 0 {
        didSet {
            pickerImageView.borderWidth = imageBorderWidth
        }
    }
    
    @IBInspectable
    public var imageBorderCornerRadius: CGFloat = 0 {
        didSet {
            pickerImageView.layer.cornerRadius = imageBorderCornerRadius
        }
    }
    
    @IBInspectable
    public var imageHeight: CGFloat = 40 {
        didSet {
            pickerImageView.size = CGSize(width: imageHeight, height: imageHeight)
            pickerImageViewHeightConstraint.constant = imageHeight
        }
    }
    
    
    // Label border
    @IBInspectable
    public var labelBorderColor: UIColor? {
        didSet {
            pickerLabel.borderColor = labelBorderColor
        }
    }
    
    @IBInspectable
    public var labelBorderWidth: CGFloat = 0 {
        didSet {
            pickerLabel.borderWidth = labelBorderWidth
        }
    }
    
    @IBInspectable
    public var labelBorderCornerRadius: CGFloat = 0 {
        didSet {
            pickerLabel.layer.cornerRadius = labelBorderCornerRadius
        }
    }
    
    
    
    // MARK: - Interface Builder
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    
    // MARK: - Methods to make the control load properly.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    
    private func initNib() {
        if !self.subviews.isEmpty { return }
        
        let bundle = Bundle(for: PickAndChooseDate.self)
        bundle.loadNibNamed(String(describing: PickAndChooseDate.self), owner: self, options: nil)
        
        self.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        setupView()
        
        clipsToBounds = true
    }
    
    
    
}
