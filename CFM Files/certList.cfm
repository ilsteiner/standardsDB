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
        <cfparam name="partNumber" default="" type="string" pattern="^[P]\d{10}$">

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
                c.certDate,
                t.name,
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
            inner join tbTechnician t on c.technicianID = t.technicianID
            WHERE c.statusID IN ('P','R')
            <cfif isDefined("FORM.partNumber")>
                and s.partNumber = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="11" value="#FORM.partNumber#">
            </cfif>
            and ROWNUM <= 5000
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
                            <!--- If we came here with a part number defined --->
                            <cfif isDefined("FORM.partNumber")>
                                <td>
                                    <form name="certifyStandard" method="POST" action="addToCert.cfm">
                                        <input type="number" name="quantity" value="1" min="1" max="<cfoutput>#p.stock#</cfoutput>" required>
                                        <input type="hidden" readonly name="certNumber" value="<cfoutput>#certNumber#</cfoutput>">
                                        <input type="hidden" readonly name="partNumber" value="<cfoutput>#FORM.partNumber#</cfoutput>">
                                        <input type="submit" name="addToCert" value="submit">
                                    </form>
                                </td>
                            </cfif>
                        </tr>
                        <tr class="productRow hidden expand-child">
                            <td colspan="3">
                                <table class="partNums tablesorter">
                                    <thead>
                                        <tr>
                                            <th>Part Number</th>
                                            <th>Type</th>
                                            <th>Target Value</th>
                                            <th>Actual Value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <cfoutput>
                                            <tr>
                                                <td>#getCerts.partNumber#</td>
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
