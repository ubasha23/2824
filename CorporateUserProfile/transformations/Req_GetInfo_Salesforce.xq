(:: pragma bea:global-element-parameter parameter="$request" element="ns1:AMA_ProfileReadRQ" location="../../PortalInterfaces/schema/AMA_ProfileReadRQ.xsd" ::)
(:: pragma bea:global-element-return element="por1:ListOfAyContactServicesIo" location="../../SalesForce/wsdl/PortalServices.wsdl" ::)
(:: pragma bea:global-element-return element="por:corporateUserQuery" location="../../SalesForce/wsdl/PortalServices.wsdl" ::)

declare namespace ns1 = "http://com.finnair";
declare namespace por="http://soap.sforce.com/schemas/class/PortalServices";
declare namespace por1="http://soap.sforce.com/schemas/class/PortalServicesUserProfile";
declare namespace xf = "http://tempuri.org/CorporateUserProfile/transformations/Req_GetInfo/";

declare function xf:Req_GetInfo_Salesforce($request as element(ns1:AMA_ProfileReadRQ))
    as element(por:corporateUserQuery) {
    <por:corporateUserQuery>
         <por:request>
         <por1:ListOfAyContactServicesIo >
		    		 <por1:ListOfContact_Account>
		    		 {
                        	if (fn:string-length(data($request/ns1:ExternalID[1]/@ID)) gt 0) then
                            	<por1:AYCustomerNumber>{data($request/ns1:ExternalID[1]/@ID)}</por1:AYCustomerNumber>
                        	else 
                            	()
                    	}	
		   			 </por1:ListOfContact_Account>
                    {
                        if (data($request/ns1:UniqueID[1]/@ID_Context) = "Username") then
                            <por1:CorpUsername>{data($request/ns1:UniqueID[1]/@ID)}</por1:CorpUsername>
                        else 
                            ()
                    }
                   
                    	{
                        if (data($request/ns1:UniqueID[1]/@ID_Context) = "LOYALTYNUMBER") then
                            <por1:ContactId>{ data($request/ns1:UniqueID[1]/@ID) }</por1:ContactId>
                        else 
                            ()
                        }
                    
                    <por1:ListOfLoyTravelProfile/>
		      
	       </por1:ListOfAyContactServicesIo>
         </por:request>
      </por:corporateUserQuery>
       
};

declare variable $request as element(ns1:AMA_ProfileReadRQ) external;

xf:Req_GetInfo_Salesforce($request)
