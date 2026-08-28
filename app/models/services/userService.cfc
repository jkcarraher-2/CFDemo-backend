component {
    function findByEmail(required string email) {
        var userRepository = new models.repos.userRepository();
        var result = userRepository.findByEmail(arguments.email);

        // User NOT FOUND
        if (result.recordCount == 0) {
            return javacast("null", "");
        }

        return {
            id: result.id[1],
            email: result.email[1],
            passwordHash: result.password_hash[1]
        };
    }
}