component {
    function exists(required numeric userId, required numeric courseId) {
        var result = queryExecute(
            "
            SELECT 1
            FROM enrollments
            WHERE user_id = :userId
              AND class_id = :classId
            LIMIT 1
            ",
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
        return result.recordCount > 0;
    }

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