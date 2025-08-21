//
//  EmojiCollectionViewCell.swift
//  Tracker
//
//  Created by Irina Gubina on 11.08.2025.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    static let identifier = "EmojiCell"
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .lightGrayE6 : .clear
            contentView.layer.cornerRadius = 16
            contentView.layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
            }
           
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
            func configure(with emoji: String) {
                emojiLabel.text = emoji
            }
            
            private func setupViews() {
                contentView.addSubview(emojiLabel)
                NSLayoutConstraint.activate([
                emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                ])
            }
        }
