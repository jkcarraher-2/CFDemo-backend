component {

    /**
     * Display a list of all users.
     */
    public struct function index() {
        var users = queryExecute("
            SELECT
                id,
                first_name,
                last_name,
                email
            FROM users
            ORDER BY last_name, first_name
        ");

        request.users = users;

        return {
            view: "users/index"
        };
    }


    /**
     * Display a single user.
     */
    public struct function show(required numeric id) {

        var user = queryExecute("
            SELECT
                id,
                first_name,
                last_name,
                email
            FROM users
            WHERE id = :id
        ", {
            id: {
                value: arguments.id,
                cfsqltype: "cf_sql_integer"
            }
        });

        if (user.recordCount == 0) {
            cfheader(
                statuscode = 404,
                statustext = "User Not Found"
            );

            return {
                view: "404"
            };
        }

        request.user = user;

        return {
            view: "users/detail"
        };
    }
}