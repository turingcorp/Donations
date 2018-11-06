import UIKit

class Cell:UICollectionViewCell {
    weak var item:Item? { didSet {
        text.attributedText = item?.text
        updateImage()
    } }
    private weak var indicator:UIActivityIndicatorView!
    private weak var imageView:UIImageView!
    private weak var text:UILabel!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 20
        makeOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func makeOutlets() {
        let indicator = UIActivityIndicatorView(style:.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indicator)
        self.indicator = indicator
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isUserInteractionEnabled = false
        text.numberOfLines = 0
        text.font = .preferredFont(forTextStyle:.title1)
        text.textColor = .black
        contentView.addSubview(text)
        self.text = text
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        self.imageView = imageView
        
        indicator.centerXAnchor.constraint(equalTo:imageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo:imageView.centerYAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo:topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-200).isActive = true
        
        text.leftAnchor.constraint(equalTo:leftAnchor, constant:20).isActive = true
        text.rightAnchor.constraint(equalTo:rightAnchor, constant:-20).isActive = true
        text.topAnchor.constraint(equalTo:imageView.bottomAnchor, constant:20).isActive = true
    }
    
    private func updateImage() {
        imageView.alpha = 0
        if let image = item?.image {
            fadeIn(image:image)
        } else if let url = item?.url {
            indicator.startAnimating()
            DispatchQueue.global(qos:.background).async { [weak self] in
                self?.request(url:url)
            }
        }
    }
    
    private func request(url:URL) {
        URLSession.shared.dataTask(with:url) { [weak self] data, _, _ in
            guard
                url == self?.item?.url,
                let data = data,
                let image = UIImage(data:data)
            else { return }
            self?.item?.image = image
            DispatchQueue.main.async { [weak self] in
                self?.fadeIn(image:image)
            }
        }.resume()
    }
    
    private func fadeIn(image:UIImage) {
        indicator.stopAnimating()
        imageView.image = image
        UIView.animate(withDuration:1.5) { [weak self] in
            self?.imageView.alpha = 1
        }
    }
}
