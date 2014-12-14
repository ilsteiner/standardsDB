<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Products</title>
        <meta name="View available products" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/periodicTable.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="js/tablesorter/themes/blue/style.css">
    </head>

    <cfset currPage = "findProd">

    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->

        <!--- Get the information from the Element table for each element --->
        <cfquery
                name="getElements"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#"
                 cachedwithin="#CreateTimeSpan(2,0,0,0)#">
        select
        symbol,
        to_number(atomicNumber) atomicNumber,
        name,
        density
        from tbElement
        order by atomicNumber
        </cfquery>

        <!--- Find out which elements are sold by the company so we can make them clickable --->
        <cfquery
                name="getElementsSold"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#"
                 cachedwithin="#CreateTimeSpan(0,12,0,0)#">
        select distinct
        symbol
        from tbPartComponent
        </cfquery>

        <!--- Make lists of atomic numbers where we need to do something different when generating the table --->
        <cfset firstEl="1,3,11,19,37,55,57,87,89">
        <cfset lastEl="2,10,18,36,54,71,86,103,118">
        <cfset hasSpace="1,4,12">

        <div id="navButtonsWrapper">
            <div id="navButtons">
                <cfinclude template = "navBar.cfm">
            </div>
        </div>

        <div id="sliderFormWrapper">
            <img src="img/loading.gif" class="hidden">

            <form name="sliderForm" id="sliderForm" action="inventory.cfm" method="POST">
                <div id="formInputs">
                    <div class="inputDiv">
                        <label for="minThick left">Minimum thickness</label><br/>
                        <input type="number" name="minThick" id="minThick" min="2" max="1002" step="2"/>μin
                    </div>

                    <div class="checks">
                        <label class="checkLabel"><input type="checkbox" checked id="foil" name="types" value="F">Foils</label>
                        <label class="checkLabel"><input type="checkbox" checked id="plated" name="types" value="P">Plated&nbsp;standards</label>
                    </div>

                    <div class="inputDiv">
                        <label for="maxThick">Maximum&nbsp;thickness</label><br/>
                        <input type="number" name="maxThick" id="maxThick" min="2" max="1002" step="2">μin</input>
                    </div>
                </div>
                <div id="rangeSlider"></div>
                <input class="col-12-12" type="hidden" name="elements" id="elements" pattern="(^(([A-Z][a-z][,])*)([A-Z][a-z])(?!,)$)|(^([A-Z][a-z][^,])$)"/>
                <div id="searchPartWrapper">
                    <div id="searchPart">
                        <label for="partialPart">Search by part number</label>
                        <input type="text" maxlength="11" name="partialPart" id="partialPart">
                    </div>
                </div>
            </form>
        </div>
        <div id="pDiv">
            <table id="pTable">
                <cfloop from="1" to=#getElements.recordcount# index="i" step="1">
                    <cfif (#getElements.atomicNumber[i]# gt 57 and #getElements.atomicNumber[i]# lte 71) or (#getElements.atomicNumber[i]# gt 89 and #getElements.atomicNumber[i]# lte 103)>
                        <!--- These are lanthinides and actinides...I'm just going to ignore them for the current implementation. --->
                    <cfelseif #getElements.atomicNumber[i]# eq 57 or #getElements.atomicNumber[i]# eq 89>
                        <!--- These are the blank spots for the lanthinide and actinide popouts.
                            They get a blank cell so that they still take up room.
                        --->
                        <td class="element transition">
                            &nbsp;
                        </td>
                    <cfelse>
                        <!--- If this is the start of a row, begin a row. --->
                        <cfif ListFind(firstEl,#getElements.atomicNumber[i]#) neq 0>
                            <tr class="elemRow">
                        </cfif>
                        <!--- 
                            This section does a few things:
                            Adds the cell containing an element, this includes:
                                Atomic Number
                                Symbol
                                Name
                                Density
                            Sets the element's class to element
                            Add an ID equal to the element's symbol so we can easily access it via Javascript
                            If this is an element with at least one row in the tbPartComponent table, mark it active as the company sells it
                         --->
                        <td id="<cfoutput>#getElements.symbol[i]#</cfoutput>" class="element <cfif ListFind(ValueList(getElementsSold.symbol),#getElements.symbol[i]#) neq 0>
                            <cfoutput>active</cfoutput></cfif>">
                            <span class="atomicNumber"><cfoutput>#getElements.atomicNumber[i]#</cfoutput></span>
                            <br/>
                            <span class="symbol"><cfoutput>#getElements.symbol[i]#</cfoutput></span>
                            <br/>
                            <span class="name"><cfoutput>#getElements.name[i]#</cfoutput></span>
                            <br/>
                            <cfif getElements.density[i] eq "">
                            <span class="density">&nbsp;</span>
                            <cfelse>
                                <span class="density"><cfoutput>#getElements.density[i]# g/cc</cfoutput></span>
                            </cfif>
                        </td>

                        <cfif #getElements.atomicNumber[i]# eq 1>
                            <td class="spacer" colspan="1">
                                &nbsp;
                            </td>
                            <td class="spacer" colspan="10" rowspan="3">
                                <div id="formResults">&nbsp;</div>
                            </td>
                            <td class="spacer" colspan="5">
                                &nbsp;
                            </td>
                        </cfif>

                        <!--- If this is the end of a row, end the row. --->
                        <cfif ListFind(lastEl,#getElements.atomicNumber[i]#) neq 0>
                            </tr>
                        </cfif>
                    </cfif>
                </cfloop>
            </table>
        </div>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jqueryui-1.11.2.min.js"><\/script>')</script>
        <script type="text/javascript" src="js/periodicTable.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <script type="text/javascript" src="js/tablesorter/jquery.tablesorter.min.js"></script>
    </body>
</html>