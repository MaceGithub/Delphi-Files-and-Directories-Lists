object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Test FileAndDirectoryUtils'
  ClientHeight = 466
  ClientWidth = 956
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 304
    Top = 19
    Width = 68
    Height = 13
    Caption = 'Wildcard Mask'
  end
  object Label2: TLabel
    Left = 304
    Top = 65
    Width = 119
    Height = 13
    Caption = 'Regular Expression mask'
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 430
    Width = 274
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 8
    Width = 274
    Height = 416
    TabOrder = 1
  end
  object btnCreateList: TButton
    Left = 304
    Top = 288
    Width = 132
    Height = 65
    Caption = 'Create List'
    TabOrder = 2
    OnClick = btnCreateListClick
  end
  object memoResult: TMemo
    Left = 448
    Top = 8
    Width = 490
    Height = 441
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object editWildCardmask: TEdit
    Left = 304
    Top = 38
    Width = 132
    Height = 21
    TabOrder = 4
    Text = '*'
  end
  object editRegularExpression: TEdit
    Left = 304
    Top = 84
    Width = 132
    Height = 21
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 304
    Top = 111
    Width = 132
    Height = 98
    TabOrder = 6
    object rbtnDirectories: TRadioButton
      Left = 13
      Top = 64
      Width = 113
      Height = 17
      Caption = 'Directories'
      TabOrder = 0
    end
    object rbtnFilesAndDirectories: TRadioButton
      Left = 13
      Top = 12
      Width = 113
      Height = 23
      Caption = 'Files and Directories'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbtnFiles: TRadioButton
      Left = 13
      Top = 41
      Width = 113
      Height = 17
      Caption = 'Files'
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 304
    Top = 215
    Width = 132
    Height = 58
    TabOrder = 7
    object rbtnName: TRadioButton
      Left = 16
      Top = 8
      Width = 73
      Height = 17
      Caption = 'Name'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbtnPath: TRadioButton
      Left = 16
      Top = 31
      Width = 49
      Height = 17
      Caption = 'Path'
      TabOrder = 1
    end
  end
end
