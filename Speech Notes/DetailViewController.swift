//
//  DetailViewController.swift
//  Speech Notes
//
//  Created by Richard Richard on 02/04/18.
//  Copyright © 2018 Richard Richard. All rights reserved.
//

import UIKit
import Speech


// Show the selected or new note
class DetailViewController: UIViewController {
    var note: Notes?
    var selectedIndex: Int?
    var saveNote: ((Notes)->())?
    
    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.white
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 5
        textView.layer.borderColor = UIColor.yellow.cgColor
        return textView
    }()
    
    var speakButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "speaker.png"), for: .normal)
        return button
    }()
    
    var recordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "microphone.png"), for: .normal)
        return button
    }()
    
    override func loadView() {
        setupView()
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
    
    private func setupView() {
        view = UIView()
        view.backgroundColor = UIColor.yellow
        
        navigationItem.title = note?.title
        noteTextView.text = note?.detail
        
        speakButton.addTarget(self, action: #selector(speakNote), for: .touchUpInside)
        recordButton.addTarget(self, action: #selector(record), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: speakButton)
        let item2 = UIBarButtonItem(customView: recordButton)
        navigationItem.setRightBarButtonItems([item1, item2], animated: true)
        
        view.addSubview(noteTextView)
    }
    
    @objc private func speakNote() {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: (noteTextView.text!))
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.volume = 1
        synthesizer.speak(utterance)
    }
    
    @objc private func record() {
//        let recorder = Recorder()
//        recorder.getSpeechResult = { (result) in
//            if self.noteTextView.text.last != " " {
//                self.noteTextView.text.append(" ")
//            }
//            self.noteTextView.text.append("\(result)")
//        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        let parentVC = parent as! NotesViewController!
        parentVC?.notes[selectedIndex!].detail = noteTextView.text!
    }
    
    private func setupConstraint() {
        speakButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        speakButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        recordButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        noteTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45).isActive = true
        noteTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        noteTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        noteTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}
