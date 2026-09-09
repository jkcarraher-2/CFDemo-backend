component {
    function exists(required integer userId) {
        var userTable = new models.daos.sqlite.userTable();
        return userTable.get(userId).recordCount > 0;
    }

    function findByEmail(required string email) {
        var userTable = new models.daos.sqlite.userTable();
        var result = userTable.findByEmail(arguments.email);

        // User NOT FOUND
        if (result.recordCount == 0) {
            return javacast("null", "");
        }

        return {
            id: result.id[1],
            first_name: result.first_name[1],
            last_name: result.last_name[1],
            kerberos: result.kerberos[1],
            email: result.email[1],
            passwordHash: result.password_hash[1]
        };
    }
}