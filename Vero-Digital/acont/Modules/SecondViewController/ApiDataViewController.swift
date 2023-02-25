//
//  SecondViewController.swift
//  acont
//
//  Created by serif mete on 8.02.2023.
//

import UIKit


final class ApiDataViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    //MARK: - My Variable
    
    private let refreshControl = UIRefreshControl()
   private var resultSearchController = UISearchController()
   private var isSearch: Bool = false
    @IBOutlet weak var myTableView: UITableView!
    private let service = DownloadService()
   private var Post: [PostElement] = []
   private var FilterPost = [PostElement]()
    
    //MARK: - My Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchResults(for: resultSearchController)
        setupSearchController()
        tableViewDD() //delegate-dataSoruce
        pulltoref()
        self.myTableView.reloadOnMainThread()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.fetchData()
        }
    }
    
    private func tableViewDD(){
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    private func setupSearchController() {
        self.resultSearchController = ({
        let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            self.myTableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    
    
   private func pulltoref() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.myTableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        myTableView.reloadOnMainThread()
        refreshControl.endRefreshing()
    }
    
    
   private func filterContentForSearchText(_ searchText: String) {
        FilterPost = Post.filter({ (post:PostElement) -> Bool in
            let titleMatch = post.title.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let descpMatch = post.description.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let taskMatch = post.task.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let colorMatch = post.colorCode.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return titleMatch != nil || descpMatch != nil || taskMatch != nil || colorMatch != nil
        })
    }
    
    
    internal func updateSearchResults(for searchController: UISearchController) {

        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            self.myTableView.reloadOnMainThread()
        }
    }
    
    
   private func reloaded() {
        self.myTableView.reloadOnMainThread()
    }
    

   private func fetchData() {
        service.downloadService { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            self.Post = result
            self.reloaded()
          
        }
    }
}

extension ApiDataViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if resultSearchController.isActive {
            return FilterPost.count
        } else {
            return Post.count
            }
            
        
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        tableView.allowsSelection = false
        if resultSearchController.isActive {
            cell.savemodel(model: FilterPost[indexPath.row])
        } else {
           // let object = kek?[indexPath.row]
            cell.savemodel(model: Post[indexPath.row])
        }
        
        
        return cell
        
    }
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if resultSearchController.isActive {
            return false
        } else {
            return true
        }
    }
}


