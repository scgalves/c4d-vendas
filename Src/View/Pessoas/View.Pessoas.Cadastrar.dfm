inherited ViewPessoasCadastrar: TViewPessoasCadastrar
  Caption = 'Pessoas cadastrar/alterar'
  ClientHeight = 385
  ClientWidth = 884
  OnShow = FormShow
  ExplicitWidth = 900
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnDados: TPanel
    Width = 884
    Height = 344
    ExplicitTop = -3
    ExplicitWidth = 884
    ExplicitHeight = 344
    object Label1: TLabel
      Left = 32
      Top = 24
      Width = 38
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 94
      Top = 24
      Width = 70
      Height = 13
      Caption = 'Nome/raz'#227'o'
      FocusControl = edtNome
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 467
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Fantasia'
      FocusControl = edtFantasia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 32
      Top = 90
      Width = 19
      Height = 13
      Caption = 'CEP'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 114
      Top = 90
      Width = 104
      Height = 13
      Caption = 'C'#243'digo cidade (F8)'
      FocusControl = edtIdCidade
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 467
      Top = 90
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 753
      Top = 90
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 32
      Top = 138
      Width = 28
      Height = 13
      Caption = 'Bairro'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 466
      Top = 138
      Width = 65
      Height = 13
      Caption = 'Complemento'
      FocusControl = DBEdit9
    end
    object Label10: TLabel
      Left = 753
      Top = 138
      Width = 55
      Height = 13
      Caption = 'Nascimento'
      FocusControl = DBEdit10
    end
    object Label11: TLabel
      Left = 32
      Top = 185
      Width = 42
      Height = 13
      Caption = 'Telefone'
      FocusControl = DBEdit11
    end
    object Label12: TLabel
      Left = 249
      Top = 185
      Width = 33
      Height = 13
      Caption = 'Celular'
      FocusControl = DBEdit12
    end
    object Label13: TLabel
      Left = 466
      Top = 185
      Width = 28
      Height = 13
      Caption = 'E-mail'
      FocusControl = DBEdit13
    end
    object Label14: TLabel
      Left = 249
      Top = 227
      Width = 19
      Height = 13
      Caption = 'CPF'
      FocusControl = edtCPF
    end
    object Label15: TLabel
      Left = 409
      Top = 227
      Width = 14
      Height = 13
      Caption = 'RG'
      FocusControl = edtRG
    end
    object Label16: TLabel
      Left = 533
      Top = 227
      Width = 25
      Height = 13
      Caption = 'CNPJ'
      FocusControl = edtCNPJ
    end
    object Label17: TLabel
      Left = 723
      Top = 227
      Width = 10
      Height = 13
      Caption = 'IE'
      FocusControl = edtIE
    end
    object Label18: TLabel
      Left = 32
      Top = 276
      Width = 44
      Height = 13
      Caption = 'Cadastro'
      FocusControl = DBEdit18
    end
    object DBEdit1: TDBEdit
      Left = 32
      Top = 40
      Width = 60
      Height = 21
      Color = clBtnFace
      DataField = 'ID'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TDBEdit
      Left = 94
      Top = 40
      Width = 370
      Height = 21
      DataField = 'NOME'
      DataSource = DataSource1
      TabOrder = 1
    end
    object edtFantasia: TDBEdit
      Left = 467
      Top = 40
      Width = 386
      Height = 21
      DataField = 'FANTASIA'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBCheckBox1: TDBCheckBox
      Left = 32
      Top = 67
      Width = 42
      Height = 17
      Caption = 'Ativo'
      DataField = 'ATIVO'
      DataSource = DataSource1
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBCheckBox2: TDBCheckBox
      Left = 82
      Top = 67
      Width = 57
      Height = 17
      Caption = 'Cliente'
      DataField = 'CLIENTE'
      DataSource = DataSource1
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBCheckBox3: TDBCheckBox
      Left = 142
      Top = 67
      Width = 71
      Height = 17
      Caption = 'Fornecedor'
      DataField = 'FORNECEDOR'
      DataSource = DataSource1
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBEdit4: TDBEdit
      Left = 32
      Top = 106
      Width = 80
      Height = 21
      DataField = 'CEP'
      DataSource = DataSource1
      TabOrder = 6
    end
    object edtIdCidade: TDBEdit
      Left = 114
      Top = 106
      Width = 79
      Height = 21
      DataField = 'ID_CIDADE'
      DataSource = DataSource1
      TabOrder = 7
      OnExit = edtIdCidadeExit
      OnKeyDown = edtIdCidadeKeyDown
    end
    object edtCidade: TEdit
      Left = 195
      Top = 106
      Width = 269
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object DBEdit6: TDBEdit
      Left = 467
      Top = 106
      Width = 284
      Height = 21
      DataField = 'ENDERECO'
      DataSource = DataSource1
      TabOrder = 9
    end
    object DBEdit7: TDBEdit
      Left = 753
      Top = 106
      Width = 100
      Height = 21
      DataField = 'NUMERO'
      DataSource = DataSource1
      TabOrder = 10
    end
    object DBEdit8: TDBEdit
      Left = 32
      Top = 154
      Width = 432
      Height = 21
      DataField = 'BAIRRO'
      DataSource = DataSource1
      TabOrder = 11
    end
    object DBEdit9: TDBEdit
      Left = 466
      Top = 154
      Width = 285
      Height = 21
      DataField = 'COMPLEMENTO'
      DataSource = DataSource1
      TabOrder = 12
    end
    object DBEdit10: TDBEdit
      Left = 753
      Top = 154
      Width = 100
      Height = 21
      DataField = 'NASCIMENTO'
      DataSource = DataSource1
      TabOrder = 13
    end
    object DBEdit11: TDBEdit
      Left = 32
      Top = 201
      Width = 215
      Height = 21
      DataField = 'TELEFONE'
      DataSource = DataSource1
      TabOrder = 14
    end
    object DBEdit12: TDBEdit
      Left = 249
      Top = 201
      Width = 215
      Height = 21
      DataField = 'CELULAR'
      DataSource = DataSource1
      TabOrder = 15
    end
    object DBEdit13: TDBEdit
      Left = 466
      Top = 201
      Width = 387
      Height = 21
      DataField = 'EMAIL'
      DataSource = DataSource1
      TabOrder = 16
    end
    object rdGroupTipoJuridico: TDBRadioGroup
      Left = 30
      Top = 236
      Width = 213
      Height = 34
      Caption = ' Tipo jur'#237'dico '
      Columns = 2
      DataField = 'TIPO_JURIDICO'
      DataSource = DataSource1
      Items.Strings = (
        'Pessoa f'#237'sica'
        'Pessoa jur'#237'dica')
      TabOrder = 17
      Values.Strings = (
        '1'
        '2')
      OnClick = rdGroupTipoJuridicoClick
    end
    object edtCPF: TDBEdit
      Left = 249
      Top = 243
      Width = 158
      Height = 21
      DataField = 'CPF'
      DataSource = DataSource1
      TabOrder = 18
    end
    object edtRG: TDBEdit
      Left = 409
      Top = 243
      Width = 122
      Height = 21
      DataField = 'RG'
      DataSource = DataSource1
      TabOrder = 19
    end
    object edtCNPJ: TDBEdit
      Left = 533
      Top = 243
      Width = 188
      Height = 21
      DataField = 'CNPJ'
      DataSource = DataSource1
      TabOrder = 20
    end
    object edtIE: TDBEdit
      Left = 723
      Top = 243
      Width = 130
      Height = 21
      DataField = 'IE'
      DataSource = DataSource1
      TabOrder = 21
    end
    object DBEdit18: TDBEdit
      Left = 32
      Top = 292
      Width = 213
      Height = 21
      Color = clBtnFace
      DataField = 'DH_CADASTRO'
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 22
    end
  end
  inherited pnRodape: TPanel
    Top = 344
    Width = 884
    ExplicitTop = 344
    ExplicitWidth = 884
    inherited btnGravar: TBitBtn
      Left = 621
      ExplicitLeft = 621
    end
    inherited btnCancelar: TBitBtn
      Left = 751
      ExplicitLeft = 751
    end
  end
  inherited DataSource1: TDataSource
    DataSet = ModelPessoasDM.QPessoasCadastro
    Left = 384
    Top = 0
  end
end
