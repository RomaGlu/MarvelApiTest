import UIKit
import SnapKit

class DetailViewController: UIViewController {
    let urlConstructor = URLConstructor()
    let detailView = DetailView()
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Comics details"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureView(_ comics: Comics) {
        if let imageUrlString = urlConstructor.getImageUrl(path: comics.thumbnail?.path,
                                                           size: .portrait,
                                                           extention: comics.thumbnail?.imageExtension) {
            
            NetworkManager().getImages(from: imageUrlString) { result in
                switch result {
                case .success(let data):
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.detailView.comicsImage.image = image
                            self.view.backgroundColor = UIColor(patternImage: image)
                            self.view.addBlurredBackground(style: .light)
                        }
                    }
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        } else {
            
        }
        self.detailView.comicsTitleLabel.text = comics.title
        
        if let description = comics.description {
            self.detailView.comicsDescriptionLabel.text = description
        } else {
            self.detailView.comicsDescriptionLabel.text = "Description is unavailable..."
        }
    }
    
}

extension UIView {
    func addBlurredBackground(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
    }
}
