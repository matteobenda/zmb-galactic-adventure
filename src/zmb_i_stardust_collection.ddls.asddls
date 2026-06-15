@AbapCatalog.sqlViewName: 'ZMB_I_STARDUSTC'
@EndUserText.label : 'Stardust Collection'
@AbapCatalog.dataMaintenance : #RESTRICTED
define view ZMB_I_STARDUST_COLLECTION
  as select from zmb_t_scoll
{
  key collection_id,
      spacefarer_id,
      collection_name
}
