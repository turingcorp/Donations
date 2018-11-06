import UIKit

class Cell:UICollectionViewCell {
    weak var item:Item? { didSet {
        text.attributedText = item?.text
    } }
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
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isUserInteractionEnabled = false
        text.numberOfLines = 0
        text.font = .preferredFont(forTextStyle:.body)
        contentView.addSubview(text)
        self.text = text
        
        text.leftAnchor.constraint(equalTo:leftAnchor, constant:20).isActive = true
        text.rightAnchor.constraint(equalTo:rightAnchor, constant:-20).isActive = true
        text.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-20).isActive = true
    }
}
