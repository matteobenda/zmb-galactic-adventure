@AbapCatalog.sqlViewName: 'ZMB_T_WEALTH'
@EndUserText.label : 'Stardust wealth'
@AbapCatalog.dataMaintenance : #RESTRICTED
define view ZMB_WEALTH
  as select from zmb_t_sfarer
{
  key spacefarer_id,
      name,
      credits
}
