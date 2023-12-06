---
title: "This website was created using Phoenix Liveview"
description: "Who said we should only build interactive, real-time web applications using liveview?, now covering the basics on how to do it."
publish_date: "2023-11-21"
tags: ["phoenix", "elixir", "liveview"]
cover: ""
series: "how-i-build-this-blog"
public: false
---

SSGs or Static Site Generators have been gaining popularity in the web space due to it's simplicity.

```markdown
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

On the otherside we have Phoenix Liveview, a recently developed way of building web applications that are highly interactive and real-time, it uses the Phoenix framework along with the Elixir programming language.

In this article I will explain why I've used Liveview for my personal website, how to do it and why you may want it too.

## How

At it's core, all markdown file reading, metadada parsing and HTML compiling happens using [NimblePublisher](https://github.com/dashbitco/nimble_publisher) created by the [Dashbit Company](https://dashbit.co/).

This library happens to do all of that once, further function calls gets only the cached result (parsed metadata and compiled HTML).

You can create the steps to do a simple blog system on [this README](https://github.com/dashbitco/nimble_publisher), however here's the gist of it:

1. Add dependency to `mix.exs` file:
    ```elixir
    # /mix.exs
    def deps do
      [
        {:nimble_publisher, "~> 1.0"}
      ]
    end
    ```

2. Define a module representing the content itself:
    ```elixir
    # /lib/app/blog/post.ex
    defmodule App.Blog.Post do
      # required fields
      @enforce_keys [:body, :slug, :title, :publish_date]

      # content fields (see that :description is optional because it's not listed on @enforce_keys)
      defstruct [:body, :slug, :title, :publish_date, :description]

      # this is a callback, a function that will be called by NimblePublisher to obtain metadata and html body
      def build(filename, attrs, body) do
        # Path.basename: Returns the last component of path with the extension stripped.
        slug = Path.basename(filename, ".md")

        # gets date from "YYY-MM-DD" format string
        publish_date = Date.from_iso8601!(attrs.publish_date)

        # description can be nil
        maybe_description = Map.get(attrs, :description)

        # we return the struct of this module (in this case a Post)
        struct!(__MODULE__, [slug: slug, body: body, title: attrs.title, publish_date: publish_date, description: maybe_description])
      end
    end
    ```

3. Create a context that will be used to retrieve the content using NimblePublisher:
    ```elixir
    # /lib/app/blog.ex
    defmodule App.Blog do
      use NimblePublisher,
        build: App.Blog.Post,
        from: Application.app_dir(:my_app, "priv/posts/**/*.md"),
        as: :posts

      # @posts is a module attribute that is injected by NimblePublisher, we can sort it by date:
      @posts Enum.sort_by(@posts, & &1.publish_date, {:desc, Date})

      # To avoid making NimblePublisher injecting the attribute everytime we need the posts, we create a function that return all posts, thus avoiding copying all posts everytime.
      def all_posts, do: @posts

      # We filter 
      def get_post_by_slug!(slug) when is_binary(slug) do
        Enum.find(all_posts(), &(&1.slug == slug)) || raise "post with slug=#{slug} not found"
      end
    end

    ```

4. Next, create a markdown file under `priv/posts`:
    ```markdown
    # /priv/posts/hello-world.md
    %{
      title: "Hello world!",
      publish_date: "2023-11-21",
      description: "How to say hello world"
    }
    ---

    ## How to say hello world?

    Hello world.
    ```

5. By calling `App.Blog.all_posts/0` on `iex` we get:
    ```elixir
    iex()> App.Blog.all_posts

    [
      %App.Blog.Post{
        body: "<h2>\nHow to say hello world?</h2>\n<p>\nHello world.</p>\n",
        slug: "hello-world",
        title: "Hello world!",
        publish_date: ~D[2023-11-21],
        description: "How to say hello world"
      }
    ]
    ```

6. After that you can simply use the body HTML and the frontmatter data to build your own system, in this case we'll use the Phoenix framework and Liveview by adding a new live route in your phoenix router:
    ```elixir
    # /lib/app_web/router.ex
    defmodule AppWeb.Router do
      #...
      scope "/", AppWeb do
        pipe_through :browser

        # ...
        live "/blog", Blog.IndexLive, :index
        live "/blog/:slug", Blog.ShowLive, :show
      end
      #...
    end
    ```

7. For `/blog` create an liveview under `/lib/app_web/live/blog/index_live.ex`:
    ```elixir
    # /lib/app_web/live/blog/index_live.ex

    defmodule AppWeb.Blog.IndexLive do
      use AppWeb, :live_view

      @impl true
      def mount(_params, _session, socket) do
        {:ok, assign(socket, posts: App.Blog.all_posts())}
      end

      @impl true
      def render(assigns) do
        ~H"""
        <content>
          <h1>Blog - Latest posts</h1>
          <ul>
            <%= for post <- @posts do %>
              <li>
                <.link navigate={~p"/blog/" <> post.slug}>
                  <h2><%= post.title %></h2>
                  <p><%= post.publish_date %></p>
                </.link>
              </li>
            <% end %>
          </ul>
        </content>
        """
      end
    end
    ```

8. For `/blog/:slug` create an liveview under `/lib/app_web/live/blog/show_live.ex`:
    ```elixir
    # /lib/app_web/live/blog/show_live.ex

    defmodule AppWeb.Blog.ShowLive do
      use AppWeb, :live_view

      @impl true
      def mount(%{"slug" => slug}, _session, socket) do
        {:ok, assign(socket, post: App.Blog.get_post_by_slug!(slug))}
      end

      @impl true
      def render(assigns) do
        ~H"""
        <article>
          <h1><%= @post.title %></h1>
          <p><%= @post.publish_date %></p>
          <p><%= @post.description %></p>

          <hr />

          <div><%= raw(@post.body) %></div>
        </article>
        """
      end
    end
    ```


<!-- As of the time I'm writing this article, the web tooling is constantly evolving and passing through changes, the rise of JavaScript over the years have flooded the web space with it's frameworks such as [React](https://react.dev/), [Angular](https://angular.dev/), [Svelte]() and many others.

And from that, JavaScript have started to spread on the backend as well, thus giving birth for full-stack frameworks like [Next.js](), [SvelteKit]() and others.

The JavaScript tooling improvements and increase in adoption have allowed us to write both interaction-heavy and content-rich web sites and applications with only a language.

However, that's not the only way to write web applications, Ruby, PHP and even Python have been used by many developers to write those same kind of applications. -->

<!-- Once considered a toy language with serious performance problem by some used only for islands of interactivity is now widely adopted on the web with all it's abstractions and tooling.

And we see an increasing usage of JavaScript on the server with runtimes such as [Node.js](), [Deno]() and [Bun()], that together with the client-side frameworks gave rise to full-stack frameworks such as [Next.js] -->