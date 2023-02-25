//
//  TableViewCell.swift
//  acont
//
//  Created by serif mete on 8.02.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    //MARK: - My Variable
    
    @IBOutlet weak var colorlabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var descp: UILabel!
    @IBOutlet weak var task: UILabel!
    
    //MARK: - My Function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .black
    }
    //MARK: - Api Data Show in Cell Text
    func savemodel(model: PostElement) {
        self.myLabel.text = "Title: \(model.title )"
        self.descp.text = "Descripton: \(model.descriptions )"
        self.task.text = "Task: \(model.task )"
        self.colorlabel.text = "Color: \(model.colorCode )"
        self.myLabel.textColor = hexStringToUIColor(hex: model.colorCode )
        self.task.textColor = hexStringToUIColor(hex: model.colorCode )
        self.descp.textColor = hexStringToUIColor(hex: model.colorCode )
        self.colorlabel.textColor = hexStringToUIColor(hex: model.colorCode )
    }
}
//MARK: - Api HEX Color Change UIColor
extension TableViewCell {
   private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
