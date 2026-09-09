<cfparam name="attributes.query" default="">

<cfoutput>
    <form 
        method="post" 
        class="max-w-2xl flex" 
    >
        <!--- Search Input --->
        <div class="relative flex-1">
            <input
                type="search"
                name="query"
                value="#encodeForHtmlAttribute(attributes.query)#"
                placeholder="eg: 52970"
                class="w-full rounded-l-md border border-gray-300 bg-white px-2 py-2 text-xs text-gray-900 outline-none placeholder:text-gray-400 focus:border-btn-blue-b focus:ring-2 focus:ring-btn-blue-b/20"
            >
        </div>

        <!--- Search Button --->
        <button
            type="submit"
            class="rounded-r-md bg-linear-to-t from-btn-blue-t to-btn-blue-b px-2.5 py-1 text-sm font-normal text-white border border-btn-blue-light cursor-pointer shadow-[inset_0_1px_0_rgba(255,255,255,0.25)] hover:from-btn-blue-light hover:to-btn-blue-light"
        >
            SEARCH
        </button>
    </form>
</cfoutput>