use jni::JNIEnv;
use jni::objects::{JClass, JString};
use jni::sys::jstring;

mod inference;
mod tracking;
mod analytics;
mod tests;

#[no_mangle]
pub extern "C" fn init_core() {
    println!("Oko Saurona Core Initialized!");
    // Setup ONNX Runtime, thread pools, SQLCipher connection
}

#[no_mangle]
pub extern "C" fn process_frame(frame_data: *const u8, width: i32, height: i32) {
    // 1. Decode / Process raw frame
    // 2. Run active models via `inference::run_models`
    // 3. Update trackers via `tracking::update`
    // 4. Calculate analytics via `analytics::calculate_trajectory`
    // 5. Store in SQLCipher
}

// Android JNI bindings
#[allow(non_snake_case)]
#[no_mangle]
pub extern "system" fn Java_com_okosaurona_CoreBridge_initEngine(
    mut env: JNIEnv,
    _class: JClass,
) -> jstring {
    init_core();
    let output = env.new_string("Engine Initialized successfully").expect("Couldn't create java string!");
    output.into_raw()
}
