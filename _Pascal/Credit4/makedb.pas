unit MakeDB;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ADODB {$IFDEF webClock}, UserSessionUnit{$ENDIF};


type
  TNewField = record
    fieldName : string;
    fieldType : TFieldType;
    fieldSize : Smallint;
  end;
  TNewIndex = record
    indexName : string;
    fieldName : string;
    idxOption    : TIndexOptions;
  end;
//  arrayfield = array of TNewField ;
//  arrayindex = array of TNewIndex ;

////////////////////Structure Of Rules Table////////////////////////////
const rulesIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const rulesTbl : array [0..152] of TNewField =
(
  (fieldName : 'Rule_Code' ; fieldType : ftSmallint ; fieldSize : 0),
  (fieldName : 'Rule_Name' ; fieldType : ftString ; fieldSize : 20  ),
  (fieldName : 'Rule_EMojavvez' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_EMojavvezafter' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_emojazday' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMinG' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMinB' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMAXG' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMAxB' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMAXA' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMAxT' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMaxM' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMaxTM' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EFix' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZA' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZATime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZA1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZT' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZTTime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZT1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZG' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZGTime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZG1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZR' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZRTime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZR1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZshab' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZshabTime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZshab1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZshabt' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZshabtTime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EZshabt1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMSHR' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMSHRt' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMDay' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMDayt' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_etk' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ehd' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Eba' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_egm' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_e28fullmomtad' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_emzero' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_EMa' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_EZMa' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_EMo' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_EZMo' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_edkeshik' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_enoworkday' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_enoworkkasr' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_eghabl1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_eghabl2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ebaad1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ebaad2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ebaad11' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ebaad12' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ebaad21' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ebaad22' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_egkl' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_egknahar' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_egtlimit' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_egfrom' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_egto' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMT1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMT2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMB' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMT1m' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMT2m' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMBm' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMaxD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GMaxM' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ggmezmanfi' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GPAS' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GZPAS' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GSLimit' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gtajilLimit' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gmorbigh' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gafvm' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gafvlimit' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_gjanbaz' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gjanbazEmor' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_gddouble' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GTMM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GTSM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GKBH' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GKBM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GTF1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTE1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTP1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTF2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTE2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTP2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTF3' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTE3' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GTP3' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gsmt1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gsmp1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gsmt2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gsmp2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gsmp3' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GZHD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GEBEIN' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_gslastm' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Gttm' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Gttmj' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_gNaghes' ; fieldType : ftSmallint ; fieldSize : 0  ),  
  (fieldName : 'Rule_GD' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GBD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GKD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GRZHD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MAHR' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_mamax' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MAkar' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Makarna' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MARMTM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MASHRMTM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MARMRM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MASHRMRM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MARMGM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MASHRMGM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MAGE' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MAms1' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MAsg' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MAsn' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_manowbat' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_manokez' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MArshgs' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_mamojavvez' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_mamtomor' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MAD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MAB1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MAK1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MARHR' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MAdFixh' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Script1' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script2' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script3' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script4' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script5' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script6' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script7' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script8' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script9' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script10' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script11' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script12' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script13' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script14' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script15' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script16' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script17' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script18' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script19' ; fieldType : ftString ; fieldSize : 255  ),
  (fieldName : 'Rule_Script20' ; fieldType : ftString ; fieldSize : 255  )
  );


////////////////////Structure Of Rulesetc Table////////////////////////////
const rulesetcIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const rulesetcTbl : array [0..145] of TNewField =
(
  (fieldName : 'Rule_Code' ; fieldType : ftSmallint ; fieldSize : 0),
  (fieldName : 'Rule_MOHR' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOEY' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOafv' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOafvlimit' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOhd' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOhdg' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOesl' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOesyl' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moesmin' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOesn' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOepl' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOeal' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOsy' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOsm' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeneg' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOeb' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOebs' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOTalab' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOKAR' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOKARNA' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOH' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOB1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOK1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MORHR' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_MOMTM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOMRM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOMGM' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOMTMs' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOMRMs' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_MOMGMs' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_monowrooz' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_morgkok' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_morsbiok' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_mobislastm' ; fieldType : ftBoolean ; fieldSize : 0  ),  
  (fieldName : 'Rule_MOMs1' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_mout' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_monowbat' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_moezcode' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moezkasr' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_morbies' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moghes' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_momojavvez' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_moeylist' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd3' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd4' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd5' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd6' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd7' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd8' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd9' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd10' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd11' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyd12' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh1' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh2' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh3' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh4' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh5' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh6' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh7' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh8' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh9' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh10' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh11' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_moeyh12' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_DTKAR' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_DGKAR' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_DRKAR' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_KarD' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_KarB1' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_KarK1' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_KarT' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_KarR' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_KarSaati' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Karlazem' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_KarPerday' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_KarPercent' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_KarPGroup' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_KarSaat' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_IsRound' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_RoundTime' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_RoundType' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_IsRoundCalc' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_RoundTimeCalc' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_RoundTypeCalc' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_IsRoundmonth' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_RoundTimemonth' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_RoundTypemonth' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_GHMH' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GDMD' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_ghmhm' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_GKar' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_outinworkmax' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_T1E2D' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_T2E1D' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_T1e2b' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_EzJomehEMor' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_EztnoJomehEMor' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_gdez' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_mojerror' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_TED' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_T1E2M' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_takhirmo' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_tajilmo' ; fieldType : ftSmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_InCard' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_OutCard' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_addyignore' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_NoHand' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Zahab' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Zahabt' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Zahabm' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Zahabtrd' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_ghaza' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_ghazat' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_ghazam' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_Ghazatrd' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_In1_Out2' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_In1_Out2_28' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_outinwork' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_mghez' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_StartDay' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_StartNight' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Night' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Shrmarz' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Shrfix' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_cbtatil' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_NaharFrom' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_NaharTo' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_NaharLimit' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_SahariFrom' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_SahariTo' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_SobhanehFrom' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_SobhanehTo' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_nahar1From' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_nahar1To' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ShamFrom' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_ShamTo' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_Fridaylimit' ; fieldType : ftsmallint ; fieldSize : 0  ),
  (fieldName : 'Rule_fridaybashift' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_fridaybishift' ; fieldType : ftBoolean ; fieldSize : 0  ),
  (fieldName : 'Rule_sprulefdate' ; fieldType : ftstring ; fieldSize : 10  ),
  (fieldName : 'Rule_spruleedate' ; fieldType : ftstring ; fieldSize : 10  ),
  (fieldName : 'Rule_sprule' ; fieldType : ftsmallint ; fieldSize : 0  )
);


////////////////////Structure Of Persons Table////////////////////////////
const personsIdx : array [0..2] of TNewIndex =
(
  (indexName : ''        ; fieldName : 'P_BarCode , P_Proxi'; idxOption : [ixPrimary]),
  (indexName : 'BCodeIdx'; fieldName : 'P_BarCode'; idxOption : [ixUnique]),
  (indexName : 'ProxiIdx'; fieldName : 'P_Proxi'  ; idxOption : [ixUnique])
);

const personsTbl : array [0..60] of TNewField =
(
   (fieldName : 'P_BarCode'     ; fieldType : ftString    ; fieldSize : 8  ),
   (fieldName : 'P_Proxi'       ; fieldType : ftString    ; fieldSize : 8  ),
   (fieldName : 'P_Estekhdami'  ; fieldType : ftString    ; fieldSize : 12 ),
   (fieldName : 'P_Name'        ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_Family'      ; fieldType : ftString    ; fieldSize : 25 ),
   (fieldName : 'P_Father'      ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_IDNo'        ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_MeliCode'    ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_FromPlace'   ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_BirthDate'   ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_BirthPlace'  ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_Madrak'      ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_Curse'       ; fieldType : ftString    ; fieldSize : 30 ),
   (fieldName : 'P_Sex'         ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Marry'       ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Military'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Address'     ; fieldType : ftString    ; fieldSize : 80 ),
   (fieldName : 'P_Tel'         ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_Domain'      ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_ADUserName'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Picture'     ; fieldType : ftString    ; fieldSize : 255),
   (fieldName : 'P_Part1'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Part2'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Part3'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Part4'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Parts'       ; fieldType : ftString    ; fieldSize : 255),
   (fieldName : 'P_JobCode'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_CoPosts'     ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Station'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_JobDate'     ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_EndJobDate'  ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_ShiftGroup'  ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_RuleGroup'   ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_ShiftGroupM' ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Vaz'         ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_Reserve1'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve2'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve3'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve4'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve5'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve6'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_reserve7'    ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_reserve8'    ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_IsValid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_ValidTest'   ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Pricable'    ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_PrePaid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Credit'      ; fieldType : ftCurrency  ; fieldSize : 0  ),
   (fieldName : 'P_Sobhaneh'    ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Nahar'       ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Sham'        ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Rejim'       ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_IsGuest'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Special'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_ManyFish'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_EtebarFish'  ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_dblFoodMax'  ; fieldType : ftSmallInt  ; fieldSize : 10 ),
   (fieldName : 'P_DblFood'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_CashType'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_DeserNoFood' ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Building'    ; fieldType : ftSmallInt  ; fieldSize : 0  )
);


////////////////////Structure Of tmpPersons Table////////////////////////////
const TmpPersonsIdx : array [0..0] of TNewIndex =
(
  (indexName : 'BCodeIdx'   ; fieldName : 'P_BarCode'; idxOption : [ixPrimary])
);

const TmpPersonsTbl : array [0..45] of TNewField =
(
   (fieldName : 'P_BarCode'     ; fieldType : ftString    ; fieldSize : 8  ),
   (fieldName : 'P_Proxi'       ; fieldType : ftString    ; fieldSize : 8  ),
   (fieldName : 'P_Estekhdami'  ; fieldType : ftString    ; fieldSize : 12 ),
   (fieldName : 'P_Name'        ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_Family'      ; fieldType : ftString    ; fieldSize : 25 ),
   (fieldName : 'P_Father'      ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_IDNo'        ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_MeliCode'    ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_FromPlace'   ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_BirthDate'   ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_BirthPlace'  ; fieldType : ftString    ; fieldSize : 15 ),
   (fieldName : 'P_Madrak'      ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_Curse'       ; fieldType : ftString    ; fieldSize : 30 ),
   (fieldName : 'P_Sex'         ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Marry'       ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Military'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Address'     ; fieldType : ftString    ; fieldSize : 80 ),
   (fieldName : 'P_Tel'         ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_Domain'      ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_ADUserName'    ; fieldType : ftString    ; fieldSize : 50 ),

   (fieldName : 'P_Picture'     ; fieldType : ftString    ; fieldSize : 255),
   (fieldName : 'P_Part1'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Part2'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Part3'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Part4'       ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_Parts'       ; fieldType : ftString    ; fieldSize : 255),
   (fieldName : 'P_JobCode'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_CoPosts'     ; fieldType : ftInteger   ; fieldSize : 0  ),
   (fieldName : 'P_JobDate'     ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_EndJobDate'  ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_ShiftGroup'  ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_RuleGroup'   ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_ShiftGroupM' ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Vaz'         ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_Reserve1'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve2'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve3'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve4'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve5'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_Reserve6'    ; fieldType : ftString    ; fieldSize : 50 ),
   (fieldName : 'P_reserve7'    ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_reserve8'    ; fieldType : ftString    ; fieldSize : 20 ),
   (fieldName : 'P_IsValid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_ChangeType'  ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_ChangeDate'  ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_Done'        ; fieldType : ftBoolean   ; fieldSize : 0  )
);


////////////////////Structure Of City Table////////////////////////////

const cityIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const cityTbl : array [0..0] of TNewField =
(
   (fieldName : 'City_Name' ; fieldType : ftString ; fieldSize : 20 )
);


////////////////////Structure Of Curse Table////////////////////////////

const curseIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const curseTbl : array [0..0] of TNewField =
(
   (fieldName : 'Curse_Name' ; fieldType : ftString ; fieldSize : 20 )
);


////////////////////Structure Of CoPosts Table////////////////////////////
const coPostsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const coPostsTbl : array [0..1] of TNewField =
(
   (fieldName : 'Post_Code' ; fieldType : ftInteger ; fieldSize : 0 ),
   (fieldName : 'Post_Name' ; fieldType : ftString   ; fieldSize : 40 )
);


////////////////////Structure Of JobType Table////////////////////////////
const jobTypeIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const jobTypeTbl : array [0..1] of TNewField =
(
   (fieldName : 'Job_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),  
   (fieldName : 'Job_Name' ; fieldType : ftString   ; fieldSize : 40 )
);

////////////////////Structure Of Parts Table////////////////////////////
const partsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'P_CustomCode'; idxOption : [ixPrimary])
);

const partsTbl : array [0..5] of TNewField =
(
   (fieldName : 'P_Code'      ; fieldType   : ftString   ; fieldSize : 255),
   (fieldName : 'P_CustomCode'; fieldType   : ftString   ; fieldSize : 255),
   (fieldName : 'P_Name'      ; fieldType   : ftString   ; fieldSize : 40 ),
   (fieldName : 'P_LChild'    ; fieldType   : ftString   ; fieldSize : 255),
   (fieldName : 'P_RSibling'  ; fieldType   : ftString   ; fieldSize : 255),
   (fieldName : 'P_Father'    ; fieldType   : ftString   ; fieldSize : 255)
);

////////////////////Structure Of Part1 Table////////////////////////////
const part1Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'P1_Code'; idxOption : [ixPrimary])
);

const part1Tbl : array [0..1] of TNewField =
(
   (fieldName : 'P1_Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P1_Name'  ; fieldType   : ftString    ; fieldSize : 40)
);


////////////////////Structure Of Part2 Table////////////////////////////
const part2Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'P2_P1Code , P2_Code'; idxOption : [ixPrimary])
);

const part2Tbl : array [0..2] of TNewField =
(
   (fieldName : 'P2_P1Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P2_Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P2_Name'  ; fieldType   : ftString    ; fieldSize : 40)
);


////////////////////Structure Of Part3 Table////////////////////////////
const part3Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'P3_P1Code , P3_P2Code , P3_Code'; idxOption : [ixPrimary])
);

const part3Tbl : array [0..3] of TNewField =
(
   (fieldName : 'P3_P1Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P3_P2Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P3_Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P3_Name'  ; fieldType   : ftString    ; fieldSize : 40)
);


////////////////////Structure Of Part4 Table////////////////////////////
const part4Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'P4_P1Code , P4_P2Code , P4_P3Code , P4_Code'; idxOption : [ixPrimary])
);

const part4Tbl : array [0..4] of TNewField =
(
   (fieldName : 'P4_P1Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P4_P2Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P4_P3Code'  ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P4_Code'    ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'P4_Name'    ; fieldType   : ftString    ; fieldSize : 40)
);


////////////////////Structure Of Shifts Table////////////////////////////
const shiftsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const shiftsTbl : array [0..14] of TNewField =
(
   (fieldName : 'SH_Code'    ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_Count'   ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_Name'    ; fieldType   : ftString    ; fieldSize : 20),
   (fieldName : 'SH_From1'   ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_To1'     ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_From2'   ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_To2'     ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_From3'   ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SH_To3'     ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Sh_Kind'    ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Sh_Nesab'   ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Sh_Type'    ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Sh_sobhaneh'; fieldType   : ftboolean   ; fieldSize : 0 ),
   (fieldName : 'Sh_nahar'   ; fieldType   : ftboolean   ; fieldSize : 0 ),
   (fieldName : 'Sh_sham'    ; fieldType   : ftboolean   ; fieldSize : 0 )
);


////////////////////Structure Of SpShift Table////////////////////////////
const spShiftIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const spShiftTbl : array [0..4] of TNewField =
(
   (fieldName : 'SP_CardNo' ; fieldType   : ftString    ; fieldSize : 8 ),
   (fieldName : 'SP_Date'   ; fieldType   : ftString    ; fieldSize : 10),
   (fieldName : 'SP_ShCode' ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SP_kind'   ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SP_ID'     ; fieldType   : ftInteger   ; fieldSize : 0 )
);

////////////////////Structure Of SpGroup Table////////////////////////////
const spGroupIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const spGroupTbl : array [0..3] of TNewField =
(
   (fieldName : 'SP_CardNo' ; fieldType   : ftString    ; fieldSize : 8 ),
   (fieldName : 'SP_Date'   ; fieldType   : ftString    ; fieldSize : 10),
   (fieldName : 'SP_GrCode' ; fieldType   : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'SP_RuleCode' ; fieldType   : ftSmallInt  ; fieldSize : 0 )
);




////////////////////Structure Of Groups Table////////////////////////////
const groupsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const groupsTbl : array [0..7] of TNewField =
(
   (fieldName : 'Grp_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Grp_Name' ; fieldType : ftString   ; fieldSize : 40),
   (fieldName : 'Grp_FromSobh' ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_ToSobh'   ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_FromNahar'; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_ToNahar'  ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_FromSham' ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_ToSham'   ; fieldType : ftString   ; fieldSize : 5 )

);


////////////////////Structure Of Grp_Dtl Table////////////////////////////
const grp_DtlIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const grp_DtlTbl : array [0..13] of TNewField =
(
   (fieldName : 'Grd_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Grd_Year' ; fieldType : ftSmallInt ; fieldSize : 40),
   (fieldName : 'Grd_M1'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M2'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M3'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M4'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M5'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M6'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M7'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M8'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M9'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M10'  ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M11'  ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grd_M12'  ; fieldType : ftString   ; fieldSize : 31)

);


////////////////////Structure Of GroupM Table////////////////////////////
const groupMIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const groupMTbl : array [0..1] of TNewField =
(
   (fieldName : 'GrpM_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'GrpM_Name' ; fieldType : ftString   ; fieldSize : 40)
);


////////////////////Structure Of GrpM_Dtl Table////////////////////////////
const grpM_DtlIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const grpM_DtlTbl : array [0..13] of TNewField =
(
   (fieldName : 'GrdM_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'GrdM_Year' ; fieldType : ftSmallInt ; fieldSize : 40),
   (fieldName : 'GrdM_M1'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M2'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M3'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M4'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M5'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M6'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M7'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M8'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M9'   ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M10'  ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M11'  ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'GrdM_M12'  ; fieldType : ftString   ; fieldSize : 31)
);


////////////////////Structure Of Errors Table////////////////////////////
const errorsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const errorsTbl : array [0..6] of TNewField =
(
   (fieldName : 'Er_Date'     ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'Er_Time'     ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Er_BarCode'  ; fieldType : ftString   ; fieldSize : 8 ),
   (fieldName : 'Er_RecState' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Er_Chg'      ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Er_ReaderNo' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Er_Type'     ; fieldType : ftSmallInt ; fieldSize : 0 )
);


////////////////////Structure Of Morkhasi Table////////////////////////////
const morkhasiIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const morkhasiTbl : array [0..34] of TNewField =
(
   (fieldName : 'Mor_PCode'    ; fieldType : ftString    ; fieldSize : 10),
   (fieldName : 'Mor_Year'     ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_DRemain'  ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_HRemain'  ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_DRemainOk'; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_HRemainOk'; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_SpDays'   ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_SpTime'   ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_User'     ; fieldType : ftString    ; fieldSize : 15),
   (fieldName : 'Mor_Bargeh'   ; fieldType : ftString    ; fieldSize : 15),
   (fieldName : 'Mor_ChgDate'  ; fieldType : ftString    ; fieldSize : 10),
   (fieldName : 'Mor_D1'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H1'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D2'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H2'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D3'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H3'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D4'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H4'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D5'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H5'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D6'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H6'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D7'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H7'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D8'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H8'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D9'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H9'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D10'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H10'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D11'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H11'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D12'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H12'      ; fieldType : ftSmallInt  ; fieldSize : 0 )
);

////////////////////Structure Of SpMor Table////////////////////////////
const SpMorIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const SpMorTbl : array [0..4] of TNewField =
(
   (fieldName : 'Spm_PCode'    ; fieldType : ftString  ; fieldSize : 10),
   (fieldName : 'Spm_Date'     ; fieldType : ftString  ; fieldSize : 10),
   (fieldName : 'Spm_Days'     ; fieldType : ftSmallInt; fieldSize : 0),
   (fieldName : 'Spm_time'     ; fieldType : ftSmallInt; fieldSize : 0),
   (fieldName : 'Spm_Remark'   ; fieldType : ftString  ; fieldSize : 30)
);

////////////////////Structure Of estelaji Morkhasi Table////////////////////////////
const smorkhasiIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const smorkhasiTbl : array [0..25] of TNewField =
(
   (fieldName : 'Mor_PCode'    ; fieldType : ftString    ; fieldSize : 10),
   (fieldName : 'Mor_Year'     ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D1'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H1'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D2'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H2'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D3'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H3'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D4'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H4'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D5'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H5'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D6'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H6'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D7'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H7'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D8'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H8'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D9'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H9'       ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D10'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H10'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D11'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H11'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_D12'      ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'Mor_H12'      ; fieldType : ftSmallInt  ; fieldSize : 0 )
);

////////////////////Structure Of Readers Table////////////////////////////
const readersIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'R_Code'; idxOption : [ixPrimary])
);
const readersTbl : array [0..13] of TNewField =
(
   (fieldName : 'R_Code'    ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Name'    ; fieldType : ftString    ; fieldSize : 20),
   (fieldName : 'R_Station' ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Active'  ; fieldType : ftString    ; fieldSize : 1 ),
   (fieldName : 'R_Port'    ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_BaudNo'  ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Type'    ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Modem'   ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_IP'    ; fieldType : ftString    ; fieldSize : 15),
   (fieldName : 'R_TCP'   ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_IsCOM' ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_VideoDevice' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'R_FrameRate' ; fieldType : ftSmallInt ; fieldSize : 0 )  ,
   (fieldName : 'R_LastFrame' ; fieldType : ftSmallInt ; fieldSize : 0 )
);


////////////////////Structure Of Users Table////////////////////////////
const UsersIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'UserName' ; idxOption : [ixPrimary])
);
const UsersTbl : array [0..18] of TNewField =
(
   (fieldName : 'UserName'     ; fieldType : ftString   ; fieldSize : 15 ),
   (fieldName : 'UserPassword' ; fieldType : ftString   ; fieldSize : 15 ),
   (fieldName : 'SecurityCode' ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Parts'        ; fieldType : ftString   ; fieldSize : 255),
   (fieldName : 'Entery'       ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'AccessPrint'  ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'DeleteInOut'  ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'editmor'      ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'editmam'      ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'limitshift'   ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'limitgroup'   ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'limitrule'    ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'Station'      ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'LastAccess'   ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'PCName'       ; fieldType : ftString   ; fieldSize : 50 ),
   (fieldName : 'IsActiveDir'  ; fieldType : ftBoolean  ; fieldSize : 0  ),
   (fieldName : 'DomainName'   ; fieldType : ftString   ; fieldSize : 15 ),
   (fieldName : 'customreps'   ; fieldType : ftString   ; fieldSize : 255),
   (fieldName : 'userparam'    ; fieldType : ftSmallInt ; fieldSize : 0 )
);
////////////////////Structure Of Security Table////////////////////////////
const securityIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'Code' ; idxOption : [ixPrimary])
);
const securityTbl : array [0..8] of TNewField =
(
   (fieldName : 'Code'         ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Name'         ; fieldType : ftString   ; fieldSize : 15),
   (fieldName : 'MenuBar'      ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'BaseMenu'     ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'ClockMenu'    ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'ReportMenu'   ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'SetupMenu'    ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'RelationMenu' ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'ToolsMenu'    ; fieldType : ftInteger  ; fieldSize : 0 )
);


////////////////////Structure Of UserStat Table////////////////////////////
const userStatIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const userStatTbl : array [0..3] of TNewField =
(
   (fieldName : 'User_Name'    ; fieldType : ftString   ; fieldSize : 15),
   (fieldName : 'User_Program' ; fieldType : ftString   ; fieldSize : 60),
   (fieldName : 'User_Date'    ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'User_Time'    ; fieldType : ftString   ; fieldSize : 5 )
);


////////////////////Structure Of Lahzeh Table////////////////////////////
const lahzehIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const lahzehTbl : array [0..4] of TNewField =
(
   (fieldName : 'L_Date'    ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'L_From'    ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'L_To'      ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'L_Kind'    ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'L_SubKind' ; fieldType : ftSmallInt ; fieldSize : 0 )
);


////////////////////Structure Of Madrak Table////////////////////////////
const madrakIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const madrakTbl : array [0..0] of TNewField =
(
   (fieldName : 'Madrak_Name' ; fieldType : ftString   ; fieldSize : 20)
);

////////////////////Structure Of personal reserve field 7 Table////////////////////////////
const reserve7Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const reserve7Tbl : array [0..0] of TNewField =
(
   (fieldName : 'rsrv7_Name' ; fieldType : ftString   ; fieldSize : 20)
);

////////////////////Structure Of personal reserve field 8 Table////////////////////////////
const reserve8Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const reserve8Tbl : array [0..0] of TNewField =
(
   (fieldName : 'rsrv8_Name' ; fieldType : ftString   ; fieldSize : 20)
);


////////////////////Structure Of AddFree Table////////////////////////////
const addFreeIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const addFreeTbl : array [0..14] of TNewField =
(
   (fieldName : 'Add_PCode'   ; fieldType : ftString   ; fieldSize : 8),
   (fieldName : 'Add_Year'    ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Month'   ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Time'    ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_TimeOK'  ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Night'   ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Cycle10' ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Cycle15' ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Cycle25' ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Cycle35' ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Cycle20' ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_nowork'  ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Max'     ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Type'    ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'Add_Remark'  ; fieldType : ftString   ; fieldSize :30)
);

////////////////////Structure Of p_mahaneh Table////////////////////////////
const mahanehIdx : array [0..0] of TNewIndex =
(
  {$IFDEF SqlPrc}
  (indexName : '' ; fieldName : 'Prc_PCode, Prc_Date' ; idxOption : [ixPrimary])
  {$Else}
  (indexName : '' ; fieldName : 'Prc_PCode; Prc_Date' ; idxOption : [ixPrimary])
  {$EndIf}
);

//{$ifdef script }
const mahanehTbl : array [0..127] of TNewField =
//{$else }
//const mahanehTbl : array [0..106] of TNewField =
//{$endif }
(
    (fieldName : 'Prc_PCode'; fieldType : ftString; fieldSize : 8),
    (fieldName : 'Prc_Date'; fieldType : ftString; fieldSize : 10),
    (fieldName : 'Prc_FirstIn'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FirstOut'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_SecondIn'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_SecondOut'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_ThirdIn'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_ThirdOut'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FourthIn'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FourthOut'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FifthIn'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FifthOut'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_LastIn'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_LastOut'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_LastInOut'; fieldType : ftSmallInt; fieldSize : 0),
//    (fieldName : 'Prc_InOuts'; fieldType : ftString; fieldSize : 150),
    (fieldName : 'Prc_NormWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_NormWorkDay'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_PresenceWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PresenceWorkDay'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_PresenceHolliday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PresenceHollidays'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PresenceFriday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PresenceFridays'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_WorkFridays'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_addnoworkday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_TotalWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PureWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PureWorkKham'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PureDayWork'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_PureWorkNight'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_PureWorkNights'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_standardwork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidTakhir'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidTajil'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWorkHolliday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWorkNoworkday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidaddWorkFriday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_InValidaddWorkFriday'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidaddWorkHolNoFr'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_InvalidaddWorkHolNoFr'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWorkbefore'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWorkafter'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_keshik'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_janbaz'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWorkNight'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidAddWorkFree'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_InvalidAddWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_TotalLessWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_ValidLessWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_BeinLessWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_TakhirLessWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_TajilLessWork'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourAbsence'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayAbsence'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDayAbsence'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayAbsencePure'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourAbsencePure'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_AbsenceNaghes'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourleaveNoSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayleaveNoSalary'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDayleaveNoSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourSleaveNoSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DaySleaveNoSalary'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDaySleaveNoSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourleaveSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayleaveSalary'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDayleaveSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourEleaveSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourEleaveSalarysum'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayEleaveSalary'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDayEleaveSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourSleaveSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DaySleaveSalary'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDaySleaveSalary'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourMission'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayMission'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_HourDayMission'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_FullMission'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_FullHourMission'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourMission51'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayMission61'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FullMission71'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_HourMission52'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_DayMission62'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_FullMission72'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift1Count'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift1time'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift2Count'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift2time'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift3Count'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift3time'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift4Count'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift4time'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift5Count'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Shift5time'; fieldType : ftInteger; fieldSize : 0),
    (fieldName : 'Prc_Zahab'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_Ghaza'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_Type'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_Kind'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_28'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_shiftcode'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_Station'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_Changed'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_TakhirCnt'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_TakhirTotal'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_TakhirTotalJarimeh'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'Prc_addfreeRemark'; fieldType : ftString; fieldSize : 30)
//     {$ifdef script }

    ,(fieldName : 'Prc_scrtimes1'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes2'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes3'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes4'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes5'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes6'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes7'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes8'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes9'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrtimes10'; fieldType : ftSmallInt; fieldSize : 0)

    ,(fieldName : 'Prc_scrdays1'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays2'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays3'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays4'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays5'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays6'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays7'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays8'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays9'; fieldType : ftSmallInt; fieldSize : 0)
    ,(fieldName : 'Prc_scrdays10'; fieldType : ftSmallInt; fieldSize : 0)
//     {$endif }
    );
////////////////////Structure Of AddWork(mojavvez ya dastory)///////////////////
const addWorkIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'E_PCode' ; idxOption : [ixPrimary])
);

const addWorkTbl : array [0..31] of TNewField =
(
    (fieldName : 'E_PCode'; fieldType : ftString; fieldSize : 8),
    (fieldName : 'E_D01'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D02'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D03'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D04'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D05'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D06'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D07'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D08'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D09'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D10'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D11'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D12'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D13'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D14'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D15'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D16'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D17'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D18'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D19'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D20'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D21'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D22'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D23'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D24'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D25'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D26'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D27'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D28'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D29'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D30'; fieldType : ftSmallInt; fieldSize : 0),
    (fieldName : 'E_D31'; fieldType : ftSmallInt; fieldSize : 0)
    );

////////////////////Structure Of AddWork(mojavvez ya dastory)///////////////////
const monthIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const monthTbl : array [0..10] of TNewField =
(
  (fieldName : 'Clock_BarCode'; fieldType : ftString; fieldSize : 8),
  (fieldName : 'Clock_BDate'; fieldType : ftString; fieldSize : 10),
  (fieldName : 'Clock_BTime'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_BRdrCode'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_BRecState'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_Date'; fieldType : ftString; fieldSize : 10),
  (fieldName : 'Clock_Time'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_RdrCode'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_Chg'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_RecState'; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'Clock_User'; fieldType : ftString; fieldSize : 15)
);

////////////////////  Structure Of N13****  ///////////////////
const BargehIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const BargehTbl : array [0..7] of TNewField =
(
  (fieldName : 'N_PCode'    ; fieldType : ftString  ; fieldSize : 8),
  (fieldName : 'N_Date'     ; fieldType : ftString  ; fieldSize : 10),
  (fieldName : 'N_Time'     ; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'N_IOType'   ; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'N_BargehNo' ; fieldType : ftInteger;  fieldSize : 0),
  (fieldName : 'N_Type1'    ; fieldType : ftSmallInt; fieldSize : 0),
  (fieldName : 'N_Type2'    ; fieldType : ftInteger ; fieldSize : 0),
  (fieldName : 'N_Remark'   ; fieldType : ftString  ; fieldSize : 20)
);

////////////////////Structure Of finger ///////////////////
const fingerIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const fingerTbl : array [0..1] of TNewField =
(
  (fieldName : 'Proxi'; fieldType : ftString; fieldSize : 8),
  (fieldName : 'Sample'; fieldType : ftBytes; fieldSize : 816)
);



////////////////////Structure Of fgr_Dtl ///////////////////
const fgr_DtlIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const fgr_DtlTbl : array [0..1] of TNewField =
(
  (fieldName : 'Proxi'; fieldType : ftString; fieldSize : 8),
  (fieldName : 'RdrCode'; fieldType : ftSmallint; fieldSize : 0)
);

////////////////////Structure Of doctors ///////////////////
const doctorsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const doctorsTbl : array [0..1] of TNewField =
(
   (fieldName : 'Code'  ; fieldType : ftInteger ; fieldSize : 0 ),
   (fieldName : 'Name'  ; fieldType : ftString   ; fieldSize : 30)
);

////////////////////Structure Of diseases ///////////////////
const diseasesIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const diseasesTbl : array [0..1] of TNewField =
(
   (fieldName : 'Code'  ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Name'  ; fieldType : ftString   ; fieldSize : 30)
);

////////////////////Structure Of mission1 ///////////////////
const mission1Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const mission1Tbl : array [0..1] of TNewField =
(
   (fieldName : 'M1_Code'  ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'M1_Name'  ; fieldType : ftString   ; fieldSize : 30)
);

////////////////////Structure Of mission2 ///////////////////
const mission2Idx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const mission2Tbl : array [0..2] of TNewField =
(
   (fieldName : 'M2_Code'  ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'M2_M1Code'  ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'M2_Name'  ; fieldType : ftString   ; fieldSize : 30)
);

////////////////////Structure Of OnlyCard ///////////////////
const OnlyCardIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const OnlyCardTbl : array [0..1] of TNewField =
(
   (fieldName : 'BarCode'  ; fieldType : ftString   ; fieldSize : 8),
   (fieldName : 'RdrCode'  ; fieldType : ftSmallInt ; fieldSize : 0)
);

////////////////////Structure Of AFreeTyp ///////////////////
const AFreeTypIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const AFreeTypTbl : array [0..1] of TNewField =
(
   (fieldName : 'AddT_Code'  ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'AddT_Name'  ; fieldType : ftString   ; fieldSize : 30)
);

////////////////////Structure Of Stations Table////////////////////////////
const StationsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const StationsTbl : array [0..1] of TNewField =
(
   (fieldName : 'st_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'st_Name' ; fieldType : ftString   ; fieldSize : 40 )
);

////////////////////Structure Of Help Table////////////////////////////
const HelpIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'help_NamesString'; idxOption : [ixPrimary])
);

const HelpTbl : array [0..2] of TNewField =
(
   (fieldName : 'help_NamesString'      ; fieldType   : ftString   ; fieldSize : 255),
   (fieldName : 'help_EventName'       ; fieldType   : ftString   ; fieldSize : 255),
   (fieldName : 'help_HelpText'        ; fieldType   : ftString   ; fieldSize : 255)
);
// help_NameString : this is the primary key of help table. What we store in it is a string with concatenation
// of name of all parents of the current object. for example if button1 is the name of an object in form1 so this
// field will store "form1.button1".

// help_EventName : this is the name of the event of the control which we want to show the help when it occurs.
// for example it may store "OnClick".

// help_HelpText : this is the text that we want to show to the user. So it has the maximum length of nvarchar type
// in SqlServer that is 4000.

////////////////////Structure Of mojavvez Table////////////////////////////
const mojavvezIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const mojavvezTbl : array [0..5] of TNewField =
(
   (fieldName : 'clock_barcode'        ; fieldType   : ftString   ; fieldSize : 8),
   (fieldName : 'clock_date'           ; fieldType   : ftString   ; fieldSize : 10),
   (fieldName : 'clock_time'           ; fieldType   : ftSmallint ; fieldSize : 0),
   (fieldName : 'clock_etime'          ; fieldType   : ftSmallint ; fieldSize : 0),
   (fieldName : 'clock_RecState'       ; fieldType   : ftSmallint ; fieldSize : 0),
   (fieldName : 'clock_User'           ; fieldType   : ftString   ; fieldSize : 15)
);

////////////////////Structure Of Pish Card Table////////////////////////////
const PishCardIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const PishCardTbl : array [0..4] of TNewField =
(
   (fieldName : 'Pish_Code'            ; fieldType   : ftSmallint ; fieldSize : 0),
   (fieldName : 'Pish_LastName'        ; fieldType   : ftString   ; fieldSize : 30),
   (fieldName : 'Pish_Name'            ; fieldType   : ftString   ; fieldSize : 30),
   (fieldName : 'Pish_active'          ; fieldType   : ftboolean  ; fieldSize : 0),
   (fieldName : 'Pish_activeWeb'       ; fieldType   : ftboolean  ; fieldSize : 0)
);

////////////////////Structure Of initial  Table////////////////////////////
const InitIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const InitTbl : array [0..2] of TNewField =
(
   (fieldName : 'Init_Title'       ; fieldType   : ftString   ; fieldSize : 30),
   (fieldName : 'Init_Value'       ; fieldType   : ftString   ; fieldSize : 50),
   (fieldName : 'Init_Code'        ; fieldType   : ftsmallint ; fieldSize : 0)
);

////////////////////Structure Of custom report Table////////////////////////////
const CustomRpIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const CustomRpTbl : array [0..6] of TNewField =
(
   (fieldName : 'CustomRp_repCode'     ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'CustomRp_repName'     ; fieldType   : ftString   ; fieldSize : 40),
   (fieldName : 'CustomRp_reppaper'    ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'CustomRp_repsize'     ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'CustomRp_fieldcount'  ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'CustomRp_repFields'   ; fieldType   : ftstring   ; fieldSize : 250),
   (fieldName : 'CustomRp_isprevmonth' ; fieldType   : ftstring   ; fieldSize : 50)
);

const CustomDpIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const CustomDpTbl : array [0..2] of TNewField =
(
   (fieldName : 'CustomDp_Code'     ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'CustomDp_CLen'     ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'CustomDp_CTitle'   ; fieldType   : ftstring   ; fieldSize : 50)
);

//  make custom text and DBF reports

const mktextrpIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const mktextrpTbl : array [0..5] of TNewField =
(
   (fieldName : 'mktextrp_RepName'     ; fieldType   : ftstring   ; fieldSize : 40),
   (fieldName : 'mktextrp_fieldcount'  ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'mktextrp_Delimiter'   ; fieldType   : ftstring   ; fieldSize : 3),
   (fieldName : 'mktextrp_RepFields'   ; fieldType   : ftstring   ; fieldSize : 150),
   (fieldName : 'mktextrp_RepLens'     ; fieldType   : ftstring   ; fieldSize : 150),
   (fieldName : 'mktextrp_RepDBFNames' ; fieldType   : ftstring   ; fieldSize : 254)

);


//   tatilat rasmi va gheir rasmi table
const holidayIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const holidayTbl : array [0..3] of TNewField =
(
   (fieldName : 'holiday_year'     ; fieldType   : ftSmallint ; fieldSize : 0),
   (fieldName : 'holiday_Month'    ; fieldType   : ftsmallint ; fieldSize : 0),
   (fieldName : 'holiday_Rasmi'    ; fieldType   : ftstring   ; fieldSize : 31),
   (fieldName : 'holiday_NonRasmi' ; fieldType   : ftstring   ; fieldSize : 31)
);

////////////////////Structure Of Agree ///////////////////
const AgreeIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const AgreeTbl : array [0..2] of TNewField =
(
   (fieldName : 'BarCode'     ; fieldType : ftString; fieldSize : 8),
   (fieldName : 'PishCard_No' ; fieldType : ftSmallInt ; fieldSize : 0),
   (fieldName : 'p_status'      ; fieldType : ftSmallInt ; fieldSize : 0)
);
////////////////////Structure Of AgreeAddTime ///////////////////
const AgreeAddTimeIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const AgreeAddTimeTbl : array [0..1] of TNewField =
(
   (fieldName : 'BarCode' ; fieldType : ftString  ; fieldSize : 8),
   (fieldName : 'IsAgree'   ; fieldType : ftBoolean ; fieldSize : 0)
);

////////////////////Structure Of Webpass ////////////////
const WebpassIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const WebpassTbl : array [0..22] of TNewField =
(
   (fieldName : 'p_barcode' ; fieldType : ftString  ; fieldSize : 8),
   (fieldName : 'p_pass'    ; fieldType : ftString ; fieldSize : 15),
   (fieldName : 'p_status ' ; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'p_part1'   ; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'p_part2'   ; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'p_part3'   ; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'p_part4'   ; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'Haspart'   ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'Hasperson' ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'TopMan'    ; fieldType : ftString ; fieldSize : 8),
   (fieldName : 'MaxTimeReq'; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'MaxOverTime'; fieldType : ftInteger ; fieldSize : 0),
   (fieldName : 'AgreeAddWork'  ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'AgreeOverTime' ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'HasMailServer' ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'HostName'   ; fieldType : ftString ; fieldSize : 30),
   (fieldName : 'UserName'   ; fieldType : ftString ; fieldSize : 40),
   (fieldName : 'Password'   ; fieldType : ftString ; fieldSize : 25),
   (fieldName : 'Port'       ; fieldType : ftSmallint ; fieldSize : 0),
   (fieldName : 'HasInsteadMan' ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'InsteadMan'    ; fieldType : ftString ; fieldSize : 8),
   (fieldName : 'isSaveAccept'  ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isAcceptOwner' ; fieldType : ftBoolean ; fieldSize : 0)
);

////////////////////Structure Of WebpassPersons ////////////////
const WebpassPersonsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);

const WebpassPersonsTbl : array [0..10] of TNewField =
(
   (fieldName : 'BarCode' ; fieldType : ftString  ; fieldSize : 255),
   (fieldName : 'PersonBarCode' ; fieldType : ftString ; fieldSize : 255),
   (fieldName : 'isKarkardfrm'  ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isRequestfrm'  ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isOperatorfrm' ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isKeeperfrm'   ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isOverTimefrm' ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isPerson'      ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isPart'        ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'isSubPart'     ; fieldType : ftBoolean ; fieldSize : 0),
   (fieldName : 'AccessType'    ; fieldType : ftBoolean ; fieldSize : 0)
);


//*****************************make resturan Database ******************************8
////////////////////Structure Of Building Table////////////////////////////
const BuildingIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const BuildingTbl : array [0..1] of TNewField =
(
   (fieldName : 'Building_Code' ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Building_Name' ; fieldType : ftString   ; fieldSize : 40 )
);

////////////////////Structure Of DblFish Table////////////////////////////
const DblFishIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const DblFishTbl : array [0..3] of TNewField =
(
   (fieldName : 'DBL_Date' ; fieldType : ftString   ; fieldSize : 10 ),
   (fieldName : 'DBL_Type' ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'DBL_PCode'; fieldType : ftString   ; fieldSize : 8  ),
   (fieldName : 'DBL_Count'; fieldType : ftSmallInt ; fieldSize : 0  )
);

////////////////////Structure Of Fish Table////////////////////////////
const FishIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'Fish_Date,Fish_Type,Fish_No'; idxOption : [ixPrimary])
);

const FishTbl : array [0..10] of TNewField =
(
   (fieldName : 'Fish_Date'     ; fieldType : ftString   ; fieldSize : 10 ),
   (fieldName : 'Fish_Type'     ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Fish_No'       ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Fish_RdrFishNo'; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Fish_Time'     ; fieldType : ftString   ; fieldSize : 5  ),
   (fieldName : 'Fish_PCode'    ; fieldType : ftString   ; fieldSize : 8  ),
   (fieldName : 'Fish_RdrCode'  ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Fish_UCode'    ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Fish_UKhadamat'; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Fish_UPrc'     ; fieldType : ftCurrency ; fieldSize : 0  ),
   (fieldName : 'Fish_UPay'     ; fieldType : ftCurrency ; fieldSize : 0  )
);

////////////////////Structure Of FishFood Table////////////////////////////
const FishFoodIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'FF_Date,FF_Type,FF_FishNo,FF_Food'; idxOption : [ixPrimary])
);

const FishFoodTbl : array [0..6] of TNewField =
(
   (fieldName : 'FF_Date'     ; fieldType : ftString   ; fieldSize : 10 ),
   (fieldName : 'FF_Type'     ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'FF_FishNo'   ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'FF_Food'     ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'FF_Price'    ; fieldType : ftCurrency ; fieldSize : 0  ),
   (fieldName : 'FF_Pay'      ; fieldType : ftCurrency ; fieldSize : 0  ),
   (fieldName : 'FF_No'       ; fieldType : ftSmallInt ; fieldSize : 0  )
);

////////////////////Structure Of FoodList Table////////////////////////////
const FoodListIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'Food_Code'; idxOption : [ixPrimary])
);

const FoodListTbl : array [0..2] of TNewField =
(
   (fieldName : 'Food_Code'   ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Food_Type'   ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'Food_Name'   ; fieldType : ftString   ; fieldSize : 20 )
);

////////////////////Structure Of FoodPrice Table////////////////////////////
const FoodPriceIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'FP_FoodCode,FP_Date'; idxOption : [ixPrimary])
);

const FoodPriceTbl : array [0..3] of TNewField =
(
   (fieldName : 'FP_FoodCode'   ; fieldType : ftSmallInt ; fieldSize : 0  ),
   (fieldName : 'FP_Date'       ; fieldType : ftString   ; fieldSize : 10 ),
   (fieldName : 'FP_PriceFee'   ; fieldType : ftCurrency ; fieldSize : 0  ),
   (fieldName : 'FP_PricePerson'; fieldType : ftCurrency ; fieldSize : 0  )

);


////////////////////Structure Of Groups Table////////////////////////////
const groupsIdxr : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const groupsTblr : array [0..19] of TNewField =
(
   (fieldName : 'Grp_Code'     ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'Grp_Name'     ; fieldType : ftString   ; fieldSize : 40),
   (fieldName : 'Grp_FromSobh' ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_ToSobh'   ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_FromNahar'; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_ToNahar'  ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_FromSham' ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_ToSham'   ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Grp_M1'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M2'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M3'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M4'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M5'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M6'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M7'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M8'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M9'       ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M10'      ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M11'      ; fieldType : ftString   ; fieldSize : 31),
   (fieldName : 'Grp_M12'      ; fieldType : ftString   ; fieldSize : 31)
);

const OutGroupIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);
const OutGroupTbl : array [0..2] of TNewField =
(
   (fieldName : 'OG_Date'     ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'OG_PCode'    ; fieldType : ftString   ; fieldSize : 8 ),
   (fieldName : 'OG_Vadeh'    ; fieldType : ftSmallint ; fieldSize : 0 )
);

{
const personsIdxr : array [0..2] of TNewIndex =
(
  (indexName : ''        ; fieldName : 'P_BarCode , P_Proxi'; idxOption : [ixPrimary]),
  (indexName : 'BCodeIdx'; fieldName : 'P_BarCode'; idxOption : [ixUnique]),
  (indexName : 'ProxiIdx'; fieldName : 'P_Proxi'  ; idxOption : [ixUnique])
);

const personsTblr : array [0..24] of TNewField =
(
   (fieldName : 'P_BarCode'     ; fieldType : ftString    ; fieldSize : 8  ),
   (fieldName : 'P_Proxi'       ; fieldType : ftString    ; fieldSize : 15  ),
   (fieldName : 'P_Name'        ; fieldType : ftString    ; fieldSize : 40 ),
   (fieldName : 'P_Family'      ; fieldType : ftString    ; fieldSize : 40 ),
   (fieldName : 'P_parts'    ; fieldType : ftString    ; fieldSize : 255),
   (fieldName : 'P_JobCode'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_GroupCode'   ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_IsValid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_ValidTest'   ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Pricable'    ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_PrePaid'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Credit'      ; fieldType : ftinteger   ; fieldSize : 0  ),
   (fieldName : 'P_Sobhaneh'    ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Nahar'       ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Sham'        ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Rejim'       ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_IsGuest'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Special'     ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_ManyFish'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_EtebarFish'  ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'P_DblFood'     ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_CashType'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_DeserNoFood' ; fieldType : ftBoolean   ; fieldSize : 0  ),
   (fieldName : 'P_Building'    ; fieldType : ftSmallInt  ; fieldSize : 0  ),
   (fieldName : 'P_Sex'         ; fieldType : ftSmallInt  ; fieldSize : 0  )
);
}
////////////////////Structure Of PrgPrs Table////////////////////////////
const PrgPrsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : ''; idxOption : [ixPrimary])
);

const PrgPrsTbl : array [0..13] of TNewField =
(
   (fieldName : 'PP_Date'      ; fieldType   : ftString    ; fieldSize : 10),
   (fieldName : 'PP_Type'      ; fieldType   : ftSmallint  ; fieldSize : 0 ),
   (fieldName : 'PP_PCode'     ; fieldType   : ftString    ; fieldSize : 8 ),
   (fieldName : 'PP_Key1'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key2'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key3'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key4'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key5'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key6'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key7'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Key8'      ; fieldType   : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'PP_Keys'      ; fieldType   : ftSmallint  ; fieldSize : 0 ),
   (fieldName : 'PP_Building'  ; fieldType   : ftInteger   ; fieldSize : 0 ),
   (fieldName : 'PP_Price'     ; fieldType   : ftCurrency  ; fieldSize : 0 )
);

////////////////////Structure Of RdrKey Table////////////////////////////
const RdrKeyIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'RK_RdrCode'; idxOption : [ixPrimary])
);

const RdrKeyTbl : array [0..1] of TNewField =
(
   (fieldName : 'RK_RdrCode'  ; fieldType   : ftSmallint  ; fieldSize : 0 ),
   (fieldName : 'RK_Keys'     ; fieldType   : ftString    ; fieldSize : 8)
);


////////////////////Structure Of Readers Table////////////////////////////
const readersIdxr : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'R_Code'; idxOption : [ixPrimary])
);
const readersTblr : array [0..11] of TNewField =
(
   (fieldName : 'R_Code'    ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Name'    ; fieldType : ftString    ; fieldSize : 40),
   (fieldName : 'R_Station' ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Active'  ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_Port'    ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_BaudNo'  ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_OnLine'  ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_Type'    ; fieldType : ftSmallInt  ; fieldSize : 0 ),
   (fieldName : 'R_Modem'   ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_IP'      ; fieldType : ftString    ; fieldSize : 15),
   (fieldName : 'R_TCP'     ; fieldType : ftBoolean   ; fieldSize : 0 ),
   (fieldName : 'R_IsCOM'   ; fieldType : ftBoolean   ; fieldSize : 0 )
);


////////////////////Structure Of Security Table////////////////////////////
const securityIdxr : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'UserName' ; idxOption : [ixPrimary])
);
const securityTblr : array [0..9] of TNewField =
(
   (fieldName : 'UserName'     ; fieldType : ftString   ; fieldSize : 15),
   (fieldName : 'UserPassword' ; fieldType : ftString   ; fieldSize : 15),
   (fieldName : 'Entery'       ; fieldType : ftBoolean  ; fieldSize : 0 ),
   (fieldName : 'MenuBar'      ; fieldType : ftSmallInt ; fieldSize : 0 ),
   (fieldName : 'BaseMenu'     ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'ResturantMenu'; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'ReportMenu'   ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'RelationMenu' ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'ToolsMenu'    ; fieldType : ftInteger  ; fieldSize : 0 ),
   (fieldName : 'AccessPrint'  ; fieldType : ftBoolean  ; fieldSize : 0 )
);

////////////////////Structure Of Units Table////////////////////////////
const UnitsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'Unit_Code'; idxOption : [ixPrimary])
);

const UnitsTbl : array [0..1] of TNewField =
(
   (fieldName : 'Unit_Code'  ; fieldType   : ftSmallint  ; fieldSize : 0 ),
   (fieldName : 'Unit_Name'  ; fieldType   : ftString    ; fieldSize : 20)
);


////////////////////Structure Of UserStat Table////////////////////////////
const userStatIdxr : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const userStatTblr : array [0..3] of TNewField =
(
   (fieldName : 'User_Name'    ; fieldType : ftString   ; fieldSize : 15),
   (fieldName : 'User_Program' ; fieldType : ftString   ; fieldSize : 60),
   (fieldName : 'User_Date'    ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'User_Time'    ; fieldType : ftString   ; fieldSize : 5 )
);


////////////////////Structure Of Week Table////////////////////////////
const WeekIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const WeekTbl : array [0..19] of TNewField =
(
   (fieldName : 'Week_Date'    ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'Week_Type'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key1'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key2'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key3'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key4'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key5'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key6'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key7'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key8'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key9'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_Key0'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N1'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N2'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N3'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N4'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N5'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N6'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N7'    ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Week_N8'    ; fieldType : ftSmallint ; fieldSize : 0 )
);

////////////////////Structure Of ClckRecs Table////////////////////////////
const ClckRecsIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const ClckRecsTbl : array [0..5] of TNewField =
(
   (fieldName : 'Clock_BarCode' ; fieldType : ftString   ; fieldSize : 8 ),
   (fieldName : 'Clock_Date'    ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'Clock_Time'    ; fieldType : ftString   ; fieldSize : 5 ),
   (fieldName : 'Clock_RdrCode' ; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Clock_RecState'; fieldType : ftSmallint ; fieldSize : 0 ),
   (fieldName : 'Clock_chg'     ; fieldType : ftSmallint ; fieldSize : 0 )
);
////////////////////Structure Of AmarTabkh Table////////////////////////////
const AmarTabkhIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const AmarTabkhTbl : array [0..0] of TNewField =
(
   (fieldName : 'Date'    ; fieldType : ftString   ; fieldSize : 10)
);


////////////////////Structure Of AmarTabkhF Table////////////////////////////
const AmarTabkhFIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const AmarTabkhFTbl : array [0..6] of TNewField =
(
   (fieldName : 'Date'    ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'Day'     ; fieldType : ftString   ; fieldSize : 10),
   (fieldName : 'Vadeh'   ; fieldType : ftsmallint ; fieldSize : 30),
   (fieldName : 'food'    ; fieldType : ftString   ; fieldSize : 30),
   (fieldName : 'personno'; fieldType : ftString   ; fieldSize : 8),
   (fieldName : 'cnt'     ; fieldType : ftsmallint ; fieldSize : 0),
   (fieldName : 'Building'; fieldType : ftString ; fieldSize : 30)
);


////////////////////Structure Of ClckRecs Table////////////////////////////
const ReservTypeIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const ReservTypeTbl : array [0..3] of TNewField =
(
   (fieldName : 'ReservType_State' ; fieldType : ftSmallint   ; fieldSize : 0 ),
   (fieldName : 'ReservType_FromDate' ; fieldType : ftString    ; fieldSize : 10 ),
   (fieldName : 'ReservType_ToDate' ; fieldType : ftString   ; fieldSize : 10 ),
   (fieldName : 'ReservType_Cycle' ; fieldType : ftSmallint   ; fieldSize : 0 )
);
////////////////////Structure Of Charge Table////////////////////////////
const ChargeIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const ChargeTbl : array [0..4] of TNewField =
(
   (fieldName : 'ch_Date'    ; fieldType : ftString   ; fieldSize : 10 ),
   (fieldName : 'ch_time'    ; fieldType : ftInteger  ; fieldSize : 0  ),
   (fieldName : 'ch_barcode' ; fieldType : ftString   ; fieldSize : 8  ),
   (fieldName : 'ch_Price'   ; fieldType : ftCurrency ; fieldSize : 0  ),
   (fieldName : 'ch_User'    ; fieldType : ftString   ; fieldSize : 20 )
);

////////////////////Structure Of mochGiri Table////////////////////////////
const MochIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const MochTbl : array [0..0] of TNewField =
(
   (fieldName : 'Moch_time'    ; fieldType : ftInteger  ; fieldSize : 0  )
);

////////////////////Structure Of yaraneh Table////////////////////////////
const yaranehIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : 'y_PCode,y_Year,y_Month' ; idxOption : [ixPrimary])
);
const yaranehTbl : array [0..5] of TNewField =
(
   (fieldName : 'y_PCode'          ; fieldType : ftString  ; fieldSize : 8 ),
   (fieldName : 'y_Year'           ; fieldType : ftSmallint; fieldSize : 0 ),
   (fieldName : 'y_Month'          ; fieldType : ftSmallint; fieldSize : 0 ),
   (fieldName : 'y_WorkDays'       ; fieldType : ftSmallint; fieldSize : 8 ),
   (fieldName : 'y_ateYaraneh'     ; fieldType : ftCurrency; fieldSize : 8 ),
   (fieldName : 'y_notAteYaraneh'  ; fieldType : ftCurrency; fieldSize : 8 )
);

////////////////////Structure Of limit Table////////////////////////////
const LimitIdx : array [0..0] of TNewIndex =
(
  (indexName : '' ; fieldName : '' ; idxOption : [ixPrimary])
);
const LimitTbl : array [0..2] of TNewField =
(
   (fieldName : 'Limit_User'          ; fieldType : ftString  ; fieldSize : 8 ),
   (fieldName : 'Limit_Table'         ; fieldType : ftSmallint; fieldSize : 0 ),
   (fieldName : 'Limit_code'          ; fieldType : ftSmallint; fieldSize : 0 )
);

//***********************************************************************************88
function  renametbl(tblname:string):boolean; overload;
function CreateTbl(tblName : String; inParadox : Boolean = False) : Boolean;
function Createview(viwName : String):boolean;
function _CreateTbl(flds : array of TNewField ; idxs : array of TNewIndex ; dbName : string) : Boolean;
function _CreateTrigger(tblName : string) : Boolean;
function changedTbl(dbName : string) : Boolean;
function  CreatePDoxTbl(tblName, dbPath : String) : Boolean;

function checkdeletviw(viwname:string):boolean;
function checkcreateview(viwname:string):boolean;
{$ifndef SqlTools}
procedure UpgradeTable(tblName : string);
Procedure BreakTable(tblName,tblnameetc : string);
procedure MatchTables(tblName,tblnameetc,fldname : string);
procedure UpgradeMonthTables(fromDate, toDate : String);
procedure RenameTbl(tblOldName : String; tblNewName : String);overload;
{$endif}

 type TAppType=(appClock,appResturant);
 var appType:TAppType;
implementation


uses
 {$ifndef SqlTools}
  {$IFNDEF Restaurant} DBS {$ELSE}DBS_Proc{$ENDIF}
  , Globals, DBLogin, TimeTool,DateProc,
 {$else}menu,{$endif}

 Funcs;

Procedure findTbl(var tblName : string;var flds : pointer;var fldhigh:byte;var idxs : pointer;var idxhigh:byte);
begin
  tblName := LowerCase(tblName);
  if tblName = 'rules' then
    begin
    flds:=addr(rulesTbl);  idxs:=addr(rulesIdx);  fldhigh:=high(rulestbl); idxhigh:=high(rulesIdx);
    end
  else if tblName = 'rulesetc' then
    begin
    flds:=addr(rulesetcTbl);  idxs:=addr(rulesetcIdx);  fldhigh:=high(rulesetctbl); idxhigh:=high(rulesetcIdx);
    end
  else if tblName = 'persons' then
    begin
    flds:=addr(personsTbl);  idxs:=addr(personsIdx);  fldhigh:=high(personsTbl); idxhigh:=high(personsIdx);
    end
  else if tblName = 'tmppersons' then
    begin
    flds:=addr(tmpPersonsTbl);  idxs:=addr(tmpPersonsIdx);  fldhigh:=high(tmpPersonsTbl); idxhigh:=high(tmpPersonsIdx);
    end
  else if tblName = 'cities' then
    begin
      flds:=addr(cityTbl);  idxs:=addr(cityIdx);  fldhigh:=high(cityTbl); idxhigh:=high(cityIdx);
    end
  else if tblName = 'curse' then
    begin
    flds:=addr(curseTbl);  idxs:=addr(curseIdx);  fldhigh:=high(curseTbl); idxhigh:=high(curseIdx);
    end
  else if tblName = 'coposts' then
    begin
    flds:=addr(coPostsTbl);  idxs:=addr(coPostsIdx);  fldhigh:=high(coPostsTbl); idxhigh:=high(coPostsIdx);
    end
  else if tblName = 'jobtype' then
    begin
    flds:=addr(jobTypeTbl);  idxs:=addr(jobTypeIdx);  fldhigh:=high(jobTypeTbl); idxhigh:=high(jobTypeIdx);
    end
  else if tblName = 'parts' then
    begin
    flds:=addr(partsTbl);  idxs:=addr(partsIdx);      fldhigh:=high(partsTbl); idxhigh:=high(partsIdx);
    end
  else if tblName = 'part1' then
    begin
    flds:=addr(part1Tbl);  idxs:=addr(part1Idx);      fldhigh:=high(part1Tbl); idxhigh:=high(part1Idx);
    end
  else if tblName = 'part2' then
    begin
    flds:=addr(part2Tbl);  idxs:=addr(part2Idx);      fldhigh:=high(part2Tbl); idxhigh:=high(part2Idx);
    end
  else if tblName = 'part3' then
    begin
    flds:=addr(part3Tbl);  idxs:=addr(part3Idx);      fldhigh:=high(part3Tbl); idxhigh:=high(part3Idx);
    end
  else if tblName = 'part4' then
    begin
    flds:=addr(part4Tbl);  idxs:=addr(part4Idx);      fldhigh:=high(part4Tbl); idxhigh:=high(part4Idx);
    end
  else if tblName = 'shifts' then
    begin
    flds:=addr(shiftsTbl);  idxs:=addr(shiftsIdx);    fldhigh:=high(shiftsTbl); idxhigh:=high(shiftsIdx);
    end
  else if tblName = 'spshift' then
    begin
    flds:=addr(spShiftTbl);  idxs:=addr(spShiftIdx);  fldhigh:=high(spShiftTbl); idxhigh:=high(spShiftIdx);
    end
  else if tblName = 'spgroup' then
    begin
    flds:=addr(spGroupTbl);  idxs:=addr(spGroupIdx);  fldhigh:=high(spGroupTbl); idxhigh:=high(spGroupIdx);
    end
  else if tblName = 'groups' then
    begin
    flds:=addr(groupsTbl);  idxs:=addr(groupsIdx);    fldhigh:=high(groupsTbl); idxhigh:=high(groupsIdx);
    end
  else if tblName = 'grp_dtl' then
    begin
    flds:=addr(grp_DtlTbl);  idxs:=addr(grp_DtlIdx);  fldhigh:=high(grp_DtlTbl); idxhigh:=high(grp_DtlIdx);
    end
  else if tblName = 'groupm' then
    begin
    flds:=addr(groupMTbl);  idxs:=addr(groupMIdx);    fldhigh:=high(groupMTbl); idxhigh:=high(groupMIdx);
    end
  else if tblName = 'grpm_dtl' then
    begin
    flds:=addr(grpM_DtlTbl);  idxs:=addr(grpM_DtlIdx); fldhigh:=high(grpM_DtlTbl); idxhigh:=high(grpM_DtlIdx);
    end
  else if tblName = 'errors' then
    begin
    flds:=addr(errorsTbl);  idxs:=addr(errorsIdx);    fldhigh:=high(errorsTbl); idxhigh:=high(errorsIdx);
    end
  else if tblName = 'morkhasi' then
    begin
    flds:=addr(morkhasiTbl);  idxs:=addr(morkhasiIdx); fldhigh:=high(morkhasiTbl); idxhigh:=high(morkhasiIdx);
    end
  else if tblName = 'spmor' then
    begin
    flds:=addr(SpMorTbl);  idxs:=addr(SpMorIdx);       fldhigh:=high(SpMorTbl); idxhigh:=high(SpMorIdx);
    end
  else if tblName = 'readers' then
    case appType of
      appClock     : begin flds:=addr(readersTbl);  idxs:=addr(readersIdx);   fldhigh:=high(readersTbl); idxhigh:=high(readersIdx); end;
      appResturant : begin flds:=addr(readersTblr);  idxs:=addr(readersIdxr);   fldhigh:=high(readersTblr); idxhigh:=high(readersIdxr); end;
    end
  else if tblName = 'security' then
    case appType of
      appClock     : begin flds:=addr(securityTbl);  idxs:=addr(securityIdx); fldhigh:=high(securityTbl); idxhigh:=high(securityIdx); end;
      appResturant : begin flds:=addr(securityTblr);  idxs:=addr(securityIdxr); fldhigh:=high(securityTblr); idxhigh:=high(securityIdxr); end;
    end
  else if tblName = 'users' then
    begin
    flds:=addr(UsersTbl);  idxs:=addr(UsersIdx);       fldhigh:=high(UsersTbl); idxhigh:=high(UsersIdx);
    end
  else if tblName = 'userstat' then
    begin
    flds:=addr(userStatTbl);  idxs:=addr(userStatIdx); fldhigh:=high(userStatTbl); idxhigh:=high(userStatIdx);
    end
  else if tblName = 'lahzeh' then
    begin
    flds:=addr(lahzehTbl);  idxs:=addr(lahzehIdx);     fldhigh:=high(lahzehTbl); idxhigh:=high(lahzehIdx);
    end
  else if tblName = 'madraks' then
    begin
    flds:=addr(madrakTbl);  idxs:=addr(madrakIdx);     fldhigh:=high(madrakTbl); idxhigh:=high(madrakIdx);
    end
  else if tblName = 'reserve7' then
    begin
    flds:=addr(reserve7Tbl);  idxs:=addr(reserve7Idx);     fldhigh:=high(reserve7Tbl); idxhigh:=high(reserve7Idx);
    end
  else if tblName = 'reserve8' then
    begin
    flds:=addr(reserve8Tbl);  idxs:=addr(reserve8Idx);     fldhigh:=high(reserve8Tbl); idxhigh:=high(reserve8Idx);
    end
  else if tblName = 'addfree' then
    begin
    flds:=addr(addFreeTbl);  idxs:=addr(addFreeIdx);   fldhigh:=high(addFreeTbl); idxhigh:=high(addFreeIdx);
    end
  else if tblName = 'finger' then
    begin
    flds:=addr(fingerTbl);  idxs:=addr(FingerIdx);     fldhigh:=high(fingerTbl); idxhigh:=high(fingerIdx);
    end
  else if tblName = 'fgr_dtl' then
    begin
    flds:=addr(fgr_DtlTbl);  idxs:=addr(fgr_DtlIdx);   fldhigh:=high(fgr_DtlTbl); idxhigh:=high(fgr_DtlIdx);
    end
  else if tblName = 'smorkhasi' then
    begin
    flds:=addr(smorkhasiTbl);  idxs:=addr(morkhasiIdx); fldhigh:=high(smorkhasiTbl); idxhigh:=high(smorkhasiIdx);
    end
  else if copy(tblName, 1, 2) = 'p1' then
    begin
    flds:=addr(mahanehTbl);  idxs:=addr(mahanehIdx);   fldhigh:=high(mahanehTbl); idxhigh:=high(mahanehIdx);
    end
  else if (copy(tblName, 1, 2) = 'e1') or (copy(tblName, 1, 2) = 'a1') then
    begin
    flds:=addr(addWorkTbl);  idxs:=addr(addWorkIdx);   fldhigh:=high(addWorkTbl); idxhigh:=high(addWorkIdx);
    end
  else if Copy(tblName, 1, 2) = 'c1' then
    begin
    flds:=addr(monthTbl);  idxs:=addr(monthIdx);       fldhigh:=high(monthTbl); idxhigh:=high(monthIdx);
    end
  else if Copy(tblName, 1, 2) = 't1' then
    begin
    flds:=addr(mojavvezTbl);  idxs:=addr(mojavvezIdx); fldhigh:=high(mojavvezTbl); idxhigh:=high(mojavvezIdx);
    end
  else if Copy(tblName, 1, 2) = 'n1' then
    begin
    flds:=addr(bargehTbl);  idxs:=addr(bargehIdx); fldhigh:=high(bargehTbl); idxhigh:=high(bargehIdx);
    end
  else if tblName = 'doctors' then
    begin
    flds:=addr(doctorsTbl);  idxs:=addr(doctorsIdx);   fldhigh:=high(doctorsTbl); idxhigh:=high(doctorsIdx);
    end
  else if tblName = 'diseases' then
    begin
    flds:=addr(diseasesTbl);  idxs:=addr(diseasesIdx); fldhigh:=high(diseasesTbl); idxhigh:=high(diseasesIdx);
    end
  else if tblName = 'mission1' then
    begin
    flds:=addr(mission1Tbl);  idxs:=addr(mission1Idx); fldhigh:=high(mission1Tbl); idxhigh:=high(mission1Idx);
    end
  else if tblName = 'mission2' then
    begin
    flds:=addr(mission2Tbl);  idxs:=addr(mission2Idx); fldhigh:=high(mission2Tbl); idxhigh:=high(mission2Idx);
    end
  else if tblName = 'onlycard' then
    begin
    flds:=addr(OnlyCardTbl);  idxs:=addr(OnlyCardIdx); fldhigh:=high(OnlyCardTbl); idxhigh:=high(OnlyCardIdx);
    end
  else if tblName = 'afreetyp' then
    begin
    flds:=addr(aFreeTypTbl);  idxs:=addr(aFreeTypIdx); fldhigh:=high(aFreeTypTbl); idxhigh:=high(aFreeTypIdx);
    end
  else if tblName = 'stations' then
    begin
    flds:=addr(StationsTbl);  idxs:=addr(StationsIdx); fldhigh:=high(StationsTbl); idxhigh:=high(StationsIdx);
    end
  else if tblName = 'help' then
    begin
    flds:=addr(HelpTbl);  idxs:=addr(HelpIdx);         fldhigh:=high(HelpTbl); idxhigh:=high(HelpIdx);
    end
  else if tblName = 'pishcard' then
    begin
    flds:=addr(pishcardTbl);  idxs:=addr(pishcardIdx); fldhigh:=high(pishcardTbl); idxhigh:=high(pishcardIdx)
    end
  else if tblName = 'init' then
    begin
    flds:=addr(InitTbl);  idxs:=addr(InitIdx); fldhigh:=high(InitTbl); idxhigh:=high(InitIdx);
    end
  else if tblName = 'customrp' then
    begin
    flds:=addr(customrpTbl);  idxs:=addr(customrpIdx); fldhigh:=high(customrpTbl); idxhigh:=high(customrpIdx);
    end
  else if tblName = 'customdp' then
    begin
    flds:=addr(customdpTbl);  idxs:=addr(customdpIdx); fldhigh:=high(customdpTbl); idxhigh:=high(customdpIdx);
    end
  else if tblName = 'mktextrp' then
    begin
    flds:=addr(mktextrpTbl);  idxs:=addr(mktextrpIdx); fldhigh:=high(mktextrpTbl); idxhigh:=high(mktextrpIdx);
    end
  else if tblName = 'holiday' then
    begin
    flds:=addr(holidayTbl);  idxs:=addr(holidayIdx); fldhigh:=high(holidayTbl); idxhigh:=high(holidayIdx);
    end
//////////////resturant///////////////////////////////////////
  else if tblName = 'week'  then
    begin
    flds:=addr(Weektbl);  idxs:=addr(WeekIdx); fldhigh:=high(Weektbl); idxhigh:=high(WeekIdx);
    end
  else if tblName = 'units' then
    begin
    flds:=addr(Unitstbl);  idxs:=addr(UnitsIdx); fldhigh:=high(Unitstbl); idxhigh:=high(UnitsIdx);
    end
  else if tblName = 'rdrkey' then
    begin
    flds:=addr(RdrKeytbl);  idxs:=addr(RdrKeyIdx); fldhigh:=high(RdrKeytbl); idxhigh:=high(RdrKeyIdx);
    end
  else if tblName = 'prgprs' then
    begin
    flds:=addr(PrgPrstbl);  idxs:=addr(PrgPrsIdx); fldhigh:=high(PrgPrstbl); idxhigh:=high(PrgPrsIdx);
    end
  else if tblName = 'outgroup' then
    begin
    flds:=addr(OutGrouptbl);  idxs:=addr(OutGroupIdx); fldhigh:=high(OutGrouptbl); idxhigh:=high(OutGroupIdx);
    end
  else if tblName = 'foodpric' then
    begin
    flds:=addr(FoodPricetbl);  idxs:=addr(FoodPriceIdx); fldhigh:=high(FoodPricetbl); idxhigh:=high(FoodPriceIdx);
    end
  else if tblName = 'foodlist' then
    begin
    flds:=addr(FoodListtbl);  idxs:=addr(FoodListIdx); fldhigh:=high(FoodListtbl); idxhigh:=high(FoodListIdx);
    end
  else if tblName = 'fishfood' then
    begin
    flds:=addr(FishFoodTbl);  idxs:=addr(FishFoodIdx); fldhigh:=high(FishFoodTbl); idxhigh:=high(FishFoodIdx);
    end
  else if tblName = 'fish' then
    begin
    flds:=addr(Fishtbl);  idxs:=addr(FishIdx); fldhigh:=high(Fishtbl); idxhigh:=high(FishIdx);
    end
  else if tblName = 'dblfish' then
    begin
    flds:=addr(DblFishTbl);  idxs:=addr(DblFishidx); fldhigh:=high(DblFishTbl); idxhigh:=high(DblFishidx);
    end
  else if tblName = 'clckrecs' then
    begin
    flds:=addr(ClckRecsTbl);  idxs:=addr(ClckRecsidx); fldhigh:=high(ClckRecsTbl); idxhigh:=high(ClckRecsidx);
    end
  else if tblName = 'building' then
    begin
    flds:=addr(BuildingTbl);  idxs:=addr(BuildingIdx); fldhigh:=high(BuildingTbl); idxhigh:=high(BuildingIdx);
    end
  else if tblName = 'amartabkh' then
    begin
    flds:=addr(AmarTabkhtbl);  idxs:=addr(AmarTabkhIdx); fldhigh:=high(AmarTabkhtbl); idxhigh:=high(AmarTabkhIdx);
    end
  else if tblName = 'amartabkhf' then
    begin
    flds:=addr(AmarTabkhFtbl);  idxs:=addr(AmarTabkhFIdx); fldhigh:=high(AmarTabkhFtbl); idxhigh:=high(AmarTabkhFIdx);
    end
  else if tblName = 'reservtype' then
    begin
    flds:=addr(ReservTypetbl);  idxs:=addr(ReservTypeIdx); fldhigh:=high(ReservTypetbl); idxhigh:=high(ReservTypeIdx);
    end
  else if tblName = 'charge' then
    begin
    flds:=addr(chargeTbl);  idxs:=addr(chargeIdx); fldhigh:=high(chargeTbl); idxhigh:=high(chargeIdx);
    end
  else if tblName = 'mochlog' then
    begin
    flds:=addr(mochTbl);  idxs:=addr(mochIdx); fldhigh:=high(mochTbl); idxhigh:=high(mochIdx);
    end
  else if tblName = 'yaraneh' then
    begin
    flds:=addr(yaranehTbl);  idxs:=addr(yaranehIdx); fldhigh:=high(yaranehTbl); idxhigh:=high(yaranehIdx);
    end
  else if tblName = 'limitusr' then
    begin
    flds:=addr(limitTbl);  idxs:=addr(limitIdx); fldhigh:=high(limitTbl); idxhigh:=high(limitIdx);
    end;

end;

function _CreateTbl(flds : array of TNewField ; idxs : array of TNewIndex ; dbName : string) : Boolean;
var
  i : Integer;
  sLoop, eLoop : Byte;
  adoQRY : TADOQuery;
  bdeTbl : TTable;
  FType : string;
  FSize : string;
begin
  {$IFDEF SqlPrc}
  {$Else}
  if (pos('p1', dbName) > 0) or (pos('P1', dbName) > 0) then
  begin
    bdeTbl := TTable.Create(Application);
    with bdeTbl do
    begin
      Active := false;
      DatabaseName := {$ifdef SqlTools}ExtractFilePath(Application.ExeName){$else}g_options.DataBasePath{$endif};
      TableType := ttParadox;
      TableName := dbName;
      FieldDefs.Clear;
      sLoop := Low(flds);
      eLoop := High(flds);
      for i := sLoop to eLoop  do
        with FieldDefs.AddFieldDef do
        begin
          Name := flds[i].fieldName;
          DataType := flds[i].fieldType;
          if DataType = ftString then
            Size := flds[i].fieldSize
          else
            Size := 0;
        end;

      IndexDefs.Clear;
      if idxs[0].fieldName <> '' then
      begin
        sLoop := Low(idxs);
        eLoop := High(idxs);
        for i := sLoop to eLoop  do
          with IndexDefs.AddIndexDef do
          begin
            Name := idxs[i].indexName;
            fields := idxs[i].fieldName;
            Options := idxs[i].idxOption;
          end;
      end;

      try
        CreateTable;
        Result := True;


      except
        Result := False;
      end;
      bdeTbl.Destroy;
    end;
  end
  else
  {$endif}
  begin
    adoQRY := TADOQuery.Create(Application);
    {$ifndef SqlTools}
    frmDBS.DBConnection.Open;
    {$EndIf}
    with {$ifdef SqlTools}frmSQLMenu.{$EndIf}adoQRY do
    begin
      Active := false;
      {$ifndef SqlTools}Connection := frmDBS.DBConnection;{$EndIf}
      SQL.Clear;
      SQL.Add('create table ' {$ifdef Network} + 'dbo.'{$endif} + dbName + '(');
      sLoop := Low(flds);
      eLoop := High(flds);

      for i := sLoop to eLoop do
      begin
        if flds[i].fieldType = ftSmallInt then
        begin
          FType := 'SmallInt';
          FSize := '';
        end;
        if flds[i].fieldType = ftCurrency then
        begin
          FType := 'money';
          FSize := '';
        end;
        if flds[i].fieldType = ftBoolean then
        begin
          FType := 'Bit';
          FSize := '';
        end;
        if flds[i].fieldType = ftString then
        begin
          FType := 'NVarChar';
          FSize := '(' + inttostr(flds[i].fieldSize) + ')';
        end;
        if flds[i].fieldType = ftInteger then
        begin
          FType := 'int';
          FSize := '';
        end;

        if i < eLoop then
          SQL.Add(flds[i].fieldName + ' ' + FType  + FSize + ',')
        else
          SQL.Add(flds[i].fieldName + ' ' + FType  + FSize);
      end;
      if (idxs[0].fieldName <> '') and (idxs[0].idxOption = [ixPrimary]) then
        SQL.Add(', primary key (' + idxs[0].fieldName + '))')
      else
        SQL.Add(')');

      try
        ExecSQL;
        result := true;
      except
          MessageDlg(SQL.Text,mtInformation,[mbok],0);
        result := false;
        exit;
      end;

      if idxs[0].fieldName <> '' then
      begin
        sLoop := Low(idxs);
        eLoop := High(idxs);
        for i := sLoop to eLoop  do
        begin
          SQL.Clear;
          if idxs[i].idxOption <> [ixPrimary] then
          begin
            SQL.Add('create index ' + idxs[i].indexName);
            SQL.Add(' on ' + dbName + '(' + idxs[i].fieldName + ')');
            try
              ExecSQL;
              result := true;
            except
              result := false;
              exit;
            end;
          end;
        end;
      end;
    end;
    adoQRY.close;
    adoQRY.Destroy;
  end;
end;

function _CreateTrigger(tblName : string) : Boolean;
var
  adoQRY : TADOQuery;
begin
  tblName := LowerCase(tblName);
  adoQRY := TADOQuery.Create(Application);
  {$ifndef SqlTools}
  frmDBS.DBConnection.Open;
  {$EndIf}
  with {$ifdef SqlTools}frmSQLMenu.{$EndIf}adoQRY do
  begin
    Active := false;
    {$ifndef SqlTools}Connection := frmDBS.DBConnection;{$EndIf}
    SQL.Clear;
    if tblName = 'charge' then
    begin
      SQL.Add('IF EXISTS (SELECT name FROM sysobjects');
      SQL.Add('WHERE name = ''Trig_Charge'' AND type = ''TR'')');
      SQL.Add('DROP TRIGGER Trig_Charge');
      ExecSQL;
      SQL.Clear;
      SQL.Add('CREATE TRIGGER Trig_Charge ON [dbo].[charge]');
      SQL.Add('FOR DELETE , INSERT, UPDATE');
      SQL.Add('AS');
      SQL.Add('Set nocount on');
      SQL.Add('update persons set p_credit=p_credit-c.ch_price');
      SQL.Add('from persons p,(select ch_barcode,ch_price=sum(ch_price) from deleted group by ch_barcode) c');
      SQL.Add('where p.p_barcode=c.ch_Barcode and not c.ch_price is null');
      SQL.Add('update persons set p_credit=p_credit+c.ch_price');
      SQL.Add('from persons p,(select ch_barcode,ch_price=sum(ch_price) from inserted group by ch_barcode) c');
      SQL.Add('where p.p_barcode=c.ch_Barcode and not c.ch_price is null');
      SQL.Add('Set nocount off');
    end
    else if tblName = 'fishfood' then
    begin
      SQL.Add('IF EXISTS (SELECT name FROM sysobjects');
      SQL.Add('WHERE name = ''Trig_FF'' AND type = ''TR'')');
      SQL.Add('DROP TRIGGER Trig_FF');
      ExecSQL;
      SQL.Clear;
      SQL.Add('CREATE TRIGGER [dbo].[Trig_FF] ON [dbo].[fishfood]');
      SQL.Add('FOR DELETE , INSERT, UPDATE');
      SQL.Add('AS');
      SQL.Add('Set nocount on');
      SQL.Add('update persons set p_credit=p_credit+ff.ff_pay from');
      SQL.Add('  (');
      SQL.Add('   select fish_pcode,ff_pay=sum(ff_pay) from fish , deleted');
      SQL.Add('   where   fish_no=ff_fishno and fish_type=ff_type and fish_date=ff_date and');
      SQL.Add('   not exists(select * from prgprs where pp_date=ff_date and pp_type=ff_type and pp_pcode=fish_pcode)');
      SQL.Add('   group by fish_pcode');
      SQL.Add('   )ff ,persons p');
      SQL.Add('where p.p_barcode=fish_pcode  and not ff_pay is null');
      SQL.Add('');
      SQL.Add('update persons set p_credit=p_credit-ff.ff_pay from');
      SQL.Add('  (');
      SQL.Add('   select fish_pcode,ff_pay=sum(ff_pay) from fish , inserted');
      SQL.Add('   where   fish_no=ff_fishno and fish_type=ff_type and fish_date=ff_date and');
      SQL.Add('   not exists(select * from prgprs where pp_date=ff_date and pp_type=ff_type and pp_pcode=fish_pcode)');
      SQL.Add('   group by fish_pcode');
      SQL.Add('   )ff ,persons p');
      SQL.Add('where p.p_barcode=fish_pcode  and not ff_pay is null');
      SQL.Add('Set nocount off');
    end
    else if tblName = 'prgprs' then
    begin
      SQL.Add('IF EXISTS (SELECT name FROM sysobjects');
      SQL.Add('WHERE name = ''Trig_PrgPrs'' AND type = ''TR'')');
      SQL.Add('DROP TRIGGER Trig_PrgPrs');
      ExecSQL;
      SQL.Clear;
      SQL.Add('CREATE TRIGGER [dbo].[Trig_PrgPrs] ON [dbo].[prgprs]');
      SQL.Add('FOR DELETE , INSERT, UPDATE');
      SQL.Add('AS');
      SQL.Add('Set nocount on');
      SQL.Add('update persons set p_credit=p_credit+ pp_price from persons p,');
      SQL.Add('(select pp_pcode,pp_price=sum(pp_price) from deleted');
      SQL.Add('where not exists(select * from fish,fishfood where fish_no=ff_fishno and fish_date=ff_Date and ff_Date=pp_date and fish_type=ff_type and ff_type=pp_type and fish_pcode=pp_Pcode)');
      SQL.Add('group by pp_pcode');
      SQL.Add(') pp');
      SQL.Add('where p_barcode=pp_Pcode');
      SQL.Add('and not pp_price is null');
      SQL.Add('update persons set p_credit=p_credit- pp_price from persons p,');
      SQL.Add('(select pp_pcode,pp_price=sum(pp_price) from inserted');
      SQL.Add('where not exists(select * from fish,fishfood where fish_no=ff_fishno and fish_date=ff_Date and ff_Date=pp_date and fish_type=ff_type and ff_type=pp_type and fish_pcode=pp_Pcode)');
      SQL.Add('group by pp_pcode');
      SQL.Add(') pp');
      SQL.Add('where p_barcode=pp_Pcode');
      SQL.Add('and not pp_price is null');
      SQL.Add('Set nocount off');
    end;
    if sql.Text <> '' then
      try
        ExecSQL;
        result := true;
      except
        result := false;
      end
    else
      result := true;
    adoQRY.close;
    adoQRY.Destroy;
  end;
end;
function changedTbl(dbName : string) : Boolean;
type
  af = array[0..1] of TNewField;
  ax = array[0..1] of TNewIndex;
var
  i : Integer;
  sLoop, eLoop : Byte;
  tbl : tadotable;
  fld : TField;
  flds : ^af;
  idxs : ^ax;
  fldptr : pointer absolute flds;
  idxptr : pointer absolute idxs;
  fldhigh,idxhigh:byte;
begin
{$ifndef SqlTools}
    if not tblexists(dbname)
    then begin
         result:=true;
         exit;
    end;
{$EndIf}
    result:=false;

    findtbl(dbname,fldptr,fldhigh,idxptr,idxhigh);

    tbl:=TAdoTable.Create(Application);
    with tbl do
    begin
      Active := false;
      Connection := {$ifdef SqlTools}frmSQLMenu.adoConct{$else}frmDBS.DBConnection{$EndIf};
      TableName := DbName;
      Active := True;
    end;

    sLoop := 0;
    eLoop := fldHigh;
    i:=sloop;
    while not result and (i<=eloop) do
    begin
        fld := tbl.FindField(flds[i].fieldName);
        if  fld = nil
        then result:=true;
        inc(i);
    end;
    tbl.close;
    tbl.Destroy;
end;


 function Createview(viwName : String):boolean;
 var
      adoQRY : TADOQuery;
      sqltxt:string;
 begin
{$ifdef SqlTools}
    adoQRY := TADOQuery.Create(Application);
    adoQRY.Connection:= {$ifdef SqlTools}frmSQLMenu.adoConct{$else}frmDBS.DBConnection{$EndIf};
    adoQRY.close;
    adoQRY.sql.Clear ;
     sqltxt:= 'CREATE VIEW  '+ viwName +
              ' AS ( SELECT ' + frmSQLMenu.txt_link.Text     +
              '.dbo. '+viwname +
               ' .* FROM '+frmSQLMenu.txt_link.Text  +
               '.dbo.'+ viwname  +
               ')';

    adoQRY.sql.Add(sqltxt);
    adoQRY.ExecSQL ;
     result:=true;
{$EndIf}
end;

function CreateTbl(tblName : String; inParadox : Boolean) : Boolean;
begin
  tblName := LowerCase(tblName);

//************************* clock and Rest*************************************
  if tblName = 'security' then
  case appType of
    appClock     : result:= _CreateTbl( securitytbl, securityIdx ,tblName );
    appResturant : Result:= _CreateTbl(securityTblr , securityIdxr , tblName);
  end
  else if tblName = 'readers' then
  case appType of
    appClock     : result:= _CreateTbl( readerstbl, readersIdx , tblName );
    appResturant : Result:= _CreateTbl( readerstblr, readersIdxr ,tblName );
  end
  else if tblName = 'groups' then
  case appType of
    appClock     : Result:=_CreateTbl(groupsTbl , groupsIdx , tblName);
    appResturant : Result:=_CreateTbl(groupsTblr, groupsIdxr, tblName);
  end

  else if tblName = 'persons' then
    result:= _CreateTbl(personsTbl, personsIdx ,tblName )
  else if tblName = 'parts' then
    Result:=_CreateTbl(partsTbl , partsIdx , tblName)
  else if tblName = 'userstat' then
    result:= _CreateTbl(userStattbl , userStatIdx , tblName)
  else if tblName = 'jobtype' then
    result:= _CreateTbl(jobTypetbl,jobTypeIdx ,tblName)
  else if tblName = 'coposts' then
    Result:=_CreateTbl(coPostsTbl , coPostsIdx , tblName)
  else if tblName = 'jobtype' then
    Result:= _CreateTbl(jobTypeTbl , jobTypeIdx , tblName)
  else if tblName = 'part1' then
    Result:=_CreateTbl(part1Tbl , part1Idx , tblName)
  else if tblName = 'part2' then
    Result:=_CreateTbl(part2Tbl , part2Idx , tblName)
  else if tblName = 'part3' then
    Result:=_CreateTbl(part3Tbl , part3Idx , tblName)
  else if tblName = 'part4' then
    Result:=_CreateTbl(part4Tbl , part4Idx , tblName)

//************************* Rest *************************************
  else if tblName = 'week'  then
    result:= _CreateTbl(Weektbl , WeekIdx ,tblName )
  else if tblName = 'units' then
    result:= _CreateTbl( Unitstbl, UnitsIdx ,tblName )
  else if tblName = 'rdrkey' then
    result:= _CreateTbl( RdrKeytbl, RdrKeyIdx ,tblName )
  else if tblName = 'prgprs' then
    result:= _CreateTbl(  PrgPrstbl, PrgPrsIdx  ,tblName)
  else if tblName = 'outgroup' then
    result:= _CreateTbl( OutGrouptbl, OutGroupIdx ,tblName )
  else if tblName = 'foodpric' then
    result:= _CreateTbl(  FoodPricetbl, FoodPriceIdx ,tblName)
  else if tblName = 'foodlist' then
    result:= _CreateTbl(FoodListtbl , FoodListIdx , tblName)
  else if tblName = 'fishfood' then
    result:= _CreateTbl( FishFoodTbl , FishFoodIdx ,tblName)
  else if tblName = 'fish' then
    result:= _CreateTbl( Fishtbl, FishIdx ,tblName )
  else if tblName = 'dblfish' then
    result:= _CreateTbl( DblFishTbl, DblFishidx ,tblName )
  else if tblName = 'clckrecs' then
    result:= _CreateTbl( ClckRecsTbl, ClckRecsidx,tblName )
  else if tblName = 'building' then
    result:= _CreateTbl( BuildingTbl, BuildingIdx , tblName)
  else if tblName = 'amartabkh' then
    result:= _CreateTbl(  AmarTabkhtbl, AmarTabkhIdx ,tblName)
  else if tblName = 'amartabkhf' then
    result:= _CreateTbl(  AmarTabkhFtbl, AmarTabkhFIdx ,tblName)
  else if tblName = 'reservtype' then
    result := _CreateTbl(ReservTypetbl, ReservTypeIdx, tblName)
  else if tblName = 'charge' then
    result := _CreateTbl(ChargeTbl, ChargeIdx, tblName)
  else if tblName = 'yaraneh' then
    result := _CreateTbl(yaranehTbl, yaranehIdx, tblName)
  else if tblName = 'limitusr' then
    result := _CreateTbl(limitTbl, limitIdx, tblName)


//************************* clock *************************************

  else if tblName = 'rules' then
    result:= _CreateTbl(rulesTbl , rulesIdx , tblName)
  else if tblName = 'rulesetc' then
    result:= _CreateTbl(rulesetcTbl , rulesetcIdx , tblName)
  else if tblName = 'tmppersons' then
    Result:=  _CreateTbl(tmpPersonsTbl , tmpPersonsIdx , tblName)
  else if tblName = 'cities' then
    Result:=_CreateTbl(cityTbl , cityIdx , tblName)
  else if tblName = 'curse' then
    Result:=_CreateTbl(curseTbl , curseIdx , tblName)
  else if tblName = 'shifts' then
    Result:=_CreateTbl(shiftsTbl , shiftsIdx , tblName)
  else if tblName = 'spshift' then
    Result:=_CreateTbl(spShiftTbl , spShiftIdx , tblName)
  else if tblName = 'spgroup' then
    Result:=_CreateTbl(spGroupTbl , spGroupIdx , tblName)
  else if tblName = 'grp_dtl' then
    Result:=_CreateTbl(grp_DtlTbl , grp_DtlIdx , tblName)
  else if tblName = 'groupm' then
    Result:=_CreateTbl(groupMTbl , groupMIdx , tblName)
  else if tblName = 'grpm_dtl' then
    Result:=_CreateTbl(grpM_DtlTbl , grpM_DtlIdx , tblName)
  else if tblName = 'errors' then
    Result:=_CreateTbl(errorsTbl , errorsIdx , tblName)
  else if tblName = 'morkhasi' then
    Result:=_CreateTbl(morkhasiTbl , morkhasiIdx , tblName)
  else if tblName = 'spmor' then
    Result:=_CreateTbl(SpMorTbl , SpMorIdx , tblName)
  else if tblName = 'users' then
    Result:=_CreateTbl(UsersTbl , UsersIdx , tblName)
  else if tblName = 'lahzeh' then
    Result:=_CreateTbl(lahzehTbl , lahzehIdx , tblName)
  else if tblName = 'madraks' then
    Result:=_CreateTbl(madrakTbl , madrakIdx , tblName)
  else if tblName = 'reserve7' then
    Result:=_CreateTbl(reserve7Tbl , reserve7Idx , tblName)
  else if tblName = 'reserve8' then
    Result:=_CreateTbl(reserve8Tbl , reserve8Idx , tblName)
  else if tblName = 'addfree' then
    Result:=_CreateTbl(addFreeTbl , addFreeIdx , tblName)
  else if tblName = 'finger' then
    Result:=_CreateTbl(fingerTbl , FingerIdx , tblName)
  else if tblName = 'fgr_dtl' then
    Result:=_CreateTbl(fgr_DtlTbl , fgr_DtlIdx , tblName)
  else if tblName = 'smorkhasi' then
    Result:=_CreateTbl(smorkhasiTbl , morkhasiIdx , tblName)
  else if copy(tblName, 1, 2) = 'p1' then
    Result:=_CreateTbl(mahanehTbl , mahanehIdx , tblName)
  else if (copy(tblName, 1, 2) = 'e1') or (copy(tblName, 1, 2) = 'a1') then
    Result:=_CreateTbl(addWorkTbl , addWorkIdx , tblName)
  else if Copy(tblName, 1, 2) = 'c1' then
    Result:=_CreateTbl(monthTbl, monthIdx, tblName)
  else if Copy(tblName, 1, 2) = 't1' then
   Result:= _CreateTbl(mojavvezTbl, mojavvezIdx, tblName)
  else if Copy(tblName, 1, 2) = 'n1' then
   Result:= _CreateTbl(bargehTbl, bargehIdx, tblName)
  else if tblName = 'doctors' then
    Result:=_CreateTbl(doctorsTbl , doctorsIdx , tblName)
  else if tblName = 'diseases' then
    Result:=_CreateTbl(diseasesTbl , diseasesIdx , tblName)
  else if tblName = 'mission1' then
    Result:=_CreateTbl(mission1Tbl , mission1Idx , tblName)
  else if tblName = 'mission2' then
    Result:=_CreateTbl(mission2Tbl , mission2Idx , tblName)
  else if tblName = 'onlycard' then
    Result:=_CreateTbl(OnlyCardTbl , OnlyCardIdx , tblName)
  else if tblName = 'afreetyp' then
    Result:=_CreateTbl(aFreeTypTbl , aFreeTypIdx , tblName)
  else if tblName = 'stations' then
    Result:=_CreateTbl(StationsTbl , StationsIdx , tblName)
  else if tblName = 'help' then
    Result:=_CreateTbl(HelpTbl , HelpIdx , tblName)
  else if tblName = 'pishcard' then
    Result:=_CreateTbl(pishcardTbl , pishcardIdx , tblName)
  else if tblName = 'init' then
    Result:=_CreateTbl(InitTbl , InitIdx , tblName)
  else if tblName = 'customrp' then
    Result:=_CreateTbl(customrpTbl , customrpIdx , tblName)
  else if tblName = 'customdp' then
    Result:=_CreateTbl(customdpTbl , customdpIdx , tblName)
  else if tblName = 'mktextrp' then
    Result:=_CreateTbl(mktextrpTbl , mktextrpIdx , tblName)
  else  if tblName = 'webpass' then
    Result:= _CreateTbl(WebpassTbl , WebpassIdx , tblName)
  else  if tblName = 'webpasspersons' then
    Result:= _CreateTbl(WebpassPersonsTbl , WebpassPersonsIdx , tblName)
  else  if tblName = 'agree' then
    Result:= _CreateTbl(AgreeTbl , AgreeIdx , tblName)
  else if tblName = 'holiday' then
    Result:= _CreateTbl(holidayTbl , holidayIdx , tblName)
  else if tblName = 'mochlog' then
    result := _CreateTbl(mochTbl, mochIdx, tblName)
  else if tblName = 'limitusr' then
    result := _CreateTbl(limitTbl, limitIdx, tblName);
end;


function renametbl(tblname:string):boolean;
  var
   qry : TAdoQuery;
   s:string;
   begin
    s:=tblname+DateToStr (date);
    s:=s+TimeToStr(time);
    qry := TAdoQuery.Create(Application);
    qry.Connection := {$ifdef SqlTools}frmSQLMenu.adoConct;{$else} frmDbs.DBConnection{$endif};
    qry.SQL.clear;
    qry.SQL.Add('exec sp_rename ' + tblName + ','+ ''''+ s + '''');
  TRY
    qry.ExecSQL;
    RESULT:=TRUE;
  EXCEPT
    RESULT:=false;
  end;
    qry.Close;

end;


function PDoxTblCreation(flds : array of TNewField; tblName, dbPath : String) : Boolean;
var
  i : Integer;
  sLoop, eLoop : Byte;
  tbl : TTable;
begin
  tbl := TTable.Create(Application);
  with  tbl do
  begin
    Active := False;
    DatabaseName := dbPath;
    TableType := ttParadox;
    TableName := tblName;
    FieldDefs.Clear;
    IndexDefs.Clear;

    sLoop := Low(flds);
    eLoop := High(flds);
    for i := sLoop to eLoop  do
      with FieldDefs.AddFieldDef do
      begin
        Name := flds[i].fieldName;
//        if flds[i].fieldType = ftLargeint then
//          flds[i].fieldType := ftInteger;
        DataType := flds[i].fieldType;
        if DataType = ftString then
          Size := flds[i].fieldSize
        else
          Size := 0;
      end;

    try
      CreateTable;
      Result := True;
    except
      Result := False;
    end;
    Free;
  end;
end;

function CreatePDoxTbl(tblName, dbPath : String) : Boolean;
begin
  tblName := LowerCase(tblName);
  if tblName = 'rules' then
    Result := PDoxTblCreation(rulesTbl, tblName, dbPath)
  else if tblName = 'rulesetc' then
    Result := PDoxTblCreation(rulesetcTbl, tblName, dbPath)
  else if tblName = 'persons' then
    Result := PDoxTblCreation(personsTbl, tblName, dbPath)
  else if tblName = 'tmppersons' then
    Result := PDoxTblCreation(tmpPersonsTbl, tblName, dbPath)
  else if tblName = 'cities' then
    Result := PDoxTblCreation(cityTbl, tblName, dbPath)
  else if tblName = 'curse' then
    Result := PDoxTblCreation(curseTbl, tblName, dbPath)
  else if tblName = 'coposts' then
    Result := PDoxTblCreation(coPostsTbl, tblName, dbPath)
  else if tblName = 'jobtype' then
    Result := PDoxTblCreation(jobTypeTbl, tblName, dbPath)
  else if tblName = 'part1' then
    Result := PDoxTblCreation(part1Tbl, tblName, dbPath)
  else if tblName = 'part2' then
    Result := PDoxTblCreation(part2Tbl, tblName, dbPath)
  else if tblName = 'part3' then
    Result := PDoxTblCreation(part3Tbl, tblName, dbPath)
  else if tblName = 'part4' then
    Result := PDoxTblCreation(part4Tbl, tblName, dbPath)
  else if tblName = 'parts' then
    Result := PDoxTblCreation(partsTbl, tblName, dbPath)
  else if tblName = 'shifts' then
    Result := PDoxTblCreation(shiftsTbl, tblName, dbPath)
  else if tblName = 'spshift' then
    Result := PDoxTblCreation(spShiftTbl, tblName, dbPath)
  else if tblName = 'spgroup' then
    Result := PDoxTblCreation(spGroupTbl, tblName, dbPath)
  else if tblName = 'groups' then
    case appType of
      appClock     : begin Result := PDoxTblCreation(groupsTbl, tblName, dbPath) end;
      appResturant : begin Result := PDoxTblCreation(groupsTblr, tblName, dbPath) end;
    end
  else if tblName = 'grp_dtl' then
    Result := PDoxTblCreation(grp_DtlTbl, tblName, dbPath)
  else if tblName = 'groupm' then
    Result := PDoxTblCreation(groupMTbl, tblName, dbPath)
  else if tblName = 'grpm_dtl' then
    Result := PDoxTblCreation(grpM_DtlTbl, tblName, dbPath)
  else if tblName = 'errors' then
    Result := PDoxTblCreation(errorsTbl, tblName, dbPath)
  else if tblName = 'morkhasi' then
    Result := PDoxTblCreation(morkhasiTbl, tblName, dbPath)
  else if tblName = 'smorkhasi' then
    Result := PDoxTblCreation(smorkhasiTbl, tblName, dbPath)
  else if tblName = 'spmor' then
    Result := PDoxTblCreation(SpMorTbl, tblName, dbPath)
  else if tblName = 'readers' then
    case appType of
      appClock     : begin Result := PDoxTblCreation(readersTbl, tblName, dbPath) end;
      appResturant : begin Result := PDoxTblCreation(readersTblr, tblName, dbPath) end;
    end
  else if tblName = 'security' then
    case appType of
      appClock     : begin Result := PDoxTblCreation(securityTbl, tblName, dbPath) end;
      appResturant : begin Result := PDoxTblCreation(securityTblr, tblName, dbPath) end;
    end
  else if tblName = 'users' then
    Result := PDoxTblCreation(UsersTbl, tblName, dbPath)
  else if tblName = 'userstat' then
    Result := PDoxTblCreation(userStatTbl, tblName, dbPath)
  else if tblName = 'lahzeh' then
    Result := PDoxTblCreation(lahzehTbl, tblName, dbPath)
  else if tblName = 'madraks' then
    Result := PDoxTblCreation(madrakTbl, tblName, dbPath)
  else if tblName = 'reserve7' then
    Result := PDoxTblCreation(reserve7Tbl, tblName, dbPath)
  else if tblName = 'reserve8' then
    Result := PDoxTblCreation(reserve8Tbl, tblName, dbPath)
  else if tblName = 'addfree' then
    Result := PDoxTblCreation(addFreeTbl, tblName, dbPath)
  else if tblName = 'finger' then
    Result := PDoxTblCreation(fingerTbl, tblName, dbPath)
  else if tblName = 'fgr_dtl' then
    Result := PDoxTblCreation(fingerTbl, tblName, dbPath)
  else if Copy(tblName, 1, 2) = 'c1' then
    Result := PDoxTblCreation(monthTbl, tblName, dbPath)
  else if Copy(tblName, 1, 2) = 't1' then
    Result := PDoxTblCreation(mojavvezTbl, tblName, dbPath)
  else if Copy(tblName, 1, 2) = 'n1' then
    Result := PDoxTblCreation(bargehTbl, tblName, dbPath)
  else if copy(tblName,1,2) = 'p1' then
    Result := PDoxTblCreation(mahanehTbl, tblName, dbPath)
  else if (copy(tblName,1,2) = 'e1') or (copy(tblName,1,2) = 'a1') then
    Result := PDoxTblCreation(addWorkTbl, tblName, dbPath)
  else if tblName = 'doctors' then
    Result := PDoxTblCreation(doctorsTbl ,  tblName, dbPath)
  else if tblName = 'diseases' then
    Result := PDoxTblCreation(diseasesTbl , tblName, dbPath)
  else if tblName = 'mission1' then
    Result := PDoxTblCreation(mission1Tbl , tblName, dbPath)
  else if tblName = 'mission2' then
    Result := PDoxTblCreation(mission2Tbl , tblName, dbPath)
  else if tblName = 'onlycard' then
    Result := PDoxTblCreation(onlyCardTbl , tblName, dbPath)
  else if tblName = 'afreetyp' then
    Result := PDoxTblCreation(afreetypTbl , tblName, dbPath)
  else if tblName = 'stations' then
    Result := PDoxTblCreation(coPostsTbl, tblName, dbPath)
  else if tblName = 'pishcard' then
    Result := PDoxTblCreation(pishcardTbl, tblName, dbPath)
  else if tblName = 'init' then
    Result := PDoxTblCreation(InitTbl, tblName, dbPath)
  else if tblName = 'customrp' then
    Result := PDoxTblCreation(customrpTbl, tblName, dbPath)
  else if tblName = 'customdp' then
    Result := PDoxTblCreation(customdpTbl, tblName, dbPath)
  else if tblName = 'mktextrp' then
    Result := PDoxTblCreation(mktextrpTbl, tblName, dbPath)
  else if tblName = 'holiday' then
    Result := PDoxTblCreation(holidayTbl, tblName, dbPath)


  else if tblName = 'building' then
    PDoxTblCreation(BuildingTbl , tblName, dbPath)
  else if tblName = 'dblfish' then
    PDoxTblCreation(DblFishTbl , tblName, dbPath)
  else if tblName = 'fish' then
    PDoxTblCreation(fishTbl , tblName, dbPath)
  else if tblName = 'fishfood' then
    PDoxTblCreation(fishfoodTbl , tblName, dbPath)
  else if tblName = 'foodlist' then
    PDoxTblCreation(foodlistTbl , tblName, dbPath)
  else if tblName = 'foodpric' then
    PDoxTblCreation(FoodPriceTbl , tblName, dbPath)
  else if tblName = 'outgroup' then
    PDoxTblCreation(outgroupTbl , tblName, dbPath)
  else if tblName = 'prgprs' then
    PDoxTblCreation(prgprsTbl , tblName, dbPath)
  else if tblName = 'rdrkey' then
    PDoxTblCreation(rdrkeyTbl , tblName, dbPath)
  else if tblName = 'units' then
    PDoxTblCreation(unitsTbl , tblName, dbPath)
  else if tblName = 'week' then
    PDoxTblCreation(weekTbl , tblName, dbPath)
  else if tblName = 'clckrecs' then
    PDoxTblCreation(ClckRecsTbl , tblName, dbPath)
  else if tblName = 'amartabkh' then
    PDoxTblCreation(AmarTabkhTbl , tblName, dbPath)
  else if tblName = 'amartabkhf' then
    PDoxTblCreation(AmarTabkhFTbl , tblName, dbPath)
  else if tblName = 'limitusr' then
    PDoxTblCreation(limitTbl , tblName, dbPath)

  else
    Result := False;
end;
 {$ifndef SqlTools}
Procedure UpgradeTable1(tblName : string);
var
  tblOld , tblNew : TAdoTable;
  qry : TAdoQuery;
  i : integer;
  fld : TField;
begin
  {$IFDEF SqlPrc}
  {$Else}
  if (Pos('p1', tblName) > 0) or (Pos('P1', tblName) > 0) or (tblName = 'InOutTmp')then
  begin
    CreateTbl(tblName);
    Exit;
  end;
  {$Endif}
  if not tblExists(tblName) then
    CreateTbl(tblName)
  else
  begin
    tblOld := TAdoTable.Create(Application);
    tblNew := TAdoTable.Create(Application);
    qry := TAdoQuery.Create(Application);
    qry.Connection := frmDBS.DBConnection;
    with tblOld do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := tblName;
      Active := True;
    end;
    tblOld.Close;
    if tblExists('Temp') then
    begin
      qry.SQL.clear;
      qry.SQL.Add('drop table temp');
      qry.ExecSQL;
    end;
    qry.SQL.clear;
    qry.SQL.Add('exec sp_rename ' + tblName + ',Temp');
    qry.ExecSQL;
    tblOld.TableName := 'Temp';
    tblOld.Open;

    CreateTbl(tblName);
    with tblNew do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := tblName;
      Active := True;
    end;
    tblOld.First;


    tblOld.First;
    while not tblOld.Eof do
    begin
      tblNew.Append;
      for i := 0 to tblOld.FieldCount - 1 do
      begin
        fld := tblNew.FindField(tblOld.Fields[i].FieldName);
        if  fld <> nil then
        begin
          if tblNew.Fields[fld.FieldNo-1].DataType = tblOld.Fields[i].DataType then
            tblNew.FieldByName(tblOld.Fields[i].FieldName).Value := tblOld.Fields[i].Value;
        end;
      end;
      tblNew.Post;
      tblOld.Next;
    end;
    tblOld.close;
    tblNew.Close;

    qry.SQL.clear;
    qry.SQL.Add('drop table temp');
    qry.ExecSQL;

    tblOld.Destroy;
    tblNew.Destroy;
  end;
end;

Procedure UpgradeTable(tblName : string);
type
  af = array[0..1] of TNewField;
  ax = array[0..1] of TNewIndex;
var
  tblOld , tblNew : TAdoTable;
  qry : TAdoQuery;
  i : integer;
  fld : TField;
  flds : ^af;
  idxs : ^ax;
  fldptr : pointer absolute flds;
  idxptr : pointer absolute idxs;
  fldhigh,idxhigh:byte;
  indexname : string;
  indexcount: byte;
  indexnames: array[1..10] of string;

function typest(i:byte):string;
begin
  case flds^[i].fieldtype of
      ftSmallInt: Typest := 'SmallInt';
      ftBoolean : Typest := 'Bit';
      ftString  : Typest := 'NVarChar(' + inttostr(flds^[i].fieldSize) + ')';
      ftInteger : Typest := 'int';
      ftLargeint: Typest := 'BigInt';
  end;
end;
begin
{  UpgradeTable1(tblName); exit;}
  {$IFDEF SqlPrc}
  {$Else}
  if (Pos('p1', tblName) > 0) or (Pos('P1', tblName) > 0) or (tblName = 'InOutTmp')then
  begin
    CreateTbl(tblName);
    Exit;
  end;
  {$Endif}
  if not tblExists(tblName)
  then begin
       CreateTbl(tblName);
       exit;
  end
  else begin
    tblOld := TAdoTable.Create(Application);
    tblNew := TAdoTable.Create(Application);
    qry := TAdoQuery.Create(Application);
    qry.Connection := frmDBS.DBConnection;

    findtbl(tblname,fldptr,fldhigh,idxptr,idxhigh);

    if tblExists('Temp')
    then begin
         qry.SQL.clear;
         qry.SQL.Add('drop table temp');
         qry.ExecSQL;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('select distinct * into temp from '+tblname);
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('drop table '+tblname);
    qry.ExecSQL;

    CreateTbl(tblName);

    with tblNew do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := tblName;
      Active := True;
    end;

    with tblOld do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := 'temp';
      Active := True;
    end;

    tblOld.First;
    while not tblOld.Eof do
    begin
      tblNew.Append;
      for i := 0 to tblnew.FieldCount - 1 do
      begin
        fld := tblold.FindField(tblnew.Fields[i].FieldName);
        if  fld <> nil then
        begin
//          if tblNew.Fields[fld.FieldNo-1].DataType = tblOld.Fields[i].DataType then
            tblNew.fields[i].Value := tblOld.FieldByName(tblnew.Fields[i].FieldName).Value;
        end
        else begin
            case tblNew.fields[i].DataType of
              ftSmallInt,ftInteger,ftLargeint: tblNew.fields[i].Value := 0;
              ftBoolean : tblNew.fields[i].Value := false;
              ftString  : tblNew.fields[i].Value := '';
            end;

        end;
      end;
      tblNew.Post;
      tblOld.Next;
    end;
    _CreateTrigger(tblName);
    tblOld.close;
    tblNew.Close;
    tblOld.Destroy;
    tblNew.Destroy;
    {
    qry.SQL.Clear;
    qry.SQL.Add('insert into '+tblname+' select * from temp');
    qry.ExecSQL;
    }
    {
    qry.SQL.Clear;
    qry.SQL.Add('SELECT name FROM sysindexes WHERE (name LIKE ''PK__'+tblname+'__%'')');
    qry.open;
    indexcount:=0;
    while not qry.Eof do
    begin
         inc(indexcount);
         indexnames[indexcount]:=qry.FieldByName('name').asstring;
         qry.Next;
    end;
    qry.Close;
    for i:=1 to indexcount do
    begin
      indexname:=indexnames[i];
      qry.SQL.Clear;
//      qry.SQL.Add('drop index '+tblname+'.'+indexname);
      qry.SQL.Add('alter table '+tblname+' drop constraint '+indexname);
      qry.execsql;
      qry.Close;
    end;

    for i:=0 to fldhigh do
    begin
        fld := tbl.FindField(flds^[i].fieldname);
        if  fld = nil
        then begin
            qry.SQL.Clear;
            qry.SQL.Add('alter table '+tblname+' add '+flds^[i].fieldName + ' ' + Typest(i));
            qry.execsql;
        end
        else begin
            if (fld.DataType<>flds^[i].fieldtype) or (fld.datasize<>flds^[i].fieldsize)
            then begin
              qry.SQL.Clear;
              qry.SQL.Add('alter table '+tblname+' alter column '+flds^[i].fieldName + ' ' + Typest(i));
              qry.execsql;
            end;
        end;
    end;
    tbl.close;
    }
    qry.Destroy;
  end;
end;

Procedure BreakTable(tblName,tblnameetc : string);
type
  af = array[0..1] of TNewField;
  ax = array[0..1] of TNewIndex;
var
  tblOld , tblNew, tblnewetc : TAdoTable;
  qry : TAdoQuery;
  i : integer;
  fld : TField;
  flds : ^af;
  idxs : ^ax;
  fldptr : pointer absolute flds;
  idxptr : pointer absolute idxs;
  fldhigh,idxhigh:byte;
  indexname : string;
  indexcount: byte;
  indexnames: array[1..10] of string;

function typest(i:byte):string;
begin
  case flds^[i].fieldtype of
      ftSmallInt: Typest := 'SmallInt';
      ftBoolean : Typest := 'Bit';
      ftString  : Typest := 'NVarChar(' + inttostr(flds^[i].fieldSize) + ')';
      ftInteger : Typest := 'int';
      ftLargeint: Typest := 'BigInt';
  end;
end;
begin
  if not tblExists(tblName)
  then begin
       CreateTbl(tblName);
       CreateTbl(tblNameetc);
       exit;
  end
  else begin
    tblOld := TAdoTable.Create(Application);
    tblNew := TAdoTable.Create(Application);
    tblNewetc := TAdoTable.Create(Application);
    qry := TAdoQuery.Create(Application);
    qry.Connection := frmDBS.DBConnection;

//    findtbl(tblname,fldptr,fldhigh,idxptr,idxhigh);

    if tblExists('Temp')
    then begin
         qry.SQL.clear;
         qry.SQL.Add('drop table temp');
         qry.ExecSQL;
    end;
    if tblExists('Tempold')
    then begin
//         qry.SQL.clear;
//         qry.SQL.Add('drop table tempetc');
//         qry.ExecSQL;
    end
    else begin
      qry.SQL.Clear;
      qry.SQL.Add('select * into tempold from '+tblname);
      qry.ExecSQL;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('select distinct * into temp from '+tblname);
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add('drop table '+tblname);
    qry.ExecSQL;

    CreateTbl(tblName);
    CreateTbl(tblNameetc);

    with tblNew do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := tblName;
      Active := True;
    end;
    with tblNewetc do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := tblNameetc;
      Active := True;
    end;
    with tblOld do
    begin
      Active := false;
      Connection := frmDBS.DBConnection;
      TableName := 'temp';
      Active := True;
    end;

    tblOld.First;
    while not tblOld.Eof do
    begin
      tblNew.Append;
      tblNewetc.Append;
      for i := 0 to tblOld.FieldCount - 1 do
      begin
        fld := tblNew.FindField(tblOld.Fields[i].FieldName);
        if  fld <> nil then
        begin
//          if tblNew.Fields[fld.FieldNo-1].DataType = tblOld.Fields[i].DataType then
            tblNew.FieldByName(tblOld.Fields[i].FieldName).Value := tblOld.Fields[i].Value;
        end;
        fld := tblNewetc.FindField(tblOld.Fields[i].FieldName);
        if  fld <> nil then
        begin
//          if tblNew.Fields[fld.FieldNo-1].DataType = tblOld.Fields[i].DataType then
            tblNewetc.FieldByName(tblOld.Fields[i].FieldName).Value := tblOld.Fields[i].Value;
        end;
      end;
      tblNew.Post;
      tblNewetc.Post;
      tblOld.Next;
    end;
    tblOld.close;
    tblNew.Close;
    tblOld.Destroy;
    tblNew.Destroy;
    qry.Destroy;
  end;
end;

procedure MatchTables(tblName,tblnameetc,fldname : string);
var
  qry : TAdoQuery;
  i : integer;
  fldset,fldsetetc,setmore  : set of byte;

begin
  if not tblExists(tblName)
  then begin
       exit;
  end;
  if not tblExists(tblNameetc)
  then begin
       exit;
  end;
  qry := TAdoQuery.Create(Application);
  qry.Connection := frmDBS.DBConnection;

  qry.SQL.Clear;
  qry.SQL.Add('select '+fldname+' from '+tblname);
  qry.open;
  fldset:=[];
  while not qry.eof do
  begin
    if qry.FieldByName(fldname).asstring<>''
    then begin
      i:=qry.FieldByName(fldname).asinteger;
      fldset:=fldset+[i];
    end;
    qry.Next;
  end;
  qry.Close;

  qry.SQL.Clear;
  qry.SQL.Add('select '+fldname+' from '+tblnameetc);
  qry.open;
  fldsetetc:=[];
  while not qry.eof do
  begin
    if qry.FieldByName(fldname).asstring<>''
    then begin
      i:=qry.FieldByName(fldname).asinteger;
      fldsetetc:=fldsetetc+[i];
    end;
    qry.Next;
  end;
  qry.Close;
  if fldset<>fldsetetc
  then begin
      setmore:=fldset-fldsetetc;
      if setmore<>[]
      then begin
        for i:=1 to 255 do
        if i in setmore
        then begin
          qry.SQL.clear;
          qry.SQL.Add('insert into '+tblnameetc+ '('+fldname+') values ('+inttostr(i)+')');
          qry.ExecSQL;
        end;
      end;
      setmore:=fldsetetc-fldset;
      if setmore<>[]
      then begin
        for i:=1 to 255 do
        if i in setmore
        then begin
          qry.SQL.clear;
          qry.SQL.Add('delete from '+tblnameetc+ ' where '+fldname+'='+inttostr(i));
          qry.ExecSQL;
        end;
      end;
  end;
  qry.Destroy;
end;


function CompareTables(tblName : string; flds : array of TNewField; idxs : array of TNewIndex) : Boolean;
var
  adoTbl : TAdoTable;
  tbl : TTable;
  i : Byte;
begin
  CompareTables := True;
  {$IFDEF SqlPrc}
  {$Else}
  if (Pos('p1', tblName) > 0) or (Pos('P1', tblName) > 0) then
  begin
    if FileExists(g_options.DataBasePath {+ 'Strctdbs'} + tblName + '.DB') then
    begin
      tbl := TTable.Create(Application);
      with tbl do
      begin
        Active := false;
        DatabaseName := g_options.DataBasePath {+ 'Strctdbs'};
        TableName := tblName;
        Open;
        for i := 0 to High(flds) do
          if FindField(flds[i].fieldName) = nil then
          begin
            CompareTables := False;
            Break;
          end;
        Close;
        Free;
      end;
    end
    else
      CompareTables := False;
  end
  else
  {$EndIf}
  if tblExists(tblName) then
  begin
    adoTbl := TAdoTable.Create(Application);
    with adoTbl do
    begin
      Connection := frmDBS.DBConnection;
      TableName := tblName;
      Open;
      for i := 0 to High(flds) do
        if FindField(flds[i].fieldName) = nil then
        begin
          CompareTables := False;
          Break;
        end;
      Close;
      Free;
    end;
  end
  else
    CompareTables := False;
end;

procedure UpgradeMonthTables(fromDate, toDate : String);
var
  fromTable, toTable : String;
  y, m : Integer;
begin
  fromDate := BeautifulDate(fromDate);
  toDate := BeautifulDate(toDate);

  toTable := 'P' + Copy(toDate, 1, 4) + Copy(toDate, 6, 2);
  y := StrToInt(Copy(fromDate, 1, 4));
  m := StrToInt(Copy(fromDate, 6, 2));
  fromTable := 'P' +  IntToStr(y) + FixLeft(IntToStr(m), '0', 2);
  if fromTable <= toTable then
  begin
    while fromTable <= toTable do
    begin
      if not CompareTables(fromTable, mahanehTbl , mahanehIdx) then
        UpgradeTable(fromTable);
      Inc(m);
      if m > 12 then
      begin
        m := 1;
        Inc(y);
      end;
      fromTable := 'P' +  IntToStr(y) + FixLeft(IntToStr(m), '0', 2);
    end;
  end;
end;

procedure RenameTbl(tblOldName : String; tblNewName : String);
var
  adoQry : TADOQuery;
begin
    adoQry := TADOQuery.Create(Application);
    adoQry.Connection := frmDBS.DBConnection;
//  {$ifdef  Network}
//    adoQry.SQL.clear;
//    adoQry.SQL.Add('exec sp_rename ' + tblOldName + ',' + tblNewName);
//    adoQry.ExecSQL;
//  {$else }
    if tblExists(tblNewName)
    then begin
         adoQry.SQL.clear;
         adoQry.SQL.Add('drop table '+tblNewName);
         adoQry.ExecSQL;
    end;

    adoQry.SQL.Clear;
    adoQry.SQL.Add('select * into '+ tblNewName +' from '+ tblOldName);
    adoQry.ExecSQL;

    adoQry.SQL.Clear;
    adoQry.SQL.Add('drop table '+tblOldName);
    adoQry.ExecSQL;

//  {$Endif }
    adoQry.Free;
end;
 {$endif}

function checkdeletviw(viwname: string):boolean;
var
  qry : TAdoQuery;
begin
  qry := TAdoQuery.Create(Application);
  qry.Connection := {$ifdef SqlTools}frmSQLMenu.adoConct{$else}frmDBS.DBConnection{$EndIf};
  qry.SQL.clear;
  qry.SQL.Add('drop view ' + viwname  );
  try
    qry.ExecSQL;
    result:=true;
  except
    result:=false;
  end;
  qry.Close;
end;

function checkcreateview(viwname: string):Boolean;
var
  adoTbl : TADOTable;
begin
  adoTbl := TADOTable.Create(application);
  adoTbl.Connection := {$ifdef SqlTools}frmSQLMenu.adoConct{$else}frmDBS.DBConnection{$EndIf};
  adoTbl.TableName := viwname;
  try
    adoTbl.Open;
  except
  end;
  if adoTbl.Active then
  begin
    adoTbl.Close;
    Result := True;
  end
  else
    Result := Createview(viwName);
end;

end.




