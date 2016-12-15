select DIV_NO as "clinic_id", DIV_NAME as "name" FROM DIVISIONS
where
(DIV_ON_OFF = 0 OR DIV_ON_OFF IS NULL)
and DIV_DIV_NO = 0;