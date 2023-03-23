//
//  GFAvatarImageView.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 17.03.2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    private let cache = NetworkManager.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        if let placeholderImage {
            image = placeholderImage
        }
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getImage(from url: String) {
        if let image = cache.object(forKey: NSString(string: url)) {
            self.image = image
        } else {
            Task {
                do {
                    if let image = try await downloadImage(from: url) {
                        await MainActor.run {
                            self.image = image
                            cache.setObject(image, forKey: NSString(string: url))
                        }
                    }
                } catch {
                    await MainActor.run {
                        image = placeholderImage
                    }
                }
            }
        }
    }
    
    private func downloadImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else   {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
            
        } catch  {
            print(error)
            throw error
        }
    }
}

