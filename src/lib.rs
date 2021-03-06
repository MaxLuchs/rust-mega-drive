#![crate_type="staticlib"]
#![no_std]

use core::panic::PanicInfo;

mod vdp;

#[no_mangle]
pub fn run_game() -> ! {
    loop {
        let vdp = vdp::VDP::new();
        loop {}
    }
}

#[panic_handler]
#[no_mangle]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
