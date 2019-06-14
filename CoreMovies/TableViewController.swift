//
//  TableViewController.swift
//  CoreMovies
//
//  Created by Jose on 20/5/19.
//  Copyright © 2019 appcat.com. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate
{
	var movies: [NSManagedObject] = []
	let coreDataStack = CoreDataStack()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		title = "Top 10 All-time Movies"
		coreDataStack.fetchController.delegate = self
		
		do
		{
			//movies = try coreDataStack.context.fetch(coreDataStack.fetchRequest)
			try coreDataStack.fetchController.performFetch()
			movies = coreDataStack.fetchController.fetchedObjects ?? []
		} catch
		{
			print("Fetch error: \(error)")
		}
		
		/*let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(contextChanged), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: coreDataStack.context)*/
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
			let movie = movies[indexPath.row]
			movies.remove(at: indexPath.row)
			coreDataStack.context.delete(movie)
			do
			{
				try coreDataStack.context.save()
			} catch
			{
				print("Save error: \(error)")
			}
		}
	}

    // MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		let addMovieVC = segue.destination as! AddMovieViewController
		addMovieVC.coreDataStack = coreDataStack
		addMovieVC.tableViewController = self
	}
	
	// MARK: - FetchedResultsController Delegate Methods
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
	{
		tableView.beginUpdates()
		//print("will change controller.fetchedObjects")
	}
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
	{
		switch type
		{
			case .insert:
				tableView.insertRows(at: [newIndexPath!], with: .automatic)
			case .delete:
				tableView.deleteRows(at: [indexPath!], with: .automatic)
			case .update:
				tableView.reloadRows(at: [newIndexPath!], with: .automatic)
			case .move:
				tableView.moveRow(at: indexPath!, to: newIndexPath!)
		}
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
	{
		tableView.reloadData()
		tableView.endUpdates()
		//print("did change controller.fetchedObjects")
	}
	
	// MARK: - Notification center selector
	@objc func contextChanged()
	{
		print("context just changed.")
	}

}
