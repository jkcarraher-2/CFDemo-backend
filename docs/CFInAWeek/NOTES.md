# CF in a week takeaways / Notes
## Questions for Phil
1. How does our team prevent SQL injections and other security vulnerabilities?

Strict cfquery paramtag enforcement for all queries to prevent SQL Injections.
The whole application is behind an auth wall.

2. What framework do admissions applications use? I see Framework-1 (MVC) and ColdBox (HMVC)

No frameworks, wild west. 

3. What server cache settings for our applications? Where do the servers run? 

Don't use cache settings too much. For HUGE queries yeah, but thats about it.

4. Do most of the applications we use have a seperate frontend, or is everything served through CF?

Everythings through .cfc/.cfm files.

## Basics
### What is Coldfusion
It's selling point is:
1. Expressiveness (You can do more with less code) 
2. Power (easy integration with important functionality like PDF form creation)

CF is written in `CFML`. Coldfusion files use the `.cmf` extension for pages, and `.cfc` extensioin for objects. `CFML` is designed for effiency compared to writing equivelant Java code.

### Setting variables
CF is loosely typed. Information can be stored in variables without having to define it's type. 
To set a variable.
```
<cfset newVar = "fun">
```
To print it out to a basic page use cfdump. `cfdump` is a tag used to print elements variables and values fo most CF Objects used largely for debugging.
```
<cfdump var = "#newVar#">
```
Notice how we surround variables with a `#` pound sign, which tells CF to evaluate the contents. Anything not specifically in quotes will be evaluated. 

You can also concatenate string with the `&` operator like below:
```
<cfset todaysDate = "Today is: " & now()>
<cfdump var = #todaysDate#>
```

To output contents of variables you've created on a screen you can use `cfoutput` like below:
```
<cfoutput>
#todaysDate#
</cfoutput>
```
It can become more powerful as you use html tags to render.

### Datatypes
There are strings,and numbers which are easy to work with.

Then there are Dates which are their own type using the following basic operations using functions provided in CF.
`now()` - returns the current date/time
`dateAdd("d", startDate, endDate)` - Compares 2 dates and tells you the difference.
`dateDiff("d", 7, now())` - Takes a date and moves it forwards / backwards.
`formattedDate = dateFormat(date, "yyyy-mm-dd)` - Returns text, formatting a date object into the style you define.

Arrays are a bit more complicated. To create an array you can use the following syntax:
```
<cfset numbers = ["fourty two", 37, "56"]>
```
Notice that they can be mixed type. We can also use this syntax:
```
<cfset numbers = arrayNew(1)>
```
To add to an array we can do either of the 
```
<cfset numbers[1] = 19>
<cfset ArrayAppend(numbers, "42")>`
```
Note that arrays are indexed from 1, NOT 0. Also we can technially set an array value without defining it beforehand.

To parse through an array to display it's contents use the cfloop in conjunction since cfoutput can't display arrays as a string.
```
<cfset ThingsILike = ["Warm Sandy Beaches", "Tropical Drinks", 42]>
<cfloop array="#ThingsILike#" index="thing">
    <cfoutput>#thing#</cfoutput>
</cfloop>
```

We also have structs which are custom defined collections of data stored by key (name). Purge ideas of structs in other programs because a CF struct is a HashMap.

To create a struct:
```
<cfset FruitBasket = structNew()>
// or
<cfset FruitBasket = {}>
```

To add entries:
```
<cfset fruitBasket = {
    "Apple" = 2,
    "Banana" = 10,
    "Cherry" = 2
}>
// or 
<cfset FruitBasket = {}>
<cfset FruitBasket.Apple = 1>
<cfset FruitBasket.Banana = 2>
<cfset FruitBasket.Cherry = 3>
```
Keep in mind, unlike an array you can't edit a struct without first defining it, hence the first cfset. Note that the bracket notation preserved the case of the notation while dot did not. Takeaway that in general bracket notation allows you to be more detailed and specific and should be preferened.

To display conents of a struct you must also use `cfloop`.
```
<cfloop collection="#FruitBasket#" item="fruit">
    <cfoutput> #FruitBasket[fruit]# #fruit# </cfoutput>
</cfloop>
```
Note that cfloop parses the collection's keys (called `items`). You can define the name of the object you access these from (I used fruit in the above example).

Queries are the final datatype here. They are a special datatype used to prepresent the result of a database query. Running the below code creates a query object called `users`
```
<cfquery name="qUsers" datasource="myDB">
    SELECT id, name, age
    FROM users
</cfquery>
```
The added benefit of this datatype is being able to use the following functions:
`queryname.recordcount` - How many rows does this query have?
`queryname.columnlist` - What columns does this query have?
`queryname.currentrow` - What row number are we currently on inside a cfoutput or cfloop?

To loop over a query use the following code:
```
<cfloop query="qUsers">
    #qUsers.Name# - #qUsers.username# <br>
</cfloop>
```

### Commenting
Generally use comments to describe intent and give context to code. Program code explains HOW, but proper comments explain WHY.

### CFScript vs CFTag
There are 2 equal ways to write CF Code: CFScript notation and CFTag notation. The choice is often team specfic.

## Decision Making & Scopes
### Decision Making
This is how to create if / elif / else statements:
```
<cfif expression>
    ..Markup..
<cfelseif another_expression>
    ..More Markup..
<cfelse>
    ..More Markup..
</cfif>
// OR
<cfscript>
    if ( myValue == 'ColdFusion' ) {
        ..code..
    } else if ( myValue != '.NET' ) {
        x = 277;
    } else {
        ..code..
    }
</cfscript>
```
Where an expression is any value that will evaluate to Boolean. Note that using cfscript means code will read similarly to Javascript.

Boolean operators look like this:
```
AND / &&
OR / ||
NOT / !
XOR, EQV
IMP - implication
```
```
<cfif structKeyExists( myStruct, 'age' ) AND myStruct.age LTE 7>
    ..code..
</cfif>

<cfscript>
    if ( structKeyExists( myStruct, 'age' ) && myStruct.age <= 7 ) {
        ..code..
    }
</cfscript>
```
Note that evaluation runs from left to right. Statements can be joined together. You can also use parenthesis to control evaluation of expressions similar to JS/TS.

There is also a way to make switch statments:
```
<cfswitch expression="#myVar#">
    <cfcase value="1">
        ..code..
    </cfcase>
    <cfcase value="9,10" >
        ..code..
    </cfcase>
    <cfdefaultcase>
        ..finally..
    </cfdefaultcase>
</cfswitch>
// or
switch ( myVar ) {
    case 1:
        writeOutput( 'Value was 1' );
        break;
    case 9:
        writeOutput( 'Value was 9' );
        break;
    default:
        writeOutput( 'Value was not 1 or 9' );
}
```

Also offered are `ternary` operations. This a shorthand way to assign a value conditionally if you have 2 possible outputs. Here's how:
```
x = ( myVar == 1 ) ? 1 : 277
```

### Scopes
To be honest a lot of this went over my head. Please reference the section to get a better idea of what's going on here.

This seems to more or less be a store option. When you want to access parameters for a function or variable,,, especially things that are cross file you can use scopes. 

## Data Handling
### Databases
To connect to a database you must first configure the DataSource in administrator. 
Here is some basic syntax for a query:
```
// script notation
<cfscript>
    myquery = QueryExecute('SELECT * FROM artists', [], {datasource = 'cfartgallery'});
</cfscript>

// tag notation
<cfquery name="myQuery" datasource="cfartgallery">
    SELECT * FROM artists
</cfquery>
```

When we want to print out queries we can do so by accessing query info with the functions mentioned in the `Query` datatype defined above.
```
<cfoutput query="myQuery">
    #myquery.CurrentRow# - #myquery.email# - #myquery.firstname# - #myquery.lastname#<br>
</cfoutput>
```

If you're looking to use query data without printing it out immediately you can store it into an array.
```
<cfset artistArray = []>
<cfloop query="myQuery">
    <cfset arrayappend(artistArray, myquery.lastname & ', ' & myQuery.firstname)>
</cfloop>
```

It's also possible to group `cfouts` if you want to group queries together based on their values and only print the group-selecting value once. Here is a layered example.
```
<cfset myquery = QueryExecute(' SELECT * FROM art ORDER BY issold', [], {datasource = 'cfartgallery'})>

<cfoutput Query="myQuery" group="issold">
    <p>
        Sold ?: #YesNoFormat(myQuery.issold)#:<br>
        <blockquote>
            <cfoutput>
                #myQuery.artname#: #DollarFormat(myQuery.price)#<br>
            </cfoutput>
        </blockquote>
    </p>
    <hr>
</cfoutput>
``` 

To prevent cfquery from being vulnerable to sql-injection you must utilize `cfqueryparam` in all your queries. Here is how to do that in script & tag:
```
// script
<cfscript>
    myquery = QueryExecute ("select * from Artists where firstname=?", ["#form.name#"], {datasource="cfartgallery"});;
</cfscript>

// tags
<cfquery name="myQuery" datasource="cfartgallery">
    SELECT * FROM artists
    WHERE firstname = <cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">
</cfquery>
```

To cache a query we can use the `cachedwithin` parameter for our cfquery which we pass in a timespan for the cached value to expire.

If we want our queries to be dynamic, tags like `if / else` can be used within `cfquery`.

Result counts can be limited with the `maxrows` param to `cfout` or `cfquery`.. whichever you prefer.

To get the ID of an object after you add it to a table, most folks just get the id of the most recently inserted item. However this can prove problematic and a better alternative is leverdging the `result` attribute of cfquery.
```
// script
<cfscript>
    QueryExecute(
        'INSERT INTO art ( artistsID, artName, description, isSold, largeImage, mediaID, price ) VALUES ( ?,?,?,?,?,?,? )',
        [ 1, 'test item', 'test desc', 1, 'img.png', 1, 1 ],
        { datasource = 'cfartgallery', result="qryResult" }
    );
</cfscript>

// tags
<cfquery result="qryResult" datasource="cfartgallery">
    INSERT INTO art
    (
        artistsID, artName, description, isSold, largeImage, mediaID, price
    )
    VALUES
    (
        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Test Item">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Test Desc">,
        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="img.png">,
        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1">,
        <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="1">
    )
</cfquery>

<cfdump var="#qryResult#">
```

### XML
Support for manipulating XML documents is very straightforward and supported. 

Files can be read as so:
```
<cfset mydoc = XmlParse(ExpandPath("./order.xml"))>
```

Can be created using the `cfxml tag like this:
```
<cfset getdata = QueryExecute('SELECT ARTISTID, ARTID, ARTNAME, DESCRIPTION, ISSOLD, PRICE, LARGEIMAGE FROM artists where artistid = ?', [1], {datasource = 'cfartgallery'});

<!---Process the query result and generate xml--->
<cfxml variable="artxml">
    <art artistid="<cfoutput>#getdata.artistid#</cfoutput>">
        <cfoutput query="getData">
            <piece id="#getData.artid#" available="#getdata.isSOLD#">
                <artname>#getData.artname#</artname>
                <description>#getData.artNAME#</description>
                <image>#getData.LARGEIMAGE#</image>
                <price>#getData.PRICE#</price>
            </piece>
        </cfoutput>
    </art>
</cfxml>
```

To then write this xml to a file you can use filewrite:
```
<cfset filewrite("#expandpath('./out.xml')#", artxml)>
```

If you need to physically parse the xml in a document, use the powerful `xmlParse()` function. Note that there is a nuance on how to access depending on if you turn on case sensitivity or not. Turning it off seems to give simpiler syntax. 

Most of the XML stuff I'm not familliar with cause I haven't used XML before.

### JSON
Creating JSON is as simple as defining a struct and converting it to a JSON object.

e.g.
```
<cfset myStruct = {
    items: {
        item1:  {name: 'something', price: 1000},
        item2:  {name: 'something else', price: 12.50},
        item3:  {name: 'something more', price: "1,240.10"}
    },
    users: {
        user1:  {id: 1, email: 'none@none.net'},
        user2:  {id: 2, email: 'none@none.net'},
        user3:  {id: 3, email: 'none@none.net'}
    }
}>

<cfset myJsonVar = serializeJSON(myStruct)>
```

By default case is not maintained in this format, but if we define the struct instead with strings case will be maintained.

```
"items": {
    "item1":    {name: 'something', price: 1000},
    "item2":    {name: 'something else', price: 12.50},
    "item3":    {name: 'something more', price: "1,240.10"}
}
```

The reverse (turning JSON into struct) can be done too.
```
<cfset myJsonStruct = deserializeJSON(myJsonVar)>
```

We can also validate an object is in proper JSON format with the following syntax:
```
<cfdump var="#isJson(myJsonVar)#">
```

## Code Reuse
### Functions
CF supports making your own custom tags?

To write your own function do so like this:
```
<cfscript>
public void function myFunction() {
    // Function content
}
</cfscript>
```

Arguments are defined like this:
```
<cfscript>
    public void function getFullName(
        required string firstName = '',
        required string lastName = ''
    ){
        // arguments are accessed like this with the arguments namespace
        var fullName = arguments.firstName & ' ' & arguments.lastName;
    }
</cfscript>
```
NOTE: We must put var in front of the variable to make sure it's scope is confined to the function.

Functions can be called in 2 ways, with the parameter names mentioned and not.
```
// Mentioned
<cfset fullName = getFullName( firstName='Matt', lastName='Gifford' )>

// Not mentioned
<cfset fullName = getFullName( 'Matt', 'Gifford' )>
```

You can also pass arguments through a function (parameter drilling ? )
```
<cfscript>
public string function getGreeting(
    string firstName = '',
    string lastName  = ''
){
    var fullName = getFullName( argumentCollection = arguments );
    // We can do more with the fullName variable here
}
</cfscript>
```

If you want to define a group of functions do so in a `.cfm` page. 

### Includes
Once you make a new `.cfm` file you can start using this file as a function library. To utilize this, you must use the `cfinclude` tag on any pages that might need it.
```
// Tag
<cfinclude template="path/to/libraries/greetingCustomizer.cfm">

// Script
include "path/to/libraries/greetingCustomizer.cfm";
```
This essentially embeds the CFML code into the file you include with. 

### Custom Tags
For displaying re-usable code for the frontend.

There are 2 times when code can be executed within a custom tag called "execution modes". They can either be "start" or "end". To explicitly define, use the following code.
```
// script notation
if (thisTag.executionMode == "start") {
    // opening tag execution
}
else if (thisTag.executionMode == "end") {
    // closing tag execution
}

// tag notation
<cfif thisTag.executionMode == "start">
    <!--- Runs when <myTag> is encountered --->
    <p>Before the body</p>
</cfif>

<cfif thisTag.executionMode == "end">
    <!--- Runs when </myTag> is encountered --->
    <p>After the body</p>
</cfif>
```

Note: This is useful when we're wrapping other tags.

To import tags we've created we can use `cfimport`
```
<cfimport prefix='display' taglib='/path/to/tags">

<display:greeting firstName="Matt" lastName="Gifford">
```

"
You can also use cfimport to bring multiple tags into your page, and put them in their own namespace. The tag takes only two arguments:
- prefix: This argument contains the prefix that the developer will use to reference the tag. This will replace the standard "cf_"
- taglib: This is the path to the tag library, relative to the web root.
"

### Components
A more modern replacement to `cfinclude` is `componets`. A component behaves like a class; it's defined in `.cfc` files.

CFC files are wrapped with a `component` tag like below:
```
component {
    public string function getFullName(
        required string firstName,
        required string lastName
    ){
        var fullName = arguments.firstName & ' ' & arguments.lastName;
        return fullName;
    }

    public string function getGreeting(
        required string firstName,
        required string lastName
    ){
        var fullName = getFullName( argumentCollection = arguments );
        var greeting = "Hello, " & fullName;

        return greeting;
    }
}
```

Components can also have properties like classes in OOP.
```
component accessors="true" {
    property name="baseGreeting" type="string" default="Hello, ";

    public function init(
        string baseGreeting = variables.baseGreeting
    ){
        setBaseGreeting( arguments.baseGreeting );
        return this;
    }

    public string function getFullName(
        required string firstName,
        required string lastName
    ){
        var fullName = arguments.firstName & ' ' & arguments.lastName;
        return fullName;
    }

    public string function getGreeting(
        required string firstName,
        required string lastName,
        string baseGreeting = getBaseGreeting()
    ){
        var fullName = getFullName( argumentCollection = arguments );
        var greeting = arguments.baseGreeting & fullName;

        return greeting;
    }
}
```
NOTE: The accessors="true" will auto create explicity accessors (getters and setters) for properties we define. The init function will set the basegreeting to anything we pass into it or the default value

In order to actually use the component we created we must use `createObject()`. The `invoke` method is to call public methods in the component.
```
<cfscript>
objGreeting = createObject( 'component', 'path.to.component.Greeting' );

myGreeting = invoke( objGreeting, 'getGreeting', {
    firstName    = 'Matt',
    lastName     = 'Gifford',
    baseGreeting = 'Welcome, '
} );

writeOutput( myGreeting );
</cfscript>
```

This can be done more simpily 
```
<cfset objGreeting = CreateObject( "Component", "path.to.component.Greeting" ).init()>
// Or override the base greeting
<cfset objGreeting = CreateObject( "Component", "path.to.component.Greeting" ).init( baseGreeting = 'Hola, ' )>
```

All together it looks like this:
```
// Create Object
<cfset objGreeting = CreateObject( "Component", "path.to.component.Greeting" ).init()>
// Call Getter from object
<cfset myGreeting  = objGreeting.getGreeting( firstName = "Matt", lastName = "Gifford" )>
// Use object value that has been assigned to a variable
<cfoutput>
    #myGreeting#
</cfoutput>
```

## Application.cfc

For CF applications there are several events who's behavior can be customized with the following functions defined in the Application.cfc file defined in your root.
1. onApplicationStart - The first time the application is used (think on reboot). Use for application config, caches.
2. onSessionStart - Any time a user makes a request to the application for the first time, or they've been using it long enough for session to expire.
3. onRequestStart - Code ran before every request, allowing variables to be set that are accessibile on every page in the site or for auth/verification.
4. onRequest - Similar to `onRequestStart`, but happens after. Also syntatically it gets the page that is requested as an argument.
5. onRequestEnd - Broadcased once a request gives control back to CF.
6. onSessionEnd - As suggested, this code runs once a session expires.
7. onApplicationend - Runs when an application times out or CF is shutting down.
8. onError - Last line of defense against errors that are left uncaught.

`onSessionEnd` gets passed 2 arguments SessionScope, and ApplicationScope. They are copies of the scopes. 
`onApplicationEnd` gets a copy of ApplicationScope too.
`onError` gets 2 arguments Exception and EventName. EventName is the handler at which the error ocurred in. Exception is the actual error. 

We can also define certain global settings for the application here:
```
this.name = "my_application_name"
this.applicationTimeout = CreateTimeSpan(10,0,0,0);
// Define where CF should look for custom tags
this.customTagPaths = [ expandPath('/myAppCustomTags') ];
// custom mappings to superceed any existing mappings of the same name.
this.mappings = {
    "/foo" = expandPath('/com/myCompany/foo')
};
// Application's globally defined datasource (only one)
this.datasource = "my_datasource";
```
## OOP
There are 2 main popular frameworks in Coldfusion. 
1. Framework-One (MVC)
2. ColdBox (HMVC)

A class is simpily a CFC. A component defines a set of public/private methods (functions) and can have public and private data.

Transient instances are ones where you create, use then throw away once done. 
Singleton instances are ones which live beyond the life of the request that created it.

Types of objects:
1. bean - an object used to hold data and provide methods for working with that data. It's the same thing as a class, just representing something IRL.
2. services - performs tasks on/for beans.
3. controllers - recieves requests and decides what should happen / coordinates services/models and manages what responses/views get returned.
4. views - display data to user / collect data for them / allow them to navigate data.

## ORM
ORM's allow you to work with objects and save them to the database automatically. Simplifies the CRUD process.

Setup is as simple as setting a datasocurce in Application.cfc and setting ormEnabled to true.

An "Entity" is a class that maps to a single db table. The idea is that it's an OBJECT that MAPS to the DB object.

You must first configure within Application.cfc where all the models you want to use are. All the cfc components that are marked with `persistent = true` are created as tables.
```
this.ormSettings = {
    cfclocation = [
        "model",
        "modules/users/model",
        "modules/orders/model"
    ]
};
```

Foreign keys are easily defined:
```
component persistent="true" table="ARTISTS" {
    property name="id" column="ARTISTID" fieldtype="id" generator="increment";
    property name="firstname" ormtype="string";
    property name="lastname" ormtype="string";

    property name="art" fieldtype="one-to-many" cfc="art" fkcolumn="ARTISTID" cascade="delete";

}
```

One of the benefits of using an orm is simplified querying:
```
<cfset artists = entityLoad( "artist", { firstname: "Jeff" }, "lastname" )>
```
Will return an array of objects where the artist's name is Jeff.

We can leverdge the foreign key to simpily print out children of this one-to-many relationship:
```
<cfoutput>
    <cfloop array="#artists#" index="artist">
        <h4>#artist.firstName# #artist.lastname# #artist.id#</h4>
        <cfif artist.hasArt()>
            <ul>
                <cfloop array="#artist.getArt()#" index="art">
                    <li>#art.name# #dollarFormat( art.price )#</li>
                </cfloop>
            </ul>
        </cfif>
    </cfloop>
</cfoutput>
```
Notice how we are technically only looping over artists, but if there is art here, we `cfloop` over a list of art with a default getter.

Random -- but we can also use the `serializeJSON( artist )` function to turn entities into JSON.

To add a Record we use the `entityNew` function with the first arg being entity name and 2nd being a structure of data. Then call `entitySave`.
```
transaction {
    art = entityNew( "art", { name : "Painting of TV", price : 200, isSold : false } );
    entitySave( art );

    artist = entityNew( "artist", { firstname : "John", lastname : "Doe" } );
    artist.addArt( art );

    entitySave( artist );
}
```

To update a record we retrieve a SINGLE object (by it's unique signature). Then any value changed will be saved to the database.
```
transaction {
    artist = entityLoad( "artist", 100, true );
    artist.firstname = "Fred";
}
```

To delete we use entityDelete
```
transaction {
    artist = entityLoad( "artist", 100, true );
    entityDelete( artist );
}
```

Final note -- we should be calling ormReload() at the beginning of onRequestStart function of Application.cfc in order apply entity configuration changes.

## Mail

I skimmed through this, leaving a note to read it over if I ever actually use this.

## Document Handling

### cfhttp
A simple way to make an http call is below:
```
<cfhttp url="http://cfmumbojumbo.com" method="get" />
<cfdump var="#cfhttp#" />
```

Additional parameters are described in the doc.

### cfdocument
Used to create PDFs. Note that it only supports up to HTML 4.01 . 

Similar to above, additional functionality is described in the section.

### cfpdf
Used to read a PDF, write meta-data to it, merge PDFs together, delete pages, create thumbnails of pages, extract text and images, add / remove watermarks, manipulate headers / footers, create PDF portfolios  and deal with PDF passwords, permissions and Encryption.

Functionality is described in the document.

### cfpdf
This allows you to generate / manipulate pdf forms. 

### File Manipulation
Files must be uploaded via form using the `cffile` tag. It offers a number of different actions that can be performed.
```
<cffile
    action="upload"
    destination="/Users/simon/Sites/aSite/files/"
    filefield="aFile"
    nameconflict="makeunique"
    accept="image/png"
    result="fileUploadResult" />
```
That `fileUploadResult` object holds a bunch of metadata reguarding the successfully uploaded file.

Keep in mind that it's generally not a good idea from a security perspective to upload files into the same working dir as the server. "ColdFusion makes this process easier by providing a temporary directory that can not be accessed via the web and is periodically purged of old files. Calling the function getTempDirectory will return the location of the temporary directory. You can then upload your file to this location, then use the result struct to get the file location and filename."

It's also good to leverdge `expandpath` when defining the paths of files we're manipulating.

Note that we can use `cfdirectory` when manipulating directories where files may be.

### Image Manipulation
The most useful functions are those that scale and crop images. 
For example of you want to scale an image:
```
ImageScaleToFit(imageObj,150,200);
```

If we want to maintain the proportions of one dimension we can leave the other param blank
```
ImageScaleToFit(imageObj,100,'');
```

Here is what croping looks like
```
ImageCrop(imageObj,20,10,150,200);
```
There is also functionality to create new images, draw on them, and get their information.

### Spreadsheets

## Caching

Performance optimization in CF is very manual. There are 2 main functions to be used `cachePut` and `cacheGet`.

For cacheGet keep in mind that if a key doesn't exist in the cache, it will be returned as `null`

To manually purge the entire cache, you can `cacheRemove('ID_OF_ITEM_TO_BE_REMOVED')`

If we want to see all the items in the cache currently we can call `cacheGetAllIds()`.
For even more detail into a single cached item, we can call `cacheGetMetadata('itemid')`. This will give us date/time created, last time accessed, size, and cache hitcount.

We can also store the result of a `queryExecute` item in cache. Be careful, make sure to use this only for data that is not accessed frequently.

Generated content can also be cached using the `cfcache` tag, similar to memoization in React. However this is "dumb" and "agressive" caching. It should only be done for NON-DYNAMIC sections of HTML.
In situations where this needs to happen you can run the following code which will flush cfcaches that match the url
```
<cfcache action="flush" expireURL="/report.cfm?state=">
```

There is also server level caching which is configued in CFAdmin.

Note that the default behavior or Cacheing does check if the data has been changed. This does add some overhead. If you want to reduce that ovehead you can enable `Trusted Cache`. Keep in mind this prevents the template cache from keeping up to date.

Cache values can also be saved between device restarts with a Save class file.

### Advanced Caching

Server supports Ehcache, JCS, memcached, and Redis by default.

Ehcache is the underlying engine behind caching in CF. Redis is Enterprise only (paid).

Server defined caching properties include:
- `Max idle time` - Default time for cache eviction
- `Max life span` - Amount of time an object will exist in cache before eviction.
- `Max elements` - Upper limit for items in the cache. 
- `Eternal` - If set to true, items in the cache wil never expire. 

We can configure a lot of cache stuff in `Application.cfc`. Here are 2 of the main peroperties. 

- `this.cache.engine` - Defines what engine (ehcache, jcs, resis, memcached) is used with this app.
- `this.cache.configfile` - Defines the path to file containing config properties for caching engine.

Custom regions can be defined so you can compartmentalized caching settings depending on the specific region. A region can be created with `cacheRegionNew( 'htmlBlock', properties )`.
Additional functions related to the region are defined in the section.

## Security
### Introduction
Key thoughts to keep in mind:
1. Anything that can communicate over HTTP is the client interface to your web application. Not just the web browser.
2. Don't trust data from the client (cookies, form post data, CGI variables). Anything can be manipulated.
3. All input MUST be validated on the server side.
4. User `Allow Lists` over `Deny Lists`.

### SQL Injection
To prevent SQL injections we should pass all variables as params to queryExecute. Here's how to do that in cfscript.
```
<cfscript>
    news = queryExecute("SELECT * FROM news WHERE id = :newsID",
        { newsID={ value=url.id, cfsqltype="integer" } } );
</cfscript>
```

