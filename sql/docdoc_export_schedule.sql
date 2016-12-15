-- расписание врачей
select
  R.RCP_NO as "reception_id",
  R.RCP_DOC_NO as "doctor_id",
  to_char(RCP_STA, 'DD.MM.YYYY HH24:MI') as "start",
  to_char(RCP_FIN, 'DD.MM.YYYY HH24:MI') as "end",
  PRP_VIS_TIME as "duration",
  PRP_DIV_NO as "clinic_id",
  DV.DIV_DIV_NO as "parent_clinic_id"
from RECEPTIONS R, POSPER, DIVISIONS DV
where
-- подтягиваем связь посредник для определения филиала
  (RCP_PRP_NO = PRP_NO(+))
  and (PRP_DIV_NO = DV.DIV_NO(+))
-- фильтруем по времени начала приема
  and (RCP_STA>=CURRENT_DATE)
  and (RCP_STA<=(CURRENT_DATE +30))
order by RCP_DOC_NO