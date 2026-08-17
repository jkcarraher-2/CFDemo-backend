# CF in a week takeaways / Notes
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