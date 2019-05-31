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
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		title = "Top 10 All-time Movies"
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

    // MARK: - Navigation
	@IBAction func unwindFromAddMovieVC(segue: UIStoryboardSegue)
	{
		let addMovieVC = segue.source as! AddMovieViewController
		self.movies.append(contentsOf: addMovieVC.movies)
		tableView.reloadData()
	}

}
