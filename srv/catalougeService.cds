using { prashant.db.master,prashant.db.transaction  } from '../db/datamodel';
using { cappo.cds } from '../db/CDSView';


service CatalougeService @(path: 'CatalougeService', requires: 'authenticated-user' ) {
  // readonly is to restrict from new creation of employee
  //@readonly
  entity EmployeeSet @(restrict: [ 
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ]) 
  
                      as projection on master.employees;

  //@Capabilities : { Deletable: false }
  //for draft functionality odata.draft.enabled: true
  entity POs @(odata.draft.enabled: true)as projection on transaction.purchaseorder{
    *,
    Items,
    case OVERALL_STATUS
    when 'P' then 'Pending'
    when 'N' then 'New'
    when 'A' then 'Approved'
    when 'X' then 'Rejected'
    end as OverallStatus : String(10),
    case OVERALL_STATUS
    when 'P' then 2
    when 'N' then 2
    when 'A' then 3
    when 'X' then 1
    end as colorCode : Integer,
 }
   
    
  //instance bound function
  actions{

 // below code is example of sideeffect in capm 
 //basically the gross amount will get addedd by 20k on each click on boost button--
      @Common.SideEffects : {

          TargetProperties : [
            'in/GROSS_AMOUNT',
          ]
        }
//end of side effect code

       action boost() returns POs
  };
  //non instance bound function
  function largestOrder() returns array of  POs;
  function getOrderDefaults() returns POs;
  entity PoItems as projection on transaction.poitems;
  entity ProductSet as projection on master.product;
  entity BusinessPartnerSet as projection on master.businesspartner;
  entity BusinessAddressSet as projection on master.address;
 
  //entity OrderItems as projection on cds.CDSViews.ItemView;
  //entity Products as projection on cds.CDSViews.ProductView;

}