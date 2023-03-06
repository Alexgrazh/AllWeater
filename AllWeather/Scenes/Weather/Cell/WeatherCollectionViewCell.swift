//
//  WeatherCollectionViewCell.swift
//  AllWeather
//
//  Created by Alex Grazhdan on 05.01.2023.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet private var iconImage: UIImageView!
    @IBOutlet private var textWeek: UILabel!
  
//    var day : String {
//        let days = DateFormatter.string(from: da)
//    }

    func configure(_ data : List){
        iconImage.image = data.weather[0].conditionImage
        textWeek.text = data.weather[0].main.rawValue

    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //contentView.layer.cornerRadius = 16
        contentView.layer.cornerRadius = 16
    }
    
}
