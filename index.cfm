<cfoutput>
    Hello from ColdFusion! Current time: #now()#
</cfoutput>

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
            adminPassword = "commandbox"
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


<cfquery name="getUsers" datasource="sqlite">
    SELECT * 
    FROM users
</cfquery>