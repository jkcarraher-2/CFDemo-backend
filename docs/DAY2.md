### Creating REST endpoints in AdobeCF
Left off yesterday having used CFAdmin to make cfc files in `/api/` discoverable. Continuing on this path, running into issues where I've registered the API in theory but the endpoint is just returning 404s

https://guides.adobe.com/coldfusion/en/docs/develop-coldfusion-applications/__references__/restful-web-services-in-coldfusion.html

I had AI write me up this diagnostic tool to help me debug if my API was discovering my api
```cfc
    <cfscript>
    writeOutput("<h1>ColdFusion REST Diagnostics</h1>");

    /* ============================================================
    1. Application metadata
    ============================================================ */

    writeOutput("<h2>1. Application Metadata</h2>");

    try {
        metadata = getApplicationMetadata();

        writeDump(
            var = metadata,
            label = "Application Metadata"
        );
    }
    catch (any e) {
        writeDump(
            var = e,
            label = "getApplicationMetadata() FAILED"
        );
    }


    /* ============================================================
    2. Registered REST services
    ============================================================ */

    writeOutput("<h2>2. Registered REST Services</h2>");

    try {
        adminAuth = createObject(
            "component",
            "CFIDE.adminapi.administrator"
        );

        adminAuth.login(
            adminPassword = "ENTER_PASSWORD_HERE"
        );

        admin = createObject(
            "component",
            "CFIDE.adminapi.extensions"
        );


        restServices = admin.getRESTServices();

        writeDump(
            var = restServices,
            label = "CFAdmin REST Services"
        );
    }
    catch (any e) {
        writeDump(
            var = e,
            label = "getRESTServices() FAILED"
        );
    }


    /* ============================================================
    3. Current request information
    ============================================================ */

    writeOutput("<h2>3. Current Request</h2>");

    writeDump(
        var = getHttpRequestData(),
        label = "HTTP Request Data"
    );


    /* ============================================================
    4. CGI information
    ============================================================ */

    writeOutput("<h2>4. CGI</h2>");

    writeDump(
        var = cgi,
        label = "CGI Scope"
    );


    /* ============================================================
    5. REST-related Application.cfc settings
    ============================================================ */

    writeOutput("<h2>5. REST Settings</h2>");

    if (
        structKeyExists(metadata, "RESTSETTINGS")
    ) {
        writeDump(
            var = metadata.RESTSETTINGS,
            label = "RESTSETTINGS"
        );
    }
    else {
        writeOutput(
            "<p>No RESTSETTINGS found in application metadata.</p>"
        );
    }


    /* ============================================================
    6. File system verification
    ============================================================ */

    writeOutput("<h2>6. REST CFC Files</h2>");

    apiPath = expandPath("api");

    writeOutput(
        "<p><strong>API path:</strong> " &
        encodeForHTML(apiPath) &
        "</p>"
    );

    writeOutput(
        "<p><strong>API directory exists:</strong> " &
        directoryExists(apiPath) &
        "</p>"
    );

    if (directoryExists(apiPath)) {

        files = directoryList(
            apiPath,
            false,
            "query",
            "*.cfc"
        );

        writeDump(
            var = files,
            label = "CFCs in API directory"
        );
    }


    /* ============================================================
    7. Verify users.cfc specifically
    ============================================================ */

    writeOutput("<h2>7. users.cfc</h2>");

    usersPath = apiPath & "/users.cfc";

    writeOutput(
        "<p><strong>Path:</strong> " &
        encodeForHTML(usersPath) &
        "</p>"
    );

    writeOutput(
        "<p><strong>Exists:</strong> " &
        fileExists(usersPath) &
        "</p>"
    );


    /* ============================================================
    8. Instantiate users.cfc
    ============================================================ */

    writeOutput("<h2>8. CFC Instantiation</h2>");

    try {

        usersCFC = createObject(
            "component",
            "api.users"
        );

        writeOutput(
            "<p style='color:green;font-weight:bold'>" &
            "SUCCESS: api.users can be instantiated." &
            "</p>"
        );

        writeDump(
            var = usersCFC,
            label = "users.cfc Component"
        );

    }
    catch (any e) {

        writeOutput(
            "<p style='color:red;font-weight:bold'>" &
            "FAILED: api.users could not be instantiated." &
            "</p>"
        );

        writeDump(
            var = e,
            label = "CFC Instantiation Error"
        );
    }
    </cfscript>
```

After chatting with Cyrus, I was able to figure out that at least `http://localhost:8080/api/users.cfc?method=createUser` enabled me test my endpoints. However this was without using the RESTFUL Web service configuration in CFAdmin. Meaning that I was physically accessing the `users.cfc` file. 

Added Debugger Package but RESTPlay was unable to be launched with commandbox.

In order to get my REST API accessible, I kept the same config detailed previously. 
```
Root Path: [PATH_TO_api_DIRECTORY]
Host[:Port]: localhost:8080
Service Mapping: api
Update REST Path: rest
```

This did however require some `commandbox` specific configuration to my `server.json`. Running this command or adding 
```
{
    "app":{
        "restMappings":"/rest/*,/api/*"
    },
}
```
to my server.json allows Commandbox to communicate with the REST Serverlet so the endpoints in `/api/` actually work. 
https://commandbox.ortusbooks.com/embedded-server/configuring-your-server/rest-servlet

Now my endpoint is accessibile at `http://localhost:8080/rest/api/users/create`