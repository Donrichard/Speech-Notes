//
//  ZeroNotesView.swift
//  Speech Notes
//
//  Created by Richard Richard on 02/04/18.
//  Copyright © 2018 Richard Richard. All rights reserved.
//

import UIKit

class ZeroNotesView: UIView {
    let noNotesLabel: UILabel = {
        var label = UILabel()
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  No note created yet!  "
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    let noNotesEmoji: UILabel = {
        var label = UILabel()
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  :(  "
        label.font = .systemFont(ofSize: 24)
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noNotesLabel)
        addSubview(noNotesEmoji)
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        noNotesLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2).isActive = true
        noNotesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        noNotesEmoji.topAnchor.constraint(equalTo: noNotesLabel.bottomAnchor).isActive = true
        noNotesEmoji.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
