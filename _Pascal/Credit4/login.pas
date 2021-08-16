unit Login;
{$I Features}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Db, DBTables, Menus, MSGs, ScktComp,
  ADODB,Grids, DBGrids, DosMove, ExtCtrls;

type
  TfrmLogin = class(TForm)
    QryLogin: TQuery;
    grpLogin: TGroupBox;
    lbl1: TLabel;
    txtPassword: TEdit;
    lbl2: TLabel;
    adoQryLogin: TADOQuery;
    cmbUserName: TComboBox;
    ADOTable1: TADOTable;
    DosMove1: TDosMove;
    CbScreen: TCheckBox;
    Image1: TImage;
    Animat: TAnimate;
    cmdCancel: TBitBtn;
    cmdOK: TBitBtn;
    lbl3: TLabel;

    procedure cmdOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    LoginNo : Integer;

  public
    { Public declarations }
    LoginValid : Boolean;

  end;

implementation

{$R *.DFM}


uses
Globals, MakeDB, DBLogin, Code_Sys, DBS, Funcs
{$IFNDEF webclock}
  ,Main
{$ELSE}
  ,ServerController, UserSessionUnit
{$ENDIF};



procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  qryLogin.DatabaseName := g_options.ProgramPath;
end;

procedure TfrmLogin.cmdOKClick(Sender: TObject);
begin
  FullScreen:=CbScreen.Checked;
// begin convert old versions of Part tables to the new one
  if tblExists('Part1') then
  begin
    if ConfirmMessage('‰”ŒÂ ÃœÊ· »Œ‘Â«Ì ‘„« ﬁœÌ„Ì „Ì »«‘œ. «ê— „«Ì· »«‘Ìœ ﬂÂ »Œ‘Â«Ì ‘„« »Â ’Ê—  œ—Œ Ì ‰„«Ì‘ œ«œÂ ‘Êœ° »«Ìœ ÃœÊ· »Œ‘Â«Ì ‘„« »Â —Ê“ —”«‰œÂ ‘Êœ. œ— ’Ê—   „«Ì· œﬂ„Â »·Ì —« ﬂ·Ìﬂ ﬂ‰Ìœ.') then
    begin
      ADOTable1.TableName := 'Part1';
      ADOTable1.ConnectionString := GetConnectionString;
      ADOTable1.Open;
      if not ADOTable1.IsEmpty then
      begin
        ConvertParts;
      end;
      RenameTbl('Part1', '_Part1');
      RenameTbl('Part2', '_Part2');
      RenameTbl('Part3', '_Part3');
      RenameTbl('Part4', '_Part4');
    end;
  end;
// end convert old versions of Part tables to the new one
  lbl3.Show;
  Animat.Show;
  Animat.Active := true;
  Refresh;
  if DBLinkTest then
  begin
    lbl3.Hide;
    Animat.Visible := True;
    Animat.Active := True;
    Refresh;
    with adoQryLogin do
    begin
      Connection := frmDBS.DBConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM Security,Users WHERE Security.Code = Users.SecurityCode');
{$IFDEF Network}
      SQL.Add('and '+ Upper_case + '(UserName) = ''' + UpperCase(cmbUserName.Text) + '''');
{$ELSE}
      SQL.Add('and UCase(UserName) = ''' + UpperCase(cmbUserName.Text) + '''');
{$ENDIF}
      SQL.Add('OR UserName = ''' + cmbUserName.Text + '''');
      Open;
    end;
    if adoQryLogin.EOF then
    begin
      ErrorMessage('ﬂ«—»— »« ç‰Ì‰ ‰«„Ì  ⁄—Ì› ‰‘œÂ «” .');
      cmbUserName.SetFocus;
      Inc(LoginNo);
      Animat.Visible := False;
      if LoginNo = 3 then
      begin
        LoginValid := False;
        adoQryLogin.Close;
        Close;
      end;
    end
    else
    begin
      if (UpperCase(CodingPassWord(adoQryLogin.FieldByName('UserPassword').AsString)) = UpperCase(txtPassword.Text)) or
         (CodingPassWord(adoQryLogin.FieldByName('UserPassword').AsString) = txtPassword.Text) then
      begin
        if not adoQryLogin.FieldByName('Entery').AsBoolean then
        begin
          InformationMessage('Ê—Êœ ‘„« »Â ”Ì” „  Ê”ÿ „œÌ— ”Ì” „ „ÕœÊœ ‘œÂ «” !');
          LoginValid := False;
        end
        else
          LoginValid := True;

        g_options.UserName := adoQryLogin.FieldByName('UserName').AsString;
        g_options.AcesPrint := adoQryLogin.FieldByName('AccessPrint').AsBoolean;

        try
          if UpperCase(cmbUserName.Text) = 'ADMIN' then
          begin
            g_Options.userParts := '';
            g_Options.userStations := -1;
          end
          else
          begin
            g_Options.userParts := adoQryLogin.FieldByName('Parts').AsString;
            g_Options.userStations := adoQryLogin.FieldByName('station').AsInteger;
          end;
        except
          UpgradeTable('users');
          InformationMessage('»«‰ò ò«—»—«‰ »—Ê“ —”«‰Ì ‘œ .');
        end;
        LoadReaders;
        adoQryLogin.Close;
        Close;
      end
      else
      begin
        if (UpperCase(cmbUserName.Text) = ADMIN_NAME) and
           checkpass(txtPassWord.Text) then
//           (UpperCase(txtPassWord.Text) = ADMIN_PASS) then
        begin
          LoginValid := True;
          g_options.UserName := adoQryLogin.FieldByName('UserName').AsString;
          g_options.AcesPrint := adoQryLogin.FieldByName('AccessPrint').AsBoolean;
          g_Options.userParts := '';
          g_Options.userStations := -1;
          adoQryLogin.Close;

          Close;
        end
        else
        begin
          ErrorMessage('ﬂ·„Â ⁄»Ê— «‘ »«Â «” .');
          txtPassword.SetFocus;
          Inc(LoginNo);
          Animat.Visible := False;
          if LoginNo = 3 then
          begin
            LoginValid := False;
            adoQryLogin.Close;
            Close;
          end;
        end;
      end;
    end;
  end
  else
  begin
    lbl3.hide;
    Animat.Visible := True;
  end;
end;

procedure TfrmLogin.cmdCancelClick(Sender: TObject);
begin
  LoginValid := False;
end;


procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  with adoQryLogin do
  begin
    lbl3.Show;
    Animat.Show;
    Animat.Active := true;
    (Sender as TForm).Refresh;
    if not DBLinkTest then
      close;
    Animat.Active := false;
    Animat.Hide;
    lbl3.Hide;
    Connection := frmDBS.DBConnection;
    SQL.Clear;
    SQL.Add('SELECT * FROM Users');
    Open;
    while not Eof do
    begin
      cmbUserName.Items.Add(FieldByName('UserName').AsString);
      Next;
    end;
    cmbUserName.ItemIndex := 0;
  end;
  txtpassword.SetFocus;
end;



end.
