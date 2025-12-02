#[test_only]
module mi_empresa::graffitysui_tests {
    use mi_empresa::graffitysui;
    use std::string::utf8;
    use sui::test_scenario as ts;
    
    #[test]
    fun test_construir_muro() {
        let mut scenario = ts::begin(@0xA);
        {
            let ctx = ts::ctx(&mut scenario);
            graffitysui::construir_muro(utf8(b"Calle 5"), 10, 3, ctx);
        };
        
        ts::next_tx(&mut scenario, @0xA);
        {
            let muro = ts::take_shared(&scenario);
            assert!(graffitysui::area_total(&muro) == 30, 0);
            ts::return_shared(muro);
        };
        ts::end(scenario);
    }
}
