component {
    /**
     * Display a list of all users.
     */
    public void function index() {
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

        include "../views/users/index.cfm";
    }


    /**
     * Display a single user.
     */
    public void function show(required numeric id) {

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

            writeOutput("User not found.");
            return;
        }

        request.user = user;

        include "../views/users/detail.cfm";
    }
}