//
//  PickAndChooseDate.swift
//  PickAndChooseDate
//
//  Created by Brent Michalski on 1/24/19.
//  Copyright © 2019 Perlguy, Inc. All rights reserved.
//

import UIKit

public protocol PickAndChooseDateDelegate {
    
}


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
            
            self.pickerLabel.text = date.dateTimeString()
        }

        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }
    
    
    @IBInspectable
    public var placeholderText: String? {
        get { return pickerLabel.text }
        set { pickerLabel.text = newValue }
    }

    
    @IBInspectable
    public var fontSize: CGFloat = 16 {
        didSet {
            pickerLabel.font = pickerLabel.font.withSize(fontSize)
        }
    }
    
    
    @IBInspectable
    public var fontColor: UIColor? {
        get { return pickerLabel.textColor }
        set { pickerLabel.textColor = newValue }
    }
    
    
    
    // Overall border
    @IBInspectable
    public var controlBorderColor: UIColor? {
        get { return containerView.borderColor }
        set { containerView.borderColor = newValue }
    }
    
    @IBInspectable
    public var controlBorderWidth: CGFloat {
        get { return containerView.borderWidth }
        set { containerView.borderWidth = newValue }
    }
    
    @IBInspectable
    public var controlBorderCornerRadius: CGFloat {
        get { return containerView.layer.cornerRadius }
        set { containerView.layer.cornerRadius = newValue }
    }
    
    
    // Image border
    @IBInspectable
    public var imageBorderColor: UIColor? {
        get { return pickerImageView.borderColor }
        set { pickerImageView.borderColor = newValue }
    }
    
    @IBInspectable
    public var imageBorderWidth: CGFloat {
        get { return pickerImageView.borderWidth }
        set { pickerImageView.borderWidth = newValue }
    }
    
    @IBInspectable
    public var imageBorderCornerRadius: CGFloat {
        get { return pickerImageView.layer.cornerRadius }
        set { pickerImageView.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    public var imageHeight: CGFloat {
        get { return pickerImageViewHeightConstraint.constant }
        set {
            pickerImageView.size = CGSize(width: newValue, height: newValue)
            pickerImageViewHeightConstraint.constant = newValue
        }
    }
    
    
    // Label border
    @IBInspectable
    public var labelBorderColor: UIColor? {
        get { return pickerLabel.borderColor }
        set { pickerLabel.borderColor = newValue }
    }
    
    @IBInspectable
    public var labelBorderWidth: CGFloat {
        get { return pickerLabel.borderWidth }
        set { pickerLabel.borderWidth = newValue }
    }
    
    @IBInspectable
    public var labelBorderCornerRadius: CGFloat {
        get { return pickerLabel.layer.cornerRadius }
        set { pickerLabel.layer.cornerRadius = newValue }
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
