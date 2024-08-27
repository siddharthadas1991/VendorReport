@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Z_CLOSING'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_CLOSING 
with parameters p_FPD_dt: z_fpd_dt ,p_Supplier: z_supplier
as select from ZCDS_JE_V_DT as A
{   
    A.Supplier as Supplier,
    sum((A.DebitAmount) - (A.CreditAmount)) as Closing
}
where A.PostingJEDate <= $parameters.p_FPD_dt  and A.Supplier = $parameters.p_Supplier
group by A.Supplier
