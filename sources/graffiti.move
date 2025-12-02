// Contrato 17: Muro de graffiti urbano
module mi_empresa::graffitysui {
    use std::string::String;
    use sui::dynamic_field as df;
    
    public struct MuroGraffiti has key {
        id: UID,
        ubicacion: String,
        ancho_metros: u8,
        alto_metros: u8
    }
    
    public struct Pieza has store, drop {
        artista: String,
        estilo: EstiloGraffiti,
        colores_usados: u8,
        fecha_creacion: u64,
        likes: u32
    }
    
    public enum EstiloGraffiti has copy, drop, store {
        Wildstyle,
        Bubble,
        Throw,
        Stencil,
        Mural
    }
    
    public fun construir_muro(
        ubicacion: String,
        ancho: u8,
        alto: u8,
        ctx: &mut TxContext
    ) {
        transfer::share_object(MuroGraffiti {
            id: object::new(ctx),
            ubicacion,
            ancho_metros: ancho,
            alto_metros: alto
        });
    }
    
    public fun pintar_pieza(
        muro: &mut MuroGraffiti,
        posicion: u64,
        artista: String,
        estilo: EstiloGraffiti,
        colores: u8,
        timestamp: u64
    ) {
        let pieza = Pieza {
            artista,
            estilo,
            colores_usados: colores,
            fecha_creacion: timestamp,
            likes: 0
        };
        
        df::add(&mut muro.id, posicion, pieza);
    }
    
    public fun dar_like_pieza(muro: &mut MuroGraffiti, posicion: u64) {
        let pieza = df::borrow_mut<u64, Pieza>(&mut muro.id, posicion);
        pieza.likes = pieza.likes + 1;
    }
    
    public fun borrar_pieza(muro: &mut MuroGraffiti, posicion: u64) {
        df::remove<u64, Pieza>(&mut muro.id, posicion);
    }
    
    public fun existe_pieza(muro: &MuroGraffiti, posicion: u64): bool {
        df::exists_<u64>(&muro.id, posicion)
    }
    
    public fun obtener_likes(muro: &MuroGraffiti, posicion: u64): u32 {
        let pieza = df::borrow<u64, Pieza>(&muro.id, posicion);
        pieza.likes
    }
    
    public fun area_total(muro: &MuroGraffiti): u16 {
        (muro.ancho_metros as u16) * (muro.alto_metros as u16)
    }
}
