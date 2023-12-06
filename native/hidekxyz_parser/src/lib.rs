use rustler::NifStruct;
use serde::{Deserialize, Serialize};

#[derive(Debug, NifStruct, Deserialize, Serialize)]
#[module = "HidekXyz.Content.Article.Frontmatter"]
struct ArticleFrontmatter {
    title: String,
    description: String,
    publish_date: String,
    tags: Vec<String>,
    public: bool,
    cover: Option<String>,
    series: Option<String>,
}

#[rustler::nif]
fn parse_frontmatter(frontmatter: String) -> ArticleFrontmatter {
    serde_yaml::from_str::<ArticleFrontmatter>(&frontmatter).unwrap()
}

rustler::init!("Elixir.HidekXyz.Content.Parser", [parse_frontmatter]);
