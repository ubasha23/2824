(:: pragma bea:global-element-parameter parameter="$response" type="ns0:corporateUserQueryResponse" location="../../SalesForce/wsdl/PortalServices.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:AMA_ProfileReadRS" location="../../PortalInterfaces/schema/AMA_ProfileReadRS.xsd" ::)

declare namespace ns1 = "http://com.finnair";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/PortalServices";
declare namespace ns2 = "http://soap.sforce.com/schemas/class/PortalServicesUserProfile";
declare namespace xf = "http://tempuri.org/CorporateUserProfile/transformations/Res_GetInfo/";
declare namespace dvm="http://xmlns.oracle.com/dvm";

declare function xf:DVMFunction($dvmTable as element(*), $sourceColumnName as xs:string,
    $sourceValue as xs:string, $targetColumnName as xs:string, $defaultValue as xs:string)
    as xs:string {
       let $idxSource as xs:integer := for $n at $i in $dvmTable/dvm:columns/dvm:column where ($n/@name = $sourceColumnName) return $i
       let $idxTarget as xs:integer := for $n at $i in $dvmTable/dvm:columns/dvm:column where ($n/@name = $targetColumnName) return $i
       
       let $res1 := $dvmTable/dvm:rows/dvm:row/dvm:cell[position() = $idxSource 
       		and text()=$sourceValue]/../dvm:cell[position() = $idxTarget]/text()
       return
       if (fn:string-length($res1) > 0) then
        string($res1)
       else
         string($defaultValue)
};

declare function xf:Res_GetInfo($response as element(ns0:corporateUserQueryResponse), $nationality as xs:string, $filter as xs:boolean)
    as element(ns1:AMA_ProfileReadRS) {
        <ns1:AMA_ProfileReadRS Version="12.2">
        	<ns1:Success/>
            <ns1:Profiles>
                {
                    for $Contact in $response/ns0:result/ns2:ListOfAyContactServicesIo
                    	return if ($Contact/ns2:OnlineAccess/text() eq "Y") then 
                        <ns1:ProfileInfo>
                        	{
	                    	if (fn:string-length($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:FinnairPlusNumber/text()) gt 0) then
                        	<ns1:UniqueID Type="21" ID="{ $Contact/ns2:ListOfLoyTravelProfile[1]/ns2:FinnairPlusNumber/text() }" ID_Context="LOYALTYNUMBER"/>
        	            	else ""
            	        	}
                        	{
	                    	if (fn:string-length($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:FinnairPlusNumber/text()) gt 0) then
                        	<ns1:UniqueID Type="9" ID="AY" ID_Context="AIRCODE"/>
        	            	else ""
            	        	}
                        	<ns1:ExternalID Type="21" ID="{ fn:replace($Contact/ns2:ContactId/text(), "-", "") }" ID_Context="CRM"/>
                        	<ns1:ExternalID Type="21" ID="{ $Contact/ns2:AYCustomerNumber/text() }" ID_Context="AY_Company_Key"/>
							<ns1:Profile ProfileType="1" Status="A">
								<ns1:Customer>
								{
								if ($Contact/ns2:Title/text() eq "Mr.") then
									attribute { "Gender" } { "Male" }
								else if (($Contact/ns2:Title/text() eq "Ms.") or ($Contact/ns2:Title/text() eq "Mrs.") 
									or ($Contact/ns2:Title/text() eq "Miss")) then
									attribute { "Gender" } { "Female" }
								else ()
								}
								{ 
								if (fn:string-length($Contact/ns2:DateOfBirth/text()) gt 0) then
									let $tokens := fn:tokenize($Contact/ns2:DateOfBirth/text(), "/")
									return attribute BirthDate { fn:concat($tokens[3], '-',$tokens[1],'-',$tokens[2]) }
								else ()
								}
									<ns1:PersonName>
										{
										if (fn:string-length($Contact/ns2:Title/text()) gt 0) then
										<ns1:NamePrefix>{ $Contact/ns2:Title/text() }</ns1:NamePrefix>
										else ()
										}
										<ns1:GivenName>{ $Contact/ns2:FirstName/text() }</ns1:GivenName>
										<ns1:Surname>{ $Contact/ns2:LastName/text() }</ns1:Surname>
									</ns1:PersonName>
									{
									if (fn:string-length($Contact/ns2:WorkPhone/text()) gt 0)
									then 
									<ns1:Telephone PhoneLocationType="6" PhoneTechType="1" PhoneNumber="{ $Contact/ns2:WorkPhone/text() }" />
									else
										""
									}
									{
									if (fn:string-length($Contact/ns2:CellularPhone/text()) gt 0)
									then 
									<ns1:Telephone PhoneLocationType="8" PhoneTechType="5" PhoneNumber="{ $Contact/ns2:CellularPhone/text() }" />
									else
										""
									}
									<ns1:Email EmailType="1" DefaultInd="true">{ $Contact/ns2:EmailAddress/text() }</ns1:Email>
									{
									if (fn:string-length($nationality) gt 0) then
									<ns1:CitizenCountryName Code="{ $nationality }" />
									else
										""
									}
									{
									if ((fn:string-length($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:PassportNumber/text()) gt 0)) then
									<ns1:Document DocID="{ $Contact/ns2:ListOfLoyTravelProfile[1]/ns2:PassportNumber/text() }" 
										DocType="2" EffectiveDate="{
											if (fn:string-length($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:PassportIssueDate/text()) gt 0) then
												let $tokens := fn:tokenize($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:PassportIssueDate/text(), "/")
												return fn:concat($tokens[3], '-',$tokens[1],'-',$tokens[2])
											else
												"" 
										}" 
										ExpireDate="{
											if (fn:string-length($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:PassportExpirationDate/text()) gt 0) then
												let $tokens := fn:tokenize($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:PassportExpirationDate/text(), "/")
												return fn:concat($tokens[3], '-',$tokens[1],'-',$tokens[2])
											else
												""
										}" 
										 />
									else
										""
									}
									{ 
									if (fn:string-length($Contact/ns2:JobTitle/text()) gt 0) then
										<ns1:EmployeeInfo EmployeeTitle="{ fn:substring($Contact/ns2:JobTitle/text(),1,35) }" />
									else 
										""
									} 
								</ns1:Customer>
								{
								if ($filter eq fn:false()) then
    	                    	<ns1:UserID Type="18" ID="{ $Contact/ns2:ContactId/text() }" ID_Context="CRM" />
    	                    	else ""
    	                    	}
	                        	{
    	                    	if ($filter eq fn:false() and fn:string-length($Contact/ns2:CorpUsername/text()) gt 0) then
    	                    	<ns1:UserID Type="4" ID="{ $Contact/ns2:CorpUsername/text() }" ID_Context="Portal" />
	                        	else ""
	                        	}
								<ns1:PrefCollections>
									<ns1:PrefCollection>
										<ns1:AirlinePref>
											<ns1:CabinPref Cabin="{
												if ($Contact/ns2:ListOfLoyTravelProfile[1]/ns2:BusClassAllowed/text() eq "N") then
													"Economy"
												else 
													"Business"
											}" />
										</ns1:AirlinePref>
									</ns1:PrefCollection>
								</ns1:PrefCollections>
								<ns1:Agreements>
									<ns1:OwnerRights RoleId="{
										if ($Contact/ns2:Role eq "Admin") then
											"A"
										else 
											"T"
									}" />
								</ns1:Agreements>
								{
								if ($filter eq fn:false()) then
								<ns1:CustomFields>
									<ns1:CustomField KeyValue="10">
									{ 
									if ($Contact/ns2:SuppressAllEmails/text() = "Y") then
										"false"
									else
										"true"
									}
									</ns1:CustomField>
								</ns1:CustomFields>
								else ""
								}
							</ns1:Profile>
                        </ns1:ProfileInfo>
                	else ()
                }
            </ns1:Profiles>
        </ns1:AMA_ProfileReadRS>
};

declare variable $response as element(ns0:corporateUserQueryResponse) external;
declare variable $nationality as xs:string external;
declare variable $filter as xs:boolean external;

xf:Res_GetInfo($response, $nationality, $filter)
