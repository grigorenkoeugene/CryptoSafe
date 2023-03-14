import UIKit

class BasicViewController: UIViewController {

    var idLabel: UILabel = UILabel()
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
        setapIdLabel()
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
    

}
