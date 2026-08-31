component {
    function findByEmail(required string email) {
        return queryExecute(
            "
            SELECT id, first_name, last_name, kerberos, email, password_hash
            FROM users
            WHERE email = :email
            ",
            {
                email: {
                    value: arguments.email,
                    cfsqltype: "cf_sql_varchar"
                }
            }
        );
    }
}