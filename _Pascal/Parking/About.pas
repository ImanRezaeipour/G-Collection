unit About;
{$I Features}

interface
                  
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, VrControls, VrHyperCtrls, ComCtrls;

type
  TfrmAbout = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lbl9: TLabel;
    lbl10: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lbl11: TLabel;
    lblVersion: TLabel;
    lblversiondate: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    lblSite: TVrWebLabel;
    Image1: TImage;
    lbl4: TStaticText;
    lbl6: TStaticText;
    lbl7: TStaticText;
    lbl5: TStaticText;
    StaticText1: TStaticText;
    TabSheet2: TTabSheet;
    RichEdit1: TRichEdit;
    lblTarehbar: TLabel;
    procedure FormDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
//    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

uses
  Globals, Funcs;
  
{$R *.DFM}


//procedure TfrmAbout.SetWinF;
//begin
//end;

procedure TfrmAbout.FormActivate(Sender: TObject);
begin
//  SetWinF;
//  {$ifdef  Network}
//    lblversion.Caption:= 'Clock ' + AppVersion + ' DB : SQL Server';
//  {$else }
//    lblversion.Caption:= 'Clock ' + AppVersion + ' - DB : Access';
//  {$Endif }
//  {$ifdef FreeVersion}
//    lblversion.Caption:= 'Clock ' + AppVersion + ' - DB : Access';
//  {$endif}
//  {$ifdef  BioStation}
////    lblversion.Caption:=lblversion.Caption+' BioStation ';
//  {$endif}
//  if ismes then lblversion.Caption:=lblversion.Caption+' „ ';
//  if prison then lblversion.Caption:=lblversion.Caption+' “ ';
//  if isfalat then lblversion.Caption:=lblversion.Caption+' › ';
//  if isansar then lblversion.Caption:=lblversion.Caption+' «·› ';
//  if isdemo then lblversion.Caption:=lblversion.Caption+' œ ';
  PageControl1.ActivePageIndex := 0;
{$ifdef TarehBar}
  lblTarehbar.Visible := True;
{$else TarehBar}
  lblTarehbar.Visible := False;
{$endif TarehBar}

{$ifdef POSBase}
  lblVersion.Caption := '‰”ŒÂ : 6/1';
{$endif POSBase}

{$ifdef PCBase}
  lblVersion.Caption := '‰”ŒÂ : 6/2';
{$endif PCBase}

end;

procedure TfrmAbout.FormDblClick(Sender: TObject);
begin
  Close;
end;

end.
