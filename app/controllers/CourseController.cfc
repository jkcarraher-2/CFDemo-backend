component {

    /**
     * Display a list of all classes.
     */
    public struct function index() {
        var courses = queryExecute("
            SELECT
                id,
                subject_code,
                course_number,
                title,
                description,
                units
            FROM classes
            ORDER BY id
        ");

        request.courses = courses;

        return {
            view: "courses/index"
        };
    }

    /**
     * Display a single course.
     */
    public struct function show(required numeric id) {

        var course = queryExecute("
            SELECT
                id,
                subject_code,
                course_number,
                title,
                description,
                units
            FROM classes
            WHERE id = :id
        ", {
            id: {
                value: arguments.id,
                cfsqltype: "cf_sql_integer"
            }
        });

        if (course.recordCount == 0) {
            cfheader(
                statuscode = 404,
                statustext = "Course Not Found"
            );

            return {
                view: "404"
            };
        }

        request.course = course;

        return {
            view: "courses/detail"
        };
    }
    /**
     * Enrolls curr user a single course.
     */
    public struct function enroll(required numeric id) {

        var course = queryExecute("
            SELECT
                id,
                subject_code,
                course_number,
                title,
                description,
                units
            FROM classes
            WHERE id = :id
        ", {
            id: {
                value: arguments.id,
                cfsqltype: "cf_sql_integer"
            }
        });

        if (course.recordCount == 0) {
            cfheader(
                statuscode = 404,
                statustext = "Course Not Found"
            );

            return {
                view: "404"
            };
        }
        if ( NOT isUserLoggedIn() ) {
            cfheader(
                statuscode = 401,
                statustext = "Must be logged in to perform this action"
            )
        }

        request.course = course;

        return {
            view: "courses/enroll"
        };
    }
}