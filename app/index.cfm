<cfscript>
    path = cgi.path_info;
    path = reReplace(path, "/$", "");

    if (path == "") {
        path = "/";
    }

    userController = new controllers.UserController();
    courseController = new controllers.CourseController();

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
        case path == "/login":
            result = { view: "auth/login" };
            break;
        default:
            cfheader(
                statuscode = 404,
                statustext = "Not Found"
            );
            result = { view: "404" };
    }

    view = result.view;

    include "views/layout.cfm";
</cfscript>
