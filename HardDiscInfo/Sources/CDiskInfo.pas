{
TDiskInfo  Component Version 1.2 - Suite GLib
Copyright (©) 2005,  by Germán Estévez (Neftalí)

  Permite obtener información completa acerca de un disco, ya sea local,
  diskette, unidad de red,...
  Información de Volumen, Serial, Espacio libre y ocupado, etiquetas,
  icono de sistema, Clusters, Sectores,...

Utilización/Usage:
  Basta con "soltar" el componente en el formulario y rellenar la propiedad:
    DriveLetter

  Place the component in the form and fill the property:
    DriveLetter

=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras, ampliaciones,
  errores y/o cualquier otro tipo de sugerencia envíame un mail a:
  german_ral@hotmail.com

IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements,
errors and/or any another type of suggestion send a mail to:
german_ral@hotmail.com
=========================================================================

@author Germán Estévez (Neftalí)
@cat Package GLib
}
unit CDiskInfo;
{
=========================================================================

  CDiskInfo.pas

  Componente

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------

  12/12/2005    * Creación.
  13/12/2005    * Se ha añadido la obtención del icono para cada unidad y
                  la Lista de unidades disponibles en el sistema.
  14/12/2005    * Añadida la porpiedad IsReady.
  20/02/2006    * Corrected bug on select letter (Thanks Vincenzo).
  16/03/2006    * (v. 1.2) Corregido un error al obtener Número de Serie
                  de varios discos instalados. (Thakns Peter Aschbacher)

=========================================================================

  Errores detectados no corregidos

=========================================================================
}

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ShellAPI, Graphics;

type

  // definición de la clase avanzada.
  // Previous Class definition
  TDiskInfo = class;

  TIdeSNDLLFunction = function(Letter:Char): String; stdcall;

  {: Tipos de discos más utilizados.// Drive types more extended
    @enum dtUnknown     Disco desconocido.
    @enum dtNoDrive     No hay disco para esa letra.
    @enum dtFloppy      Disco floppy o diskette.
    @enum dtFixed       Disco duro.
    @enum dtNetwork     Disco de red.
    @enum dtCDROM       CD-ROm o DVD.
    @enum dtRAM         Disco de memoria RAM.
  }
  TDriveType = (dtUnknown, dtNoDrive, dtFloppy, dtFixed, dtNetwork, dtCDROM, dtRAM);

  {:Clase TSizeInfo.
    La clase TSizeInfo sirve para almecenar tamañlos en diferentes unidades; Size
    structure for no need conversions.
  }
  TSizeInfo = class(TPersistent)
  private
    FInMB: Double;
    FInGB: Double;
    FInBytes: Double;
    FInKB: Double;
    FOwner:TDiskInfo;

    // No escribe nada
    procedure SetEmptyDouble(const Value: Double);

  protected

  public
    //: Conversiones entre diferentes unidades.// Conversions beetween units.
    procedure SetSizeInBytes(Size:Double);
    //: Constructor redefinido.
    constructor Create(Owner:TDiskInfo);

  published
    // Tamaños en diferentes unidades (para evitar tener que convertir)
    property InBytes:Double read FInBytes write SetEmptyDouble Stored False;
    property InKB:Double read FInKB write SetEmptyDouble Stored False;
    property InMB:Double read FInMB write SetEmptyDouble Stored False;
    property InGB:Double read FInGB write SetEmptyDouble Stored False;
  end;


  //: Clase que almacena la información de disco.
  TDiskInfo = class(TComponent)
  private
    FDriveLetter: Char;
    FDriveSize: TSizeInfo;
    FDriveType: TDriveType;
    FDriveFree: TSizeInfo;
    FVolumeLabel: String;
    FVolumeNumber: Cardinal{DWord};
    FVolumeNumberFmt: String;
    FSerialNumber: String;
    FFileSystemName: String;
    FFreeClusters: DWORD;
    FClusters: DWORD;
    FBytesForSector: DWORD;
    FSectorsForCluster: DWORD;
    FSystemIcon: hIcon;
    FImageIndex: integer;
    FExplorerDisplayName: String;
    FDriveTypeName: string;
    FOnChangeLetter: TNotifyEvent;
    FIsReady: Boolean;

    // Obtener el Serial.
    function _GetSerialStr(Serial:Integer):String;
    function _DiskInDrive(Drive: Char): Boolean;
    function _CallDLLFunction(const dllname, functionname: string):String;

    procedure SetDriveLetter(const Value: Char);
    procedure SetDriveType(const Value: TDriveType);

    //: Procedimientos de escrivtura vacía (las propiedades no se esciben).
    procedure SetEmptySizeInfo(const Value: TSizeInfo);
    procedure SetEmptyDriveType(const Value: TDriveType);
    procedure SetEmptyStr(const Value: String);
    procedure SetEmptyLongWord(const Value: LongWord);
    procedure SetEmptyDWord(const Value: DWORD);
    procedure SetEmptyInteger(const Value: Integer);
  public
    //: Redefinimos el constructor
    constructor Create(AOwner: TComponent); override;
    //: Redefinimos el destructor de la clase
    destructor Destroy; override;
    //: Obtiene la luista de unidades válidas en el sistema.
    procedure GetDriveList(TS:TStrings);
    //: Indica si la unidad está disponible
    property IsReady:Boolean read FIsReady write FIsReady stored False;

  published
    //: Letra //  Driver letter
    property DriveLetter:Char read FDriveLetter write SetDriveLetter;
    //: Tamaño del disco. Size of disk.
    property DriveSize:TSizeInfo read FDriveSize write SetEmptySizeInfo;
    //: Espacio libre en disco. Free space on Drive.
    property DriveFree: TSizeInfo read FDriveFree write SetEmptySizeInfo;
    //: Tipo de disco.  DiskType
    property DriveType:TDriveType read FDriveType write SetEmptyDriveType Stored False;
    //: Etiqueta del volumen (Se muestra cuando haces un   C:\> LABEL  )
    property VolumeLabel: String read FVolumeLabel write SetEmptyStr Stored False;
    //: Numero del volumen (Se muestra cuando haces un   C:\> LABEL  )
    property VolumeNumber: Cardinal{LongWord} read FVolumeNumber write SetEmptyLongWord Stored False;
    //: Etiqueta del volumen (decimal)
    property VolumeNumberFmt: String read FVolumeNumberFmt write SetEmptyStr Stored False;
    //: Etiqueta del volumen (Hexadecimal) (Se muestra cuando haces un   C:\> LABEL  )
    property SerialNumber:String read FSerialNumber write SetEmptyStr Stored False;
    //: Sistema de ficheros utilizado por ese disco.
    property FileSystemName: String read FFileSystemName write SetEmptyStr Stored False;
    //: Sectores por Cluster.
    property SectorsForCluster:DWORD read FSectorsForCluster write SetEmptyDWord Stored False;
    //: Bytes por sector.
    property BytesForSector:DWORD read FBytesForSector write SetEmptyDWord Stored False;
    //: clusters actualmente libres.
    property FreeClusters:DWORD read FFreeClusters write SetEmptyDWord Stored False;
    //: Numero total de Clusters en disco.
    property Clusters:DWORD read FClusters write SetEmptyDWord Stored False;
    // Icono asignado por Windows a ese disco.
    property SystemIcon: hIcon read FSystemIcon Stored False;
    { Indice de la imagen asignada a ese disco en las listas de iconos de windows.
      Ver API:  SHGetFileInfo   para obtener las listas}
    property ImageIndex: integer read FImageIndex write SetEmptyInteger Stored False;
    //: Nombre mostrado por el explorador de windows.
    property ExplorerDisplayName:String read FExplorerDisplayName write SetEmptyStr Stored False;
    //: Nombre del tipo de disco traducido por el sistema.
    property DriveTypeName: string read FDriveTypeName write SetEmptyStr Stored False;

    //: Evento que salta al cambiar de letra
    property OnChangeLetter: TNotifyEvent read FOnChangeLetter write FOnChangeLetter;
  end;

//: Constantes
const
  //: Constante para el String vacío.
  STR_EMPTY = '';
  //: Constante para añadir a la letra de unidad.
  SUFFIX_LETTER = ':\';
  //: Constante para el caracter de espacio.
  CHAR_SPACE = ' ';
  //: Constante para el caracter vacío.
  CHAR_EMPTY = #0;

//: Procedimiento de registro.
procedure Register;
//// Importar la DLL
//function GetIdeSN : String; stdcall; external 'IDESN.DLL';

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  Dialogs;

procedure Register;
begin
  RegisterComponents('GLib', [TDiskInfo]);
end;



function TDiskInfo._GetSerialStr(Serial:Integer):String;
begin
  result := Format ('%4x-%4x', [longrec(Serial).hi, longrec(Serial).lo]);
  while pos(CHAR_SPACE,result)>0 do
    result[pos(CHAR_SPACE,result)] := '0';
end;

//: Constructtor de la clase.
constructor TDiskInfo.Create(AOwner: TComponent);
begin
  inherited;

  FDriveLetter := CHAR_EMPTY;

  FDriveSize := TSizeInfo.Create(Self);
  FDriveFree := TSizeInfo.Create(Self);

end;

//: Destructor de la clase.
destructor TDiskInfo.Destroy();
begin

  // limpiar
  Self.FOnChangeLetter := nil;
  Self.FDriveLetter := CHAR_EMPTY;

  // Liberar
  FreeAndNil(FDriveSize);
  FreeAndNil(FDriveFree);

  inherited;
end;

procedure TDiskInfo.SetDriveLetter(const Value: Char);
var
  VolumeLabel, FSystem: Array[0..$FF] of Char;
  DW, SysFlags: DWord;
  SerialNumber:Cardinal{DWord};
  ADrive:array[0..2] of char;
  _SectorsForCluster,_BytesForSector, _FreeClusters,_Clusters: DWORD;
  _IsReady, _MustClear:Boolean;
  SHFileInfo : TSHFileInfo;
begin

  // Nombre no valido ==> Asignar algo correcto
  if (Value = STR_EMPTY) or (Value = CHAR_SPACE) then begin
    Self.FDriveLetter := CHAR_EMPTY;
  end
  else begin
    Self.FDriveLetter := Value;
  end;

  // Calculos
  StrPCopy(ADrive, FDriveLetter + SUFFIX_LETTER);
  Self.FDriveType := TDriveType(GetDriveType(ADrive));
  _MustClear := False;
  _IsReady := True;

  // Es un drive valido?
  if (Self.FDriveType <> dtUnknown) and (Self.FDriveType <> dtNoDrive) then begin

    _IsReady := True;
    // Es un Drive o CDROM, comprobar si está?
    if (Self.FDriveType = dtFloppy) or (Self.FDriveType = dtCDROM) then begin
      _IsReady := _DiskInDrive(FDriveLetter);
      _MustClear := not _IsReady;
    end;

    // Preparado
    if (_IsReady) then begin
      Self.FDriveSize.SetSizeInBytes(SysUtils.DiskSize(Byte(FDriveLetter) - $40));
      Self.FDriveFree.SetSizeInBytes(SysUtils.DiskFree(Byte(FDriveLetter) - $40));

      // Sectores y Clusters
      if GetDiskFreeSpace(ADrive, _SectorsForCluster,_BytesForSector,
                          _FreeClusters,_Clusters) then begin
        // recoger la información...
        Self.FSectorsForCluster := _SectorsForCluster;
        Self.FBytesForSector := _BytesForSector;
        Self.FFreeClusters := _FreeClusters;
        Self.FClusters := _Clusters;
      end;
    end;

    // Info referente al Shell
    ShGetFileInfo (ADrive, 0, SHFileInfo, SizeOf (TSHFileInfo),
     SHGFI_TYPENAME or SHGFI_DISPLAYNAME or SHGFI_SYSICONINDEX or SHGFI_ICON);

    // Recuperar info del Shell
    Self.FSystemIcon  := SHFileInfo.hIcon;
    Self.FImageIndex := SHFileInfo.iIcon;
    Self.FExplorerDisplayName := SHFileInfo.szDisplayName;
    Self.FDriveTypeName := SHFileInfo.szTypeName;

    // Preparado
    if (_IsReady) then begin
      // Info Volumen
      GetVolumeInformation(PChar(FDriveLetter + SUFFIX_LETTER), VolumeLabel,
                           SizeOf(VolumeLabel),
                           @SerialNumber, DW, SysFlags,
                           FSystem, SizeOf(FSystem));

      // recuperar la informacion
      Self.FVolumeLabel := VolumeLabel;
      Self.FVolumeNumber := SerialNumber;
      Self.FVolumeNumberFmt := _GetSerialStr(FVolumeNumber);
      // Sistema de ficheros
      Self.FFileSystemName := FSystem;
      // Serial (externo)
      // {Llamada estatica} Self.FSerialNumber := GetIdeSN;
      {llamada dinamica} Self.FSerialNumber :=
        _CallDLLFunction('IDESN.DLL', 'GetIdeSN');
    end;
    
    // Leventar el evento
    if Assigned(Self.FOnChangeLetter) then begin
      Self.FOnChangeLetter(Self);
    end;
  end
  else begin
    _MustClear := True;
  end;

  if (_MustClear) then begin
    // Limpiar la info.
    Self.FDriveSize.SetSizeInBytes(0);
    Self.FDriveFree.SetSizeInBytes(0);
    //
    Self.FSectorsForCluster := 0;
    Self.FBytesForSector := 0;
    Self.FFreeClusters := 0;
    Self.FClusters := 0;
    //
    Self.FSystemIcon  := 0;
    Self.FImageIndex := -1;

    // Deconocido?
    if (Self.FDriveType = dtUnknown) or (Self.FDriveType = dtNoDrive) then begin
      Self.FExplorerDisplayName := STR_EMPTY;
      Self.FDriveTypeName := STR_EMPTY;
    end;
    //
    Self.FVolumeLabel := STR_EMPTY;
    Self.FVolumeNumber := 0;
    Self.FVolumeNumberFmt := STR_EMPTY;
    //
    Self.FFileSystemName := STR_EMPTY;
    //
    Self.FSerialNumber := STR_EMPTY;
  end;

  // está disponible
  Self.FIsReady := _IsReady;

end;

procedure TDiskInfo.SetDriveType(const Value: TDriveType);
begin
  // Nada
end;

procedure TDiskInfo.SetEmptySizeInfo(const Value: TSizeInfo);
begin
  // Nada
end;

procedure TDiskInfo.SetEmptyDriveType(const Value: TDriveType);
begin
  // Nada
end;

procedure TDiskInfo.SetEmptyStr(const Value: String);
begin
  // Nada
end;

procedure TDiskInfo.SetEmptyLongWord(const Value: LongWord);
begin
  // Nada
end;

procedure TDiskInfo.SetEmptyDWord(const Value: DWORD);
begin
  // Nada
end;

procedure TDiskInfo.SetEmptyInteger(const Value: Integer);
begin
  // Nada
end;

//: Redefinir el constructor.
constructor TSizeInfo.Create(Owner: TDiskInfo);
begin
  inherited Create;

  // Asignar el Owner
  Self.FOwner := Owner;
end;

//: No escribe nada.
procedure TSizeInfo.SetEmptyDouble(const Value: Double);
begin
  // Nada
end;

//: Conversiones entre diferentes unidades.
procedure TSizeInfo.SetSizeInBytes(Size: Double);
var
  Str:String;
begin
  // Bytes
  Self.FInBytes := Size;

  // No válido?
  if (Size = 0) then begin
    Self.FInKB := 0;
    Self.FInMB := 0;
    Self.FInGB := 0;
    Exit;
  end;

  // KB
  Self.FInKB := (Size / 1024);
  Str := FloatToStrF(Self.FInKB, ffFixed, 18 ,2);
  Self.FInKB := StrToFloat(Str);
  // MB
  Self.FInMB := Round(Size / 1048576);
  Str := FloatToStrF(Self.FInMB, ffFixed, 18 ,2);
  Self.FInMB := StrToFloat(Str);
  // GB
  Self.FInGB := (Size / 1073741824);
  Str := FloatToStrF(Self.FInGB, ffFixed, 18 ,2);
  Self.FInGB := StrToFloat(Str);
end;


//: Retorna si el disco está en la unidad.
function TDiskInfo._DiskInDrive(Drive: Char): Boolean;
var
  ErrorMode: Word;
begin
  // letras mayusculas
  if (Drive in ['a'..'z']) then begin
    Dec(Drive, $20);
  end;

  // Letra no correcta?
  if not (Drive in ['A'..'Z']) then begin
    Result := False;
    Exit;   //thnks; Vincenzo.
  end;

  // desactivar errores críticos // turn off critical errors.
  ErrorMode := SetErrorMode(SEM_FailCriticalErrors);
  // Proteccion
  try
    // probar a acceder
    if (DiskSize(Ord(Drive) - $40) = -1) then begin
      Result := False
    end
    else begin
      Result := True;
    end;
  finally
    // Restaurar el modo de los errores
    SetErrorMode(ErrorMode);
  end;
end;


//: Obtiene la lista de unidades válidas en el sistema.
procedure TDiskInfo.GetDriveList(TS: TStrings);
var
  nDrives: LongWord;
  Drives: array[0..128] of char;
  pDrive: PChar;
begin

  // No asignada la lista...
  if not Assigned(TS) then begin
    Exit;
  end;

  // Obtiene un array con todas las letras válidas de unidades.
  nDrives := GetLogicalDriveStrings(SizeOf(Drives), Drives);
  // Na hay o error
  if (nDrives = 0) then begin
    Exit;
  end;

  // Hay alguna?
  if (nDrives > SizeOf(Drives)) then begin
    Exit;
  end;

  // Asignar
  pDrive := Drives;

  // Para todas  las letras...
  while (pDrive^ <> CHAR_EMPTY) do begin
    TS.Add(pDrive);
    Inc(pDrive, 4);
  end;
end;



function TDiskInfo._CallDLLFunction(const dllname, functionname: string):String;
var
  hDLL: THandle;
  theFunction: TIdeSNDLLFunction;
  buf: array [0..144] of Char;

  Strpath:string;
begin
  // Get a handle to the DLL module.
  // das Handle zum DLL Modul ermitteln.
  StrPath := StrPCopy(buf, dllname);
  hDLL := LoadLibrary(PChar(strPath));
  // If the handle is valid, try to get the function address.
  // Wenn das Handle gültig ist, versuche die Adresse der Funktion zu ermitteln
  if hDLL <> 0 then
  begin
    // Return the address of the specified exported (DLL) function.
    // Adresse der Dll-Funktion ermitteln
    try
      @theFunction := GetProcAddress(hDll, StrPCopy(buf, functionname));
      // If the function address is valid, call the function.
      // Wenn die Funktion gefunden wurde...
      if @theFunction <> nil then
        Result := theFunction(Self.DriveLetter)
      else
        Result := Format('<Error in %s>', [dllname]);
    finally
      // Free the DLL module.
      // Dll wieder freigeben.
      Try
        FreeLibrary(hDLL);
      except
        on E:Exception do begin
          MessageDlg('Error: ' + E.Message, mtWarning, [mbOK], 0);
        end;
      end;
    end;
  end
  else
    Result := Format('<Error in %s>', [dllname]);
end;



end.


