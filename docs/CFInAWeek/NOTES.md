# CF in a week takeaways / Notes
## Questions for Phil
1. How does our team prevent SQL injections and other security vulnerabilities?

2. 

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
For displaying re-usable code 