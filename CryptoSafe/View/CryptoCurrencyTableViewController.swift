import UIKit

class CryptoCurrencyTableViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    private var tableView: UITableView = UITableView()
    private var coordinator = AppCoordinator()
    
    var viewModel: CryptoCurrencyTableViewViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        viewModel = CryptoCurrencyTableViewViewModel()
        setupTableView()
        setupActivityIndicator()
        navigationController()
        activityIndicator.startAnimating()
        viewModel?.fetchAssets { [weak self] _ in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func backAction() {
        AuthManager.isAuthorized = false
        coordinator.switchScreen(.login)
    }
    
    @objc func sortAction() {
        let alertController = UIAlertController(title: "Сортировка", message: "Выберите вариант сортировки:", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "По возрастанию цены", style: .default) { action in
            self.viewModel?.sortAssets(by: .ascending)
            self.tableView.reloadData()
        }
        
        let action2 = UIAlertAction(title: "По убыванию цены", style: .default) { action in
            self.viewModel?.sortAssets(by: .descending)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            self.viewModel?.sortAssets(by: .back)
            self.tableView.reloadData()
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func navigationController() {
        self.title = "Crypto info"
        let backButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(backAction))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortAction))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CryptoCurrencyTableViewCell.self, forCellReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

extension CryptoCurrencyTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let asset = viewModel?.asset(atIndex: indexPath.row), let basicViewModel = viewModel?.cyrrencyDetailViewModel(forAsset: asset) {
            let basicView = CurrencyDetailViewController(viewModel: basicViewModel)
            navigationController?.pushViewController(basicView, animated: true)
        }
    }
    
    @objc func dismis() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CryptoCurrencyTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        cell?.accessoryType = .disclosureIndicator
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
}
