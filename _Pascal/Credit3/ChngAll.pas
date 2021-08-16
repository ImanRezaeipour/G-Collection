unit ChngAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DosMove;

type
  TfrmAllChange = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    cmbActive: TComboBox;
    cmbFood: TComboBox;
    cmbRejim: TComboBox;
    cmbSobh: TComboBox;
    cmbNahar: TComboBox;
    cmbSham: TComboBox;
    cmdChange: TBitBtn;
    cmdHelp: TBitBtn;
    cmdClose: TBitBtn;
    lbl4: TLabel;
    cmbSahari: TComboBox;
    lbl8: TLabel;
    cmbEftari: TComboBox;
    DosMove1: TDosMove;
    procedure FormCreate(Sender: TObject);
    procedure cmdChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAllChange : TfrmAllChange;

implementation

uses
  Globals, MSGs, Funcs, DBS, FntSel;

{$R *.dfm}

procedure TfrmAllChange.FormCreate(Sender: TObject);
begin
  SetFontColor(TForm(frmAllChange));
  
  Caption := (Caption);
  lbl1.Caption := (lbl1.Caption);
  lbl2.Caption := (lbl2.Caption);
  lbl3.Caption := (lbl3.Caption);
  lbl4.Caption := (lbl4.Caption);
  lbl5.Caption := (lbl5.Caption);
  lbl6.Caption := (lbl6.Caption);
  lbl7.Caption := (lbl7.Caption);
  lbl8.Caption := (lbl8.Caption);
  cmdChange.Caption := (cmdChange.Caption);
  cmdHelp.Caption := (cmdHelp.Caption);
  cmdClose.Caption := (cmdClose.Caption);

  cmbActive.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbActive.Items.Add(('›⁄«·'));
  cmbActive.Items.Add(('€Ì— ›⁄«·'));
  cmbActive.ItemIndex := 0;

  cmbFood.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbFood.Items.Add(('«Ã«“Â €–«Ì «÷«›Ì'));
  cmbFood.Items.Add(('⁄œ„ ”—Ê €–«Ì «÷«›Ì'));
  cmbFood.ItemIndex := 0;

  cmbRejim.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbRejim.Items.Add(('Å—”‰· —éÌ„Ì'));
  cmbRejim.Items.Add(('Å—”‰· ⁄«œÌ'));
  cmbRejim.ItemIndex := 0;

  cmbSahari.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbSahari.Items.Add(('«Ã«“Â ”—Ê ”Õ—Ì'));
  cmbSahari.Items.Add(('⁄œ„ ”—Ê ”Õ—Ì'));
  cmbSahari.ItemIndex := 0;

  cmbSobh.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbSobh.Items.Add(('«Ã«“Â ”—Ê ’»Õ«‰Â'));
  cmbSobh.Items.Add(('⁄œ„ ”—Ê ’»Õ«‰Â'));
  cmbSobh.ItemIndex := 0;

  cmbNahar.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbNahar.Items.Add(('«Ã«“Â ”—Ê ‰«Â«—'));
  cmbNahar.Items.Add(('⁄œ„ ”—Ê ‰«Â«—'));
  cmbNahar.ItemIndex := 0;

  cmbEftari.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbEftari.Items.Add(('«Ã«“Â ”—Ê «›ÿ«—Ì'));
  cmbEftari.Items.Add(('⁄œ„ ”—Ê ’»Õ«‰Â'));
  cmbEftari.ItemIndex := 0;

  cmbSham.Items.Add(('»œÊ‰  €ÌÌ—'));
  cmbSham.Items.Add(('«Ã«“Â ”—Ê ‘«„'));
  cmbSham.Items.Add(('⁄œ„ ”—Ê ‘«„'));
  cmbSham.ItemIndex := 0;
end;

procedure TfrmAllChange.cmdChangeClick(Sender: TObject);
begin
  if ConfirmMessage(' €ÌÌ—«  œ—ŒÊ«” Ì »— —ÊÌ ﬂ·ÌÂ Å—”‰· «⁄„«· „Ì ‘Êœ. ¬Ì« »—«Ì  €ÌÌ—«  «ÿ„Ì‰«‰ œ«—Ìœø') then
  begin
    with frmDBS.adoQryG do
    begin
      if cmbActive.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbActive.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Active = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_Active = 0');
        ExecSQL;
      end;

      if cmbFood.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbFood.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_DblFood = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_DblFood = 0');
        ExecSQL;
      end;

      if cmbRejim.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbRejim.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Type = ' + IntToStr(EMPL_REJIM))
        else
          SQL.Add('UPDATE Employee SET Empl_Type = ' + IntToStr(EMPL_NORMAL));
        ExecSQL;
      end;

      if cmbSahari.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbSahari.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Sahari = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_Sahari = 0');
        ExecSQL;
      end;

      if cmbSobh.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbSobh.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Sobhaneh = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_Sobhaneh = 0');
        ExecSQL;
      end;

      if cmbNahar.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbNahar.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Nahar = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_Nahar = 0');
        ExecSQL;
      end;

      if cmbEftari.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbEftari.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Eftari = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_Eftari = 0');
        ExecSQL;
      end;

      if cmbSham.ItemIndex <> 0 then
      begin
        SQL.Clear;
        if cmbSham.ItemIndex = 1 then
          SQL.Add('UPDATE Employee SET Empl_Sham = -1')
        else
          SQL.Add('UPDATE Employee SET Empl_Sham = 0');
        ExecSQL;
      end;

      InformationMessage(' €ÌÌ—«  «‰Ã«„ ‘œ.');
    end;
  end;
end;

end.
