//
//  AddMovieViewController.swift
//  CoreMovies
//
//  Created by Jose on 21/5/19.
//  Copyright © 2019 appcat.com. All rights reserved.
//
import UIKit

class AddMovieViewController: UIViewController, UITextFieldDelegate
{
	var movies: [String]!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var button: UIButton!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		movies = []
		textField.delegate = self
		textField.layer.borderWidth = 1.1
		textField.layer.borderColor = UIColor.blue.cgColor
		textField.layer.cornerRadius = 6.0
		button.layer.borderWidth = 1.1
		button.layer.borderColor = UIColor.blue.cgColor
		button.layer.cornerRadius = 6.0
    }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		guard let text = textField.text else
		{
			textField.resignFirstResponder()
			return false
		}
		if textField.text != ""
		{
			let trimmedText = text.trimmingCharacters(in: .whitespaces)
			movies.append(trimmedText)
			textField.text = ""
		}
		textField.resignFirstResponder()
		return true
	}
}
