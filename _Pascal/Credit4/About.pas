unit About;
{$I Features}

interface
                  
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, VrControls, VrHyperCtrls;

type
  TfrmAbout = class(TForm)
    lbl9: TLabel;
    lbl10: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lbl11: TLabel;
    lblVersion: TLabel;
    lbl13: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Image1: TImage;
    lbl4: TStaticText;
    lbl6: TStaticText;
    lbl7: TStaticText;
    lbl5: TStaticText;
    StaticText1: TStaticText;
    lblSite: TVrWebLabel;
    procedure FormDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure SetWinF;
  public
    { Public declarations }
  end;


implementation

uses
  Globals, Funcs;
  
{$R *.DFM}


procedure TfrmAbout.SetWinF;
begin
end;

procedure TfrmAbout.FormActivate(Sender: TObject);
begin
  SetWinF;
end;

procedure TfrmAbout.FormDblClick(Sender: TObject);
begin
  Close;
end;

end.
