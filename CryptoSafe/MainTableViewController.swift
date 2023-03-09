
import UIKit

class MainTableViewController: UIViewController {
    
//    var cryptoArray = ["bitcoin","ethereum","tron", "luna","polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    
    private var assets: [Asset] = []
    private var originalAssets: [Asset] = []
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    private var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        setupTableView()
        setupActivityIndicator()
        navigationController()
        print("asdf")
        
        RequestServer().fetchAssets { [weak self] assets in
            guard let assets = assets else {
                return
            }
            self?.assets = assets
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.originalAssets = assets
                self?.tableView.reloadData()
            }
        }
    }

    
    @objc func backAction() {
        let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "login")
            defaults.removeObject(forKey: "password")
            defaults.synchronize()
        let previousViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: previousViewController)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }

    @objc func sortAction() {
        let alertController = UIAlertController(title: "Сортировка", message: "Выберите вариант сортировки:", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "По возрастанию цены", style: .default) { action in
            self.assets = self.assets.sorted { (asset1, asset2) -> Bool in
                guard let priceUsd1 = asset1.priceUsd, let priceUsd2 = asset2.priceUsd else {
                    return false
                }
                return Double(priceUsd1) ?? 0 < Double(priceUsd2) ?? 0
            }
            self.tableView.reloadData()
        }

        let action2 = UIAlertAction(title: "По убыванию цены", style: .default) { action in
            self.assets = self.assets.sorted { (asset1, asset2) -> Bool in
                guard let priceUsd1 = asset1.priceUsd, let priceUsd2 = asset2.priceUsd else {
                    return false
                }
                return Double(priceUsd1) ?? 0 > Double(priceUsd2) ?? 0
            }
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            self.assets = self.originalAssets
            self.tableView.reloadData()
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)

    }
    
    private func navigationController() {
        self.title = "Крипта"
        let backButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(backAction))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortAction))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
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

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let asset = assets[indexPath.row]
        let basicView = BasicViewController()
        basicView.idLabel.text = "id: \(asset.id)"
        basicView.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exite", style: .done, target: self, action: #selector(dismis))
        let navigation = UINavigationController(rootViewController: basicView)
                navigation.modalPresentationStyle = .fullScreen
                present(navigation, animated: true)
    }
    
    @objc func dismis() {
        dismiss(animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            fatalError("Unable to dequeue MainTableViewCell")
        }
        let asset = assets[indexPath.row]
        cell.titleLabel.text = asset.name
        let priceDouble = convertToDouble(asset.priceUsd)
        cell.subtitleLabel.text = formatPrice(priceDouble)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func formatPrice(_ price: Double?) -> String {
        guard let price = price else {
            return "$0.00"
        }
        return String(format: "$%.5f", price)
    }
    
    private func convertToDouble(_ string: String?) -> Double? {
        guard let string = string else { return nil }
        return Double(string)
    }

}
