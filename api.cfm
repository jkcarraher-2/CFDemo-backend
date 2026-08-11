<cfscript>
    data = {
        message: "Hello from ColdFusion API",
        timestamp: now(),
        version: "1.0"
    };
    
    // Set content type
    header("Content-Type", "application/json");
    
    // Output JSON
    writeOutput(serializeJSON(data));
</cfscript>