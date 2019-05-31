//
//  MVVM_ContactTests.swift
//  MVVM ContactTests
//
//  Created by UziApel on 11/12/18.
//  Copyright © 2018 uzi. All rights reserved.
//

import XCTest
@testable import MVVM_Contact
class MVVM_ContactTests: XCTestCase {
    var command : ContactViewModel = ContactViewModel(dataService: ApiContact())
    
    func testPerformanceGetContact() {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }
    
    func testPerformanceGetContactByGender() {
        // This is an example of a performance test case.
        self.measure {
            command.list.addObserver(fireNow: true) { (contactList) in
                print("update list \(contactList)")
            }
            command.isLoading.addObserver { (isLoading) in
                print("check loading \(isLoading)")
            }
            command.isError.addObserver { (isError) in
                print("check error \(isError)")
            }
            command.getContact()
        }
    }
}
