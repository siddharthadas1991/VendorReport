@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED 
@EndUserText.label: 'Z_FINAL_RPT'
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity Z_FINAL_RPT as
select from I_PurchaseRequisitionItemAPI01 as A
left outer join I_GoodsMovementCube as K on K.PurchaseOrder=A.PurchasingDocument and A.Material=K.Material
{
    K.PurchaseOrder,
    A.PurchasingDocument,
    A.Material,
    K.Material as M2
}
where
A.Material = 'ROH27'
