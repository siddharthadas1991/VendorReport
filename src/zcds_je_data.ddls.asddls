@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '${ddl_source_description}'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
 }
 
 
define view entity ZCDS_JE_DATA 
as select distinct from I_GLAccountLineItemSemTag as Booking
{   
   Booking.OffsettingAccount,
   Booking.Supplier,
   Booking.AccountingDocumentType
    
    
}
where 
    //Booking.AccountingDocument = $parameters.p_JE_no  //'5100000000'
    //Booking.AccountingDocument = '5100000000' and 
    //and
    //Booking.AccountingDocument = '5000000000' and 
  Booking.Ledger = '0L' and Booking.SourceLedger = '0L'  
  and Booking.SemanticTag='NETRESULT' 
  and Booking.GLAccountHierarchy='1810'
  and Booking.AccountingDocumentCategory <> 'U'

 