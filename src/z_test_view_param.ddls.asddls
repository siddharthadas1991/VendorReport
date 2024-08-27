@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Z_TEST_VIEW_PARAM'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,  
    dataClass: #CUSTOMIZING
}

define view entity Z_TEST_VIEW_PARAM   
as 
select from  I_Product {
        
        key Product
      }
