//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Maxwell Poffenbarger on 1/24/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    //MARK: - Properties
    var movieInfo: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        
        let movie = movieInfo[indexPath.row]
        
        cell?.movie = movie
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 7
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? MovieDetailViewController else {return}
                let movie = movieInfo[indexPath.row]
                destinationVC.movie = movie
            }
        }
    }
}//End of class

//MARK: - Extensions
extension MovieTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        MovieController.FetchMovieData(movieValue: searchTerm.lowercased()) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.movieInfo = movie
                    searchBar.text = ""
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of extension
