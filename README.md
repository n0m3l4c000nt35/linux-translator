# Traductor para Linux

Permite traducir al idioma configurado textos seleccionados y escuchar su pronunciación

Crear dos atajos:
- Uno para que luego de seleccionado el texto se realice la traducción
- Otro para escuchar la pronunciación del texto seleccionado

Al traducir el texto seleccionado se abre un cuadro de diálogo con la traducción y hay una opción para escuchar la pronunciación desde el cuadro de diálogo. Si solo se quiere escuchar la pronunciación se puede seleccionar un texto y presionar el atajo de teclado.

Está configurado para usarse con GNOME.

![tradu](./tradu.png)

Los atajos de teclado que uso son:
- `Control + Super + Alt + g` para el script `translate.sh`
- `Control + Super + Alt + p` para el script `pronounce.sh`

Ambos archivos están en `$HOME/.config/scripts`
