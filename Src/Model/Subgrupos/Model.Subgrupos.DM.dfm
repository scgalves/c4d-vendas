object ModelSubgruposDM: TModelSubgruposDM
  OldCreateOrder = False
  Height = 240
  Width = 343
  object QSubgruposCadastro: TFDQuery
    BeforePost = QSubgruposCadastroBeforePost
    Connection = ModelConexaoDM.FDConnection1
    SQL.Strings = (
      'select * from subgrupos')
    Left = 104
    Top = 56
    object QSubgruposCadastroID: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      DisplayFormat = '000000'
    end
    object QSubgruposCadastroNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
  end
  object QSubgruposBusca: TFDQuery
    Connection = ModelConexaoDM.FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select * from subgrupos')
    Left = 216
    Top = 56
    object QSubgruposBuscaID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '000000'
    end
    object QSubgruposBuscaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
  end
  object QLook: TFDQuery
    Connection = ModelConexaoDM.FDConnection1
    SQL.Strings = (
      'select '
      'NOME'
      'from subgrupos'
      'where(ID = :IdSubgrupo)')
    Left = 104
    Top = 128
    ParamData = <
      item
        Name = 'IDSUBGRUPO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QLookNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
  end
end
