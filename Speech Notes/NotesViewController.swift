//
//  ViewController.swift
//  Speech Notes
//
//  Created by Richard Richard on 02/04/18.
//  Copyright © 2018 Richard Richard. All rights reserved.
//

import UIKit

// List of all Notes
class NotesViewController: UIViewController {
    var selectedIndex: Int?
    var notes: [Notes] = []
    
    let notesTableView: UITableView = {
        var tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = UIColor.clear
        tb.isHidden = true
        tb.separatorStyle = .none
        return tb
    }()
    
    let noNotesView: UIView = {
        let view = ZeroNotesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func loadView() {
        setupView()
        setupProperties()
        
        view.addSubview(noNotesView)
        view.addSubview(notesTableView)
        
        setupConstraint()
        
        notesTableView.reloadData()
        if notes.count == 0 {
            noNotesView.isHidden = false
            notesTableView.isHidden = true
        } else {
            noNotesView.isHidden = true
            notesTableView.isHidden = false
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
    private func setupView() {
        view = UIView()
        view.backgroundColor = UIColor.yellow
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        navigationItem.title = "Notes Collection"
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupProperties() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupConstraint() {
        noNotesView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noNotesView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noNotesView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        noNotesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        notesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        notesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func addNote() {
        let addTitleVC = AddTitleViewController()
        addChildViewController(addTitleVC)
        view.addSubview(addTitleVC.view)
        addTitleVC.didMove(toParentViewController: self)
        notesTableView.isUserInteractionEnabled = false
        noNotesView.isHidden = true
        
        addTitleVC.view.layer.cornerRadius = 5
        addTitleVC.view.layer.borderWidth = 2
        addTitleVC.view.layer.borderColor = UIColor.orange.cgColor
        
        DispatchQueue.main.async(execute: {
            addTitleVC.view.translatesAutoresizingMaskIntoConstraints = false
            addTitleVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
            addTitleVC.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
            addTitleVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            addTitleVC.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        })
        
        addTitleVC.menuClosed = {
            self.notesTableView.isUserInteractionEnabled = true
            self.notesTableView.reloadData()
            self.noNotesView.isHidden = false
        }
        
        addTitleVC.noteAdded = { (title) in
            self.notes.append(Notes(title: title, detail: ""))
            return self.notes.count-1
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesTableViewCell
        cell.titleLabel.text = "Note's Title"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let detailVC = DetailViewController()
        detailVC.selectedIndex = selectedIndex!
        detailVC.note = notes[selectedIndex!]
        navigationController?.pushViewController(detailVC, animated: true)
        notesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.notes.remove(at: indexPath.row)
        }
        return [delete]
    }
}
