component {
    function get(required string userId) {
        return queryExecute(
            "
                SELECT
                    id
                FROM users
                WHERE id IS :userId
            ",
            {
                userId: {
                    value: arguments.userId,
                    cfsqltype: "cf_sql_numeric"
                }
            }
        );
    }
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