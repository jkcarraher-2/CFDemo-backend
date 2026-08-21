<cfscript>
    path = cgi.path_info;
    path = reReplace(path, "/$", "");

    if (path == "") {
        path = "/";
    }

    userController = new controllers.UserController();

    if (path == "/users") {
        result = userController.index();
    }
    else if (reFind("^/users/[0-9]+$", path)) {
        userId = listLast(path, "/");

        result = userController.show(
            id = val(userId)
        );
    }
    else {
        cfheader(
            statuscode = 404,
            statustext = "Not Found"
        );

        result = {
            view: "404"
        };
    }

    view = result.view;

    include "views/layout.cfm";
</cfscript>
