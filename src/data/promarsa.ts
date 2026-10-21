// Coordinates refer to the original sheet, without its blank page margins.
// Labels and measurements are transcribed from CORRECION 6.pdf.
export const zones = [
  ['Bancos o cajas',167,46,288,40], ['Telefonía',455,46,330,40],
  ['Farmacia',785,46,293,40], ['Tienda de conveniencia',1078,46,166,40], ['Apuestas',1244,46,62,40],
  ['Carne',176,96,150,97], ['Pollo',339,96,345,97], ['Papa y tubérculos',701,96,170,97],
  ['Limones',888,96,44,97], ['Zapallos',950,96,43,97], ['Tomates',1008,96,44,97], ['Verduras',1068,96,219,97],
  ['Pescado',176,201,150,101], ['Leche / huevos / quesos / embutidos',339,201,276,101], ['Cebolla',635,201,237,101],
  ['Limones',888,212,44,90], ['Zapallos',950,212,43,90], ['Tomates',1008,212,44,90], ['Verduras',1068,212,219,90],
  ['Plástico y productos de limpieza',176,312,203,109], ['Flores',447,312,42,109],
  ['Patio de comidas',563,319,315,103], ['Chifa',950,312,43,109], ['Granos verdes',1068,312,100,109], ['Choclo',1184,312,103,109],
  ['Ropa',176,431,203,110], ['Calzado',393,431,95,110], ['Bazar',503,431,113,110],
  ['Productos de la sierra / menestras',635,431,239,110], ['Frutos secos',893,431,101,110], ['Abarrotes',1009,438,101,103], ['Frutas',1127,431,160,110],
  ['Costura',285,546,42,114], ['Joyería',338,546,43,114], ['Maletas',393,546,42,114], ['Ferretería',447,546,42,114],
  ['Juguetería',503,546,113,114], ['P. naturales',635,546,48,114], ['Golosinas',764,546,48,114], ['Especerías',828,546,47,114],
  ['Regalos',893,546,43,114], ['Abarrotes',1009,546,101,114], ['Frutas',1127,556,160,104],
  ['Mascotas',266,677,106,40], ['Peluquería',372,677,165,40], ['Cuidado personal',537,677,120,40],
  ['Cosmético',657,677,114,40], ['Librería',771,677,81,40], ['Servicio técnico',852,677,133,40],
  ['Licorería',985,677,115,40], ['Papelería',1100,677,119,40], ['T. tecnología',1219,677,92,40],
  ['Estacionamientos',1313,70,404,341], ['Carga y descarga',1572,468,231,221],
].map(([name,x,y,w,h], index) => ({ id: index, name: String(name), x: Number(x), y: Number(y), w: Number(w), h: Number(h) }));
