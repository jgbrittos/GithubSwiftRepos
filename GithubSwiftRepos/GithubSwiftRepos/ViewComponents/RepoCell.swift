import UIKit

final class RepoCell: UIView {
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "user")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.download(from: "https://avatars2.githubusercontent.com/u/484656?v=4")
        return image
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension RepoCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(photoImageView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func finalSetup() {
        backgroundColor = .blue
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
