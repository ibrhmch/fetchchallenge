//
//  MealDetailViewModelTests.swift
//  fetchchallengeTests
//
//  Created by octopus on 6/10/24.
//

import XCTest
@testable import fetchchallenge

final class MealDetailViewModelTests: XCTestCase {
    var viewModel: MealDetailViewModel!
    var mockService: MockNetworkingService!
    
    override func setUp() async throws {
        try await super.setUp()
        mockService = MockNetworkingService()
        viewModel = MealDetailViewModel(networkingService: mockService)
    }
    
    override func tearDown() async throws {
        viewModel = nil
        mockService = nil
        try await super.tearDown()
    }
    
    func testFetchMealDetailSuccess() async throws {
        // Arrange
        let mealID = "52788"
        let mockData = """
        {
            "meals": [
                {
                    "idMeal": "52788",
                    "strMeal": "Apple Pie",
                    "strInstructions": "Some instructions",
                    "strMealThumb": "nil"
                }
            ]
        }
        """.data(using: .utf8)!
        
        mockService.fetchDataHandler = { _ in
            return mockData
        }
        
        // Act
        await viewModel.fetchMealDetail(mealID: mealID)
        
        // Assert
        XCTAssertNotNil(viewModel.viewState, "ViewState should not be nil")
    }
    
    func testFetchMealDetailFailure() async throws {
        // Arrange
        let mealID = "InvalidID"
        
        mockService.fetchDataHandler = { _ in
            throw URLError(.badServerResponse)
        }
        
        // Act
        await viewModel.fetchMealDetail(mealID: mealID)
        
        // Assert
        XCTAssert(viewModel.viewState == .failure("The operation couldn’t be completed. (NSURLErrorDomain error -1011.)"), "View state should be failure")
    }
}
