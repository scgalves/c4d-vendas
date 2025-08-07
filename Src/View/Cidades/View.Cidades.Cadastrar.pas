unit View.Cidades.Cadastrar;

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
  Model.Cidades.DM,
  Vcl.Mask,
  Vcl.DBCtrls,
  RTTI.FieldName;

type
  TViewCidadesCadastrar = class(TViewHerancasCadastrar)
    Label1: TLabel;
    edtCodigo: TDBEdit;
    Label2: TLabel;
    [FieldName('NOME')]
    edtNome: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    [FieldName('CODIGO_IBGE')]
    edtCodigoIBGE: TDBEdit;
    [FieldName('UF')]
    cBoxUF: TDBComboBox;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  Exceptions.FieldName,
  Utils;

procedure TViewCidadesCadastrar.FormShow(Sender: TObject);
begin
  inherited;

  ModelCidadesDM.CadastrarGet(inherited IdRegistroAlterar);
  if(DataSource1.DataSet.IsEmpty)then
    DataSource1.DataSet.Append
  else
    DataSource1.DataSet.Edit;

  edtNome.SetFocus;
end;

procedure TViewCidadesCadastrar.btnGravarClick(Sender: TObject);
begin
  try
    DataSource1.DataSet.Post;
  except
    on E: ExceptionsFieldName do
      TUTils.TratarExceptionsFieldName(Self, E);
  end;
  inherited;
end;

end.
