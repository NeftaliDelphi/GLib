unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdActns, ActnList, ComCtrls, StdCtrls, CLogDisk,
  ExtCtrls, ImgList, ToolWin, ExtActns;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileExit1: TFileExit;
    Fichero1: TMenuItem;
    edicin1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    N1: TMenuItem;
    Paste1: TMenuItem;
    Open1: TMenuItem;
    SaveAs1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Exit2: TMenuItem;
    mmMain: TRichedit;
    LogDisk: TLogDisk;
    Splitter1: TSplitter;
    pnlLog: TPanel;
    Label1: TLabel;
    mmLog: TMemo;
    Timer1: TTimer;
    Panel1: TPanel;
    cbContinuo: TCheckBox;
    cblogTime: TCheckBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ImageList1: TImageList;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ActionIncreaseFont: TAction;
    ActionDecreaseFont: TAction;
    procedure FileOpen1Accept(Sender: TObject);
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure pnlLogResize(Sender: TObject);
    procedure cbContinuoClick(Sender: TObject);
    procedure cblogTimeClick(Sender: TObject);
    procedure mmMainKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ActionIncreaseFontExecute(Sender: TObject);
    procedure ActionDecreaseFontExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  {generales} ShellAPI;


procedure TForm1.FileOpen1Accept(Sender: TObject);
begin
  if (FileOpen1.Dialog.FileName <> '') then begin
    mmMain.Lines.LoadFromFile(FileOpen1.Dialog.FileName);
    LogDisk.Log('Cargando fichero: ', FileOpen1.Dialog.FileName);
  end;
end;

procedure TForm1.FileSaveAs1Accept(Sender: TObject);
begin
  if (FileSaveAs1.Dialog.FileName <> '') then begin
    mmMain.Lines.SaveToFile(FileSaveAs1.Dialog.FileName);

    LogDisk.Log('Grabado el fichero: ', FileSaveAs1.Dialog.FileName);
  end;

end;

procedure TForm1.StatusBar1Click(Sender: TObject);
begin
    ShellExecute(Handle,
             'open',
             'http://neftali.clubdelphi.com',
             nil,
             nil,
             SW_SHOW);
    LogDisk.Log('Acceso a la página. ', 'http://neftali.clubdelphi.com');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  // Ir actualizando lo que tiene el LOG
  mmLog.Lines.Assign(Self.LogDisk.LogLines);

end;

procedure TForm1.pnlLogResize(Sender: TObject);
begin
  LogDisk.Log(Format('Resize panel Log, Ancho=%d    Alto=%d',
        [pnlLog.Width, pnlLog.Height]));
end;

procedure TForm1.cbContinuoClick(Sender: TObject);
begin
  LogDisk.ContinuousWrite := cbContinuo.Checked;
end;

procedure TForm1.cblogTimeClick(Sender: TObject);
begin
  LogDisk.LogWithTime := cblogTime.Checked;
end;

procedure TForm1.mmMainKeyPress(Sender: TObject; var Key: Char);
begin
  // Se ha pulsado ENTER?
  if (key = #13) then begin
    LogDisk.Log('Se ha pulsado ENTER');
  end
  // pulsado borrado?
  else if (key = #8) then begin
    LogDisk.Log('Se ha pulsado BACK SPACE');
  end;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  RichEditBold1.Execute;
  LogDisk.Log('Pulsado NEGRITA');
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  RichEditItalic1.Execute;
  LogDisk.Log('Pulsado CURSIVA');
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  RichEditUnderline1.Execute;
  LogDisk.Log('Pulsado SUBRAYADO');
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  RichEditStrikeOut1.Execute;
  LogDisk.Log('Pulsado TACHADO');
end;

procedure TForm1.ActionIncreaseFontExecute(Sender: TObject);
begin
  mmMain.SelAttributes.Size := mmMain.SelAttributes.Size + 2;
  LogDisk.Log('Incrementando la fuente');
end;

procedure TForm1.ActionDecreaseFontExecute(Sender: TObject);
begin
  mmMain.SelAttributes.Size := mmMain.SelAttributes.Size - 2;
  LogDisk.Log('Decrementando la fuente');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  
  inherited;

  // Abrir
  ShellExecute(Handle,
               'open',
               PChar(Self.LogDisk.LogFileName),
               nil,
               nil,
               SW_SHOW);

end;

end.
