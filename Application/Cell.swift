import UIKit

class Cell:UICollectionViewCell {
    weak var item:Item? { didSet { updateViewModel() } }
    private weak var indicator:UIActivityIndicatorView!
    private weak var imageView:UIImageView!
    private weak var text:UILabel!
    private weak var donate:UIControl!
    private weak var refresh:UIButton!
    private weak var facebook:UIButton!
    private weak var donateMessage:UILabel!
    
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
        
        let donate = UIControl()
        donate.translatesAutoresizingMaskIntoConstraints = false
        donate.layer.cornerRadius = 50
        donate.layer.borderColor = UIColor.black.cgColor
        donate.layer.borderWidth = 1
        contentView.addSubview(donate)
        self.donate = donate
        
        let refresh = UIButton()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.backgroundColor = UIColor(white:1, alpha:0.5)
        refresh.setTitleColor(.black, for:.normal)
        refresh.setTitleColor(UIColor(white:0, alpha:0.2), for:.highlighted)
        refresh.layer.cornerRadius = 14
        refresh.titleLabel!.font = .systemFont(ofSize:11, weight:.bold)
        contentView.addSubview(refresh)
        self.refresh = refresh
        
        let facebook = UIButton()
        facebook.translatesAutoresizingMaskIntoConstraints = false
        facebook.backgroundColor = UIColor(white:1, alpha:0.95)
        facebook.setTitleColor(.black, for:.normal)
        facebook.setTitleColor(UIColor(white:0, alpha:0.2), for:.highlighted)
        facebook.layer.cornerRadius = 6
        facebook.titleLabel!.font = .systemFont(ofSize:13, weight:.bold)
        contentView.addSubview(facebook)
        self.facebook = facebook
        
        let donateMessage = UILabel()
        donateMessage.translatesAutoresizingMaskIntoConstraints = false
        donateMessage.isUserInteractionEnabled = false
        donateMessage.textAlignment = .center
        donateMessage.numberOfLines = 0
        donateMessage.textColor = .black
        donateMessage.font = .systemFont(ofSize:14, weight:.medium)
        donate.addSubview(donateMessage)
        self.donateMessage = donateMessage
        
        indicator.centerXAnchor.constraint(equalTo:imageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo:imageView.centerYAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo:topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-230).isActive = true
        
        text.leftAnchor.constraint(equalTo:leftAnchor, constant:20).isActive = true
        text.rightAnchor.constraint(equalTo:rightAnchor, constant:-20).isActive = true
        text.topAnchor.constraint(equalTo:imageView.bottomAnchor, constant:20).isActive = true
        
        donate.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        donate.widthAnchor.constraint(equalToConstant:100).isActive = true
        donate.heightAnchor.constraint(equalToConstant:100).isActive = true
        donate.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-20).isActive = true
        
        refresh.rightAnchor.constraint(equalTo:rightAnchor, constant:-5).isActive = true
        refresh.topAnchor.constraint(equalTo:topAnchor, constant:5).isActive = true
        refresh.widthAnchor.constraint(equalToConstant:60).isActive = true
        refresh.heightAnchor.constraint(equalToConstant:34).isActive = true
        
        facebook.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        facebook.centerYAnchor.constraint(equalTo:imageView.bottomAnchor).isActive = true
        facebook.widthAnchor.constraint(equalToConstant:190).isActive = true
        facebook.heightAnchor.constraint(equalToConstant:35).isActive = true
        
        donateMessage.topAnchor.constraint(equalTo:donate.topAnchor).isActive = true
        donateMessage.bottomAnchor.constraint(equalTo:donate.bottomAnchor).isActive = true
        donateMessage.leftAnchor.constraint(equalTo:donate.leftAnchor).isActive = true
        donateMessage.rightAnchor.constraint(equalTo:donate.rightAnchor).isActive = true
    }
    
    private func updateViewModel() {
        guard let item = self.item else { return }
        text.attributedText = item.text
        donate.isHidden = item.donateHidden
        facebook.isHidden = item.facebookHidden
        refresh.isHidden = item.refreshHidden
        donateMessage.text = item.donateMessage
        refresh.setTitle(item.refreshMessage, for:[])
        facebook.setTitle(item.facebookMessage, for:[])
        updateImage()
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
