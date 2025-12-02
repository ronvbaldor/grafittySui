# GrafittySui

## Descripción

**GrafittySui** es un smart contract descentralizado construido sobre la blockchain Sui que simula un muro de graffiti urbano digital. El contrato permite crear muros virtuales donde artistas pueden pintar piezas de graffiti en diferentes posiciones, utilizando diversos estilos artísticos (Wildstyle, Bubble, Throw, Stencil, Mural). Cada pieza registra información del artista, estilo, colores utilizados y fecha de creación, además de permitir que la comunidad interactúe dando "likes" a las obras. Este sistema crea un espacio inmutable y verificable para el arte urbano digital, preservando la cultura del graffiti en la blockchain.

## Funciones del Contrato

### Funciones Públicas

#### `construir_muro`
```move
public fun construir_muro(
    ubicacion: String,
    ancho: u8,
    alto: u8,
    ctx: &mut TxContext
)
```
Crea un nuevo muro de graffiti compartido en la blockchain.
- **Parámetros:**
  - `ubicacion`: Ubicación del muro (ej: "Calle 5")
  - `ancho`: Ancho del muro en metros
  - `alto`: Alto del muro en metros
  - `ctx`: Contexto de la transacción
- **Comportamiento:** Crea un objeto `MuroGraffiti` compartido que puede ser utilizado por múltiples artistas

#### `pintar_pieza`
```move
public fun pintar_pieza(
    muro: &mut MuroGraffiti,
    posicion: u64,
    artista: String,
    estilo: EstiloGraffiti,
    colores: u8,
    timestamp: u64
)
```
Pinta una nueva pieza de graffiti en una posición específica del muro.
- **Parámetros:**
  - `muro`: Referencia mutable al muro
  - `posicion`: Posición en el muro donde se pintará la pieza
  - `artista`: Nombre del artista
  - `estilo`: Estilo de graffiti (Wildstyle, Bubble, Throw, Stencil, Mural)
  - `colores`: Número de colores utilizados
  - `timestamp`: Timestamp de creación
- **Comportamiento:** Añade una pieza de graffiti usando dynamic fields en la posición especificada

#### `dar_like_pieza`
```move
public fun dar_like_pieza(muro: &mut MuroGraffiti, posicion: u64)
```
Incrementa el contador de likes de una pieza específica.
- **Parámetros:**
  - `muro`: Referencia mutable al muro
  - `posicion`: Posición de la pieza en el muro
- **Comportamiento:** Incrementa en 1 el contador de likes de la pieza

#### `borrar_pieza`
```move
public fun borrar_pieza(muro: &mut MuroGraffiti, posicion: u64)
```
Elimina una pieza de graffiti del muro.
- **Parámetros:**
  - `muro`: Referencia mutable al muro
  - `posicion`: Posición de la pieza a eliminar
- **Comportamiento:** Remueve la pieza del muro usando dynamic fields

#### `existe_pieza`
```move
public fun existe_pieza(muro: &MuroGraffiti, posicion: u64): bool
```
Verifica si existe una pieza en una posición específica.
- **Parámetros:**
  - `muro`: Referencia al muro
  - `posicion`: Posición a verificar
- **Retorna:** `true` si existe una pieza en esa posición, `false` en caso contrario

#### `obtener_likes`
```move
public fun obtener_likes(muro: &MuroGraffiti, posicion: u64): u32
```
Obtiene el número de likes de una pieza específica.
- **Parámetros:**
  - `muro`: Referencia al muro
  - `posicion`: Posición de la pieza
- **Retorna:** Número de likes de la pieza

#### `area_total`
```move
public fun area_total(muro: &MuroGraffiti): u16
```
Calcula el área total del muro en metros cuadrados.
- **Parámetros:**
  - `muro`: Referencia al muro
- **Retorna:** Área total (ancho × alto)

### Estructuras de Datos

#### `MuroGraffiti`
```move
public struct MuroGraffiti has key {
    id: UID,
    ubicacion: String,
    ancho_metros: u8,
    alto_metros: u8
}
```
Estructura principal que representa un muro de graffiti.

#### `Pieza`
```move
public struct Pieza has store, drop {
    artista: String,
    estilo: EstiloGraffiti,
    colores_usados: u8,
    fecha_creacion: u64,
    likes: u32
}
```
Representa una pieza de graffiti pintada en el muro.

#### `EstiloGraffiti` (Enum)
```move
public enum EstiloGraffiti has copy, drop, store {
    Wildstyle,  // Estilo complejo con letras entrelazadas
    Bubble,     // Letras redondeadas tipo burbuja
    Throw,      // Estilo rápido y simple
    Stencil,    // Plantillas
    Mural       // Murales artísticos
}
```
Tipos de estilos de graffiti disponibles.

## Características Técnicas

- **Dynamic Fields**: Utiliza dynamic fields de Sui para almacenar piezas de manera eficiente
- **Shared Objects**: Los muros son objetos compartidos accesibles por múltiples usuarios
- **Interacción Social**: Sistema de likes para valorar las obras

## Tecnología

- **Blockchain:** Sui
- **Lenguaje:** Move
- **Módulo:** `mi_empresa::graffitysui`
