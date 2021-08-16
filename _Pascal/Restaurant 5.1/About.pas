unit About;
{$I features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TfrmAbout = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Image2: TImage;
    Image1: TImage;
    lbl11: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    lbl13: TLabel;
    lbl12: TLabel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    lbl6: TStaticText;
    lbl4: TStaticText;
    lbl5: TStaticText;
    StaticText1: TStaticText;
    lbl7: TStaticText;
    RichEdit1: TRichEdit;
    Label2: TLabel;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;


implementation

uses
  Globals;
  
{$R *.DFM}


procedure TfrmAbout.FormActivate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
{$ifdef RestService}
  Label2.Visible := True;
  Label4.Visible := True;
{$else RestService}
{$ifdef BankMarkazi}
  Label2.Caption := 'نسخه اختصاصی';
  Label4.Caption := 'بانک مرکزی ج.ا.ایران';
  Label2.Visible := True;
  Label4.Visible := True;
{$else BankMarkazi}
{$ifdef OperatorBase}
//  Label2.Caption := 'نسخه اپراتوری';
  Label4.Caption := 'نسخه اپراتوری';
//  Label2.Visible := True;
  Label4.Visible := True;
  lbl12.Top := lbl12.Top + 10;
  lbl13.Top := lbl13.Top + 20;
{$else OperatorBase}
  Label4.Visible := False;
  Label2.Visible := False;
  lbl12.Top := lbl12.Top + 10;
  lbl13.Top := lbl13.Top + 20;
{$endif OperatorBase}
{$endif BankMarkazi}
{$endif RestService}
end;

end.
