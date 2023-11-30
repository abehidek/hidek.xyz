---
title: "This website was created using Phoenix Liveview"
description: "Who said we can only build interactive, real-time web applications using liveview?"
publish_date: "2023-11-21"
tags: ["phoenix", "elixir", "liveview"]
cover: ""
public: false
---

SSGs or Static Site Generators have been gaining popularity in the web space due to it's simplicity.

```text
1. Write markdown 
2. Generate HTML on build based on markdown
3. Serve then from a server (it could be a CDN)
```

I've mentioned markdown however it could be any kind of content, as long as it's static (since you only build your website once)

Nowadays we have amazing tooling such as:
- Jekyll
- Hugo
- 11ty
- Astro

On the otherside we have Phoenix Liveview, a recently developed way of building web applications that are highly interactive and real-time, it uses the Phoenix framework and consequently the Elixir language.

In this article I will explain why I've used Liveview for my personal website, how to do it and why you may want it too.

## How

At it's core, all markdown file reading, metadada parsing and HTML compiling happens using [NimblePublisher](https://github.com/dashbitco/nimble_publisher) created by the [Dashbit Company](https://dashbit.co/).

This library happens to do all of that once (when Phoenix application starts) and further API calls get only the cached result.

First create a module along with a callback `build/3` that returns a struct containing all metadata that you want.

```elixir
defmodule HidekXyz.Article do
  @enforce_keys [:slug, :title, :description, :body, :publish_date]
  defstruct [:slug, :title, :description, :body, :publish_date]

  def build(filename, attrs, body) do
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    struct!(__MODULE__,
      slug: slug,
      title: attrs.title,
      description: attrs.description,
      body: body, # markdown body
      publish_date: publish_date
    )
  end
end
```

Next create module following the following code:

```elixir
defmodule HidekXyz.Contents do
  use NimblePublisher,
    build: HidekXyz.Article,
    from: Application.app_dir(:hidek_xyz, "priv/content/**/*.md"), # where your markdown files are located (recommend putting in priv)
    as: :articles # this atom will be used to fill all your articles into this module atribute

  # we sort the articles
  @articles Enum.sort_by(@articles, & &1.publish_date, {:desc, Date})

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  @spec all_articles() :: [%HidekXyz.Article{}]
  def all_articles, do: @articles #  @articles are filled by NimblePublisher on `as: :articles`, docs recommend calling this function instead of using the @articles attr to avoid copying all articles everytime

  @spec get_article_by_slug!(String.t()) :: %HidekXyz.Article{}
  def get_article_by_slug!(slug) when is_binary(slug) do
    Enum.find(all_articles(), &(&1.slug == slug)) ||
      raise NotFoundError, "article with slug=#{slug} not found"
  end
end
```

after that just render your html using `<%= raw(@article.body) %>`

[This website source code is open-source](https://github.com/abehidek/hidek.xyz) and you can give it a look.

<!-- As of the time I'm writing this article, the web tooling is constantly evolving and passing through changes, the rise of JavaScript over the years have flooded the web space with it's frameworks such as [React](https://react.dev/), [Angular](https://angular.dev/), [Svelte]() and many others.

And from that, JavaScript have started to spread on the backend as well, thus giving birth for full-stack frameworks like [Next.js](), [SvelteKit]() and others.

The JavaScript tooling improvements and increase in adoption have allowed us to write both interaction-heavy and content-rich web sites and applications with only a language.

However, that's not the only way to write web applications, Ruby, PHP and even Python have been used by many developers to write those same kind of applications. -->

<!-- Once considered a toy language with serious performance problem by some used only for islands of interactivity is now widely adopted on the web with all it's abstractions and tooling.

And we see an increasing usage of JavaScript on the server with runtimes such as [Node.js](), [Deno]() and [Bun()], that together with the client-side frameworks gave rise to full-stack frameworks such as [Next.js] -->