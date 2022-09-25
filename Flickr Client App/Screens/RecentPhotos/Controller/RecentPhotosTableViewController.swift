//
//  RecentPhotosTableViewController.swift
//  Flickr Client App
//
//  Created by Ali Berkay BERBER on 30.08.2022.
//

import UIKit

class RecentPhotosTableViewController: UITableViewController,
                                       UISearchResultsUpdating {

   private var response: PhotoResponse? {
       didSet {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
           
       }
   }

    private var selectedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetchRecentPhotos()

    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }

    private func fetchRecentPhotos() {
        guard let url = URL(string:                                                                 "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=7dd89640e14551c5df5f7bbae1f68223&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data, let response = try? JSONDecoder().decode(PhotoResponse.self, from: data) {
                self.response = response
            }
        }.resume()
    }
                                        
    private func searchPhotos(with text: String) {
       guard let url = URL(string:                                                                "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=7dd89640e14551c5df5f7bbae1f68223&text=\(text)&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else {return}
       let request = URLRequest(url: url)
       
       URLSession.shared.dataTask(with: request) { data, response, error in
           if let error = error {
               debugPrint(error)
               return
           }
           if let data = data, let response = try? JSONDecoder().decode(PhotoResponse.self, from: data) {
               self.response = response
               
           }
       }.resume()
   }

    private func fetchImage(with url: String?, competion: @escaping (Data) -> Void){
        
        if let urlString = url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    debugPrint(error)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        competion(data)
                        //cell.photoImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.photos?.photo?.count ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = response?.photos?.photo?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        cell.ownerImageView.backgroundColor = .darkGray
        cell.ownerNameLabel.text = photo?.ownername
        
        if let iconserver = photo?.iconserver,
           let iconfarm = photo?.iconfarm,
            let nsid = photo?.owner,
           NSString(string: iconserver).intValue > 0 {
            
            fetchImage(with: "http://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(nsid).jpg") { data in
                cell.ownerImageView.image = UIImage(data: data)
            }
        } else {
            fetchImage(with: "https://www.flickr.com/images/buddyicon.gif") { data in
                cell.ownerImageView.image = UIImage(data: data)
            }
        }
        
        fetchImage(with: photo?.urlN) { data in
            cell.photoImageView.image = UIImage(data: data)
        }
        //cell.photoImageView.backgroundColor = .gray
        cell.titleLabel.text = photo?.title
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPhoto = response?.photos?.photo?[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoDetailViewController {
            viewController.photo = selectedPhoto
           
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            searchPhotos(with: text)        }
        
    }
}

