<cfscript>
    path = cgi.path_info;
    path = reReplace(path, "/$", "");

    if (path == "") {
        path = "/";
    }

    userController = new controllers.UserController();
    courseController = new controllers.CourseController();
    errorController = new controllers.ErrorController();

    switch(true) {
        case path == "/":
            result = { view: "index" };
            break;
        case path == "/users":
            result = userController.index();
            break;
        case reFind("^/users/[0-9]+$", path):
            userId = listLast(path, "/");
            result = userController.show(
                id = val(userId)
            );
            break;
        case path == "/courses":
            result = courseController.index();
            break;
        case reFind("^/courses/[0-9]+$", path):
            courseId = listLast(path, "/");
            result = courseController.show(
                id = val(courseId)
            );
            break;
        case path == "/auth/login":
            result = { view: "auth/login" };
            break;
        case path == "/auth/logout":
            result = { view: "auth/logout" };
            break;
        case reFind("^/courses/enroll/[0-9]+$", path):
            courseId = listLast(path, "/");
            result = courseController.enroll(
                id = val(courseId)
            );
            break;
        default:
            result = errorController.errorView();
    }

    view = result.view;

    include "views/layout.cfm";
</cfscript>
