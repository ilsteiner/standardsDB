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

    <cfinclude template="forceLogin.cfm">

    <cfset currPage = "findStan">

    <cfparam name="partNum" default="" type="string" pattern="^[P]\d{10}$">
    <cfparam name="serialNum" default="" type="string" pattern="^[S]\d{10}$">
	
	<!--- Editing an existing Standard --->
    <cfif #serialNum# neq "">
    	<cfquery
	        name="getData"
	        datasource="#Request.DSN#"
	        username="#Request.username#"
	        password="#Request.password#"
	        result="theStandard">
	    SELECT 
	    	s.partNumber,
	    	s.certNumber,
	    	s.actualValue,
	    	pc.symbol,
			pc.composition,
			p.stock,
			p.targetValue,
			p.price,
			st.typeDesc,
			p.platedElement,
			p.custom
	    FROM tbStandard s 
	    left join tbCertification c on s.certNumber = c.certNumber
	    inner join tbPartComponent pc on s.partNumber = pc.partNumber
	    inner join tbPart p on pc.partNumber = p.partNumber
	    inner join tbStandardType st on p.typeID = st.typeID
	    WHERE s.serialNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#serialNum#">
	    </cfquery>
    </cfif>
	
	<!--- Creating a new Standard --->
	<cfif #partNum# neq "">
	    <cfquery
	        name="getData"
	        datasource="#Request.DSN#"
	        username="#Request.username#"
	        password="#Request.password#"
	        result="theParts">
	    SELECT distinct
	           pc.partNumber,
	           pc.symbol,
	           pc.composition,
	           p.stock,
	           p.targetValue,
	           p.price,
	           st.typeDesc,
	           p.platedElement,
	           p.custom
	    FROM tbPartComponent pc inner join tbPart p on p.partNumber = pc.partNumber inner join tbStandardType st on p.typeID = st.typeID
	    WHERE pc.partNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partNum#">
	    </cfquery>
	</cfif>

    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![enidf]-->

        <form id="newStandard">
            <label for="partNumber">Part Number</label>
            <input type="text" required readonly id="partNumber" name="partNumber" value="<cfoutput>#partNum#</cfoutput>"/>
            <label for="stanType">Standard Type</label>
            <input type="text" required disabled id="stanType" name="stanType" value="<cfoutput>#getData.typeDesc#</cfoutput>"/>
            <!--- If this is a plated standard, show what it is plated on --->
            <cfif #getData.typeDesc# eq "Plated">
                <label for="plated">Plated On</label>
                <input type="text" required disabled id="plated" name="plated" value="<cfoutput>#getData.typeDesc#</cfoutput>"/>
            </cfif>
            <!--- Editing an existing Standard --->
    		<cfif #serialNum# neq "">

			<!--- Creating a new Standard --->
			<cfelifif #partNum# neq "">
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