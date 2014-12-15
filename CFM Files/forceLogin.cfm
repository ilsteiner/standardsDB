<cflogin>
	<cfif not (isDefined("FORM.userLogin")
		and isDefined("FORM.userPassword"))>
			<cfabort>
		<cfelse>
			<cfquery
				name="getUser"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
					select *
					from tbLogin
					where uname = <cfqueryparam cfsqltype="cf_sql_varchar" value="Form.UserLogin">
					and pwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.UserPassword#">
			</cfquery>

			<cfif getUser.recordCount eq 1>
				<cfloginuser
					name="#getUser.name#"
					password="#FORM.userPassword#"
					roles="#getUser.userview#">
				
				<cfelse>
					<div class="failedLogin">
						The username and password combination you entered was not valid. Please login again.
					</div>

					<cfinclude template="login.cfm">
			</cfif>
	</cfif>
</cflogin>