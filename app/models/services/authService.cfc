component {

    property name="authService";

    function login(required struct rc) {

        if (!structKeyExists(rc, "username") ||
            !structKeyExists(rc, "password")) {

            rc.error = "Username and password are required.";
            return;
        }

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

    function authenticate(required string email, required string password) {
        userService = new models.services.userService
        var user = userService.findByUsername(arguments.email);

        if (isNull(user)) {
            return {
                success: false
            };
        }

        if (!VerifyBCryptHash(arguments.password, user.passwordHash)) {
            return {
                success: false
            };
        }

        return {
            success: true,
            user: user
        };
    }

}