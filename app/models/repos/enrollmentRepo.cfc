component {
    function enroll(required numeric userId, required numeric courseId) {
        return queryExecute(
            "
            INSERT INTO enrollments (
                user_id,
                class_id
            )
            VALUES (
                :userId,
                :classId
            )",
            {
                userId: {
                    value: arguments.userId,
                    cfsqltype: "cf_sql_integer"
                },
                classId: {
                    value: arguments.courseId,
                    cfsqltype: "cf_sql_integer"
                }
            }
        );
    }
}