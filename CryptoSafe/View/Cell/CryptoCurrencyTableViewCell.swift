import UIKit

final class CryptoCurrencyTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let changeUSDLast1HourLabel = UILabel()
    
    weak var viewModel: CryptoCurrencyTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.name
            subtitleLabel.text = "Price to USD: \(String(viewModel.price))"
            changeUSDLast1HourLabel.attributedText = viewModel.changeUSDLast1HourAttributedString
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        changeUSDLast1HourLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(changeUSDLast1HourLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        changeUSDLast1HourLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            changeUSDLast1HourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            changeUSDLast1HourLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: changeUSDLast1HourLabel.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
