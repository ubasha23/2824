(:: pragma bea:global-element-parameter parameter="$AMA_create" element="ns1:AMA_ProfileCreateRQ" location="../../PortalInterfaces/schema/AMA_ProfileCreateRQ.xsd" ::)
(:: pragma bea:local-element-return type="ns2:corporateUserCreation/ns2:request/ns0:ListOfAyContactServicesIo" location="../../SalesForce/wsdl/PortalServices.wsdl" ::)



declare namespace ns2 = "http://soap.sforce.com/schemas/class/PortalServices";
declare namespace ns1 = "http://com.finnair";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/PortalServicesUserProfile";
declare namespace xf = "http://tempuri.org/CorporateUserProfile/transformations/Req_Insert/";

declare function xf:Req_Insert_salesforce($AMA_create as element(ns1:AMA_ProfileCreateRQ))
    as element() {
        <ns0:ListOfAyContactServicesIo>
                {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:Telephone[@PhoneLocationType="8"]/@PhoneNumber)) gt 0) then
	                <ns0:CellularPhone>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:Telephone[@PhoneLocationType="8"]/@PhoneNumber) }</ns0:CellularPhone>
	            else
	            	""
	            }
                <ns0:ContactId>0</ns0:ContactId>
                {
                if (fn:string-length($AMA_create/ns1:Profile/ns1:Customer/@BirthDate) gt 0) then
                    <ns0:DateOfBirth>{
                	let $tokens := tokenize($AMA_create/ns1:Profile/ns1:Customer/@BirthDate, "-")
                	return fn:concat($tokens[2], "/", $tokens[3], "/", $tokens[1])
                	}
                    </ns0:DateOfBirth>
                else 
                    ""
                }
                <ns0:CorpUsername>0</ns0:CorpUsername>
                {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:Email)) gt 0) then
                    <ns0:EmailAddress>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:Email) }</ns0:EmailAddress>
	            else
	            	""
	            }
	            {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:GivenName)) gt 0) then 
                    <ns0:FirstName>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:GivenName) }</ns0:FirstName>
	            else
	            	""
	            }
	            {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:EmployeeInfo/@EmployeeTitle)) gt 0) then
                    <ns0:JobTitle>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:EmployeeInfo/@EmployeeTitle) }</ns0:JobTitle>
                else 
                	""
                }
                {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:Surname)) gt 0) then 
                    <ns0:LastName>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:Surname) }</ns0:LastName>
	            else
	            	""
	            }
                <ns0:ListOfContact_Account>
                    	<ns0:AccountType>Company</ns0:AccountType>
                    	<ns0:AccountTypeCode>FCP</ns0:AccountTypeCode>
                        <ns0:AYCustomerNumber>{ data($AMA_create/ns1:ExternalID[@ID_Context="AY_Company_Key"]/@ID) }</ns0:AYCustomerNumber>
                </ns0:ListOfContact_Account>
                <ns0:ListOfLoyTravelProfile>
                    	{
                        if (fn:string-length($AMA_create/ns1:Profile/ns1:PrefCollections/ns1:PrefCollection[1]/ns1:AirlinePref/ns1:CabinPref/@Cabin) gt 0) then
                            <ns0:BusClassAllowed>{ if ($AMA_create/ns1:Profile/ns1:PrefCollections/ns1:PrefCollection[1]/ns1:AirlinePref/ns1:CabinPref/@Cabin eq "Business") then
                        	"Y"
                        else
                        	"N" }
                            </ns0:BusClassAllowed>
                        else
                            ""
                        }
                        {
                        if (fn:string-length(data($AMA_create/ns1:UniqueID[@ID_Context="LOYALTYNUMBER"]/@ID)) gt 0) then
	                        <ns0:FinnairPlusNumber>{ data($AMA_create/ns1:UniqueID[@ID_Context="LOYALTYNUMBER"]/@ID) }</ns0:FinnairPlusNumber>
	                    else
	                    	""
	                   	}
	                   	<ns0:ParentContactId/>
	                   	{
                        if (fn:string-length($AMA_create/ns1:Profile/ns1:Customer/ns1:Document[1]/@ExpireDate) gt 0) then
                            <ns0:PassportExpirationDate>{ 
                        	let $tokens := tokenize($AMA_create/ns1:Profile/ns1:Customer/ns1:Document[1]/@ExpireDate, "-")
                        	return fn:concat($tokens[2], "/", $tokens[3], "/", $tokens[1])
                        	}
                            </ns0:PassportExpirationDate>
	                    else
	                    	""
	                   	}
	                   	{
                        if (fn:string-length($AMA_create/ns1:Profile/ns1:Customer/ns1:Document[1]/@EffectiveDate) gt 0) then
                            <ns0:PassportIssueDate>{ 
                        	let $tokens := tokenize($AMA_create/ns1:Profile/ns1:Customer/ns1:Document[1]/@EffectiveDate, "-")
                        	return fn:concat($tokens[2], "/", $tokens[3], "/", $tokens[1])
                        	}
                            </ns0:PassportIssueDate>
	                    else
	                    	""
	                   	}
                        {
                            for $DocID in $AMA_create/ns1:Profile/ns1:Customer/ns1:Document[1]/@DocID
                            return
                                <ns0:PassportNumber>{ data($DocID) }</ns0:PassportNumber>
                        }
                        <ns0:TravelProfileId>0</ns0:TravelProfileId>
                </ns0:ListOfLoyTravelProfile>
                {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:CitizenCountryName[1]/@Code)) gt 0) then
                    <ns0:Nationality>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:CitizenCountryName[1]/@Code) }</ns0:Nationality>
                else
                	""
                }
                <ns0:OnlineAccess>Y</ns0:OnlineAccess>
                {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Agreements/ns1:OwnerRights/@RoleId)) gt 0) then
                    <ns0:Role>{ if ($AMA_create/ns1:Profile/ns1:Agreements/ns1:OwnerRights/@RoleId eq "A") then
                	"Admin"
                else 
                	"Traveler" }
                    </ns0:Role>
                else 
                    ""
                }
                <ns0:SuppressAllEmails>{
               	if ($AMA_create/ns1:Profile/ns1:CustomFields/ns1:CustomField[@KeyValue="10"]/text() = "false") then
               		"Y"
               	else
               		"N"
               	}
               	</ns0:SuppressAllEmails>
                { 
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:NamePrefix)) gt 0) then 
	                <ns0:Title>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:NamePrefix) }</ns0:Title>
	            else
	            	""
	            }
	            {
                if (fn:string-length(data($AMA_create/ns1:Profile/ns1:Customer/ns1:Telephone[@PhoneLocationType="6"]/@PhoneNumber)) gt 0) then
	                <ns0:WorkPhone>{ data($AMA_create/ns1:Profile/ns1:Customer/ns1:Telephone[@PhoneLocationType="6"]/@PhoneNumber) }</ns0:WorkPhone>
	            else
	            	""
	            }
            </ns0:ListOfAyContactServicesIo>
};

declare variable $AMA_create as element(ns1:AMA_ProfileCreateRQ) external;
xf:Req_Insert_salesforce($AMA_create)
