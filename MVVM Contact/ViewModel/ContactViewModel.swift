//
//  ContactViewModel.swift
//  MVVM Contact
//
//  Created by UziApel on 19/01/19.
//  Copyright © 2019 uzi. All rights reserved.
//
import UIKit
import SwiftyJSON
import Foundation

class ContactViewModel {
    private var dataService: ApiContact?
    
    // MARK: - Properties List
    public var roomsfilter : [Contact] = []
    public var list = Observable<[Contact]>(value: [])
    
    // MARK: - Properties
    public var isError = Observable<String>(value: "")
    public var isLoading = Observable<Bool>(value: false)
    
    // MARK: - Constructor
    init(dataService: ApiContact) {
        self.dataService = dataService
    }
    
    func getContact() {
        self.isLoading.value = true
        ApiContact.getContact { (response) in
            switch(response){
            case .succeed(let data):
                self.bindingModel(data: data)
                break
            case .failed(let m):
                self.isError.value = m
                break
            default:
                break
            }
        }
    }
    
    func genderContact(gender : String){
        self.isLoading.value = true
        ApiContact.getContactGender(gender: gender) { (response) in
            switch(response){
            case .succeed(let data):
                self.bindingModel(data: data)
                break
            case .failed(let m):
                self.isError.value = m
                break
            default:
                break
            }
        }
    }
    
    func bindingModel(data : Any?){
        let dataJSON = JSON(data)
        var localList : [Contact] = []
        for list in dataJSON["results"].arrayValue {
            let w = Contact()
            w.name = list["name"]["title"].stringValue + " " + list["name"]["first"].stringValue + " " + list["name"]["last"].stringValue
            w.image = list["picture"]["large"].stringValue
            w.phone = list["phone"].stringValue
            localList.append(w)
        }
        self.list.value = localList
        self.roomsfilter = localList
        self.isLoading.value = false
    }
}
