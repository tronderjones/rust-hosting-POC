use serde::Deserialize;
use actix_web::{get, web::Query};

#[derive(Deserialize)]
pub(crate) struct Info {
    name: Option<String>,
}

#[get("/api/HttpTrigger")]
pub(crate) async fn get_hello(info: Query<Info>) -> String {

    match info.name {
        Some(ref name) => format!("Hello {}!", name),
        None => "Hello! You should tell me who you are!".to_string(),
    }
    
}