//
//  TableViewController.swift
//  CoreMovies
//
//  Created by Jose on 20/5/19.
//  Copyright © 2019 appcat.com. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController
{
	var movies: [NSManagedObject] = []
	let coreDataStack = CoreDataStack()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		title = "Top 10 All-time Movies"
		
		/*let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(contextChanged), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: coreDataStack.context)*/
    }
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		do
		{
			movies = try coreDataStack.context.fetch(coreDataStack.fetchRequest)
			//try coreDataStack.fetchController.performFetch()
			//movies = coreDataStack.fetchController.fetchedObjects ?? []
			print("movies array: \(movies.count)")
		} catch
		{
			print("Fetch error: \(error)")
		}
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int
	{
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let movie = movies[indexPath.row]
		cell.textLabel?.text = movie.value(forKey: "name") as? String
        return cell
    }
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
	{
		if editingStyle == .delete
		{
			coreDataStack.context.delete(movies[indexPath.row])
			do { try coreDataStack.context.save() }
			catch { print("Save error: \(error)") }
			
			movies.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}

    // MARK: - Navigation
	@IBAction func unwindFromAddMovieVC(segue: UIStoryboardSegue)
	{
		let addMovieVC = segue.source as! AddMovieViewController
		self.movies.append(contentsOf: addMovieVC.movies)
		tableView.reloadData()
	}
	
	// MARK: - Notification center selector
	@objc func contextChanged()
	{
		print("context just changed.")
	}

}
