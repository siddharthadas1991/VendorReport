@EndUserText.label: 'Vendor Function'
@AccessControl.authorizationCheck:#NOT_REQUIRED
@ClientHandling.type: #CLIENT_INDEPENDENT
define table function Z_VND_FUNC
with parameters 
        clnt:abap.clnt
returns
{
  MANDT    : abap.clnt;
  ROW_NUM   : abap.char( 2 );
  DEBIT   : abap.dec( 17, 2 );
  CREDIT   : abap.dec( 17, 2 );
}
implemented by method
  zcl_vnd_rpt=>Get_Data;
 