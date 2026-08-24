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
}