//@AbapCatalog.sqlViewName: 'ZCDS_JE_V_DT01'
//@AbapCatalog.compiler.compareFilter: true 
//@ClientHandling.type: #CLIENT_DEPENDENT
//@AccessControl.authorizationCheck: #NOT_ALLOWED
//@EndUserText.label: 'ZCDS_JE_REPORT_DATA'
//@Search.searchable : true

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED 
@EndUserText.label: 'ZCDS_JE_REPORT_DATA'
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}



/*
@UI:
{
 headerInfo:
  {
    typeName: 'Booking',
    typeNamePlural: 'Bookings',
    title: { type: #STANDARD, value: 'Booking' }
  }
 }
*/

define view entity ZCDS_JE_V_DT 
as select  from I_GLAccountLineItemSemTag as Booking
inner join I_Supplier as Supp  on Supp.Supplier=Booking.Supplier or Supp.Supplier = Booking.OffsettingAccount 
{ 
        @UI.facet: [
        {
          id:       'Booking',
          purpose:  #STANDARD,
          type:     #IDENTIFICATION_REFERENCE,
          label:    'Booking',
          position: 10 }
                ]
      
      @UI: {
          lineItem: [ { position: 10, importance: #HIGH, label: 'Journal Entry' } ], 
          identification:[ { position: 10, label: 'AccountingDocument' } ]
          }
         @Search.defaultSearchElement: true
  key Booking.AccountingDocument                                as AccountingDocument,
      
      @UI: {
        lineItem: [ { position: 20, importance: #HIGH, label: 'Supplier' } ],
        identification:[ { position: 20, label: 'Supplier' } ],
        selectionField: [ { position: 10 } ]
      }
      @Search.defaultSearchElement: true
    key  (case when Booking.Supplier = '' then Booking.OffsettingAccount else   Booking.Supplier end)  as Supplier,
       
      @UI: {
        lineItem: [ { position: 30, importance: #HIGH, label: 'Supplier Name' } ],
        identification:[ { position: 30, label: 'Supplier Name' } ]
      }
       @Search.defaultSearchElement: true
      key Supp.SupplierFullName                           as SupplierName,
       
      @UI: {
        lineItem: [ { position: 40, importance: #HIGH, label: 'Reference Document' } ],
        identification:[ { position: 40, label: 'Reference Document' } ]
      }
       @Search.defaultSearchElement: true
      key Booking.ReferenceDocument                           as ReferenceDocument,
      
       @UI: {
        lineItem: [ { position: 50, importance: #HIGH, label: 'JE Posting Date' } ],
        identification:[ { position: 50, label: 'JE Posting Date' } ]
      }
      @Search.defaultSearchElement: true
      key Booking.PostingDate                           as PostingJEDate,
       
       @UI: { 
        lineItem: [ { position: 60, importance: #HIGH, label: 'JE DocDate' } ],
        identification:[ { position: 60, label: 'JE Doc Date' } ]
      }
      
      key Booking.DocumentDate                           as DocumentJEDate ,
      
      @UI: {
        lineItem: [ { position: 70, importance: #HIGH, label: 'GL A/C' } ],
        identification:[ { position: 70, label: 'GL A/c' } ],
        selectionField: [ { position: 20 } ]
      }
       @Search.defaultSearchElement: true
      key cast(Booking.GLAccount as abap.char(50)) as GL_AC,               
       @UI: {
       lineItem: [ {  position: 80, importance: #HIGH, label: 'Debit' } ],
        identification:[ { qualifier: 'SalesData', position: 80, label: 'Debit' } ]
      }
       @Search.defaultSearchElement: true
      cast(Booking.DebitAmountInTransCrcy as abap.dec( 19, 2 )) as DebitAmount,
      
       @UI: { 
       lineItem: [ { position: 90, importance: #HIGH, label: 'Credit' } ],
        identification:[ { qualifier: 'SalesData', position: 90, label: 'Credit' } ]
      }
      @Search.defaultSearchElement: true
      cast((case when Booking.CreditAmountInTransCrcy <0 then (Booking.CreditAmountInTransCrcy * -1) else Booking.CreditAmountInTransCrcy end ) as abap.dec( 19, 2 )) as CreditAmount
      ,Booking.OffsettingAccount  as OffsetAC
}
where 
    //Booking.AccountingDocument = $parameters.p_JE_no  //'5100000000'
    //Booking.AccountingDocument = '5100000000' and 
    //and
  Booking.Ledger = '0L' and Booking.SourceLedger = '0L'  
  and Booking.SemanticTag='NETRESULT' 
  and Booking.GLAccountHierarchy='1810'
  and Booking.AccountingDocumentCategory <> 'U'
  and Booking.OffsettingAccount <> Booking.Supplier
  and Booking.Supplier <> ''
  
  and 
  (Booking.AccountingDocumentType = 'KA'
  or Booking.AccountingDocumentType = 'KG'
  or Booking.AccountingDocumentType = 'KN'
  or Booking.AccountingDocumentType = 'KR'
  or Booking.AccountingDocumentType = 'KZ'
  or Booking.AccountingDocumentType = 'RA'
  or Booking.AccountingDocumentType = 'RE'
  or Booking.AccountingDocumentType = 'RK'
  or Booking.AccountingDocumentType = 'RN'
  or Booking.AccountingDocumentType = 'SJ'
  or Booking.AccountingDocumentType = 'SK'
  or Booking.AccountingDocumentType = 'ZP'
  or Booking.AccountingDocumentType = 'ZR'
  or Booking.AccountingDocumentType = 'ZZ')
  

