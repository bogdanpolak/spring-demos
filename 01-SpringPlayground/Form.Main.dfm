object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 427
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 190
    Height = 421
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
  end
  object ActionList1: TActionList
    Left = 224
    Top = 24
    object actListAndSelectMany: TAction
      Caption = 'actListAndSelectMany'
      OnExecute = actListAndSelectManyExecute
    end
    object actTObjectDataSet: TAction
      Caption = 'actTObjectDataSet'
      OnExecute = actTObjectDataSetExecute
    end
    object Action3: TAction
      Caption = 'Action3'
      OnExecute = Action3Execute
    end
  end
end
