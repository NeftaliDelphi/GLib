unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, jpeg, ExtCtrls, TeEngine, Series,
  TeeProcs, Chart, CSaveComps, CSelectOnRunTime, ActnList, Buttons, ShellAPI,
  VclTee.TeeGDIPlus, System.Actions, System.ImageList;

type
  TFormMain = class(TForm)
    pnlTitulo: TPanel;
    pnlOperaciones: TPanel;
    sbMensajes: TStatusBar;
    pnlPlano: TPanel;
    imgPlano: TImage;
    pcModo: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ImageList1: TImageList;
    btnCrearMesa: TBitBtn;
    btnBorrarMesa: TBitBtn;
    btnModifMesa: TBitBtn;
    Label1: TLabel;
    cbMesa: TComboBox;
    btnOcupar: TBitBtn;
    btnCuenta: TBitBtn;
    pnlOcupacion: TPanel;
    ChartOcup: TChart;
    Series1: TPieSeries;
    SelectOnRunTime: TSelectOnRunTime;
    SaveComps1: TSaveComps;
    TimerTime: TTimer;
    btnGuardarDist: TBitBtn;
    btnRecuperarDist: TBitBtn;
    sdDist: TSaveDialog;
    imgMesaDemo: TImage;
    ActionList1: TActionList;
    ActionCrearMesa: TAction;
    ActionChangeGray: TAction;
    ActionChangeColor: TAction;
    ActionSalir: TAction;
    ActionBorrarMEsa: TAction;
    odRecuperar: TOpenDialog;
    ActionGuardarDistribucion: TAction;
    ActionRecuperarDistribucion: TAction;
    ActionModificarMesa: TAction;
    ActionNuevoCliente: TAction;
    ActionNota: TAction;
    Label2: TLabel;
    cbMesa2: TComboBox;
    imgMesaDemo2: TImage;
    mmDescAdmin: TMemo;
    mmDescNormal: TMemo;
    procedure FormShow(Sender: TObject);
    procedure TimerTimeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionCrearMesaExecute(Sender: TObject);
    procedure pcModoChange(Sender: TObject);
    procedure ActionChangeGrayExecute(Sender: TObject);
    procedure ActionChangeColorExecute(Sender: TObject);
    procedure SaveComps1NotExistComponentEvent(TObject: TObject;
      ComponentName, ComponentClassName, ComponentParent: String;
      Props: TStrings);
    procedure ActionBorrarMEsaExecute(Sender: TObject);
    procedure cbMesaChange(Sender: TObject);
    procedure SelectOnRunTimeBeforeSelect(Sender: TObject;
      Selected: TControl; var Select: Boolean);
    procedure ActionGuardarDistribucionExecute(Sender: TObject);
    procedure ActionRecuperarDistribucionExecute(Sender: TObject);
    procedure ActionNuevoClienteExecute(Sender: TObject);
    procedure ActionNotaExecute(Sender: TObject);
    procedure sbMensajesClick(Sender: TObject);
    procedure SelectOnRunTimeBeginMove(Sender: TObject; Control: TControl;
      const x, y: Integer);
    procedure SelectOnRunTimeEndMove(Sender: TObject; Control: TControl;
      const x, y: Integer);
  private
    { Private declarations }
    _OriginalBitmap:TBitmap;
    _nmesas:Integer;

    procedure OnMesaClick(Sender: TObject);

    procedure _ConfigureChart();
    function _CreateMesa(AName:String; AParent:TWinControl;
                         ALeft, ATop:Integer):TImage;

  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain._ConfigureChart();
var
  PorcOcup, PorcFree:Integer;
  i:Integer;
  comp:TComponent;
  StrName:String;
begin

  // Iniciales
  PorcFree := 0;
  PorcOcup := 0;
  // Graph
  ChartOcup.Title.Text[0] := 'Nivel de ocupación';
  // Valores
  ChartOcup.Series[0].Clear;

  // recorrer componentes.
  for i := 0 to (Self.ComponentCount - 1) do begin
    comp := Self.Components[i];
    // Es un TImage?
    if (comp is TImage) then begin
      StrName := Copy(comp.Name, 1, 4);
      // Es una Mesa?
      if (StrName = 'Mesa') then begin

        // Ocupada ?
        if (comp.Tag = 99) then begin
          PorcOcup := PorcOcup + 1;
        end
        else begin
          PorcFree := PorcFree + 1;
        end;
      end;
    end;
  end;

  // etiquetas
  ChartOcup.Series[0].Add(PorcFree, 'Libre', clPurple);
  ChartOcup.Series[0].Add(PorcOcup, 'Ocupado', clBlue);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  // CopyRight
  sbMensajes.Panels[2].Text := '© 2006 Neftalí -Germán Estévez-';
  // Configurar el ráfico
  _ConfigureChart();
end;

procedure TFormMain.TimerTimeTimer(Sender: TObject);
begin
  // Actualizar la hora
  sbMensajes.Panels[1].Text := DateTimeToStr(Now);
end;


procedure TFormMain.FormCreate(Sender: TObject);
begin

  inherited;

  // Crear elementos
  _OriginalBitmap := TBitmap.Create();

  // Inicalizaciones
  pcModo.ActivePageIndex := 1;

end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin

  // Elimnar elementos creados
  if Assigned(_OriginalBitmap) then begin
    FreeAndNil(_OriginalBitmap);
  end;

  inherited;

end;



function TFormMain._CreateMesa(AName:String; AParent:TWinControl;
                               ALeft, ATop:Integer):TImage;
var
  img:TImage;
  comp:TComponent;
  NewName:String;
begin

  // Crear el nuevo elemento
  img := TImage.Create(Self);
  Result := img;

  // Modificar
  with img do begin

    // crear la nueva mesa
    Picture := imgMesaDemo.Picture;

    // Props
    // Se ha pasado nombre?
    if (AName <> '') then begin
      NewName := AName;
    end
    else begin
      // Proteccion simple por si el nombre existe... (por si se han borrado)
      NewName := 'Mesa_' + IntToStr(_nmesas);
      comp := Self.FindComponent(NewName);
      // ir buscando nombre no existente
      while Assigned(comp) do begin
        _nmesas := _nmesas + 1;
        NewName := 'Mesa_' + IntToStr(_nmesas);
        comp := Self.FindComponent(NewName);
      end;
    end;

    _nmesas := _nmesas + 1;
    Parent := AParent{pnlPlano};
    img.Name := NewName;
    img.ShowHint := True;
    img.Hint := 'Mesa: ' + img.Name;

    // Posicion
    Left := ALEft;
    Top := ATop;
    // Tamaño
    height := imgMesaDemo.Height;
    width := imgMesaDemo.Width;
    // Otras propìedades
    Transparent := True;
    Stretch := True;
    // eventos
    OnClick := OnMesaClick;

    // Añadirla al combo de mesas
    cbMesa.Items.Add(NewName);
    cbMesa.ItemIndex := 0;
    cbMesa2.Items.Add(NewName);
    cbMesa2.ItemIndex := 0;

  end;
end;

procedure TFormMain.ActionCrearMesaExecute(Sender: TObject);
var
  img:TImage;
begin

  // Crear
  img := _CreateMesa('', pnlPlano, 10, 10);
  // Activar
  SelectOnRunTime.Active := True;
  // Seleccionar
  SelectOnRunTime.SelectControl := img;

end;

procedure TFormMain.pcModoChange(Sender: TObject);
begin
  // Al cambiar de pestaña, cambiamos la imagen para mostrar el modo
  if (pcModo.ActivePageIndex = 0) then begin
    ActionChangeGray.Execute;
    SelectOnRunTime.Active := True;
  end
  else begin
    ActionChangeColor.Execute;
    SelectOnRunTime.Active := False;
  end;

  // Combo de mesas
  cbMesa.ItemIndex := 0;
  cbMesa2.ItemIndex := 0;
  // descripciones
  mmDescAdmin.Visible := (pcModo.ActivePageIndex = 0);
  mmDescNormal.Visible := (pcModo.ActivePageIndex = 1);

end;

procedure TFormMain.ActionChangeGrayExecute(Sender: TObject);

  // Convierte una imagen en Escala de Grises.
  //············································································
  procedure ITEVImageGrayScale(AnImage: TBitmap); overload;
  var
    JPGImage: TJPEGImage;
    BMPImage: TBitmap;
    MemStream: TMemoryStream;
  begin
    // Crear una temporal
    BMPImage := TBitmap.Create;
    // Proteccion
    try
      // Dimensiones
      BMPImage.Width := AnImage.Width;
      BMPImage.Height := AnImage.Height;
      // Creo un jpeg
      JPGImage := TJPEGImage.Create;
      // preteccion
      try
        // Asignaciones
        JPGImage.Assign(AnImage);
        JPGImage.CompressionQuality := 100;
        JPGImage.Compress;
        JPGImage.Grayscale := True;
        // Oasarlo al Bitmap
        BMPImage.Canvas.Draw(0, 0, JPGImage);

        MemStream := TMemoryStream.Create;
        // proteccion
        try
          BMPImage.SaveToStream(MemStream);
          //you need to reset the position of the MemoryStream to 0
          MemStream.Position := 0;

          AnImage.LoadFromStream(MemStream);
        finally
          MemStream.Free;
        end;
      finally
        JPGImage.Free;
      end;
    finally
      BMPImage.Free;
    end;
  end; //fin de ImageGrayScale
  //············································································

begin
  // Gris (se cambia el modo para distinguir como se trabaja -Admin/normal-)
  _OriginalBitmap.Assign(imgPlano.Picture.Bitmap);
  ITEVImageGrayScale(imgPlano.Picture.Bitmap);
end;

procedure TFormMain.ActionChangeColorExecute(Sender: TObject);
begin
  // Restaurar la original
  imgPlano.Picture.Bitmap.Assign(_OriginalBitmap);
end;


procedure TFormMain.SaveComps1NotExistComponentEvent(TObject: TObject;
  ComponentName, ComponentClassName, ComponentParent: String;
  Props: TStrings);
var
  StrName, StrValue:String;
  ALeft, ATop, Index:Integer;
begin

  // Es un TImage?
  if (ComponentClassName = 'TImage') then begin
    StrName := Copy(ComponentName, 1, 4);
    ALeft := 10;
    ATop := 10;
    // Es una Mesa?
    if (StrName = 'Mesa') then begin

      // recuperar el LEFT
      StrValue := Props.Values['Left'];
      if (StrValue <> '') then begin
        ALeft := StrToInt(Props.Values['Left']);
      end;

      // Recuperar TOP
      StrValue := Props.Values['Top'];
      if (StrValue <> '') then begin
        ATop := StrToInt(Props.Values['Top']);
      end;

      // Crear la mesa
      _CreateMesa(ComponentName, pnlPlano, ALeft, ATop);

    end;
  end;


end;

procedure TFormMain.OnMesaClick(Sender: TObject);
begin
  // Está en modo administrador?
  if (pcModo.ActivePageIndex = 0) then begin
    SelectOnRunTime.Selected := False;
    // En un TControl?
    if (Sender is TControl) then begin
      SelectOnRunTime.SelectControl := TControl(Sender);
      SelectOnRunTime.Selected := True;
    end;
  end;
end;




procedure TFormMain.ActionBorrarMEsaExecute(Sender: TObject);
var
  ctrl:TControl;
begin

  // Hay alguna Seleccionada?
  if (SelectOnRunTime.Selected) then begin
    // Hay algo seleccionado?
    if Assigned(SelectOnRunTime.SelectControl) then begin

      ctrl := SelectOnRunTime.SelectControl;
      SelectOnRunTime.Selected := False;

      FreeAndNil(ctrl);
      SelectOnRunTime.SelectControl := nil;

      Exit;
    end;
  end;

  // No hay nada seleccionado
  MessageDlg('Seleccione mediante el ratón el elemento que desea borrar.', mtWarning, [mbOK], 0);

end;

procedure TFormMain.cbMesaChange(Sender: TObject);
var
  CompName:String;
  comp:TComponent;
begin
  // Seleccionar esa mesa...
  if (cbMesa.ItemIndex <> -1) then begin
    CompName := cbMesa.Items[cbMesa.ItemIndex];

    // Seleccionar
    comp := Self.FindComponent(CompName);
    // Encontrado?
    if Assigned(comp) then begin
      SelectOnRunTime.SelectControl := TControl(comp);
      SelectOnRunTime.Selected := True;
    end;
  end;

end;

procedure TFormMain.SelectOnRunTimeBeforeSelect(Sender: TObject;
  Selected: TControl; var Select: Boolean);
var
  Index:Integer;
begin
  // Buscar
  Index := cbMesa.Items.IndexOf(Selected.Name);
  // encontrado?
  if (Index <> -1) then begin
    cbMesa.ItemIndex := Index;
  end;


end;

procedure TFormMain.SelectOnRunTimeBeginMove(Sender: TObject; Control: TControl;
  const x, y: Integer);
begin
  Self.Caption := 'BEGIN: ' + IntToStr(X) + ' - ' + IntToStr(Y);
end;

procedure TFormMain.SelectOnRunTimeEndMove(Sender: TObject; Control: TControl;
  const x, y: Integer);
begin
  Self.Caption := 'FINISH: ' + IntToStr(X) + ' - ' + IntToStr(Y);
end;

procedure TFormMain.ActionGuardarDistribucionExecute(Sender: TObject);
var
  FileName:String;
begin
  // Recuperar
  if (sdDist.Execute) then begin
    // Guardar la configuracion actual
    SaveComps1.SaveComponentsProps;
    // Grabar configu
    CopyFile(PChar(SaveComps1.IniFileName), PChar(sdDist.FileName), False);
  end;
end;

procedure TFormMain.ActionRecuperarDistribucionExecute(Sender: TObject);
var
  FileName:String;
  i:Integer;
  comp:TComponent;
begin
  // Guardar
  if (odRecuperar.Execute) then begin

    // Copiar config
    CopyFile(PChar(odRecuperar.FileName), PChar(SaveComps1.IniFileName), False);

    // Eliminar las mesas actuales
    for i := 1 to (cbMesa.Items.Count - 1) do begin
      // Componente
      comp := self.FindComponent(cbMesa.Items[i]);
      // Encontrado?
      if Assigned(comp) then begin
        SelectOnRunTime.SelectControl := NIL;
        SelectOnRunTime.Selected := False;
        FreeAndNil(comp);
      end;
    end;

    // Cargar la nueva
    SaveComps1.LoadComponentsProps;
  end;

end;

procedure TFormMain.ActionNuevoClienteExecute(Sender: TObject);
var
  comp:TComponent;
  mesa:TImage;
begin

  // No hay mesa seleccionada?
  if (cbMesa2.ItemIndex = 0) then begin
    MessageDlg('Seleccione una mesa en el combo superior. El Hint de cada mesa muestra el nombre/código', mtWarning, [mbOK], 0);
    Exit;
  end;

  // Acceder al control
  comp := FindComponent(cbMesa2.Items[cbMesa2.ItemIndex]);
  if Assigned(comp) then begin
    mesa := TImage(comp);

    // La mesa ya está ocupada?
    if (mesa.Tag = 99) then begin
      MessageDlg(Format('La <%s> mesa ya está ocupada.', [comp.Name]), mtWarning, [mbOK], 0);
      Exit;
    end;

    // Ocupar la mesa
    mesa.Tag := 99;
    mesa.Picture.Bitmap.Assign(imgMesaDemo2.Picture.Bitmap);

    // Actualizar porcentage
    _ConfigureChart();

  end;

end;

procedure TFormMain.ActionNotaExecute(Sender: TObject);
var
  comp:TComponent;
  mesa:TImage;
begin

  // No hay mesa seleccionada?
  if (cbMesa2.ItemIndex = 0) then begin
    MessageDlg('Seleccione una mesa en el combo superior. El Hint de cada mesa muestra el nombre/código', mtWarning, [mbOK], 0);
    Exit;
  end;

  // Acceder al control
  comp := FindComponent(cbMesa2.Items[cbMesa2.ItemIndex]);
  if Assigned(comp) then begin
    mesa := TImage(comp);

    // La mesa ya está Libre?
    if (mesa.Tag = 0) then begin
      MessageDlg(Format('La <%s> mesa ya está libre.', [comp.Name]), mtWarning, [mbOK], 0);
      Exit;
    end;

    // Ocupar la mesa
    mesa.Tag := 0;
    mesa.Picture.Bitmap.Assign(imgMesaDemo.Picture.Bitmap);

    // Actualizar porcentage
    _ConfigureChart();

  end;
end;

procedure TFormMain.sbMensajesClick(Sender: TObject);
begin
    // Web
    ShellExecute(Handle,
             'open',
             'http://neftali.clubdelphi.com/delphi_componentes.html',
             nil,
             nil,
             SW_SHOW);


end;

end.
