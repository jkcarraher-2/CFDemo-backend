<!--- REUSABLE BUTTON COMPONENT --->
<cfparam name='attributes.text' default="Button">
<cfparam name='attributes.type' default="button">
<cfparam name='attributes.class' default="">
<cfparam name='attributes.href' default="">
<cfparam name='attributes.onClick' default="">

<cfset buttonClass = "mt-6 inline-block rounded-md bg-blue-600 px-5 py-2.5 text-sm font-semibold text-white hover:bg-blue-700">

<cfoutput>
    <!--- IF HREF -> use <a> tag --->
    <cfif len(attributes.href)>
        <a
            href="#encodeForHtmlAttribute(attributes.href)#"
            class="#encodeForHtmlAttribute(buttonClass)#"
            <cfif len(attributes.onClick)>
                onclick="#encodeForHtmlAttribute(attributes.onClick)#"
            </cfif>
        >
            #encodeForHtml(attributes.text)#
        </a>
    
    <!--- OTHERWISE -> use <button> --->
    <cfelse>
        <button
            type="#encodeForHtmlAttribute(attributes.type)#"
            class="#encodeForHtmlAttribute(buttonClass)#"
            <cfif len(attributes.onClick)>
                onclick="#encodeForHtmlAttribute(attributes.onClick)#"
            </cfif>
        >
            #encodeForHtml(attributes.text)#
        </button>
    </cfif>

</cfoutput>