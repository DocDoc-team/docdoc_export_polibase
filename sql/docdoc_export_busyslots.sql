select VIS_NO as "visit_id", VIS_DOC_NO as "doctor_id",
  to_char(VIS_DATE_PS, 'DD.MM.YYYY HH24:MI') as "start",
  to_char(VIS_DATE_PF, 'DD.MM.YYYY HH24:MI') as "end",
  VIS_DIV_NO as "d_clinic_id", P.PRP_DIV_NO as "clinic_id",
  PDV.DIV_DIV_NO as "d_parent_clinic_id", PPDV.DIV_DIV_NO as "parent_clinic_id"
from VISITS, POSPER P, DIVISIONS PDV, DIVISIONS PPDV
where
(VIS_DIV_NO = PDV.DIV_NO(+))
and (PRP_DIV_NO = PPDV.DIV_NO(+))
and (VIS_DOC_NO = PRP_PER_NO(+))
  and (VIS_VTY_NO = 100)
and (VIS_PMT_NO <> 121)
and ( (VIS_VST_NO <> 102) or (VIS_VST_NO is null) )
and ( (VIS_VST_NO <> 105) or (VIS_VST_NO is null) )
and (VIS_DATE_PS>=CURRENT_DATE)
and (VIS_DATE_PS<=(CURRENT_DATE +30))
order by VIS_DATE_PS;