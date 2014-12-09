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
        <link rel="stylesheet" type="text/css" href="css/periodicTable.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">
    </head>

    <cfset currPage = "findStan">

    <cfparam name="partNum" default="" type="string" pattern="^[P]\d{10}$">

    <cfquery
        name="getPart"
        datasource="#Request.DSN#"
        username="#Request.username#"
        password="#Request.password#"
        result="theParts">
    SELECT distinct
           main.partNumber,
           main.symbol,
           main.composition,
           p.stock,
           p.targetValue,
           p.price,
           st.typeDesc,
           p.platedElement,
           p.custom
    FROM tbPartComponent main inner join tbPart p on p.partNumber = main.partNumber inner join tbStandardType st on p.typeID = st.typeID
    WHERE main.partNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partNum#">
    </cfquery>

    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->

        <!--- Get the information from the Element table for each element --->

        <form id="newStandard">
            <label for="partNumber">Part Number</label>
            <input type="text" required readonly id="partNumber" name="partNumber" value="<cfoutput>#partNumber#</cfoutput>"/>
            <label for="stanType">Standard Type</label>
            <input type="text" required disabled id="stanType" name="stanType" value="<cfoutput>#typeDesc#</cfoutput>"/>
            <cfif #typeDesc# eq "P">
                <label for="plated">Plated On</label>
                <input type="text" required disabled id="plated" name="plated" value="<cfoutput>#typeDesc#</cfoutput>"/>
            </cfif>
            <label for="actualValue">Measured thickness</label>
            <input type="number" name="actualValue" id="actualValue" required min="2" max="1002" step="2"/>
        </form>



        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jqueryui-1.11.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.js"></script>
    </body> 
</html>