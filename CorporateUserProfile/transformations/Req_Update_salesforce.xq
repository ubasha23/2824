(:: pragma bea:local-element-parameter parameter="$update" type="ns2:corporateUserProfileUpdate/ns2:request/ns0:ListOfAyContactServicesIo" location="../../SalesForce/wsdl/PortalServices.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$AMA_update" element="ns1:AMA_UpdateRQ" location="../../PortalInterfaces/schema/AMA_UpdateRQ.xsd" ::)
(:: pragma bea:local-element-return type="ns2:corporateUserProfileUpdate/ns2:request/ns0:ListOfAyContactServicesIo" location="../../SalesForce/wsdl/PortalServices.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/PortalServicesUserProfile";
declare namespace ns1 = "http://com.finnair";
declare namespace ns2 = "http://soap.sforce.com/schemas/class/PortalServices";
declare namespace xf = "http://tempuri.org/CorporateUserProfile/transformations/Req_Update_salesforce/";

declare function xf:Req_Update_salesforce($update as element(),
    $AMA_update as element(ns1:AMA_UpdateRQ))
    as element() {
        <ns0:ListOfAyContactServicesIo>
        		<ns0:AYCustomerNumber>{ data($update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:AYCustomerNumber) }</ns0:AYCustomerNumber>
        		<ns0:CellularPhone>{ data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Telephone[@PhoneLocationType="8"]/@PhoneNumber) }</ns0:CellularPhone>
        		<ns0:ContactId>{ data($update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:ContactId) }</ns0:ContactId>
        		<ns0:CorpUsername>{ data($update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:CorpUsername) }</ns0:CorpUsername>
        		<ns0:DateOfBirth>
                            {
                                if (fn:string-length($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/@BirthDate) > 0) then
                                    let $tokens  := fn:tokenize($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/@BirthDate, "-")  
                                    return fn:concat($tokens[2], "/", $tokens[3], "/", $tokens[1])
                                else 
                                    ()
                            }
               </ns0:DateOfBirth>
        	   <ns0:EmailAddress>{ data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Email) }</ns0:EmailAddress>	
        	   {
               		for $GivenName in $AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:GivenName
                    return
                    	<ns0:FirstName>{ data($GivenName) }</ns0:FirstName>
               }	
        	   {
                	for $EmployeeTitle in $AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:EmployeeInfo/@EmployeeTitle
                    return
                    <ns0:JobTitle>{ data($EmployeeTitle) }</ns0:JobTitle>
                }	
        		<ns0:LastName>{ data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:Surname) }</ns0:LastName>
        		<ns0:ListOfContact_Account>
        		       {
                      	for $AccountType in $update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:ListOfContact_Account[1]/ns0:AccountType
                        return
                            <ns0:AccountType>{ data($AccountType) }</ns0:AccountType>
                       }
                       {
                        for $AccountTypeCode in $update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:ListOfContact_Account[1]/ns0:AccountTypeCode
                        return
                        	<ns0:AccountTypeCode>{ data($AccountTypeCode) }</ns0:AccountTypeCode>
                       }
                       {
                      	for $AYCustomerNumber in $update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:ListOfContact_Account[1]/ns0:AYCustomerNumber
                        return
                        	<ns0:AYCustomerNumber>{ data($AYCustomerNumber) }</ns0:AYCustomerNumber>
                       }
                 </ns0:ListOfContact_Account>
                  <ns0:ListOfLoyTravelProfile>
                     <ns0:BusClassAllowed>
                                    {
                                        if (data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:PrefCollections/ns1:PrefCollection[1]/ns1:AirlinePref/ns1:CabinPref[1]/@Cabin) = "Business") then
                                            ("Y")
                                        else 
                                            "N"
                                    }
                      </ns0:BusClassAllowed> 
                      <ns0:FinnairPlusNumber>{ data($AMA_update/ns1:UniqueID[@ID_Context="LOYALTYNUMBER"]/@ID) }</ns0:FinnairPlusNumber>
                      {
                                    for $ParentContactId in $update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:ListOfLoyTravelProfile[1]/ns0:ParentContactId
                                    return
                                        <ns0:ParentContactId>{ data($ParentContactId) }</ns0:ParentContactId>
                      }
                      <ns0:PassportExpirationDate>
	                            {
	                                if (fn:string-length($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Document[1]/@ExpireDate) > 0) then
	                                    let $tokens  := fn:tokenize($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Document[1]/@ExpireDate, "-")  
	                                    return fn:concat($tokens[2], "/", $tokens[3], "/", $tokens[1])
	                                else 
	                                    ()
	                            }
                      </ns0:PassportExpirationDate>
                     <ns0:PassportIssueDate>
	                            {
	                                if (fn:string-length($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Document[1]/@EffectiveDate) > 0) then
	                                    let $tokens  := fn:tokenize($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Document[1]/@EffectiveDate, "-")  
	                                    return fn:concat($tokens[2], "/", $tokens[3], "/", $tokens[1])
	                                else 
	                                    ()
	                            }
                      </ns0:PassportIssueDate>       
                      {
                                    for $DocID in $AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Document[1]/@DocID
                                    return
                                        <ns0:PassportNumber>{ data($DocID) }</ns0:PassportNumber>
                       }      
                       {
                                    for $TravelProfileId in $update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:ListOfLoyTravelProfile[1]/ns0:TravelProfileId
                                    return
                                        <ns0:TravelProfileId>{ data($TravelProfileId) }</ns0:TravelProfileId>
                       }     
                 </ns0:ListOfLoyTravelProfile>       
                 {
                            for $Code in $AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:CitizenCountryName[1]/@Code
                            return
                                <ns0:Nationality>{ data($Code) }</ns0:Nationality>
                 }       
                 {
                            for $OnlineAccess in $update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:OnlineAccess
                            return
                                <ns0:OnlineAccess>{ data($OnlineAccess) }</ns0:OnlineAccess>
                 }       
                 <ns0:Role>
                            {
                                if (data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Agreements/ns1:OwnerRights[1]/@RoleId) = "A") then
                                    ("Admin")
                                else 
                                    "Traveler"
                            }
                 </ns0:Role>       
        		<ns0:Status>{ data($update/ns2:result/ns0:ListOfAyContactServicesIo/ns0:Status) }</ns0:Status>
        		<ns0:SuppressAllEmails>{
		               	if (data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:CustomFields/ns1:CustomField[@KeyValue="10"]) = "false") then
		               		"Y"
		               	else
		               		"N"
		               	}
		         </ns0:SuppressAllEmails>
        		{
                            let $result :=
                                for $NamePrefix in $AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:PersonName[1]/ns1:NamePrefix
                                return
                                    <ns0:Title>{ data($NamePrefix) }</ns0:Title>
                            return
                                $result[1]
                 }
 				 <ns0:WorkPhone>{ data($AMA_update/ns1:Position/ns1:Root/ns1:Profile/ns1:Customer/ns1:Telephone[@PhoneLocationType="6"]/@PhoneNumber) }</ns0:WorkPhone>
          </ns0:ListOfAyContactServicesIo>
                        
};

declare variable $update as element() external;
declare variable $AMA_update as element(ns1:AMA_UpdateRQ) external;

xf:Req_Update_salesforce($update,
    $AMA_update)
