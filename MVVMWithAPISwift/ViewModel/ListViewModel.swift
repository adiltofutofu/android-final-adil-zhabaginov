//
//  ListViewModel.swift
//  MVVMWithAPISwift
//
//  Created by Adil on 23.05.2023.
//  Copyright © 2023 Adil Zhabaginov. All rights reserved.
//
import UIKit
class ListViewModel {
    
    var reload = {() -> () in }
    var errorM = {(message : String) -> () in }
    
    var list : [List] = []{
        didSet{
            reload()
        }
    }
    
    func getListData() {
        guard let listURL = URL(string: "https://meowfacts.herokuapp.com/?count=10") else {
            return
        }
        URLSession.shared.dataTask(with: listURL) { (data, response, error) in
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MeowFactsResponse.self, from: jsonData)
                let facts = response.data
                self.list = facts.enumerated().map { (index, fact) -> List in
                    var list = List()
                    list.id = index
                    list.fact = fact
                    return list
                }
            } catch let error {
                print("Error ->\(error.localizedDescription)")
                self.errorM(error.localizedDescription)
            }
        }.resume()
    }
}
