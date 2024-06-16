//
//  MealListViewModelTests.swift
//  fetchchallengeTests
//
//  Created by octopus on 6/10/24.
//

import XCTest
@testable import fetchchallenge

class MealListViewModelTests: XCTestCase {
    
    var viewModel: MealListViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        await viewModel = MealListViewModel()
    }
    
    override func tearDown() async throws {
        viewModel = nil
        try await super.tearDown()
    }
    
    func testFetchMealsSuccess() async throws {
        // Act
        await viewModel.fetchMeals()
        
        // Assert
//        await MainActor.run {
//            XCTAssertFalse(viewModel.meals.isEmpty, "Meals should not be empty")
//            XCTAssertFalse(viewModel.isLoading, "isLoading should be false")
//            XCTAssertNil(viewModel.errorMessage, "errorMessage should be nil")
//        }
    }
    
    func testSearchMeals() async throws {
        // Arrange
        await MainActor.run {
            viewModel.meals = [
                Meal(id: "1", name: "Apple Pie", thumbnail: "nil"),
                Meal(id: "2", name: "Banana Bread", thumbnail: "nil"),
                Meal(id: "3", name: "Cherry Tart", thumbnail: "nil")
            ]
            
            // Act
            viewModel.searchText = "Apple"
            
            // Assert
            XCTAssertEqual(viewModel.filteredMeals.count, 1)
            XCTAssertEqual(viewModel.filteredMeals.first?.name, "Apple Pie")
        }
    }
}
