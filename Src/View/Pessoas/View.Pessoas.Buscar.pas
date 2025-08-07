unit View.Pessoas.Buscar;

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
  View.Herancas.Buscar,
  Data.DB,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Model.Pessoas.DM,
  View.Pessoas.Cadastrar;

type
  TViewPessoasBuscar = class(TViewHerancasBuscar)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
  private
  protected
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
  public
  end;

var
  ViewPessoasBuscar: TViewPessoasBuscar;

implementation

{$R *.dfm}

procedure TViewPessoasBuscar.BuscarDados;
var
  LStrBuscar: string;
  LCondicao: string;
begin
  LStrBuscar := QuotedStr('%'+ edtBuscar.Text +'%').ToUpper;
  LCondicao := '';
  case rdGroupFiltros.ItemIndex of
    0: LCondicao := 'where(pessoas.id like ' + LStrBuscar + ')';
    1: LCondicao := 'where(upper(pessoas.nome) like ' + LStrBuscar + ')or(upper(pessoas.fantasia) like ' + LStrBuscar + ')';
    2: LCondicao := 'where(upper(cidades.nome) like ' + LStrBuscar + ')';
  end;

  ModelPessoasDM.PessoasBuscar(LCondicao);
  inherited;
end;

procedure TViewPessoasBuscar.ChamarTelaCadastrar(const AId: Integer = 0);
var
  LViewPessoasCadastrar: TViewPessoasCadastrar;
begin
  inherited;
  LViewPessoasCadastrar := TViewPessoasCadastrar.Create(nil);
  try
    LViewPessoasCadastrar.IdRegistroAlterar := AId;
    if(LViewPessoasCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := LViewPessoasCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    LViewPessoasCadastrar.Free;
  end;
end;

procedure TViewPessoasBuscar.Excluir1Click(Sender: TObject);
begin
  if(ModelPessoasDM.QPessoasBuscaID.AsInteger = 1)then
    raise Exception.Create('A pessoa com o código 1 não pode ser excluída');

  inherited;
end;

procedure TViewPessoasBuscar.FormCreate(Sender: TObject);
begin
  inherited;
  if(ModelPessoasDM = nil)then
    ModelPessoasDM := TModelPessoasDM.Create(nil);
end;

procedure TViewPessoasBuscar.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ModelPessoasDM);
end;

end.
