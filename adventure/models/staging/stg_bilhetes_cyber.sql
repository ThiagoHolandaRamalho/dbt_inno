

with bilhetes as (

    select
     
    id_apolice = f.id 
    ,f.* 
    ,att = getdate()
     
     from {{source('innoveo','bilhetes_cyber')}} f
     where id <= 30
)

select * from bilhetes