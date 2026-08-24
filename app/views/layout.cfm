<cfimport prefix="layout" taglib="/components/layout">
<cfscript>
    savecontent variable="content" {
        include "/views/#view#.cfm";
    }
</cfscript>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CFDemo</title>

    <link rel="stylesheet" href="/assets/css/output.css">
</head>

<body>
    <layout:header>
    <main class="mx-15 my-10">
        <cfoutput>
            #content#
        </cfoutput>
    </main>

    <footer>
        <!--- CFDemo-Footer --->
    </footer>
</body>
</html>

