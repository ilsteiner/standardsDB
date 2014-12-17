<cfquery name='tbElement' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbElement </cfquery>
<cfquery name='tbCertStatus' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbCertStatus </cfquery>
<cfquery name='tbTechnician' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbTechnician </cfquery>
<cfquery name='tbStandardType' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbStandardType </cfquery>
<cfquery name='tbCertification' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbCertification </cfquery>
<cfquery name='tbPart' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbPart </cfquery>
<cfquery name='tbStandard' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbStandard </cfquery>
<cfquery name='tbPartComponent' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbPartComponent </cfquery>
<cfquery name='tbStandardComponent' datasource='#Request.DSN#' username='#Request.username#' password='#Request.password#'> SELECT * FROM tbStandardComponent </cfquery>

<table>
<tr><cfloop list="#tbElement.ColumnList#" index="col" delimiters=",">
<th><cfoutput>#col#</cfoutput></th>
</cfloop></tr>
<cfoutput query="tbElement">
<tr><cfloop list="#tbElement.ColumnList#" index="col">
<td>#tbElement[col][CurrentRow]#</td></cfloop></tr>
</cfoutput>
</table>