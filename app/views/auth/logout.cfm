<cflogout>

<cfset SessionInvalidate()> 
<cfset StructClear(Session)>

<cflocation URL="/" ADDTOKEN = "No">