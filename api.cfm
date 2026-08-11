<cfscript>
    // Simple JSON API endpoint
    data = {
        message: "Hello from ColdFusion API",
        timestamp: now(),
        version: "1.0"
    };
    
    // Set content type
    header name="Content-Type" value="application/json";
    
    // Output JSON
    writeOutput(serializeJSON(data));
</cfscript>