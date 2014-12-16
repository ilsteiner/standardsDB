<cfparam name="Request.DSN" default="cscie60">
<cfparam name="Request.username" default="ilebwohl">
<cfparam name="Request.password" default="8443">

<cfapplication name="StandardsDB" 
    sessionmanagement="Yes"
    sessiontimeout=#CreateTimeSpan(0,2,0,0)#>