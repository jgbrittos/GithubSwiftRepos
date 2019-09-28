import UIKit

extension UIImageView {
    func download(from link: String) {
        guard let url = URL(string: link) else { return }
        download(from: url)
    }

    private func download(from url: URL) {
        contentMode = .scaleAspectFit
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data,
                error == nil,
                let image = UIImage(data: data)
                else {
//                    update(to: )
                    return
            }
            
            self?.update(to: image)
            
        }.resume()
    }
    
    private func update(to image: UIImage) {
        DispatchQueue.main.async() {
            self.image = image
        }
    }
}
