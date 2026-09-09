component {
    function exists(required integer courseId) {
        var courseTable = new models.daos.sqlite.courseTable();
        return courseTable.get(courseId).recordCount > 0;
    }

    function search(required string searchQuery) {
        var courseTable = new models.daos.sqlite.courseTable();

        return courseTable.search( searchQuery )
    }

    function enroll(required integer userId, required integer courseId) {
        var userService = new models.services.userService();
        
        // Course doesn't exist
        if ( NOT this.exists(arguments.courseId) ) {
            throw(
                type = "Enrollment.CourseNotFound",
                message = "Course not found."
            );
        }

        // User doesn't exist
        if ( NOT userService.exists(arguments.userId) ) {
            throw(
                type = "Enrollment.UserNotFound",
                message = "User not found."
            );
        }

        var enrollmentTable = new models.daos.sqlite.enrollmentTable();
        
        // Already enrolled
        if ( enrollmentTable.exists(arguments.userId, arguments.courseId) ) {
            throw(
                type = "Enrollment.AlreadyExists",
                message = "User is already enrolled in this course."
            );
        }

        return enrollmentTable.enroll(arguments.userId, arguments.courseId);
    }
}