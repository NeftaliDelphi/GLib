unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CDiskInfo, StdCtrls, ExtCtrls, ComCtrls, ImgList, ShellAPI,
  TeEngine, Series, TeeProcs, Chart, Buttons, TypInfo;

type
  TForm1 = class(TForm)
    DiskInfo1: TDiskInfo;
    pnlResult: TPanel;
    Label1: TLabel;
    lbDriveLetters: TListBox;
    imgDrive: TImage;
    pnlGraph: TPanel;
    Chart1: TChart;
    Series1: TPieSeries;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblCapacidad: TLabel;
    lblUtilizado: TLabel;
    lblLibre: TLabel;
    lblExplorerDisplayName: TLabel;
    lblDriveTypeName: TLabel;
    Panel1: TPanel;
    Button7: TButton;
    spClose: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    mmInfo: TMemo;
    procedure Button7Click(Sender: TObject);
    procedure lbDriveLettersClick(Sender: TObject);
    procedure spCloseClick(Sender: TObject);
    procedure Label6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button7Click(Sender: TObject);
begin
  // Obtener las letras de unidad
  lbDriveLetters.Clear;
  DiskInfo1.GetDriveList(lbDriveLetters.Items);

  MessageDlg('Seleccina la unidad que desees de las disponibles en la lista.'+#13+#10+'Select a drive from the list.', mtInformation, [mbOK], 0);
end;

procedure TForm1.lbDriveLettersClick(Sender: TObject);
var
  PorcOcup, PorcFree:Integer;
  Str:String;

  //············································································
  procedure _AddInfo(Title, Value:String);
  begin
    if (Title <> STR_EMPTY) then begin
      mmInfo.Lines.Add(Title + ':  ' + Value);
    end
    else begin
      mmInfo.Lines.Add(STR_EMPTY);
    end;
  end;
  //············································································

begin

  // Item Seleccionado?
  if (lbDriveLetters.ItemIndex <> -1) then begin

    pnlGraph.Visible := True;

    DiskInfo1.DriveLetter := lbDriveLetters.Items[lbDriveLetters.ItemIndex][1];
    // Imagen
    imgDrive.Picture.Icon.handle := DiskInfo1.SystemIcon;

    // Graph
    Chart1.Title.Text[0] := DiskInfo1.ExplorerDisplayName;
    // Valores
    Chart1.Series[0].Clear;

    // Está disponible?
    if (DiskInfo1.IsReady) then begin
      PorcFree := Round((DiskInfo1.DriveFree.InKB / DiskInfo1.DriveSize.InKB) * 100);
      PorcOcup := 100 - PorcFree;
    end
    else begin
      PorcFree := 0;
      PorcOcup := 0;
    end;

    Chart1.Series[0].Add(PorcFree, 'Libre', clPurple);    
    Chart1.Series[0].Add(PorcOcup, 'Ocupado', clBlue);

    lblCapacidad.Caption :=
      FormatFloat('#.##, bytes', Trunc(DiskInfo1.DriveSize.InBytes)) + '   ' +
      FloatToStr(DiskInfo1.DriveSize.InGB) + ' GB';
    lblLibre.Caption :=
      FormatFloat('#.##, bytes', DiskInfo1.DriveFree.InBytes) + '   ' +
      FloatToStr(DiskInfo1.DriveFree.InGB) + ' GB';
    lblUtilizado.Caption :=
      FormatFloat('#.##, bytes', DiskInfo1.DriveSize.InBytes - DiskInfo1.DriveFree.InBytes) + '   ' +
      FloatToStr(DiskInfo1.DriveSize.InGB - DiskInfo1.DriveFree.InGB) + ' GB';

    // El resto
    lblExplorerDisplayName.Caption := DiskInfo1.ExplorerDisplayName;
    lblDriveTypeName.Caption := DiskInfo1.DriveTypeName;

    // memo...
    mmInfo.Lines.Clear;
    _AddInfo('Letra', DiskInfo1.DriveLetter);

    Str := GetEnumName(TypeInfo(TDriveType), Ord(DiskInfo1.DriveType));
    _AddInfo('Tipo de disco', Str);
    _AddInfo(STR_EMPTY, STR_EMPTY);
    _AddInfo('Tipo de disco (fmt)', DiskInfo1.DriveTypeName);
    _AddInfo('Nombre (Explorer)', DiskInfo1.ExplorerDisplayName);
    _AddInfo(STR_EMPTY, STR_EMPTY);
    _AddInfo('Etiqueta de volumen', DiskInfo1.VolumeLabel);
    _AddInfo('NSerie del volumen', DiskInfo1.VolumeNumberFmt);
    _AddInfo(STR_EMPTY, STR_EMPTY);
    _AddInfo('Número de Serie', DiskInfo1.SerialNumber);
    _AddInfo(STR_EMPTY, STR_EMPTY);
    _AddInfo('Sistema de ficheros', DiskInfo1.FileSystemName);
    _AddInfo(STR_EMPTY, STR_EMPTY);
    _AddInfo('Número de clusters', IntToStr(DiskInfo1.Clusters));
    _AddInfo('Clusters libres', IntToStr(DiskInfo1.FreeClusters));
    _AddInfo('Sectores/cluster', IntToStr(DiskInfo1.SectorsForCluster));
    _AddInfo('Bytes/sector', IntToStr(DiskInfo1.BytesForSector));
  end;

end;

procedure TForm1.spCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
    ShellExecute(Handle,
             'open',
             'http://neftali.clubdelphi.com/delphi_componentes.html',
             nil,
             nil,
             SW_SHOW);
end;

end.
