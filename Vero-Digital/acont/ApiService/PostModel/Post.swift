//
//  POST.swift
//  acont
//
//  Created by serif mete on 8.02.2023.
//



import Foundation
// MARK: - PostElement
final class PostElement: NSObject, Codable {
    @objc dynamic var task = ""
    @objc dynamic var title = ""
    @objc dynamic var descriptions = ""
    @objc dynamic var colorCode = ""
    @objc dynamic var _id: UUID?
    
    enum CodingKeys: String, CodingKey {
        case task
        case title
        case descriptions = "description"
        case colorCode
    }
   convenience init(task: String?, title:String?,description:String?, colorCode:String?) {
       self.init()
       self.task = task ?? ""
       self.title = title ?? ""
       self.descriptions = description ?? ""
       self.colorCode = colorCode ?? ""
        
    }

}
