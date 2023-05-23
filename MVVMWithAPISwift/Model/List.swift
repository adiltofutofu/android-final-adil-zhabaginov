//
//  List.swift
//  MVVMWithAPISwift
//
//  Created by Adil on 23.05.2023.
//  Copyright © 2023 Adil Zhabaginov. All rights reserved.
//
import UIKit
class List: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    var fact: String? // New property for the fact
}
