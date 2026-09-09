component {
    function get(required string courseId) {
        return queryExecute(
            "
                SELECT
                    id,
                    crn,
                    course_number,
                    subject_code,
                    title,
                    description,
                    units,
                    seats
                FROM classes
                WHERE id IS :courseId
            ",
            {
                courseId: {
                    value: arguments.courseId,
                    cfsqltype: "cf_sql_integer"
                }
            }
        );
    }
    function search(required string searchQuery) {
        return queryExecute(
            "
                SELECT
                    id,
                    crn,
                    course_number,
                    subject_code,
                    title,
                    description,
                    units,
                    seats
                FROM classes
                WHERE title LIKE :search
                   OR description LIKE :search
                ORDER BY title
            ",
            {
                search: {
                    value: "%" & arguments.searchQuery & "%",
                    cfsqltype: "varchar"
                }
            }
        );
    }
}