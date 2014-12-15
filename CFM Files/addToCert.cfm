<cfparam name="partNumber" default="P1111111111,P1111111113" type="string" pattern="(^(([P]\d{10}[,])*)([P]\d{10})$)|(^([P]\d{10})$)">
<cfparam name="technician" default="T01" type="string" pattern="^[T]\d{2}$">

<!--- <cfset technician = "T01"> --->
        
    <!--- Create a new certification --->
    <cfquery
        name="createNewCert"
        datasource="#Request.DSN#"
        username="#Request.username#"
        password="#Request.password#"
        result="theCert">

        INSERT INTO tbCertification
        (technicianID,statusID,certDate)
        VALUES (<cfqueryparam cfsqltype="cf_sql_char" maxlength="3" null="false" value="#technician#">,'C',<cfqueryparam cfsqltype="cf_sql_date" null="false" value="#Now()#">)
    </cfquery>

    <!--- Get the ROWID for the certification we just created --->
    <cfset newCertRow = theCert.ROWID>

    <!--- Create a list in which to store the standards we find for each part--->
    <cfset stanList = ''>

    <!--- Put the list of part numbers into an array --->
    <!--- <cfset partArray = listToArray("#partNumber#")> --->

    <!--- <cfloop from="1" to="#ArrayLen(partArray)#" index="i"> --->
        <cfquery
            name="getStandard"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="aStandard">
            -- Get a standard that has the correct part number and doesn't already have a cert
            SELECT
                serialNumber
                FROM tbStandard
                WHERE partNumber in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" maxlength="11" null="false" value="#partNumber#">)
                -- and ROWNUM = 1
                and certNumber is null
                -- and serialNumber not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#stanList#">)
        </cfquery>

        <cfoutput query="getStandard" group="partNumber">
            <!--- Add the serial number to the list of serial numbers --->
            #partNumber#
            #serialNumber#

            <!--- <cfset stanList = ListAppend(stanList,#getStandard.serialNumber[0]#)> --->
        </cfoutput>
    <!--- </cfloop> --->

<!--     - Get the first standard with each partnumber that does not already have a certification -
<cfloop index = "partNum" list = "#partNumber#" delimiters=",">
    <cfquery
        name="getStandard"
        datasource="#Request.DSN#"
        username="#Request.username#"
        password="#Request.password#"
        result="aStandard">
        -- Get a standard that has the correct part number and doesn't already have a cert
        SELECT
            serialNumber
            FROM tbStandard
            WHERE partNumber = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="11" null="false" value="#partNum#">
            and ROWNUM = 1
            and certNumber is null
    </cfquery>
    <cfoutput query="getStandard">
        - Add the serial number to the list of serial numbers -
        <cfset stanList = ListAppend(stanList,#serialNumber#)>
    </cfoutput>
</cfloop>       
 -->
<!-- <cfdump var = "#partNumber#">
<cfdump var = "#partArray#">
<cfdump var = "#stanList#"> -->

 <!--    <cfquery
         name="addCertToStandard"
         datasource="#Request.DSN#"
         username="#Request.username#"
         password="#Request.password#"
         result="addedCerts">
 
         -- Set all the standards we found (by serial number) to the certNumber we just added
         UPDATE tbStandard
         SET certNumber = (SELECT certNumber from tbCertification where ROWID = '#newCertRow#')
         WHERE serialNumber in (<cfqueryparam list="true" cfsqltype="cf_sql_varchar" value="#stanList#">)
 </cfquery>
 
 <cfoutput>
     Updated #addedCerts.RecordCount# records.
 </cfoutput> -->