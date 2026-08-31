component {
    this.name = "CFDemo";
    this.datasource = "sqlite";
    // Login Setup
    this.sessionManagement = true;
    this.loginStorage = "session";
    this.sessionTimeout= createTimeSpan(0,6,0,0); 
    this.applicationTimeout = createTimeSpan(1,0,0,0);
    
    // This code runs whenever a request starts
    function onRequestStart() {
        // Fetch Authenticated User Object
        if ( isUserLoggedIn() ) {
            request.userId = GetAuthUser()
            var userService = new models.services.userService();
            var user = userService.findByEmail(request.userId)
            request.first_name = user.first_name
            request.last_name = user.last_name
            request.kerberos = user.kerberos
        }
    }

    // This code runs one time when App STARTS
    function onApplicationStart() {
        initDB();
    }

    function initDB() {
        var schemaPath = expandPath("../databases/schema.sql");
        var schema = fileRead(schemaPath);
        
        // Execute each statement in the schema 
        var statements = listToArray(schema, ";");
                
        for (var statement in statements) {
            statement = trim(statement)
            if ( len(statement) ) {
                queryExecute(
                    statement,
                    {},
                    { datasource: this.datasource }
                )
            }
        }
    }
}