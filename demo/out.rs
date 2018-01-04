#[path = "../demo/main.rs"]
mod main;

fn main(){
	main::init();

	print!("content-type: html\n\n<html><head><title>demo</title></head><body>{}</body></html>",main::content());
}