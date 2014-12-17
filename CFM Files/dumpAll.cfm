<cfquery name='tbElement' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbElement </cfquery>
<cfquery name='tbCertStatus' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbCertStatus </cfquery>
<cfquery name='tbTechnician' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbTechnician </cfquery>
<cfquery name='tbStandardType' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbStandardType </cfquery>
<cfquery name='tbCertification' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbCertification </cfquery>
<cfquery name='tbPart' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbPart </cfquery>
<cfquery name='tbStandard' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbStandard </cfquery>
<cfquery name='tbPartComponent' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbPartComponent </cfquery>
<cfquery name='tbStandardComponent' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbStandardComponent </cfquery>

<!--- <table><tr><cfloop list='#tbElement.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbElement'><tr><cfloop list='#tbElement.ColumnList#' index='col'><td>#tbElement[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>

<table><tr><cfloop list='#tbCertStatus.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbCertStatus'><tr><cfloop list='#tbCertStatus.ColumnList#' index='col'><td>#tbCertStatus[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>

<table><tr><cfloop list='#tbTechnician.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbTechnician'><tr><cfloop list='#tbTechnician.ColumnList#' index='col'><td>#tbTechnician[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>

<table><tr><cfloop list='#tbStandardType.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbStandardType'><tr><cfloop list='#tbStandardType.ColumnList#' index='col'><td>#tbStandardType[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>

<table><tr><cfloop list='#tbCertification.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbCertification'><tr><cfloop list='#tbCertification.ColumnList#' index='col'><td>#tbCertification[col][CurrentRow]#</td></cfloop></tr></cfoutput></table> 

<table><tr><cfloop list='#tbPart.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbPart'><tr><cfloop list='#tbPart.ColumnList#' index='col'><td>#tbPart[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>
--->
 <table><tr><cfloop list='#tbStandard.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbStandard'><tr><cfloop list='#tbStandard.ColumnList#' index='col'><td>#tbStandard[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>
<!---
<table><tr><cfloop list='#tbPartComponent.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbPartComponent'><tr><cfloop list='#tbPartComponent.ColumnList#' index='col'><td>#tbPartComponent[col][CurrentRow]#</td></cfloop></tr></cfoutput></table>

<table><tr><cfloop list='#tbStandardComponent.ColumnList#' index='col' delimiters=','><th><cfoutput>#col#</cfoutput></th></cfloop></tr><cfoutput query='tbStandardComponent'><tr><cfloop list='#tbStandardComponent.ColumnList#' index='col'><td>#tbStandardComponent[col][CurrentRow]#</td></cfloop></tr></cfoutput></table> --->
