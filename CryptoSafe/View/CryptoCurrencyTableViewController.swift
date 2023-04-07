import UIKit

final class CryptoCurrencyTableViewController: UIViewController {

    // MARK: - Properties

    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    private var tableView: UITableView = UITableView()
    private var coordinator = AppCoordinator()
    private var viewModel: CryptoCurrencyTableViewViewModelType?
    
    
    // MARK: - Lifecycle

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
    
    // MARK: - Navigation

    private func navigationController() {
        self.title = "Crypto info"
        let backButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(backAction))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortAction))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    // MARK: - Actions on navigationBar

    @objc func backAction() {
        AuthManager.isAuthorized = false
        coordinator.switchScreen(.login)
    }
    
    @objc func sortAction() {
        let alertController = UIAlertController(title: "Сортировка", message: "Выберите вариант сортировки:", preferredStyle: .actionSheet)
        
        let actions: [(title: String, style: UIAlertAction.Style, sortType: SortOrder)] = [
            ("По возрастанию цены", .default, .ascending),
            ("По убыванию цены", .default, .descending),
            ("Изменение цены за час по убыванию", .default, .down),
            ("Изменение цены за час по возрастанию", .default, .up),
            ("Отмена", .cancel, .back)
        ]
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                self.viewModel?.sortAssets(by: action.sortType)
                self.tableView.reloadData()
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true)
    }
    
    // MARK: - Setup

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

// MARK: - UITableViewDataSource

extension CryptoCurrencyTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
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

// MARK: - UITableViewDelegate

extension CryptoCurrencyTableViewController: UITableViewDelegate {
    
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
}
