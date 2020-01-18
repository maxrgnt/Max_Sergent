//
//  Extension.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/19/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
}

extension UILabel {

    func frameForLabel(text:String, font:UIFont, numberOfLines: Int, width: CGFloat? = CGFloat.greatestFiniteMagnitude) -> (width: CGFloat, height: CGFloat) {
        let max = CGFloat.greatestFiniteMagnitude
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width!, height: max))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return (width: label.frame.width, height: label.frame.height)
    }
}

extension UIImage {
    func saveImage(as fileName: String) -> Bool {
        guard let data = self.jpegData(compressionQuality: 1) ?? self.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(fileName).png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329 //color #999999 if string has wrong format
                    // UInt32 but deprecated in iOS 13
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue) // scanHexInt32 but deprecated in iOS 13
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


//    UIView.animate(withDuration: 0.55, delay: 0.0,
//        // 1.0 is smooth, 0.0 is bouncy
//        usingSpringWithDamping: 0.7,
//        // 1.0 corresponds to the total animation distance traversed in one second
//        // distance/seconds, 1.0 = total animation distance traversed in one second
//        initialSpringVelocity: 1.0,
//        options: [.curveEaseInOut],
//        // [autoReverse, curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear]
//        animations: {
//            //Do all animations here
//            self.view.layoutIfNeeded()
//    }, completion: {
//           //Code to run after animating
//            (value: Bool) in
//        }
//    )
