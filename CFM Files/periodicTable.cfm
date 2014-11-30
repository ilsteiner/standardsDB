<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Product Table</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="periodicTable.css">

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->

        <cfquery
                name="getElements"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
        select
        symbol,
        to_number(atomicNumber) atomicNumber,
        name,
        density
        from tbElement
        order by atomicNumber
        </cfquery>

        <cfset firstEl="1,3,11,19,37,55,57,87,89">
        <cfset lastEl="2,10,18,36,54,71,86,103,118">
        <cfset hasSpace="1,4,12">

        <div id="pTable">
            <cfloop from="1" to=#getElements.recordcount# index="i" step="1">
                <cfif (#getElements.atomicNumber[i]# gt 57 and #getElements.atomicNumber[i]# lte 71) or (#getElements.atomicNumber[i]# gt 89 and #getElements.atomicNumber[i]# lte 103)>
                    <!-- These are lanthinides and actinides...I'm just going to ignore them for the current implementation. -->
                <cfelseif #getElements.atomicNumber[i]# eq 57 or #getElements.atomicNumber[i]# eq 89>
                    <!-- These are the blank spots for the lanthinides and actinides.
                        They get a blank div so that they still take up room.
                    -->
                    <div class="element">
                        &nbsp;
                    </div>
                <cfelse>
                    <!-- If this is the start of a row, begin a row div. -->
                    <cfif ListFind(firstEl,#getElements.atomicNumber[i]#) neq 0>
                        <div class="elemRow">
                    </cfif>

                    <div class="element">
                        <span class="atomicNumber"><cfoutput>#getElements.atomicNumber[i]#</cfoutput></span>
                        <span class="symbol"><cfoutput>#getElements.symbol[i]#</cfoutput></span>
                        <span class="name"><cfoutput>#getElements.name[i]#</cfoutput></span>
                        <span class="density"><cfoutput>#getElements.density[i]#</cfoutput></span>
                    </div>

                    <cfif #getElements.atomicNumber[i]# eq 1>
                        <div class="spacer_16">&nbsp;</div>
                    <cfelseif (#getElements.atomicNumber[i]# eq 4) or (#getElements.atomicNumber[i]# eq 12)>
                        <div class="spacer_10">&nbsp;</div>
                    </cfif>

                    <!-- If this is the end of a row, end the row div. -->
                    <cfif ListFind(lastEl,#getElements.atomicNumber[i]#) neq 0>
                        </div>
                    </cfif>
                </cfif>
            </cfloop>
        </div>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
    </body>
</html>