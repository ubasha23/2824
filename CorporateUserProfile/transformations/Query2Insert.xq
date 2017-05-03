xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$params" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:AMA_ProfileCreateRQ" location="../../PortalInterfaces/schema/AMA_ProfileCreateRQ.xsd" ::)

declare namespace xf = "http://tempuri.org/CorporateUserProfile/transformations/Query2Insert/";
declare namespace com = "http://com.finnair";

declare function xf:Query2Insert($params as element(*))
    as element(com:AMA_ProfileCreateRQ) {
<com:AMA_ProfileCreateRQ Version="1.0" xmlns:com="http://com.finnair">
    <com:UniqueID Type="21" Instance="1" ID="{ data( $params/param[@name="fplusNumber"]/@value) }" ID_Context="LOYALTYNUMBER"/>
    <com:ExternalID Type="21" Instance="1" ID="{ data( $params/param[@name="upClientId"]/@value) }" ID_Context="AY_Company_Key"/>
    <com:Profile>
        <com:Customer BirthDate="{ data( $params/param[@name="birthdate"]/@value) }">
            <com:PersonName>
                <com:NamePrefix>{ data( $params/param[@name="title"]/@value) }</com:NamePrefix>
                <com:GivenName>{ data( $params/param[@name="firstname"]/@value) }</com:GivenName>
                <com:Surname>{ data( $params/param[@name="lastname"]/@value) }</com:Surname>
            </com:PersonName>
            <com:Telephone PhoneLocationType="6" PhoneTechType="1" PhoneNumber="{ data( $params/param[@name="workPhoneNumber"]/@value) }"/>
            <com:Telephone PhoneLocationType="8" PhoneTechType="5" PhoneNumber="{ data( $params/param[@name="mobileNumber"]/@value) }"/>
            <com:Email>{ data( $params/param[@name="upEmail"]/@value) }</com:Email>
            <com:CitizenCountryName Code="{ data( $params/param[@name="nationality"]/@value) }"/>
            <com:Document DocID="{ data( $params/param[@name="passportNumber"]/@value) }" EffectiveDate="{ data( $params/param[@name="issued"]/@value) }" ExpireDate="{ data( $params/param[@name="expires"]/@value) }" />
            <com:EmployeeInfo EmployeeTitle="{ data( $params/param[@name="jobTitle"]/@value) }"/>
        </com:Customer>
        <com:PrefCollections>
            <com:PrefCollection>
                <com:AirlinePref>
                    <com:CabinPref Cabin="{ data( $params/param[@name="travelingClass"]/@value) }"/>
                </com:AirlinePref>
            </com:PrefCollection>
        </com:PrefCollections>
        <com:Agreements>
            <com:OwnerRights RoleId="{ data( $params/param[@name="role"]/@value) }"/>
        </com:Agreements>
        <com:CustomFields>
        	<com:CustomField KeyValue="10">
        	{ if (data($params/param[@name="allowEmails"]/@value) eq "true") then
        		"true"
        	else
        		"false"
        	}
        	</com:CustomField>
        </com:CustomFields>
    </com:Profile>
</com:AMA_ProfileCreateRQ>
};

declare variable $params as element(*) external;

xf:Query2Insert($params)
