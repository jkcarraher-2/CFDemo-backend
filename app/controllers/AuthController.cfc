component {
    property name="authController";

    function login(required struct rc) {

        if (!structKeyExists(rc, "username") ||
            !structKeyExists(rc, "password")) {

            rc.error = "Username and password are required.";
            return;
        }
        authService = new models.services.authService()

        var result = authService.authenticate(
            rc.username,
            rc.password
        );

        if (!result.success) {
            rc.error = "Invalid username or password.";
            return;
        }

        // Establish the authenticated session
        session.user = result.user;

        location("/");
    }

}
