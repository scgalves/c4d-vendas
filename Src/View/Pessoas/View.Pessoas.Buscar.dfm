inherited ViewPessoasBuscar: TViewPessoasBuscar
  Caption = 'Pessoas buscar'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnGrid: TPanel
    inherited DBGrid1: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FANTASIA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLIENTE'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORNECEDOR'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_CIDADE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADENOME'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFONE'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CELULAR'
          Width = 64
          Visible = True
        end>
    end
  end
  inherited pnRodape: TPanel
    inherited rdGroupFiltros: TRadioGroup
      Columns = 3
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo (F1)'
        'Nome / fantasia (F2)'
        'Cidade (F3)')
    end
  end
  inherited DataSource1: TDataSource
    DataSet = ModelPessoasDM.QPessoasBusca
  end
end
