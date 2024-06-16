//
//  MealListViewModelTests.swift
//  fetchchallengeTests
//
//  Created by octopus on 6/10/24.
//

import XCTest
@testable import fetchchallenge

final class MealListViewModelTests: XCTestCase {
    var viewModel: MealListViewModel!
    var mockService: MockNetworkingService!
    
    override func setUp() async throws {
        try await super.setUp()
        mockService = MockNetworkingService()
        viewModel = MealListViewModel(networkingService: mockService)
    }
    
    override func tearDown() async throws {
        viewModel = nil
        mockService = nil
        try await super.tearDown()
    }
    
    func testFetchMealsSuccess() async throws {
        // Arrange
        let mockData = """
        {
            "meals": [
                { "idMeal": "1", "strMeal": "Apple Pie", "strMealThumb": "nil" },
                { "idMeal": "2", "strMeal": "Banana Bread", "strMealThumb": "nil" }
            ]
        }
        """.data(using: .utf8)!
        
        mockService.fetchDataHandler = { _ in
            return mockData
        }
        
        // Act
        await viewModel.fetchMeals()
        
        // Assert
        XCTAssertFalse(viewModel.meals.isEmpty, "Meals should not be empty")
        XCTAssertEqual(viewModel.meals.count, 2, "There should be 2 meals")
        XCTAssertEqual(viewModel.meals.first?.name, "Apple Pie", "First meal should be Apple Pie")
        XCTAssert(viewModel.viewState == .success(viewModel.meals), "View state should be success")
    }
    
    func testFetchMealsFailure() async throws {
        // Arrange
        mockService.fetchDataHandler = { _ in
            throw URLError(.badServerResponse)
        }
        
        // Act
        await viewModel.fetchMeals()
        
        // Assert
        XCTAssertTrue(viewModel.meals.isEmpty, "Meals should be empty")
        XCTAssert(viewModel.viewState == .failure("The operation couldn’t be completed. (NSURLErrorDomain error -1011.)"), "View state should be failure")
    }
    
    func testFetchMealsWithInvalidURL() async throws {
        // Arrange
        viewModel = MealListViewModel(networkingService: mockService)
        
        // Act
        await viewModel.fetchMeals()
        
        // Assert
        XCTAssert(viewModel.viewState == .failure("Invalid URL"), "View state should be failure due to invalid URL")
    }
    
    func testSearchMealsNoMatches() async throws {
        // Arrange
        await MainActor.run {
            viewModel.meals = [
                Meal(id: "1", name: "Apple Pie", thumbnail: "nil"),
                Meal(id: "2", name: "Banana Bread", thumbnail: "nil")
            ]
        }
        
        // Act
        viewModel.searchText = "Cherry"
        
        // Assert
        XCTAssertTrue(viewModel.filteredMeals.isEmpty, "Filtered meals should be empty")
    }
    
    func testSearchTextChange() async throws {
        // Arrange
        await MainActor.run {
            viewModel.meals = [
                Meal(id: "1", name: "Apple Pie", thumbnail: "nil"),
                Meal(id: "2", name: "Banana Bread", thumbnail: "nil")
            ]
        }
        
        // Act
        viewModel.searchText = "Banana"
        
        // Assert
        XCTAssertEqual(viewModel.filteredMeals.count, 1)
        XCTAssertEqual(viewModel.filteredMeals.first?.name, "Banana Bread")
    }
}
