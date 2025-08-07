inherited ViewCidadesCadastrar: TViewCidadesCadastrar
  Caption = 'Cidades cadastrar/alterar'
  ClientHeight = 304
  ClientWidth = 572
  OnShow = FormShow
  ExplicitWidth = 588
  ExplicitHeight = 343
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnDados: TPanel
    Width = 572
    Height = 263
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
    object Label3: TLabel
      Left = 48
      Top = 133
      Width = 14
      Height = 13
      Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 48
      Top = 176
      Width = 59
      Height = 13
      Caption = 'C'#243'digo IBGE'
      FocusControl = edtCodigoIBGE
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
    object edtCodigoIBGE: TDBEdit
      Left = 48
      Top = 192
      Width = 134
      Height = 21
      DataField = 'CODIGO_IBGE'
      DataSource = DataSource1
      TabOrder = 3
    end
    object cBoxUF: TDBComboBox
      Left = 48
      Top = 149
      Width = 134
      Height = 21
      Style = csDropDownList
      DataField = 'UF'
      DataSource = DataSource1
      DropDownCount = 28
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SE'
        'SP'
        'TO'
        'EX')
      TabOrder = 2
    end
  end
  inherited pnRodape: TPanel
    Top = 263
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
    DataSet = ModelCidadesDM.QCidadesCadastro
  end
end
