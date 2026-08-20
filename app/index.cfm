<cfscript>
    path = cgi.path_info;
    path = reReplace(path, "/$", "");
    
    if (path == "") {
        path = "/";
    }

    userController = new controllers.UserController();

    // GET /users
    if (path == "/users") {
        userController.index();
    }

    // GET /users/123
    else if (reFind("^/users/[0-9]+$", path)) {
        userId = listLast(path, "/");
        userController.show(
            id = val(userId)
        );
    }

    //404
    else {
        cfheader(
            statuscode = 404,
            statustext = "Not Found"
        );
        writeOutput("<h1>404 - Page Not Found</h1>");
    }

</cfscript>