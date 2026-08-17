### Creating more REST endpoints, linking to UI
Spending today exploring how REST code works, what the best uniform way to write modern REST endpoints using CF.

`cffunction` described here is used to define how we outline REST Api Routes
https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-f/cffunction.html

`cfparam` is how we take in params from the uri.
https://guides.adobe.com/coldfusion/en/docs/cfml-reference/__references__/cfparam.html

wanting to use modern re-writing syntax; change the server.json to include
```
"web":{
    "rewrites": {
        "enable": true
    }
}
```
https://commandbox.ortusbooks.com/embedded-server/configuring-your-server/url-rewrites