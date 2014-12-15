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
    </head>

    <cfparam name="partNumber" default="P1111111111" type="string" pattern="^[P]\d{10}$">

    <cfset FORM.partNumber = "P1111111111">

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
					<th><div class="headerWrapper">Thickness</div></th>
					<th><div class="headerWrapper">Price</div></th>
					<th><div class="headerWrapper">In Stock</div></th>
					<th><div class="headerWrapper">Composition</div></th>
					<th><div class="headerWrapper">Density</div></th>
				</tr>
			</thead>

			<tbody class="ui-widget-content">
				<cfoutput query="getThePart" group="partNumber">
					<tr>
						<td class="partNumVal">#partNumber#</td>
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
			</tbody>
		</table>
		
		<table id="standardTable">
			<!--- <caption>table title and/or explanatory text</caption> --->
			<thead>
				<tr>
					<th>Serial Number</th>
					<th>Measured Thickness</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="serialNumber"></td>
					<td class="thick formRow">
						<form action="createStandard.cfm" id="newStandardForm" method="POST">
				        	<input required readonly type="hidden" form="newStandardForm" name="partNumber" value="<cfoutput>#FORM.partNumber#</cfoutput>">
				        	<input required type="number" form="newStandardForm" name="actualValue" id="actualValue" min="<cfoutput>#getThePart.minThick#</cfoutput>" max="<cfoutput>#getThePart.maxThick#</cfoutput>" step=".01" placeholder="<cfoutput>#getThePart.minThick#μin - #getThePart.maxThick#μin</cfoutput>">
						</form>
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="submit" name="addMore" value="Create and new" form="newStandardForm">
		<input type="submit" name="done" value="Create and done" form="newStandardForm">
		<input type="submit" name="cancel" value="Cancel entry" form="newStandardForm">

    	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jqueryui-1.11.2.min.js"><\/script>')</script>
        <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/newStandard.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
    </body>
</html>