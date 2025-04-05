import XCTest

final class CleosPageUITests: XCTestCase {

    override func setUpWithError() throws {
        // Set up before the invocation of each test method in the class.
        continueAfterFailure = false // Stop immediately when a failure occurs.
    }

    override func tearDownWithError() throws {
        // Tear down after the invocation of each test method in the class.
    }

    @MainActor
    func testLaunchLoginView() throws {
        // Test if LoginView is correctly displayed upon app launch.
        let app = XCUIApplication()
        app.launch()

        // Assert that the title "Login to Cleo's App" is displayed.
        XCTAssert(app.staticTexts["Login to Cleo's App"].exists)

        // Assert presence of email and password input fields.
        XCTAssert(app.textFields["Email"].exists)
        XCTAssert(app.secureTextFields["Password"].exists)
        
        // Assert that the "Login" button is visible.
        XCTAssert(app.buttons["Login"].exists)
    }

    @MainActor
    func testLoginFlowSuccess() throws {
        // Test a successful login process.
        let app = XCUIApplication()
        app.launch()

        // Enter email and password.
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]

        XCTAssert(emailField.exists)
        XCTAssert(passwordField.exists)

        emailField.tap()
        emailField.typeText("test@example.com") // Replace with a valid test email.

        passwordField.tap()
        passwordField.typeText("password123") // Replace with a valid test password.

        // Tap the "Login" button.
        let loginButton = app.buttons["Login"]
        XCTAssert(loginButton.exists)
        loginButton.tap()

        // Verify transition to MainView.
        XCTAssert(app.staticTexts["Welcome to Cleo's App"].exists)
    }

    @MainActor
    func testGoogleSignInButtonExists() throws {
        // Test if the Google Sign-In button is available.
        let app = XCUIApplication()
        app.launch()

        // Assert that the Google Sign-In button is visible.
        let googleButton = app.buttons["Google Sign-In"]
        XCTAssert(googleButton.exists)
    }

    @MainActor
    func testAppleSignInButtonExists() throws {
        // Test if the Apple Sign-In button is available.
        let app = XCUIApplication()
        app.launch()

        // Assert that the Apple Sign-In button is visible.
        let appleButton = app.buttons["Continue with Apple"]
        XCTAssert(appleButton.exists)
    }

    @MainActor
    func testCloseButtonNavigatesToMainView() throws {
        // Test the "Close" button functionality for direct navigation to MainView.
        let app = XCUIApplication()
        app.launch()

        // Tap the "Close" button.
        let closeButton = app.buttons["Close"]
        XCTAssert(closeButton.exists)
        closeButton.tap()

        // Verify transition to MainView.
        XCTAssert(app.staticTexts["Welcome to Cleo's App"].exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        // Measure how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
