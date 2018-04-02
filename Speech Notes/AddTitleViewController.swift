//
//  AddTitleViewController.swift
//  Speech Notes
//
//  Created by Richard Richard on 02/04/18.
//  Copyright © 2018 Richard Richard. All rights reserved.
//

import UIKit

class AddTitleViewController: UIViewController {
    var noteAdded: ((String)->(Int))?
    var menuClosed: (()->())?
    
    let titleTF: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Input your title here"
        return textField
    }()
    
    let addButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    let cancelButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
        
        view.addSubview(titleTF)
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        
        addButton.addTarget(self, action: #selector(showNotesDetail), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(closeAnimation), for: .touchUpInside)
        
        setupConstraint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showAnimation()
    }
    
    private func showAnimation() {
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        view.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (finished : Bool) in
            if (finished) {
                self.titleTF.becomeFirstResponder()
            }
        }
    }
    
    @objc private func closeAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (finished : Bool) in
            if (finished) {
                self.view.removeFromSuperview()
                self.menuClosed!()
            }
        }
    }
    
    @objc private func showNotesDetail() {
        closeAnimation()
        let detailVC = DetailViewController()
        detailVC.selectedIndex = noteAdded!(titleTF.text!)
        detailVC.note = Notes(title: titleTF.text!, detail: "")
        navigationController?.pushViewController(detailVC, animated: true)
        defer {
            titleTF.text = ""
        }
    }
    
    private func setupConstraint() {
        titleTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        titleTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
}
