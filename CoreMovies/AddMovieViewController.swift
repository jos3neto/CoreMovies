//
//  AddMovieViewController.swift
//  CoreMovies
//
//  Created by Jose on 21/5/19.
//  Copyright © 2019 appcat.com. All rights reserved.
//
import UIKit
import CoreData

class AddMovieViewController: UIViewController, UITextFieldDelegate
{
	var movies: [NSManagedObject] = []
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
		if text != ""
		{
			let trimmedText = text.trimmingCharacters(in: .whitespaces)
			self.save(trimmedText)
			textField.text = ""
		}
		textField.resignFirstResponder()
		return true
	}
	
	func save(_ name: String)
	{
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
		{
				return
		}
		let context = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
		let movie = NSManagedObject(entity: entity,
									 insertInto: context)
		movie.setValue(name, forKeyPath: "name")
		
		do
		{
			try context.save()
			movies.append(movie)
		} catch
		{
			print("Save error: \(error)")
		}
	}
}
