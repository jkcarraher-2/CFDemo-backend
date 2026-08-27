component {
    function findByUsername(required string username) {
        return queryExecute(
            "
            SELECT id, username, password_hash, role
            FROM users
            WHERE username = :username
            ",
            {
                username: {
                    value: arguments.username,
                    cfsqltype: "cf_sql_varchar"
                }
            }
        );
    }
}