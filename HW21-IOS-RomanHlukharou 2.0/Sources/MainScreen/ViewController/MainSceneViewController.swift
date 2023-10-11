//
//  ViewController.swift
//  HW21-IOS-RomanHlukharou 2.0
//
//  Created by Роман Глухарев on 8.10.23.
//

import UIKit

class MainSceneViewController: UIViewController {

    //    MARK: - Properies
    
    let urlConstructor = URLConstructor()
    let networkManager = NetworkManager()
    let comicsView = ComicsView()
    var timer: Timer?
    var comics: [Comics] = []
    
    //    MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = comicsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComics(from: urlConstructor.getMasterUrl(name: nil, value: nil))
        setupView()
        setupSearchBar()
        setupTableView()
    }
    
    //    MARK: - Layout
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Marvel Comics"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        comicsView.comicsTableView.dataSource = self
        comicsView.comicsTableView.delegate = self
        comicsView.comicsTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search by character."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    //    MARK: - Alert
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //    MARK: - Fetch function

    private func fetchComics(from url: String) {
        networkManager.fetchData(from: url) { (result) in
            switch result {
            case .success(let comics):
                DispatchQueue.main.async {
                    self.comics = comics
                    if self.comics.isEmpty {
                        self.showAlert(title: "Error", message: "Title not found")
                    }
                    self.comicsView.comicsTableView.reloadData()
                }

            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                self.showAlert(title: "Request error", message: error.localizedDescription)
            }
        }
    }
}

extension MainSceneViewController: UISearchBarDelegate {
    
    //    MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.fetchComics(from: self.urlConstructor.getMasterUrl(name: "title", value: searchText))
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchComics(from: urlConstructor.getMasterUrl(name: nil, value: nil))
    }
}

extension MainSceneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comics = comics[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        cell.configureView(with: comics)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            comics.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let comics = comics[indexPath.row]
        let viewController = DetailViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.configureView(comics)
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
