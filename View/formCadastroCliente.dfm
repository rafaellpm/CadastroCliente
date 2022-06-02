object frmCadastroCliente: TfrmCadastroCliente
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Cliente'
  ClientHeight = 332
  ClientWidth = 549
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 549
    Height = 75
    Align = alTop
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object btnNovo: TSpeedButton
      Left = 11
      Top = 5
      Width = 75
      Height = 68
      Caption = 'Gravar'
      ImageIndex = 0
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      NumGlyphs = 4
      ParentFont = False
      Transparent = False
      OnClick = btnNovoClick
    end
    object btnExcluir: TSpeedButton
      Left = 90
      Top = 5
      Width = 75
      Height = 68
      HelpType = htKeyword
      Caption = 'Excluir'
      ImageIndex = 2
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = btnExcluirClick
    end
    object btnFechar: TSpeedButton
      Left = 471
      Top = 5
      Width = 75
      Height = 68
      Caption = 'Fechar'
      ImageIndex = 5
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      OnClick = btnFecharClick
    end
    object btnCancelar: TSpeedButton
      Left = 171
      Top = 5
      Width = 75
      Height = 68
      HelpType = htKeyword
      Caption = 'Cancelar'
      ImageIndex = 6
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = btnCancelarClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 5
    Top = 88
    Width = 535
    Height = 236
    Caption = 'Cadastro de Cliente'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 119
      Top = 28
      Width = 75
      Height = 13
      Caption = 'Nome Completo'
    end
    object Label3: TLabel
      Left = 200
      Top = 79
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object Label4: TLabel
      Left = 16
      Top = 176
      Width = 33
      Height = 13
      Caption = 'Celular'
    end
    object Label5: TLabel
      Left = 200
      Top = 176
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object Label6: TLabel
      Left = 16
      Top = 79
      Width = 48
      Height = 13
      Caption = 'CPF/CNPJ'
    end
    object Label7: TLabel
      Left = 16
      Top = 126
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label8: TLabel
      Left = 167
      Top = 126
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object edtCodigo: TEdit
      Left = 16
      Top = 44
      Width = 97
      Height = 21
      TabStop = False
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtNomeCliente: TEdit
      Left = 119
      Top = 44
      Width = 402
      Height = 21
      TabOrder = 1
    end
    object edtEndereco: TEdit
      Left = 200
      Top = 95
      Width = 321
      Height = 21
      TabOrder = 3
    end
    object edtCelular: TEdit
      Left = 16
      Top = 192
      Width = 178
      Height = 21
      TabOrder = 6
      OnExit = edtCelularExit
    end
    object edtEmail: TEdit
      Left = 200
      Top = 192
      Width = 321
      Height = 21
      TabOrder = 7
      OnExit = edtEmailExit
    end
    object edtCpfCnpj: TEdit
      Left = 16
      Top = 95
      Width = 178
      Height = 21
      TabOrder = 2
      OnExit = edtCpfCnpjExit
    end
    object cbbUF: TComboBox
      Left = 16
      Top = 142
      Width = 145
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
      OnExit = cbbUFExit
    end
    object cbbCidade: TComboBox
      Left = 167
      Top = 142
      Width = 354
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
    end
  end
end
