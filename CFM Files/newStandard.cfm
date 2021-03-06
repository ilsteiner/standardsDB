<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Add Standard(s)</title>
        <meta name="Add new standards" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" type="text/css" href="css/newStandard.css">
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="js/tablesorter/themes/blue/style.css">
    </head>

    <cferror type="EXCEPTION" exception="expression" template="error.cfm">

    <cfparam name="partNumber" default="" type="string" pattern="^[P]\d{10}$">

    <cfset currPage = "newStan">
	
	<!--- Get information about the part for which we are creating a new standard --->
    <cfquery
	name="getThePart"
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
		       p.custom,
		       e.density,
		       -- Calculate the minimum and maximum acceptable thicknesses for this product
		       (p.targetValue - (p.targetValue * .15)) minThick,
		       (p.targetValue + (p.targetValue * .15)) maxThick
		FROM tbPartComponent main 
		inner join tbPart p on p.partNumber = main.partNumber 
		inner join tbStandardType st on p.typeID = st.typeID
		inner join tbElement e on e.symbol = main.symbol
		WHERE main.partNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partNumber#">
	</cfquery>

    <body>
		<div id="navButtonsWrapper">
            <div id="navButtons">
                <cfinclude template = "navBar.cfm">
            </div>
        </div>

	    <table id="product" class="tablesorter">
			<thead>
				<tr>
					<th><div class="headerWrapper">Part Number</div></th>
					<th><div class="headerWrapper">Type</div></th>
					<th><div class="headerWrapper">Target Thickness</div></th>
					<th><div class="headerWrapper">Price</div></th>
					<th><div class="headerWrapper">In Stock</div></th>
					<th><div class="headerWrapper">Composition</div></th>
					<th><div class="headerWrapper">Density</div></th>
				</tr>
			</thead>

			<tbody class="ui-widget-content">
				<!--- If the query returned an unexpected number of results --->
				<cfif #getThePart.RECORDCOUNT# neq 1>
					<td class="partNumVal">
						<form name="selectNewPart" method="POST" action="newStandard.cfm">
							<input type="search" id="partNumber" name="partNumber" value="" placeholder="P1111111111" maxlength="11" pattern="^[P]\d{10}$" title="Type in a different a part number to create standards">
							<input type="submit" name="submit" value="Change selected product" class="ui-widget ui-widget-content ui-corner-all">
							<span class="error">There are no parts with that part number. Please enter a different value.</span>
						</form>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</td>
				<!--- If the query executed normally --->
				<cfelse>
					<cfoutput query="getThePart" group="partNumber">
						<tr>
							<td class="partNumVal">
								<form name="selectNewPart" method="POST" action="newStandard.cfm">
									<input type="search" id="partNumber" name="partNumber" value="#partNumber#" placeholder="P1111111111" maxlength="11" pattern="^[P]\d{10}$" title="Type in a different part number to create standards for another product">
									<input type="submit" name="submit" value="Change selected product" class="ui-widget ui-widget-content ui-corner-all">
								</form>
							</td>
							<td>#typeDesc#<cfif #typeDesc# eq 'Plated'> (#platedElement#)</cfif></td>
							<td>#targetValue#μin</td>
							<td>$#price#</td>
							<td>#stock#</td>
							<td class="composition">
								<cfset elemList="">
								<cfset denSum="0">
								<cfoutput>
									<cfset currElem = composition & "%" & " " & symbol>

									<!--- Add to the sum of densities of component elements of this alloy...or just this element if it isn't an alloy --->
									<cfset currDen = (composition/100) / density>
							
									<cfset denSum = denSum + currDen>
									<cfset elemList = listAppend(elemList,currElem)>
								</cfoutput>
								#elemList#
							</td>
							<td>
								<!--- Display the density for this product --->
								<cfset theDen = (1 / denSum)>
								#numberformat(theDen,"0.00")#g/cc
							</td>
						</tr>
					</cfoutput>
				</cfif>
			</tbody>
		</table>
		
		<table id="standardTable" class="tablesorter">
			<!--- <caption>table title and/or explanatory text</caption> --->
			<thead>
				<tr>
					<th>Serial Number</th>
					<th>Measured Thickness</th>
				</tr>
			</thead>
			<tbody>
				<tr id="formRow">
					<td class="serialNumber"></td>
					<td>
						<form action="createStandard.cfm" id="newStandardForm" method="POST">
							<input type="submit" name="submit" class="ui-button" id="submit" value="Create standard" form="newStandardForm">
				        	<input required readonly type="hidden" form="newStandardForm" name="partNumber" value="<cfoutput>#getThePart.partNumber#</cfoutput>">
				        	<input required type="number" form="newStandardForm" id="actualValue" name="actualValue" class="ui-widget ui-widget-content ui-corner-all" id="actualValue" min="<cfoutput>#getThePart.minThick#</cfoutput>" max="<cfoutput>#getThePart.maxThick#</cfoutput>" step=".01" placeholder="<cfoutput>#getThePart.minThick#μin - #getThePart.maxThick#μin</cfoutput>">
						</form>
					</td>
				</tr>
			</tbody>
		</table>

    	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jqueryui-1.11.2.min.js"><\/script>')</script>
        <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/newStandard.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
    </body>
</html>