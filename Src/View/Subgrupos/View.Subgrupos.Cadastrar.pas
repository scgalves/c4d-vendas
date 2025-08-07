unit View.Subgrupos.Cadastrar;

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
  Model.Subgrupos.DM,
  Vcl.Mask,
  Vcl.DBCtrls,
  RTTI.FieldName;

type
  TViewSubgruposCadastrar = class(TViewHerancasCadastrar)
    Label1: TLabel;
    edtCodigo: TDBEdit;
    Label2: TLabel;
    [FieldName('NOME')]
    edtNome: TDBEdit;
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

procedure TViewSubgruposCadastrar.FormShow(Sender: TObject);
begin
  inherited;

  ModelSubgruposDM.CadastrarGet(inherited IdRegistroAlterar);
  if(DataSource1.DataSet.IsEmpty)then
    DataSource1.DataSet.Append
  else
    DataSource1.DataSet.Edit;

  edtNome.SetFocus;
end;

procedure TViewSubgruposCadastrar.btnGravarClick(Sender: TObject);
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
