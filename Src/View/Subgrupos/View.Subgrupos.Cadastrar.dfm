inherited ViewSubgruposCadastrar: TViewSubgruposCadastrar
  Caption = 'Subgrupos cadastrar/alterar'
  ClientHeight = 220
  ClientWidth = 572
  OnShow = FormShow
  ExplicitWidth = 588
  ExplicitHeight = 259
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnDados: TPanel
    Width = 572
    Height = 179
    ExplicitTop = -3
    ExplicitWidth = 572
    ExplicitHeight = 263
    object Label1: TLabel
      Left = 48
      Top = 45
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = edtCodigo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 48
      Top = 88
      Width = 32
      Height = 13
      Caption = 'Nome'
      FocusControl = edtNome
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigo: TDBEdit
      Left = 48
      Top = 61
      Width = 134
      Height = 21
      Color = clBtnFace
      DataField = 'ID'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TDBEdit
      Left = 48
      Top = 104
      Width = 481
      Height = 21
      DataField = 'NOME'
      DataSource = DataSource1
      TabOrder = 1
    end
  end
  inherited pnRodape: TPanel
    Top = 179
    Width = 572
    ExplicitTop = 263
    ExplicitWidth = 572
    inherited btnGravar: TBitBtn
      Left = 309
      ExplicitLeft = 309
    end
    inherited btnCancelar: TBitBtn
      Left = 439
      ExplicitLeft = 439
    end
  end
  inherited DataSource1: TDataSource
    DataSet = ModelSubgruposDM.QSubgruposCadastro
  end
end
