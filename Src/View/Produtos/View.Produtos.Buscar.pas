unit View.Produtos.Buscar;

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
  Model.Produtos.DM,
  View.Produtos.Cadastrar;

type
  TViewProdutosBuscar = class(TViewHerancasBuscar)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
  private

  public
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
  end;

var
  ViewProdutosBuscar: TViewProdutosBuscar;

implementation

{$R *.dfm}

procedure TViewProdutosBuscar.BuscarDados;
var
  LStrBuscar: string;
  LCondicao: string;
begin
  LStrBuscar := QuotedStr('%'+ edtBuscar.Text +'%').ToUpper;
  LCondicao := '';
  case rdGroupFiltros.ItemIndex of
    0: LCondicao := 'where(produtos.id like ' + LStrBuscar + ')';
    1: LCondicao := 'where(upper(produtos.nome) like ' + LStrBuscar + ') ';
    2: LCondicao := 'where(produtos.codigo_barras like ' + LStrBuscar + ')';
    3: LCondicao := 'where(upper(subgrupos.NOME) like ' + LStrBuscar + ')';
  end;

  ModelProdutosDM.ProdutosBuscar(LCondicao);
  inherited;
end;

procedure TViewProdutosBuscar.ChamarTelaCadastrar(const AId: Integer);
var
  LViewProdutosCadastrar: TViewProdutosCadastrar;
begin
  inherited;
  LViewProdutosCadastrar := TViewProdutosCadastrar.Create(nil);
  try
    LViewProdutosCadastrar.IdRegistroAlterar := AId;
    if(LViewProdutosCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := LViewProdutosCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    LViewProdutosCadastrar.Free;
  end;
end;

procedure TViewProdutosBuscar.Excluir1Click(Sender: TObject);
begin
  if(ModelProdutosDM.QProdutosBuscaID.AsInteger = 1)then
    raise Exception.Create('O produto com o código 1 não pode ser excluído');

  inherited;
end;

procedure TViewProdutosBuscar.FormCreate(Sender: TObject);
begin
  inherited;
  if(ModelProdutosDM = nil)then
    ModelProdutosDM := TModelProdutosDM.Create(nil);
end;

procedure TViewProdutosBuscar.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ModelProdutosDM);
end;

end.
