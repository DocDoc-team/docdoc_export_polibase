-- филиалы
select "clinic_id;name"

select DIV_NO as "clinic_id", DIV_NAME as "name" FROM DIVISIONS
where
-- включен или нет отметки об этом, фактически в самом
-- POLYBASE нет возможности менять это значние и оно ни как не влияеет на его работу
(DIV_ON_OFF = 0 OR DIV_ON_OFF IS NULL)
-- забираем только головные подразделения, которые и считаем филиалами
and DIV_DIV_NO = 0