xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$profiles" element="ns0:AMA_ProfileReadRS" location="../../PortalInterfaces/schema/AMA_ProfileReadRS.xsd" ::)

declare namespace xf = "http://tempuri.org/CorporateUserProfile/transformations/Profiles2JSON/";
declare namespace ns0 = "http://com.finnair";

declare function xf:Profiles2JSON($profiles as element(ns0:AMA_ProfileReadRS))
    as xs:string {
    concat('{ "profiles" : [', 
	for $profile in $profiles/ns0:Profiles/ns0:ProfileInfo
		return concat('{ "userId" : "', $profile/ns0:Profile/ns0:UserID[@Type='4']/@ID,'", ',
			'"clientId" : "', $profile/ns0:ExternalID[@ID_Context='AY_Company_Key']/@ID, '", ',
			'"firstname" : "', $profile/ns0:Profile/ns0:Customer/ns0:PersonName/ns0:GivenName/text(), '", ',
			'"lastname" : "', $profile/ns0:Profile/ns0:Customer/ns0:PersonName/ns0:Surname/text(), '", ',
			'"email" : "', $profile/ns0:Profile/ns0:Customer/ns0:Email/text(), '", ',
			'"siebelId" : "', $profile/ns0:Profile/ns0:UserID[@Type='18']/@ID, '", ',
			'"travelClass" : "', $profile/ns0:Profile/ns0:PrefCollections/ns0:PrefCollection[1]/ns0:AirlinePref/ns0:CabinPref/@Cabin, '", ',
			'"role" : "', $profile/ns0:Profile/ns0:Agreements/ns0:OwnerRights/@RoleId, '", ',	
			'"onlineAccess" : "', if ($profile/ns0:Profile/@Status eq "A") then "Y" else "N", '", ',
			'"title" : "', $profile/ns0:Profile/ns0:Customer/ns0:PersonName/ns0:NamePrefix/text(), '", ',
			'"finnairPlus" : "', $profile/ns0:UniqueID[@ID_Context='LOYALTYNUMBER']/@ID, '", ',
			'"workPhone" : "', $profile/ns0:Profile/ns0:Customer/ns0:Telephone[@PhoneLocationType='6']/@PhoneNumber, '", ',			
			'"mobile" : "', $profile/ns0:Profile/ns0:Customer/ns0:Telephone[@PhoneLocationType='8']/@PhoneNumber, '", ',
			'"jobTitle" : "', $profile/ns0:Profile/ns0:Customer/ns0:EmployeeInfo/@EmployeeTitle, '", ',
			'"nationality" : "', $profile/ns0:Profile/ns0:Customer/ns0:CitizenCountryName/@Code, '", ',
			'"passportNumber" : "', $profile/ns0:Profile/ns0:Customer/ns0:Document/@DocID, '", ',
			'"issued" : "', $profile/ns0:Profile/ns0:Customer/ns0:Document/@EffectiveDate, '", ',
			'"expires" : "', $profile/ns0:Profile/ns0:Customer/ns0:Document/@ExpireDate, '", ',
			'"birthdate" : "', $profile/ns0:Profile/ns0:Customer/@BirthDate, '", ',
			'"allowEmails" : "', $profile//ns0:CustomField[@KeyValue='10']/text(), '"',
			' }')
    ,']}')
};

declare variable $profiles as element(ns0:AMA_ProfileReadRS) external;

xf:Profiles2JSON($profiles)
