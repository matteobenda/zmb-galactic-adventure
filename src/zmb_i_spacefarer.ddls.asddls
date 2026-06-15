@EndUserText.label : 'Spacefarer Root Entity'
@AbapCatalog.dataMaintenance : #RESTRICTED

define root view entity ZMB_I_SPACEFARER
  as select from zmb_t_sfarer
{
  key spacefarer_id,
      name,
      navigation_skill,
      reputation,
      origin_planet,
      spacesuit_color,
      credits
}
