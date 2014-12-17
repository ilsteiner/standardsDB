<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Certifications</title>
        <meta name="View certifications" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="js/tablesorter/themes/blue/style.css">
    </head>
    
    <body>
        <cfparam name="partNumFilter" default="" type="string" pattern="^[P]\d{10}$">

        <!--- Get the list of certifications and associated products --->
        <cfquery
            name="getCerts"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="theStandard">
            SELECT DISTINCT
                s.partNumber,
                s.certNumber,
                s.serialNumber,
                c.certDate,
                cs.statusDesc,
                t.name,
                s.actualValue,
                pc.symbol,
                pc.composition,
                p.stock,
                p.targetValue,
                p.price,
                st.typeDesc,
                p.platedElement,
                p.custom,
                e.density
            FROM tbStandard s 
            left join tbCertification c on s.certNumber = c.certNumber
            inner join tbPartComponent pc on s.partNumber = pc.partNumber
            inner join tbPart p on pc.partNumber = p.partNumber
            inner join tbStandardType st on p.typeID = st.typeID
            inner join tbTechnician t on c.technicianID = t.technicianID
            inner join tbCertStatus cs on c.statusID = cs.statusID
            INNER JOIN tbElement e on e.symbol = pc.symbol
            WHERE ROWNUM <= 5000
            <cfif isDefined("partNumFilter") and #partNumFilter# neq "">
                and s.partNumber = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="11" value="#partNumFilter#">
            </cfif>
            ORDER BY c.certDate DESC
        </cfquery>

        <cfset currPage = "findCert">

        <div id="mainWrapper">
            <span id="navButtonsCenter">
                <cfinclude template = "navBar.cfm">

                <!--- Page controls --->
                <div id="pager" class="pager hidden">
                    <form>
                      <img src="img/first.png" class="first"/>
                      <img src="img//prev.png" class="prev"/>
                      <input type="text" class="pagedisplay"/>
                      <img src="img//next.png" class="next"/>
                      <img src="img//last.png" class="last"/>
                      <select class="pagesize">
                        <option selected="selected"  value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option  value="40">40</option>
                      </select>
                    </form>
                </div>
            </span>
        
            <table id="certTable" class="hidden tablesorter">
                <caption>Certifications</caption>

                <thead>
                    <tr>
                        <th></th>
                        <th>Certification Number</th>
                        <th>Certification Date</th>
                        <th>Technician</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <!--- Loading image --->
                <img src="img/loading.gif" id="loading">

                <tbody id="certTable">
                    <cfoutput query="getCerts" group="certNumber" maxrows="5000">
                        <tr class="certRow">
                            <td><img src="img/plus.png" alt="expand" class="expand"></td>
                            <td>#certNumber#</td>
                            <td>#certDate#</td>
                            <td>#name#</td>
                            <td>#statusDesc#</td>
                        </tr>
                        <tr class="productRow hidden expand-child">
                            <td colspan="3">
                                <table class="partNums tablesorter">
                                    <thead>
                                        <tr>
                                            <th>Serial Number</th>
                                            <th>Part Number</th>
                                            <th>Composition</th>
                                            <th>Density</th>
                                            <th>Type</th>
                                            <th>Target Value</th>
                                            <th>Actual Value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <cfoutput>
                                            <tr>
                                                <td>#getCerts.serialNumber#</td>
                                                <td>#getCerts.partNumber#</td>
                                                <td class="composition">
                                                    <cfset elemList="">
                                                    <cfset denSum="0">
                                                    <cfset compSum="0">
                                                    <cfoutput>
                                                        <cfset currElem = composition & "%" & " " & symbol>
                                                        
                                                        <!--- This is to fix a bug that is a result of how I am grouping this query output...things were showing once for each element they contained --->
                                                        <cfset compSum = compSum + composition>

                                                        <!--- Add to the sum of densities of component elements of this alloy...or just this element if it isn't an alloy --->
                                                        <cfset currDen = (composition/100) / density>
                                                
                                                        <cfset denSum = denSum + currDen>
                                                        <cfset elemList = listAppend(elemList,currElem)>
                                                    </cfoutput>
                                                    <cfif #compSum# neq "100">
                                                        <span class="hideParent">#compSum#</span>
                                                    </cfif>
                                                    #elemList#
                                                </td>
                                                <td>
                                                    <!--- Display the density for this product --->
                                                    <cfset theDen = (1 / denSum)>
                                                    #numberformat(theDen,"0.00")#g/cc
                                                </td>
                                                <td>#getCerts.typeDesc#</td>
                                                <td>#getCerts.targetValue#μin</td>
                                                <td>#getCerts.actualValue#μin</td>
                                            </tr>
                                        </cfoutput>
                                    </tbody>
                                </table>
                            </td>
                            
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jqueryui-1.11.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/jExpand.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <script type="text/javascript" src="js/tablesorter/jquery.tablesorter.min.js"></script>
        <script type="text/javascript" src="js/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
        <script type="text/javascript" src="js/certList.js"></script>

        <script>
            $("#certTable").jExpand();
        </script>      
    </body>

</html>
