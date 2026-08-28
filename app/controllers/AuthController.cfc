component {
    function login(required struct rc) {

        if (!structKeyExists(rc, "username") ||
            !structKeyExists(rc, "password")) {

            rc.error = "Username and password are required.";
            return;
        }

        var authService = new models.services.AuthService();

        var result = authService.authenticate(
            rc.username,
            rc.password
        );

        if (!result.success) {
            rc.error = result.error;
            return;
        }

        // Establish the authenticated session
        session.user = result.user;

        location("/");
    }

}
