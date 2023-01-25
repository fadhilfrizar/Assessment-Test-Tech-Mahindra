//
//  UserInteractorTests.swift
//  Assessment Test Tech MahindraTests
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import Foundation
import XCTest
@testable import Assessment_Test_Tech_Mahindra

class UserInteractorTests: XCTestCase {
    var interactor: UserInteractor!
    var presenter: UserPresenter!
    var expectation: XCTestExpectation!
    
    
    override func setUp() {
        super.setUp()
        presenter = UserPresenter()
        interactor = UserInteractor()
        interactor.presenter = presenter
    }
    
    func testGetUsers() {
        expectation = self.expectation(description: "Fetch Users")
        presenter.view = self
        interactor.getUsers(page: 1)
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Error: \(error!.localizedDescription)")
        }
    }
}

extension UserInteractorTests: UserView {
    func showLoading() {
    }
    
    func stopLoading() {
    }
    
    func displayUsers(_ users: [User]) {
        XCTAssert(users.count > 0)
        expectation.fulfill()
    }
}
