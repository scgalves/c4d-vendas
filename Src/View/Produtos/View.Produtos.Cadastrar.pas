unit View.Produtos.Cadastrar;

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
  Vcl.Menus,
  Vcl.Imaging.pngimage,
  Model.Produtos.DM,
  Model.Subgrupos.DM,
  View.Subgrupos.Buscar,
  RTTI.FieldName,
  Exceptions.FieldName,
  Utils,
  JPEG;

type
  TViewProdutosCadastrar = class(TViewHerancasCadastrar)
    Label1: TLabel;
    edtCodigo: TDBEdit;
    Label2: TLabel;

    [FieldName('NOME')]
    edtNome: TDBEdit;

    Label3: TLabel;
    edtDescricao: TDBEdit;
    Label4: TLabel;

    [FieldName('PRECO_CUSTO')]
    edtPrecoCusto: TDBEdit;
    Label5: TLabel;

    [FieldName('PORCENTAGEM')]
    edtPorcentagem: TDBEdit;
    Label6: TLabel;

    [FieldName('PRECO_VENDA')]
    edtPrecoVenda: TDBEdit;
    Label7: TLabel;

    [FieldName('UNIDADE')]
    edtUnidade: TDBEdit;
    Label8: TLabel;

    [FieldName('CODIGO_BARRAS')]
    edtCodigoBarras: TDBEdit;
    Label9: TLabel;

    [FieldName('ID_SUBGRUPO')]
    edtIdSubgrupo: TDBEdit;
    edtSubgrupo: TEdit;
    Panel1: TPanel;
    imgFoto: TImage;
    pMenuFoto: TPopupMenu;
    BuscarFoto1: TMenuItem;
    LimparFoto1: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure edtIdSubgrupoExit(Sender: TObject);
    procedure edtIdSubgrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPrecoCustoExit(Sender: TObject);
    procedure edtPorcentagemExit(Sender: TObject);
    procedure edtPrecoVendaExit(Sender: TObject);
    procedure BuscarFoto1Click(Sender: TObject);
    procedure LimparFoto1Click(Sender: TObject);
  private
    FAlterarFoto: Boolean;
    FFotoOrigemAlterar: string;
    procedure CalcularPrecoVenda;
    procedure CalcularPorcentagem;
    procedure ProcessarImagemAoGravar;
    procedure CarregarFotoAtual;
  public

  end;

var
  ViewProdutosCadastrar: TViewProdutosCadastrar;

implementation

{$R *.dfm}

procedure TViewProdutosCadastrar.btnGravarClick(Sender: TObject);
begin
  try
    DataSource1.DataSet.Post;
    DataSource1.DataSet.Edit;
    Self.ProcessarImagemAoGravar;
    DataSource1.DataSet.Post;
  except
    on E: ExceptionsFieldName do
      TUtils.TratarExceptionsFieldName(Self, E);
  end;
  inherited;
end;

procedure TViewProdutosCadastrar.ProcessarImagemAoGravar;
var
  LImgNome: string;
  LDestino: string;
begin
  if(imgFoto.Picture.Graphic = nil)then
  begin
    if(ModelProdutosDM.QProdutosCadastroIMAGEM.AsString.Trim.IsEmpty)then
      Exit;

    LDestino := TUtils.GetPastaImgProdutos + ModelProdutosDM.QProdutosCadastroIMAGEM.AsString.Trim;
    DeleteFile(LDestino);
    ModelProdutosDM.QProdutosCadastroIMAGEM.Clear;
  end
  else if(not FFotoOrigemAlterar.Trim.IsEmpty)then
  begin
    LImgNome := ModelProdutosDM.QProdutosCadastroIMAGEM.AsString.Trim;
    if(not LImgNome.IsEmpty)then
    begin
      LDestino := TUtils.GetPastaImgProdutos + LImgNome;
      DeleteFile(LDestino);
    end;

    LImgNome := FormatDateTime('YYYYmmdd_HHnnss_zzz', Now) + ExtractFileExt(FFotoOrigemAlterar);
    LDestino := TUtils.GetPastaImgProdutos + LImgNome;

    CopyFile(PWideChar(FFotoOrigemAlterar), PWideChar(LDestino), False);
    ModelProdutosDM.QProdutosCadastroIMAGEM.AsString := LImgNome;
  end;
end;

procedure TViewProdutosCadastrar.edtIdSubgrupoExit(Sender: TObject);
var
  LModelSubgruposDM: TModelSubgruposDM;
begin
  inherited;

  edtSubgrupo.Clear;
  if(Trim(edtIdSubgrupo.Text).IsEmpty)then
    Exit;

  LModelSubgruposDM := TModelSubgruposDM.Create(nil);
  try
    LModelSubgruposDM.LookSubgrupos(StrToIntDef(edtIdSubgrupo.Text, 0));
    if(LModelSubgruposDM.QLook.IsEmpty)then
    begin
      edtIdSubgrupo.SetFocus;
      raise Exception.Create('Subgrupo não localizado');
    end;

    edtSubgrupo.Text := LModelSubgruposDM.QLookNOME.AsString;
  finally
    LModelSubgruposDM.Free;
  end;
end;

procedure TViewProdutosCadastrar.edtIdSubgrupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if(Key = VK_F8)then
  begin
    ViewSubgruposBuscar := TViewSubgruposBuscar.Create(nil);
    try
      if(ViewSubgruposBuscar.ShowModal = mrOk)then
        edtIdSubgrupo.Text := ViewSubgruposBuscar.IdSelecionado.ToString;
    finally
      FreeAndNil(ViewSubgruposBuscar);
    end;
  end;
end;

procedure TViewProdutosCadastrar.FormShow(Sender: TObject);
begin
  inherited;

  FAlterarFoto := False;
  FFotoOrigemAlterar := '';

  ModelProdutosDM.CadastrarGet(inherited IdRegistroAlterar);
  if(DataSource1.DataSet.IsEmpty)then
    DataSource1.DataSet.Append
  else
  begin
    DataSource1.DataSet.Edit;
    edtIdSubgrupoExit(edtIdSubgrupo);
    Self.CarregarFotoAtual;
  end;

  edtNome.SetFocus;
end;

procedure TViewProdutosCadastrar.CarregarFotoAtual;
var
  LFilePath: string;
begin
  LFilePath := TUtils.GetPastaImgProdutos + ModelProdutosDM.QProdutosCadastroIMAGEM.AsString.Trim;

  if(FileExists(LFilePath))then
    imgFoto.Picture.LoadFromFile(LFilePath);
end;

procedure TViewProdutosCadastrar.edtPrecoCustoExit(Sender: TObject);
begin
  inherited;
  Self.CalcularPrecoVenda;
end;

procedure TViewProdutosCadastrar.edtPorcentagemExit(Sender: TObject);
begin
  inherited;
  Self.CalcularPrecoVenda;
end;

procedure TViewProdutosCadastrar.CalcularPrecoVenda;
begin
  if(edtPrecoCusto.Field.AsFloat < 0)then
    edtPrecoCusto.Field.AsFloat := 0;

  if(edtPorcentagem.Field.AsFloat < 0)then
    edtPorcentagem.Field.AsFloat := 0;

  if(edtPrecoCusto.Field.AsFloat = 0)or(edtPorcentagem.Field.AsFloat = 0)then
    Exit;

  edtPrecoVenda.Field.AsFloat := edtPrecoCusto.Field.AsFloat +
    ((edtPrecoCusto.Field.AsFloat * edtPorcentagem.Field.AsFloat) / 100);
end;

procedure TViewProdutosCadastrar.edtPrecoVendaExit(Sender: TObject);
begin
  inherited;
  Self.CalcularPorcentagem;
end;

procedure TViewProdutosCadastrar.CalcularPorcentagem;
begin
  if(edtPrecoVenda.Field.AsFloat < 0)then
    edtPrecoVenda.Field.AsFloat := 0;

  if(edtPrecoVenda.Field.AsFloat  = 0)then
  begin
    edtPorcentagem.Field.AsFloat := 0;
    Exit;
  end;

  edtPorcentagem.Field.AsFloat := ((edtPrecoVenda.Field.AsFloat / edtPrecoCusto.Field.AsFloat) * 100) - 100;
  if(edtPorcentagem.Field.AsFloat < 0)then
    edtPorcentagem.Field.AsFloat := 0;
end;

procedure TViewProdutosCadastrar.BuscarFoto1Click(Sender: TObject);
begin
  if(not OpenDialog1.Execute)then
    Exit;

  imgFoto.Picture.LoadFromFile(OpenDialog1.FileName);
  FAlterarFoto := True;
  FFotoOrigemAlterar := OpenDialog1.FileName;
end;

procedure TViewProdutosCadastrar.LimparFoto1Click(Sender: TObject);
begin
  imgFoto.Picture := nil;
  FAlterarFoto := True;
  FFotoOrigemAlterar := '';
end;

end.
