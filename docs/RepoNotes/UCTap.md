## Notes on UC Tap Repo (Aug 26 2026)
Tech Stack:
- Bootstrap styling 
- JQuery (Mainly used for DOM manipulation. You "select" query HTML elements and perform actions on them).


### Auth layer 

`request.ucDeveloper` is how we are permissed onto other pages. It's set in `prod/counselors` and `prod/students`. Suprisingly simple, if the user is either UID 1 or 2 (Phil or Brian) the user is let through.
```
<CFIF listfind("X, Y, Z", request.userId)>
    <CFSET request.ucDeveloper = 1>
</CFIF>
```

`request.userId` is the variable used to SET if ucDeveloper is true or not. It's set with this function:
```
<CFSET request.userId = GetAuthUser()>
```
`GetAuthUser()` is a cfFunction that is defined by the user set when we use "cfloginUser" 


If they are unautherized the following page is displayed:
```
<CFIF NOT request.ucDeveloper>

    <!---  <!--- for testing, if not a developer, keep index down in play. BCA 10/9/16 --->
    <CFLOCATION URL="/index_down.html" ADDTOKEN="No"> --->
    
    <CFERROR TYPE="exception"  TEMPLATE="#pathFromRoot#/tagError.cfm">
    <CFERROR TYPE="request" TEMPLATE="#pathFromRoot#/tagError.cfm">
</CFIF>
```

Let's see if we can bypass "cflogin" somehow. The form controlling it is `prod/students/tagAuth.cfm`

This file references `prod/students/tagLoginForm.cfm` which we see on the homepage.


Additional Notes:
CF Variable Scopes
`Request` Scope
- Lasts only as long as a single HTTP request
- Viewable the entire time only within that page.

`Session` Scope
- Lasts entire user session (timeout / logout)
- Cross Page