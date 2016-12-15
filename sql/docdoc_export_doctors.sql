-- врачи
select PER_NO as "doctor_id", PER_FULL_NAME as "name",
  DV.DIV_NO as "clinic_id",
  DV.DIV_DIV_NO as "parent_clinic_id"
from PERSONS, POSPER, DIVISIONS DV
where
-- выбираем записи только по персоналу
 (PER_STAFF='Staff')
-- и с привязкой к филиалу
  and (PRP_DIV_NO = DIV_NO)
  and (PER_NO = PRP_PER_NO(+))
-- исключаем из выборки системные записи
  and (PER_NO > 10)
order by PER_NO