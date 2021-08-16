//This file is being changed by File Line Attachment

unit RpBarcode;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ADODB;

type
  TqrptBarcode = class(TQuickRep)
    DetailBand1: TQRBand;
    lblBarcode: TQRLabel;
    QRImagebarcode: TQRImage;
    adoQryPersons: TADOQuery;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    cntr : integer;
    GrpType : Byte;
    procedure RPTSetWinF;
  end;

{var
  qrptInOut: TqrptInOut;}


implementation

uses
  Globals, DBS, Funcs;

{$R *.DFM}
type
   pk500 = packed array[1..500] of char;

procedure TqrptBarcode.RPTSetWinF;
begin
  
end;

PROCEDURE MAKEBAR39(BAR:string;VAR ST:pk500;var stlen:integer);
CONST
   BARVAL:PACKED ARRAY[0..43] OF CHAR =
                 '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*';
   BARBIN:ARRAY[0..43] OF STring =
         ('000110100',
          '100100001',
          '001100001',
          '101100000',
          '000110001',
          '100110000',
          '001110000',
          '000100101',
          '100100100',
          '001100100',
          '100001001',
          '001001001',
          '101001000',
          '000011001',
          '100011000',
          '001011000',
          '000001101',
          '100001100',
          '001001100',
          '000011100',
          '100000011',
          '001000011',
          '101000010',
          '000010011',
          '100010010',
          '001010010',
          '000000111',
          '100000110',
          '001000110',
          '000010110',
          '110000001',
          '011000001',
          '111000000',
          '010010001',
          '110010000',
          '011010000',
          '010000101',
          '110000100',
          '011000100',
          '010101000',
          '010100010',
          '010001010',
          '000101010',
          '010010100');
   BCHAR:ARRAY[BOOLEAN] OF CHAR =('0','1');
VAR
   I,J,L:BYTE;
   k:integer;
   B:BOOLEAN;
   CH:CHAR;
FUNCTION FINDNO(CH:CHAR):BYTE;
VAR
   I:BYTE;
BEGIN
     FOR I:=0 TO 43 DO IF CH=BARVAL[I]
     THEN BEGIN
          FINDNO:=I;
          EXIT;
     END;
     FINDNO:=38;
END;
BEGIN
   WHILE POS(' ',BAR) > 0 DO DELETE(BAR,POS(' ',BAR),1);
   {IF ISACCESS
   THEN BAR:='*'+BAR+' '+ACCESSCODE+'*'
   ELSE }BAR:='*'+BAR+'*';
   K:=0;
   FOR I:=1 TO LENGTH(BAR) DO
   BEGIN
        B:=FALSE;
        INC(K);
        ST[K]:=BCHAR[B];
        FOR J:=1 TO 9 DO
        BEGIN
             B:=NOT B;
             INC(K);
             ST[K]:=BCHAR[B];
             CH:=BAR[I];
             L:=FINDNO(CH);
             IF BARBIN[L][J]='1'
             THEN BEGIN
                  INC(K);
                  ST[K]:=BCHAR[B];
                  INC(K);
                  ST[K]:=BCHAR[B];
             END;
        END;
   END;
   stlen:=K;
END;

procedure TqrptBarcode.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
const
   barleft:integer = 5;
   barsize:integer = 2;
   barwidth:integer = 250;
   bartop:integer = 32;
   barheight:integer = 70;
   barsizes : array[1..4] of real = (1,1.5,2,3);
var
   k:integer;
   barcode:string;
   pk : pk500;
   barlen: integer;
   i : integer;
begin
    barcode:=DelLeftZero(adoQryPersons.fieldbyname('Empl_No').asstring);
    lblBarcode.Caption:=#254+barcode;
    makebar39(barcode,pk,barlen);
    k:=barleft+round((barwidth-barlen*barsizes[barsize])/2);
    with QRImagebarcode do
    begin
       left:=k;
       width:=round(barlen*barsizes[barsize]);
       {top:=bartop;}
       height:=barheight;
       with picture.bitmap do
       begin
          height:=1;
          width:=barlen;
       end;
       for i:=1 to barlen do
         if pk[i]='1'
           then canvas.pixels[i-1,0]:=clblack
           else canvas.pixels[i-1,0]:=clwhite;
    end;
end;

end.
