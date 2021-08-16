unit Cnstants;

interface

type
  STR_TYPE = ansistring;//[128];

const
  ALL_COLLECTION = 1;
  ALL_RECOVERY   = 2;
  NEW_RECOVERY   = 3;

  ERR_NONE     = 1;
  ERR_TIMEOUT  = 2;
  ERR_CHEKSUM  = 3;
  ERR_STX      = 4;
  ERR_ETX      = 5;
  ERR_OFF      = 6;
  MB_BUFFEMPTY = 7;
  MB_TRUEREC   = 8;
  MB_BADREC    = 9;
  MB_BADDATA   = 10;
  MTT_OFFLINE  = 15;

  RDR_Z80   = 100;
  RDR_Z84   = 101;
  RDR_PROXI = 102;

  PRN_LX          = 0;
  PRN_LQ          = 1;
  PRN_CITIZEN3551 = 2;
  PRN_CITIZEN3541 = 3;
  PRN_ITHACA      = 4;

implementation

end.
