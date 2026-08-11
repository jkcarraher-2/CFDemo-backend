<cfscript>
    data = {
    message: "Hello from ColdFusion API",
    timestamp: now(),
    version: "1.0"
    };

    cfheader(
        name = "Content-Type",
        value = "application/json"
    );

    writeOutput(serializeJSON(data));
</cfscript>