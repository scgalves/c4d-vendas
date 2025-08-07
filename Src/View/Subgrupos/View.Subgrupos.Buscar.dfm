inherited ViewSubgruposBuscar: TViewSubgruposBuscar
  Caption = 'Subgrupos buscar'
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
        end>
    end
  end
  inherited pnRodape: TPanel
    inherited rdGroupFiltros: TRadioGroup
      Columns = 3
      ItemIndex = 1
      Items.Strings = (
        'C'#243'digo (F1)'
        'Nome (F2)')
    end
  end
  inherited pnTotal: TPanel
    inherited lbTotal: TLabel
      Height = 19
    end
  end
  inherited DataSource1: TDataSource
    DataSet = ModelSubgruposDM.QSubgruposBusca
  end
end
