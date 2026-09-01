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
            var errorController = new controllers.errorController();
            return errorController.errorView(404, "Course Not Found");
        }

        request.course = course;

        return {
            view: "courses/detail"
        };
    }
    
    /**
     * Enrolls curr user a single course.
     */
    public struct function enroll(required numeric courseId) {

        if ( NOT isUserLoggedIn() ) {
            var errorController = new controllers.ErrorController();
            return errorController.errorView(401, "Must be logged in to perform this action")
        }

        var courseService = new models.services.courseService();
        courseService.enroll(
            userId = request.userId, 
            courseId = courseId
        );

        return {
            view: "index"
        };
    }
}