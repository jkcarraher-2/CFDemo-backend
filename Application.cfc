component {
    this.name = "CFDemo";
    this.datasource = "sqlite";

    // This code runs one time when App STARTS
    function onApplicationStart() {
        initalizeDatabase();
    }

    function initalizeDatabase() {
        var schemaPath = expandPath("db/schema.sql");
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