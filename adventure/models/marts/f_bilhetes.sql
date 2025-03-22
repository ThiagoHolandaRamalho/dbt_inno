{{
    config(
        materialized='incremental'
        ,on_schema_change = 'fail'
        ,unique_key = 'uuid'
        ,full_refresh =  false
    )
}}
--,pre_hook="SET IDENTITY_INSERT [innoveo].[gold].[f_bilhetes] ON;"
--,post_hook="SET IDENTITY_INSERT [innoveo].[gold].[f_bilhetes] OFF;"

select * from {{ref("stg_bilhetes_cyber")}}


{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
where id_apolice >= (select coalesce(max(id_apolice),0) from {{ this }} )

{% endif %}