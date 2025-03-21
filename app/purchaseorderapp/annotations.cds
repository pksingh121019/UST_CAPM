using CatalougeService as service from '../../srv/catalougeService';

annotate service.POs with @(
    Common.DefaultValuesFunction : 'getOrderDefaults',
   UI.SelectionFields:[
            PO_ID,
            PARTNER_GUID.COMPANY_NAME,
            GROSS_AMOUNT,
            OVERALL_STATUS
   ],

   UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },{
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalougeService.boost' ,
            Label : 'Boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : colorCode,
        },
        
   ],

   UI.HeaderInfo:{
     TypeName : 'Purchase Order',
     TypeNamePlural : 'PurchaseOrders',
     Title :{Value : PO_ID},
     Description : {Value : PARTNER_GUID.COMPANY_NAME}
        },
//collection facet
    UI.Facets:[
      
        {
            $Type : 'UI.CollectionFacet',
            Label: 'General Information',
//child facet 1
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Order Details',
                    Target : '@UI.Identification', //Add thr target 
                },
 //child facet 2               
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Configuration Details',
                    Target : '@UI.FieldGroup#Spiderman', //Add thr target 
                },
                
            ],
        },
        {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Po Items',
                    Target : 'Items/@UI.LineItem',//link to get the table for PO items
                },

    ],
//Add maultiple fields 
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Label: 'Purchase Order',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
             Label: 'Product Id',
            Value : PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
             Label: 'Status',
            Value : OVERALL_STATUS,
        },
     
    ],
   //Add maultiple fields 
    UI.FieldGroup #Spiderman:{
        Label: 'PO Pricing',
        Data: [
        
           {
               $Type : 'UI.DataField',
               Value : GROSS_AMOUNT,
           }, 
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value :CURRENCY_code ,
            },
        ],
    },

);

annotate service.PoItems with @(
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Label: 'PO Line Item',
            Value :PO_ITEM_POS ,
        },
        {
            $Type : 'UI.DataField',
             Label: 'Product Id',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.CATEGORY,
        },
    ],
    UI.HeaderInfo:{
        TypeName: 'PO Item',
        TypeNamePlural : 'PO Items',
        Title:{Value : PO_ITEM_POS},
        Description:{Value:PRODUCT_GUID.DESCRIPTION},

    },
    UI.Facets:[
        {
            $Type : 'UI.ReferenceFacet',
            Label: 'More Info',
            Target : '@UI.Identification',
        },

    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
             Label: 'PO Line Item',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
             Label: 'Product Id',
            Value : PARENT_KEY_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
         {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
         {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },

    ],
);

//attach the value help 
annotate service.POs with {
    PARTNER_GUID@(
        Common : {
            Text : PARTNER_GUID.COMPANY_NAME,
        },
        ValueList.entity: CatalougeService.BusinessPartnerSet

    );
    OVERALL_STATUS @(
        readonly,
    )
} ;

annotate service.PoItems with {
    PRODUCT_GUID@(
        Common : {
            Text : PRODUCT_GUID.DESCRIPTION,
        },
        ValueList.entity: CatalougeService.ProductSet

    )
} ;

//definition of value help
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
  UI.Identification:[

    {
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    },
  ]
    
);


@cds.odata.valuelist
annotate service.ProductSet with @(
  UI.Identification:[

    {
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    },
  ]
    
);
