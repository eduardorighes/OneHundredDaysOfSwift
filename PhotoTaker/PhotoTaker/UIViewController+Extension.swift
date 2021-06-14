//
//  UIViewController+Extension.swift
//  PhotoTaker
//
//  Created by Eduardo Maestri Righes on 14/06/2021.
//

import UIKit

extension UIViewController {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
