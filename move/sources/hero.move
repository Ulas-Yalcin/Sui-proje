module challenge::hero;

use std::string::String;

// ========= STRUCTS =========
public struct Hero has key, store {
    id: UID,
    name: String,
    image_url: String,
    power: u64,
}

public struct HeroMetadata has key, store {
    id: UID,
    timestamp: u64,
}

// ========= FUNCTIONS =========

#[allow(lint(self_transfer))]
public fun create_hero(name: String, image_url: String, power: u64, ctx: &mut TxContext) {
    // 1. Yeni bir Hero objesi oluştur
    let id = object::new(ctx);
    
    // Değişkenleri Hero içine taşıyoruz (Move)
    let hero = Hero { 
        id, 
        name, 
        image_url, 
        power 
    };

    // 2. Hero'yu işlemi yapan kişiye (sender) transfer et
    let sender = tx_context::sender(ctx);
    transfer::public_transfer(hero, sender);

    // 3. HeroMetadata oluştur (Sadece timestamp ile)
    let metadata = HeroMetadata {
        id: object::new(ctx),
        timestamp: tx_context::epoch_timestamp_ms(ctx)
    };

    // 4. Metadata'yı dondur (Immutable yap)
    transfer::freeze_object(metadata);
    
    // TODO: Create a new Hero struct with the given parameters
        // Hints:
        // Use object::new(ctx) to create a unique ID
        // Set name, image_url, and power fields
    // TODO: Transfer the hero to the transaction sender
    // TODO: Create HeroMetadata and freeze it for tracking
        // Hints:
        // Use ctx.epoch_timestamp_ms() for timestamp
    //TODO: Use transfer::freeze_object() to make metadata immutable
}

// ========= GETTER FUNCTIONS =========

public fun hero_power(hero: &Hero): u64 {
    hero.power
}

#[test_only]
public fun hero_name(hero: &Hero): String {
    hero.name
}

#[test_only]
public fun hero_image_url(hero: &Hero): String {
    hero.image_url
}

#[test_only]
public fun hero_id(hero: &Hero): ID {
    object::id(hero)
}

