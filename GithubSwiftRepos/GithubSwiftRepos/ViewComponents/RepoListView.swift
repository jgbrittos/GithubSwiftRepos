import UIKit

final class RepoListView: UIView {
    private let repo = RepoCell()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

extension RepoListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(repo)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            repo.leadingAnchor.constraint(equalTo: leadingAnchor),
            repo.trailingAnchor.constraint(equalTo: trailingAnchor),
            repo.topAnchor.constraint(equalTo: topAnchor),
            repo.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func finalSetup() {
        backgroundColor = .white
        repo.translatesAutoresizingMaskIntoConstraints = false
    }
}
