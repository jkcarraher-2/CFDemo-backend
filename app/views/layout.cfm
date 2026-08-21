<cfscript>
    savecontent variable="content" {
        include "/views/#view#.cfm";
    }
</cfscript>

<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>CFDemo</title>

        <link rel="stylesheet" href="/assets/css/output.css">
    </head>

    <body>

        <header>
            <!--- <h1>CFDemo</h1> --->
        </header>

        <main>
            #content#
        </main>

        <footer>
            <!--- CFDemo-Footer --->
        </footer>
    </body>
    </html>

</cfoutput>