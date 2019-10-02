import UIKit

final class RepoItemTableViewCell: UITableViewCell {
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "user")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        return image
    }()
    
    private let repoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let authorNameLabel = UILabel()
    private let starsLabel = UILabel()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repoNameLabel, authorNameLabel, starsLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    func set(repo: Repo) {
        repoNameLabel.text = repo.name
        authorNameLabel.text = "Author: \(repo.owner.name)"
        starsLabel.text = "\(repo.stars) ⭐️"
        photoImageView.download(from: repo.owner.photoUrl)
        
        build()
    }
}

extension RepoItemTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(stackView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func finalSetup() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
