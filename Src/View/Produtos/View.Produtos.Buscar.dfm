inherited ViewProdutosBuscar: TViewProdutosBuscar
  Caption = 'Produtos buscar'
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
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Width = 223
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO_CUSTO'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PORCENTAGEM'
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO_VENDA'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDADE'
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODIGO_BARRAS'
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_SUBGRUPO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUBGRUPO_NOME'
          Visible = True
        end>
    end
  end
  inherited pnRodape: TPanel
    inherited rdGroupFiltros: TRadioGroup
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo(F1)'
        'Nome(F2)'
        'C'#243'digo de barras (F3)'
        'Subgrupo (F4)')
    end
  end
  inherited pnTotal: TPanel
    inherited lbTotal: TLabel
      Height = 19
    end
  end
  inherited DataSource1: TDataSource
    DataSet = ModelProdutosDM.QProdutosBusca
  end
end
