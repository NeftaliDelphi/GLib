# GLib
GLib es una librería/biblioteca de componentes para elphi de uso general.

Son de uso gratuito y de licencia libre.

Puedes usarlos libremente y descargar el código fuente para estudiarlo o modificarlo; Puedes utilizarlos en cualquier tipo de aplicaciones; Gratuías o comerciales. Sólo te pido que si haces cambios en el código (mejoras, correcciones,…) me lo comuniques para actualizar los componentes, si son de interés para mi y para otras personas.

Puedes descargar los componentes de forma individual o todos juntos en un package, dependiendo de lo que te interese. Para ello selecciona los links individuales o para descargar el paquete completo el último que hace referencia a la Librería GLib.

<img src="https://neftali.clubdelphi.com/images/gLibComponents.bmp">

_________________________________________
__Componente TLogDisk.__
(version 1.0)

El componente TLogDisk sirve para facilitar el trabajo a un programador que necesite añadir un Log a sus programas. Basta con “soltar?? el componente en un formulario del programa y activarlo. Automáticamente el componente crea el fichero de Log, almacena datos de la aplicación (cabecera) y ofrece al programador métodos/rutinas para añadir datos de diferentes tipos al Log.

_________________________________________
__Componente TEditInsideHelp.__
(version 1.0)

Este componente permite definir un texto de ayuda en la parte interna del control de edición (TEdit). El texto desaparace cuando el control contiene algun texto que el usuario ha introducido. Se pueden definir el color que deseamos para el texto de la ayuda de forma independiente al color definido en la fuente (propiedad Font) del componente.

_________________________________________
__Componente TPanelGrid.__
(version 1.0)

Este componente (en éste caso derivado de un TPanel) muestra cómo añadir a un componente una Cuadrícula o Grid similar a la que aparece en los formularios cuando los estamos diseñando desde el IDE de Delphi.
Se puede configurar en el componente el color y el espaciado entre puntos de la cuadrícula.
Basta con soltarlo en el formulario y activarlo.


_________________________________________
__Componente TDiskInfo.__
(version 1.2)

Este componente permite para recuperar información diversa sobre los Discos existentes en el de sistema; Discos duros, diskettes, discos de red, discos RAM… Colóquelo en un formulario y defina la letra del disco.

Puede recuperar la información sobre:

    Volumem; Etiqueta, número…
    Serial number (no número de volumen)
    Espacio; Libre, total, ocupado.
    Icono del suistema
    Nombre en el Explorer y descripción
    Tipo de disco
    Sistema de ficheros
    Clusters, Sectores,…
    …


_________________________________________
__Componente TSortListBox.__
(version 1.0)

Componente derivado de un TListBox que añade la propiedad de definir ordenaciones para los diferentes elementos de la lista; Junto a cada elemento se muestra una señal para indicar la ordenación. Posee una propiedad de tipo array para consultar el estado de cada item de la lista


_________________________________________
__Componente TSaveComps.__
(version 1.4)

Permite guardar la posicion y tamaño de todos los componentes que se encuentran en el formulario. Utiliza para ello un fichero INI.
Basta con colocar el componente en el formulario y activarlo; Cuando la aplicación se cierra graba la posición/tamaño y al volver a ejecutarla los recupera de forma automática.


_________________________________________
__Componente TSelectOnRuntime.__
(version 1.5)

Permite seleccionar componentes visuales (en Runtime) que haya en un form de forma visual como se hace con las imágenes en los programas de diseño o con los controles en el IDE de Delphi.
Además se pueden mover y redimensionar los controles seleccionados. Basta con soltar el control en el formulario, asignarle el control que se desea seleccionar/mover/redimensionar y activarlo.

_________________________________________
__Componente TKeysOnForm.__
(version 1.0)

Permite gestionar de forma sencilla (sin código) algunas de las combinaciones de teclas más utilizadas en los formularios. Basta con soltar el componente sobre el formulario y activar las propiedades deseadas segun el comportamiento que queramos.

    ENTER para cambiar de campo.
    ESC para cerrar el formulario
    Avanzar al siguiente control
    Retrasar al anterior control
    Teclas de función
    …


_________________________________________
__Componente TCustomizeGrid.__
(version 1.3)

Permite modificar algunos aspectos en la visualización de un Grid estandard.
No deriva del DBGrid, si no que funciona como complemento al componente estandard de Delphi. (En construcción…)
La propiedad Flat permite modificar el aspecto del DBGrid.
Implementa métodos para mejorar el pintado en el Grid de las celdas de tipo Booleano y Memo;
Sustituye el texto por un checkbox y (MEMO) que aparece en los campos Memo por el texto del campo.

Además provee eventos para modificar colores del DBGrid:

    OnPaintCell: Para pintar xeldas de un determinado color.
    OnPaintCellExt: BIS del anterior con más parámetros.
    OnPaintColumn: Permite pintar una columna de color.
    OnPaintRow: Permite pintar una file de color.
    OnPaintCellImage: Permite pintar imágenes en una celda.
    OnChangeTitleCell: Modificar las celdas de título.


_________________________________________
__Componente TInactivityApp.__
(version 1.0)

Este componente permite detectar en la aplicación donde se utiliza la inactividad de teclado y de ratón pasado un determinado tiempo (de forma similar a cómo se activa el salvapantallas del sistema).
El tiempo que se quiere detectar de inactividad es configurable por el usuario en minutos y segundos. Basta con activar el componente, configurar el tiempo de inactividad; Pasado este tiempo de inactividad «saltará» un evento de aviso.


