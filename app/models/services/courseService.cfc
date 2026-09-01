component {
    function exists(required integer courseId) {
        var courseRepo = new models.repos.courseRepo();
        return courseRepo.get(courseId).recordCount > 0;
    }

    function search(required string searchQuery) {
        var courseRepo = new models.repos.courseRepo();

        return courseRepo.search( searchQuery )
    }

    function enroll(required integer userId, required integer courseId) {
        var userService = new models.services.userService();

        if ( NOT this.exists(courseId) ) {
            return;
        }
        if ( NOT userService.exists(userId) ) {
            return;
        }

        var enrollmentRepo = new models.repos.enrollmentRepo();
        
        return enrollmentRepo.enroll(userId, courseId);
    }
}