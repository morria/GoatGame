//
//  ViewController.swift
//  goat
//
//  Created by Andrew S. Morrison on 12/13/17.
//  Copyright © 2017 Goats, Inc. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    // This is the text input box on the screen.
    @IBOutlet weak var input: UITextField!

    // This is the output box.
    @IBOutlet weak var output: UITextView!

    var goat:Goat = Goat()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.delegate = self;
        self.output.layoutManager.allowsNonContiguousLayout = false;


        self.scrollToEnd();
        self.input.becomeFirstResponder()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )

    }

    func scrollToEnd() {
        let stringLength:Int = self.output.text.characters.count

        self.output.scrollRangeToVisible(
            NSMakeRange(stringLength-1, 0)
        )
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.output.text =
            self.output.text
            + "\n"
            + self.goat.handle(input: self.input.text!);

        self.input.text = "";
        self.scrollToEnd();

        textField.becomeFirstResponder()

        // Inhibit default behavior
        return false;
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            // self.view.frame.origin.y -= keyboardSize.height

            let delta = self.view.frame.size.height - keyboardSize.origin.y + keyboardSize.height

            self.view.frame = CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: self.view.frame.height - delta
            )

            // self.view.layoutIfNeeded();
            // self.view.setNeedsUpdateConstraints();
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            // self.view.frame.origin.y += keyboardSize.height

            let delta = self.view.frame.size.height - keyboardSize.minY + keyboardSize.height

            self.view.frame = CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: self.view.frame.height + delta
            )



            // self.view.layoutIfNeeded();
            // self.view.setNeedsUpdateConstraints();
        }
    }

}

