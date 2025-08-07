unit View.Pessoas.Cadastrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  View.Herancas.Cadastrar,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Model.Pessoas.DM,
  RTTI.FieldName,
  Exceptions.FieldName,
  Utils,
  View.Cidades.Buscar;

type
  TViewPessoasCadastrar = class(TViewHerancasCadastrar)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    [FieldName('NOME')]
    edtNome: TDBEdit;
    Label3: TLabel;
    [FieldName('FANTASIA')]
    edtFantasia: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    [FieldName('ID_CIDADE')]
    edtIdCidade: TDBEdit;
    edtCidade: TEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    rdGroupTipoJuridico: TDBRadioGroup;
    Label14: TLabel;
    edtCPF: TDBEdit;
    Label15: TLabel;
    edtRG: TDBEdit;
    Label16: TLabel;
    edtCNPJ: TDBEdit;
    Label17: TLabel;
    edtIE: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtIdCidadeExit(Sender: TObject);
    procedure rdGroupTipoJuridicoClick(Sender: TObject);
  private
    procedure ConfigurarTipoJuridico;
  public
  end;

var
  ViewPessoasCadastrar: TViewPessoasCadastrar;

implementation

{$R *.dfm}

uses
  Model.Cidades.DM;

procedure TViewPessoasCadastrar.edtIdCidadeExit(Sender: TObject);
var
  LModelCidadesDM: TModelCidadesDM;
begin
  inherited;

  edtCidade.Clear;
  if(Trim(edtIdCidade.Text).IsEmpty)then
    Exit;

  LModelCidadesDM := TModelCidadesDM.Create(nil);
  try
    LModelCidadesDM.LookCidade(StrToIntDef(edtIdCidade.Text, 0));
    if(LModelCidadesDM.QLook.IsEmpty)then
    begin
      edtIdCidade.SetFocus;
      raise Exception.Create('Cidade não localizada');
    end;

    edtCidade.Text := LModelCidadesDM.QLookNOME.AsString + ' / ' +
                      LModelCidadesDM.QLookUF.AsString;
  finally
    LModelCidadesDM.Free;
  end;
end;

procedure TViewPessoasCadastrar.edtIdCidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if(Key = VK_F8)then
  begin
    ViewCidadesBuscar := TViewCidadesBuscar.Create(nil);
    try
      if(ViewCidadesBuscar.ShowModal = mrOk)then
        edtIdCidade.Text := ViewCidadesBuscar.IdSelecionado.ToString;
    finally
      FreeAndNil(ViewCidadesBuscar);
    end;
  end;
end;

procedure TViewPessoasCadastrar.FormShow(Sender: TObject);
begin
  inherited;

  ModelPessoasDM.CadastrarGet(inherited IdRegistroAlterar);
  if(DataSource1.DataSet.IsEmpty)then
    DataSource1.DataSet.Append
  else
  begin
    DataSource1.DataSet.Edit;
    edtIdCidadeExit(edtIdCidade);
  end;

  Self.ConfigurarTipoJuridico;
  edtNome.SetFocus;
end;

procedure TViewPessoasCadastrar.rdGroupTipoJuridicoClick(Sender: TObject);
begin
  inherited;
  Self.ConfigurarTipoJuridico;
end;

procedure TViewPessoasCadastrar.btnGravarClick(Sender: TObject);
begin
  try
    DataSource1.DataSet.Post;
  except
    on E: ExceptionsFieldName do
      TUTils.TratarExceptionsFieldName(Self, E);
  end;
  inherited;
end;

procedure TViewPessoasCadastrar.ConfigurarTipoJuridico;
begin
  edtCPF.Enabled := True;
  edtRG.Enabled := True;
  edtCNPJ.Enabled := True;
  edtIE.Enabled := True;

  if(rdGroupTipoJuridico.ItemIndex = 0)then
    edtCNPJ.Enabled := False
  else
  begin
    edtCPF.Enabled := False;
    edtRG.Enabled := False;
  end;
end;

end.
