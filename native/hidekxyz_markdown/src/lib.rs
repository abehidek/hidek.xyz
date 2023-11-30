use rustler::NifStruct;
use serde::{Deserialize, Serialize};

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[derive(Debug, Serialize, Deserialize)]
struct Point {
    x: i64,
    y: i64,
}

#[rustler::nif]
fn test(a: i64, b: i64) -> String {
    let point = Point { x: a, y: b };

    let serialized = serde_json::to_string(&point).unwrap();

    serialized
}

#[derive(Debug, NifStruct, Deserialize, Serialize)]
#[module = "HidekXyz.Content.Article.Frontmatter"]
struct Article {
    title: String,
    description: String,
    publish_date: String,
    tags: Vec<String>,
    public: bool,
    cover: Option<String>,
}

#[rustler::nif]
fn parse_yml(frontmatter: String) -> Article {
    let des: Article = serde_yaml::from_str(&frontmatter).unwrap();

    des

    // frontmatter.to_uppercase()
}

rustler::init!("Elixir.HidekXyz.Markdown", [add, test, parse_yml]);
