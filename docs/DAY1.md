### Linking SQLite to this cfm
Followed this guide to see that it was possible
https://www.bennadel.com/blog/4653-experimenting-with-sqlite-jdbc-connections-in-lucee-cfml.htm

First needed to install a custom Driver from this link. Go to `releases` click `show all files` (if needed) and download the one titled `sqlite-jdbc-X.X.X.jar`.
https://github.com/xerial/sqlite-jdbc

Now we need a way for our commandbox to find and use our `SQLite-JDBC` driver. Add the following to your `server.json` file.
```
"app":{
    "libDirs":"java_lib"
}
```
Then create a `java_lib/` directory (and a `db/database.db` while you're at it).

Then we can finally link configured that custom driver with 'other' driver config.
https://guides.adobe.com/coldfusion/en/docs/install-and-configure-coldfusion/__references__/data-source-management-for-coldfusion.html#

This is what I did. Open CFAdmin -> Data & Services -> Add New Data Source . Call it whatever you'd like, and set the driver type to "other" and press add. From there you will be promted to fill in more information. Here's what I put.
```
CF Data Source Name: sqlite
JDBC URL: jdbc:sqlite:[ABSOLUTE_PATH_TO_database.db_FILE]
Driver Class: org.sqlite.JDBC
Driver Name: SQLite 
```
Leave the Username and Password fields blank for sqlite. If all goes to plan this should work. I used the following code on my index.cfm to debug issues with the driver.
```
<cfscript>
    try {
        driver = createObject("java", "org.sqlite.JDBC");
        writeDump(driver);
    } catch (any e) {
        writeDump(e);
    }
</cfscript>
```