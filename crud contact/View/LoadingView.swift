//
//  LoadingView.swift
//  Attenza
//
//  Created by Rizki Dwi Putra on 25/07/19.
//  Copyright © 2019 Rizki Dwi Putra. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func show() {
        self.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func show(from view: UIView) {
        view.bringSubviewToFront(self)
        show()
    }
    
    func hide() {
        self.isHidden = true
        activityIndicatorView.stopAnimating()
    }
}
