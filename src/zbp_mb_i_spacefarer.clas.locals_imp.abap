CLASS lhc_ZMB_I_SPACEFARER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmb_i_spacefarer RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zmb_i_spacefarer RESULT result.
    METHODS validate_skill_reputation FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmb_i_spacefarer~validate_skill_reputation.
    METHODS validate_delete FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmb_i_spacefarer~validate_delete.

ENDCLASS.

CLASS lhc_ZMB_I_SPACEFARER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validate_skill_reputation.
  READ ENTITIES OF zmb_i_spacefarer IN LOCAL MODE
    ENTITY zmb_i_spacefarer
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(spacefarers).

  LOOP AT spacefarers INTO DATA(spacefarer).

    IF spacefarer-navigation_skill + spacefarer-reputation >= 99.

      APPEND VALUE #(
        %tky = spacefarer-%tky
      ) TO failed-zmb_i_spacefarer.

      APPEND VALUE #(
        %tky = spacefarer-%tky
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Navigation Skill + Reputation must be below 99'
        )
      ) TO reported-zmb_i_spacefarer.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

METHOD validate_delete.

  READ ENTITIES OF zmb_i_spacefarer IN LOCAL MODE
    ENTITY zmb_i_spacefarer
    FIELDS ( spacefarer_id )
    WITH CORRESPONDING #( keys )
    RESULT DATA(spacefarers).

  LOOP AT spacefarers INTO DATA(spacefarer).

    SELECT SINGLE collection_id
      FROM zmb_t_scoll
      WHERE spacefarer_id = @spacefarer-spacefarer_id
      INTO @DATA(lv_collection).

    IF sy-subrc = 0.

      APPEND VALUE #(
        %tky = spacefarer-%tky
      ) TO failed-zmb_i_spacefarer.

      APPEND VALUE #(
        %tky = spacefarer-%tky
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Spacefarer cannot be deleted while owning a Stardust Collection'
        )
      ) TO reported-zmb_i_spacefarer.

    ENDIF.

  ENDLOOP.

ENDMETHOD.

ENDCLASS.
