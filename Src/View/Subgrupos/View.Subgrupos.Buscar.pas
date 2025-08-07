unit View.Subgrupos.Buscar;

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
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Model.Subgrupos.DM,
  Vcl.Menus;

type
  TViewSubgruposBuscar = class(TViewHerancasBuscar)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  protected
    procedure BuscarDados; override;
    procedure ChamarTelaCadastrar(const AId: Integer = 0); override;
  public
  end;

var
  ViewSubgruposBuscar: TViewSubgruposBuscar;

implementation

{$R *.dfm}

uses
  View.Subgrupos.Cadastrar;

procedure TViewSubgruposBuscar.BuscarDados;
var
  LStrBuscar: string;
  LCondicao: string;
begin
  LStrBuscar := QuotedStr('%'+ edtBuscar.Text +'%').ToUpper;
  LCondicao := '';
  case rdGroupFiltros.ItemIndex of
    0: LCondicao := 'where(id like ' + LStrBuscar + ')';
    1: LCondicao := 'where(upper(nome) like ' + LStrBuscar + ')';
  end;

  ModelSubgruposDM.SubgruposBuscar(LCondicao);
  inherited;
end;

procedure TViewSubgruposBuscar.ChamarTelaCadastrar(const AId: Integer = 0);
var
  LViewSubgruposCadastrar: TViewSubGruposCadastrar;
begin
  inherited;
  LViewSubgruposCadastrar := TViewSubGruposCadastrar.Create(nil);
  try
    LViewSubgruposCadastrar.IdRegistroAlterar := AId;
    if(LViewSubgruposCadastrar.ShowModal = mrOk)then
    begin
      inherited UltId := LViewSubgruposCadastrar.UltId;
      Self.BuscarDados;
    end;
  finally
    LViewSubgruposCadastrar.Free;
  end;
end;

procedure TViewSubgruposBuscar.FormCreate(Sender: TObject);
begin
  inherited;
  if(ModelSubgruposDM = nil)then
    ModelSubgruposDM := TModelSubgruposDM.Create(nil);
end;

procedure TViewSubgruposBuscar.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ModelSubgruposDM);
end;

end.
