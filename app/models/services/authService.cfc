component {
    function login(required struct rc) {

        if (!structKeyExists(rc, "username") ||
            !structKeyExists(rc, "password")) {

            rc.error = "Username and password are required.";
            return;
        }

        var result = authenticate(
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
        var userService = new models.services.userService();
        var user = userService.findByEmail(arguments.email);

        if (isNull(user)) {
            return {
                success: false,
                error: "Invalid Email"
            };
        }

        if (!VerifyBCryptHash(arguments.password, user.passwordHash)) {
            return {
                success: false,
                error: "Wrong Password"
            };
        }

        return {
            success: true,
            user: user
        };
    }

}