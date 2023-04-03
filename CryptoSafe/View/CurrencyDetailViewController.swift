import UIKit

class CurrencyDetailViewController: UIViewController {

    var viewModel: CurrencyDetailViewModel
    private var idLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    private var supplyLabel: UILabel = UILabel()
    private var capUsdLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(idLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(supplyLabel)
        self.view.addSubview(capUsdLabel)
        idLabel.text = viewModel.id
        nameLabel.text = viewModel.name
        supplyLabel.text = viewModel.symbol
        setapIdLabel()
        setapNameLabel()
        setapSupplyLabel()

    }
    private func setapSupplyLabel() {
        supplyLabel.translatesAutoresizingMaskIntoConstraints = false
        supplyLabel.textColor = .red
        NSLayoutConstraint.activate([
            supplyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            supplyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            supplyLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setapNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .red
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setapIdLabel() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.textColor = .red
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            idLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    init(viewModel: CurrencyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
