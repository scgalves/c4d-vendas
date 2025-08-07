object ModelProdutosDM: TModelProdutosDM
  OldCreateOrder = False
  Height = 320
  Width = 363
  object QProdutosCadastro: TFDQuery
    AfterInsert = QProdutosCadastroAfterInsert
    BeforePost = QProdutosCadastroBeforePost
    Connection = ModelConexaoDM.FDConnection1
    SQL.Strings = (
      'select *'
      'from produtos')
    Left = 112
    Top = 112
    object QProdutosCadastroID: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '000000'
    end
    object QProdutosCadastroID_SUBGRUPO: TIntegerField
      DisplayLabel = 'C'#243'd. subgrupo'
      FieldName = 'ID_SUBGRUPO'
      Origin = 'ID_SUBGRUPO'
      Required = True
      DisplayFormat = '000000'
    end
    object QProdutosCadastroNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object QProdutosCadastroDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 150
    end
    object QProdutosCadastroPRECO_CUSTO: TFMTBCDField
      DisplayLabel = 'Pre'#231'o de custo'
      FieldName = 'PRECO_CUSTO'
      Origin = 'PRECO_CUSTO'
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QProdutosCadastroPORCENTAGEM: TFMTBCDField
      DisplayLabel = 'Porcentagem'
      FieldName = 'PORCENTAGEM'
      Origin = 'PORCENTAGEM'
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QProdutosCadastroPRECO_VENDA: TFMTBCDField
      DisplayLabel = 'Pre'#231'o de venda'
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QProdutosCadastroUNIDADE: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
    end
    object QProdutosCadastroCODIGO_BARRAS: TStringField
      DisplayLabel = 'C'#243'digo de barras'
      FieldName = 'CODIGO_BARRAS'
      Origin = 'CODIGO_BARRAS'
    end
    object QProdutosCadastroIMAGEM: TStringField
      FieldName = 'IMAGEM'
      Origin = 'IMAGEM'
      Size = 200
    end
  end
  object QProdutosBusca: TFDQuery
    Connection = ModelConexaoDM.FDConnection1
    SQL.Strings = (
      'select'
      'produtos.ID,'
      'produtos.NOME,'
      'produtos.PRECO_CUSTO,'
      'produtos.PORCENTAGEM,'
      'produtos.PRECO_VENDA,'
      'produtos.UNIDADE,'
      'produtos.CODIGO_BARRAS,'
      'produtos.id_subgrupo,'
      'subgrupos.NOME as Subgrupo_Nome'
      'from produtos'
      'join subgrupos on (subgrupos.id = produtos.id_subgrupo)')
    Left = 224
    Top = 120
    object QProdutosBuscaID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '000000'
    end
    object QProdutosBuscaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object QProdutosBuscaPRECO_CUSTO: TFMTBCDField
      DisplayLabel = 'Pre'#231'o de custo'
      FieldName = 'PRECO_CUSTO'
      Origin = 'PRECO_CUSTO'
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QProdutosBuscaPORCENTAGEM: TFMTBCDField
      DisplayLabel = 'Porcentagem'
      FieldName = 'PORCENTAGEM'
      Origin = 'PORCENTAGEM'
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QProdutosBuscaPRECO_VENDA: TFMTBCDField
      DisplayLabel = 'Pre'#231'o de venda'
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      DisplayFormat = ',,0.00'
      Precision = 18
      Size = 2
    end
    object QProdutosBuscaUNIDADE: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
    end
    object QProdutosBuscaCODIGO_BARRAS: TStringField
      DisplayLabel = 'C'#243'digo de barras'
      FieldName = 'CODIGO_BARRAS'
      Origin = 'CODIGO_BARRAS'
    end
    object QProdutosBuscaID_SUBGRUPO: TIntegerField
      DisplayLabel = 'C'#243'd. subgrupo'
      FieldName = 'ID_SUBGRUPO'
      Origin = 'ID_SUBGRUPO'
      Required = True
      DisplayFormat = '000000'
    end
    object QProdutosBuscaSUBGRUPO_NOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Subgrupo'
      FieldName = 'SUBGRUPO_NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
  end
  object QLook: TFDQuery
    Connection = ModelConexaoDM.FDConnection1
    SQL.Strings = (
      'select '
      'first 1'
      'ID,'
      'NOME,'
      'PRECO_VENDA,'
      'UNIDADE'
      'from produtos'
      'where(codigo_barras = :CodBarras)')
    Left = 192
    Top = 200
    ParamData = <
      item
        Name = 'CODBARRAS'
        DataType = ftString
        ParamType = ptInput
        Size = 20
        Value = Null
      end>
    object QLookID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QLookNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object QLookPRECO_VENDA: TFMTBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Precision = 18
      Size = 2
    end
    object QLookUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
    end
  end
end
