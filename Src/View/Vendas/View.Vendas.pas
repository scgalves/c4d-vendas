unit View.Vendas;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Imaging.pngimage,
  Utils,
  Model.Vendas.DM,
  Model.Produtos.DM,
  FireDAC.Comp.Client;

type
  TViewVendas = class(TForm)
    pnBackTudo: TPanel;
    pnMsgTopo: TPanel;
    lbMsg: TLabel;
    pnCorpo: TPanel;
    pnCorpoEsquerda: TPanel;
    pnCorpoDireta: TPanel;
    Label2: TLabel;
    edtLancamento: TEdit;
    pnBackValores: TPanel;
    Label3: TLabel;
    edtQuantidade: TDBEdit;
    Label4: TLabel;
    edtValorUnitario: TDBEdit;
    Label5: TLabel;
    edtDesconto: TDBEdit;
    Label6: TLabel;
    edtAcrescimo: TDBEdit;
    Label7: TLabel;
    edtTotalLiquido: TDBEdit;
    Panel2: TPanel;
    pnBackImg: TPanel;
    imgFoto: TImage;
    pnRodapeDireita: TPanel;
    DBGrid1: TDBGrid;
    pnRodapeEquerda: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    pnBackTotalVenda: TPanel;
    lbTotalDaVenda: TLabel;
    edtTotalDaVenda: TDBEdit;
    pnBackDadosDaVenda: TPanel;
    Panel6: TPanel;
    Label13: TLabel;
    lbDBDataVenda: TDBText;
    Label14: TLabel;
    lbDBVendaNumero: TDBText;
    DS_VendasCadastrar: TDataSource;
    DS_VendasItensListar: TDataSource;
    DS_VendasItensCadastrar: TDataSource;
    Label15: TLabel;
    DBText1: TDBText;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtLancamentoKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DS_VendasItensListarDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    FDM: TModelVendasDM;
    procedure ProcessarF2;
    procedure LimparTela;
    procedure ImagemPadrao;
    procedure ProcessarEsc;
    procedure CancelarVenda;
    procedure ProcessarF3;
    procedure ProcessarEnterNoEdtLancamento;
    procedure TotalizarVenda;
    procedure ProcessarDelete;
    procedure DeletarItemSelecionado;
    procedure DeletarVendaAtual;
  public

  end;

var
  ViewVendas: TViewVendas;

implementation

{$R *.dfm}

procedure TViewVendas.FormCreate(Sender: TObject);
begin
  if(ModelVendasDM = nil)then
    ModelVendasDM := TModelVendasDM.Create(nil);
  FDM := ModelVendasDM;

  if(ModelProdutosDM = nil)then
    ModelProdutosDM := TModelProdutosDM.Create(nil);
end;

procedure TViewVendas.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ModelProdutosDM);
  FreeAndNil(ModelVendasDM);
end;

procedure TViewVendas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case(Key)of
    VK_F2:
      Self.ProcessarF2;
    VK_F3:
      Self.ProcessarF3;
    VK_F4:
    begin
      if(ssAlt in Shift)then
        Key := 0;
    end;
    VK_Escape:
      Self.ProcessarEsc;
    VK_UP:
    begin
      DBGrid1.DataSource.DataSet.Prior;
      Key := 0;
    end;
    VK_DOWN:
    begin
      DBGrid1.DataSource.DataSet.Next;
      Key := 0;
    end;
    VK_DELETE:
      Self.ProcessarDelete;
  end;
end;

procedure TViewVendas.ProcessarDelete;
begin
  if FDM.QVendasCadastrar.State in dsEditModes then
    Self.DeletarItemSelecionado
  else
    Self.DeletarVendaAtual;
end;

procedure TViewVendas.DeletarItemSelecionado;
begin
  if not(FDM.QVendasCadastrar.State in dsEditModes) then
    Exit;

  if FDM.QVendasItensListar.IsEmpty then
    raise Exception.Create('Selecione um item para ser excluído');

  if(Application.MessageBox('Confirma exclusão do item selecionado?', 'Confirmação',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  FDM.QVendasItensListar.Delete;
  Self.TotalizarVenda;
end;

procedure TViewVendas.DeletarVendaAtual;
begin
  ShowMessage('Deletar a venda. Em desenvolvimento!');
end;

procedure TViewVendas.ProcessarF2;
begin
  //if(ModelVendasDM.QVendasCadastrar.State in [dsInsert, dsEdit])then
  if(FDM.QVendasCadastrar.State in dsEditModes)then
    Exit;

  Self.LimparTela;
  FDM.QVendasCadastrar.Append;

  lbMsg.Caption := 'Inserindo produtos na venda';
  edtLancamento.SetFocus;
end;

procedure TViewVendas.LimparTela;
begin
  FDM.VendasGet;
  FDM.VendasItensGet;
  FDM.VendasItensListar;
  Self.ImagemPadrao;
  lbMsg.Caption := 'Tecle F2 para iniciar uma nova venda';
end;

procedure TViewVendas.ImagemPadrao;
begin
  imgFoto.Picture.LoadFromFile(TUtils.GetPastaImg + 'c4d-logo-118X118.png');
end;

procedure TViewVendas.ProcessarEsc;
begin
  if(FDM.QVendasCadastrar.State in dsEditModes)then
    Self.CancelarVenda
  else
    Self.Close;
end;

procedure TViewVendas.CancelarVenda;
begin
  if(Application.MessageBox('Confirma cancelamento desta venda?', 'Confirmação',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES)
  then
    Exit;

  FDM.QVendasCadastrar.Cancel;
  Self.LimparTela;
end;

procedure TViewVendas.ProcessarF3;
begin
  if not(FDM.QVendasCadastrar.State in dsEditModes)then
    Exit;

  FDM.QVendasCadastrar.Post;
  Self.LimparTela;

  edtLancamento.SetFocus;
end;

procedure TViewVendas.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if(not Odd(TDBGrid(Sender).DataSource.DataSet.RecNo))then
    DBGrid1.Canvas.Brush.Color := $00DDDDDD;

  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TViewVendas.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(ssCtrl in Shift)and(Key = VK_DELETE)then
    Key := 0;
end;

procedure TViewVendas.DBGrid1TitleClick(Column: TColumn);
var
  LCampo: string;
  LOrdem: string;
begin
  if(DS_VendasItensListar.DataSet.IsEmpty)then
    Exit;

  LCampo := Column.FieldName.Trim;
  if(LCampo.IsEmpty)or(Column.Field.FieldKind = fkCalculated)then
    Exit;

  LOrdem := LCampo + ':D;ID';
  if(TFDQuery(DS_VendasItensListar.DataSet).IndexFieldNames.Contains(':D'))then
    LOrdem := LCampo + ';ID';

  TFDQuery(DS_VendasItensListar.DataSet).IndexFieldNames := LOrdem;
end;

procedure TViewVendas.edtLancamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
    Self.ProcessarEnterNoEdtLancamento;
end;

procedure TViewVendas.ProcessarEnterNoEdtLancamento;
var
  LCodBarras: string;
  LQtd: Double;
  LDesconto: Double;
  LAcrescimo: Double;
begin
  if not(FDM.QVendasCadastrar.State in dsEditModes)then
    Exit;

  if(Trim(edtLancamento.Text).IsEmpty)then
    Exit;

  TUtils.PegarDadosLancamento(edtLancamento.Text, LCodBarras, LQtd, LDesconto, LAcrescimo);

  if(not ModelProdutosDM.LookProdutos(LCodBarras))then
  begin
    edtLancamento.SetFocus;
    raise Exception.Create('Produto não encontrado');
  end;

  if(FDM.QVendasCadastrar.State in [dsInsert])then
  begin
    FDM.QVendasCadastrar.Post;
    FDM.QVendasCadastrar.Edit;
  end;

  FDM.QVendasItensCadastrar.Append;
  FDM.QVendasItensCadastrarID_VENDA.AsInteger := FDM.QVendasCadastrarID.AsInteger;
  FDM.QVendasItensCadastrarID_PRODUTO.AsInteger := ModelProdutosDM.QLookID.AsInteger;
  FDM.QVendasItensCadastrarQUANTIDADE.AsFloat := LQtd;
  FDM.QVendasItensCadastrarVALOR_UNITARIO.AsFloat := ModelProdutosDM.QLookPRECO_VENDA.AsFloat;
  FDM.QVendasItensCadastrarTOTAL_BRUTO.AsFloat :=
    FDM.QVendasItensCadastrarQUANTIDADE.AsFloat * FDM.QVendasItensCadastrarVALOR_UNITARIO.AsFloat;
  FDM.QVendasItensCadastrarDESCONTO.AsFloat := LDesconto;
  FDM.QVendasItensCadastrarACRESCIMO.AsFloat := LAcrescimo;
  FDM.QVendasItensCadastrarTOTAL_LIQUIDO.AsFloat := FDM.QVendasItensCadastrarTOTAL_BRUTO.AsFloat
    - FDM.QVendasItensCadastrarDESCONTO.AsFloat + FDM.QVendasItensCadastrarACRESCIMO.AsFloat;
  FDM.QVendasItensCadastrar.Post;

  FDM.VendasItensListar(FDM.QVendasCadastrarID.AsInteger, FDM.QVendasItensCadastrarID.AsInteger);

  Self.TotalizarVenda;

  edtLancamento.Clear;
  edtLancamento.SetFocus;
end;

procedure TViewVendas.TotalizarVenda;
begin
  if not(FDM.QVendasCadastrar.State in dsEditModes)then
    Exit;

  FDM.VendaTotalizar(FDM.QVendasCadastrarID.AsInteger);
  FDM.QVendasCadastrarTOTAL_BRUTO.AsFloat := FDM.QVendasTotalizarTOTALBRUTO.AsFloat;
  FDM.QVendasCadastrarTOTAL_DESCONTOS.AsFloat := FDM.QVendasTotalizarTOTALDESCONTO.AsFloat;
  FDM.QVendasCadastrarTOTAL_ACRESCIMOS.AsFloat := FDM.QVendasTotalizarTOTALACRESCIMO.AsFloat;
  FDM.QVendasCadastrarTOTAL_LIQUIDO.AsFloat := FDM.QVendasTotalizarTOTALLIQUIDO.AsFloat;
  FDM.QVendasCadastrar.Post;
  FDM.QVendasCadastrar.Edit;
end;

procedure TViewVendas.DS_VendasItensListarDataChange(Sender: TObject; Field: TField);
var
  LFileImg: string;
begin
  if(FDM.QVendasItensListar.IsEmpty)then
    Exit;

  if(FDM.QVendasItensListarID.AsInteger <= 0)then
    Exit;

  if(FDM.QVendasItensListarIMAGEM.AsString.Trim.IsEmpty)then
  begin
    Self.ImagemPadrao;
    Exit;
  end;

  LFileImg := TUtils.GetPastaImgProdutos + FDM.QVendasItensListarIMAGEM.AsString.Trim;

  if(not FileExists(LFileImg))then
  begin
    Self.ImagemPadrao;
    Exit;
  end;

  imgFoto.Picture.LoadFromFile(LFileImg);
end;

end.
