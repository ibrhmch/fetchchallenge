//
//  MealDetailViewModelTests.swift
//  fetchchallengeTests
//
//  Created by octopus on 6/10/24.
//

import XCTest
@testable import fetchchallenge

class MealDetailViewModelTests: XCTestCase {
    
    var viewModel: MealDetailViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        viewModel = await MealDetailViewModel()
    }
    
    override func tearDown() async throws {
        viewModel = nil
        try await super.tearDown()
    }
    
    func testFetchMealDetailSuccess() async throws {
        // Arrange
        let mealID = "52788"
        
        // Act
        await viewModel.fetchMealDetail(mealID: mealID)
        
        // Assert
        await MainActor.run {
            XCTAssertNotNil(viewModel.mealDetail, "MealDetail should not be nil")
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false")
            XCTAssertNil(viewModel.errorMessage, "errorMessage should be nil")
        }
    }
    
    func testFetchMealDetailFailure() async throws {
        // Arrange
        let mealID = "InvalidID"
        
        // Act
        await viewModel.fetchMealDetail(mealID: mealID)
        
        // Assert
        await MainActor.run {
            XCTAssertNil(viewModel.mealDetail, "MealDetail should be nil")
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false")
            XCTAssertNotNil(viewModel.errorMessage, "errorMessage should not be nil")
        }
    }
}
