---
title: "This website was created using Phoenix Liveview"
description: "Who said we should only build interactive, real-time web applications using liveview?, covering the basics on how to do it and why should you."
publish_date: "2023-12-06"
tags: ["phoenix", "elixir", "liveview"]
cover: "/priv/content/media/phoenix.png"
series:
  slug: "how-i-build-this-website"
  title: "How I build this website"
  part: 1
public: true
---

## Intro

SSGs or Static Site Generators have been gaining popularity in the web space due to it's simplicity:

```markdown
1. Write markdown
2. Generate HTML on build based on markdown
3. Serve then from a server (it could be a CDN)
```

I've mentioned markdown however it could be any kind of content, as long as it's static (since you build your website once)

Nowadays we have amazing tooling for that purpose such as:
- Jekyll
- Hugo
- 11ty
- Astro

But on the other side totally opposite, we have Phoenix Liveview, a recently developed way of building web applications that are highly interactive and real-time, it uses the Phoenix framework along with the Elixir programming language.

In this article I will explain why I've used Liveview for my personal website, how to do it and why you may want it too.

## The Whys

New tooling is developed every day, it have come to such a point where the tooling that was supposed to help us is actually doing the opposite due to numerous options. This has parallels with the paradox of choice, where raising the options can increase a lot of anxiety from the user.

And nowadays many developers are well recognized if they know which tooling is best for each job, which itself is great, but this isn't what software engineering is really about.

It's about building stuff, hacking it, solving problems (both already solved and not solved yet).

But many falls into that trap, we as developers forgot that we have the power to create our own tooling, functions, libs and frameworks. Instead of doing that, we always try to solve a problem by seeing if another one have solved it. one classic example is the [left-pad incident](https://www.theregister.com/2016/03/23/npm_left_pad_chaos/).

And of course, doing that can save many hours and allow us to deliver functionality in less time, but it's a trade, in exchange you are introducing complexity, and believing the code's author is doing a good job in terms of performance, security and fixing bugs. In personal terms, you are also sacrificing learning about how that stuff really works.

![classic xkcd](https://www.explainxkcd.com/wiki/images/d/d7/dependency.png)

However, for companies, products and organizations we often are willing to do that exchange even with the tradeoffs because time and energy are scarce, however we shouldn't apply this mentality for everything.

<!-- 
For instance Theo says we should always use the right tool for the right job, and then proceeds to blame everyone that uses Next.js for their blog systems and recommends Astro. -->

Of couse, to learn how different tools are important of course, but I think it's more important how to solve problems in your own, that's what I think it makes a good developer which Fabio Akita calls "hyper seniors" not "10x developers", see below:

<blockquote class="twitter-tweet" data-lang="en" data-theme="dark">
  <p lang="en" dir="ltr">
  I have a different understanding about the elusive &quot;10x engineer&quot; moniker. Most descriptions are about hyper seniors, not 10x.
  <br><br>
  Been there. Done that. I was the kind of person that would go as far as defragment dll memory to have contiguous address space for a process that required it. Or reverse engineer a license jar file in order to crack authentication of SDKs for my team to be able to work on it.
  <br><br>
  But 10x doesn't require any of that. You're talking about vertical optimization. 10x is about horizontal scaling.
  <br><br>
  10 juniors can do 10 units of work per week. But with a 10x engineer nearby, to properly mentor them, they can each double their yield. Some can make them do 3x more. It's about streamlining the amount of choice they have. You already know what works.
  <br><br>
  The kind of work that requires hyper seniors, people that can "see the Matrix" is super rare. Most of the work is actually pretty mundane, but in large quantities. A true 10x engineer resolves that.
  <br><br>
  Most projects wouldn't know what to do with a hyper senior that is very very good at very specific hard issues but lazy and unproductive with mundane work.
  <a href="https://t.co/09Ju6xtI1J">https://t.co/09Ju6xtI1J</a>
  </p>
  &mdash; Akitando.com (@AkitaOnRails) 
  <a href="https://twitter.com/AkitaOnRails/status/1732021556149133555?ref_src=twsrc%5Etfw">December 5, 2023</a>
</blockquote>

A blog, even for a company in most cases, isn't some kind of necessary or mission critical application, you can of course use 11ty, Astro or other static site generators (which in turn allows you to build it quickly), but you also can use pure HTML, or compiling markdown and serving then using Rust, or other programming language without a specific framework for that.

In my case, I choose to use Elixir and the Phoenix framework not because it's the fastest way to build a blog system or the one with faster loader times, but because I'm learning these technologies and wanted to see what a system built using these tools looks like.

Of course, we should not fall into using the same tool for every thing, in serious business and organizations we should aim for efficiency and elaborate decisions (for example it's difficult to adopt bleeding edge tooling if no one knows how it works and you don't have time and energy to learn it).

But for your own side-projects you can and should use the technology you want to use, simply as that.

Independently if is an esolang, an unknow framework/lib or not, there's always something new you can extract from if you dig deep enough, that's a certainty and what makes our field so fascinating.

In essence some amount of over engineering is necessary to learn new things, another good example of this is [Xe Iaso's website](https://xeiaso.net/).

<!-- In the future I'll be discussing about the Erlang/Elixir and Go ecosystems and how it encompasses t. -->

## The How

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
    This module will be used by NimblePublisher to parse markdown files to the module struct.

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
    ```text
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

    Note that the frontmatter in this case is written like an Elixir map (`%{title: "Hello World!", ...}`) to simplify markdown parsing. However this is not a common format to write markdown frontmatter (instead many uses the YAML format), the NimblePublisher library provides a way to provide a custom parser, later in this series we'll cover how to parse YAML instead (spoilers: using Rust).

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

    By own system, I mean it, you can use Elixir to take the body and frontmatter data and export templated HTML and simply serve then using any webserver such as Nginx or Apache HTTP Server.

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

With that, you now have a simple blog system written in Elixir, [it does not fall too much behind static site generators as well noted in this blog post](https://bernheisel.com/blog/moving-blog).

Basically, you'll lose the ability to put your app in a CDN and distribute it across the globe, but we can do it by deploying across various regions using [fly.io](https://fly.io/docs/reference/regions/).

But in counterpoint, the Phoenix Liveview provides a easy abstraction for creating real-time experiences, next article in this series we'll create a real-time user tracking component used in this website.

<!-- As of the time I'm writing this article, the web tooling is constantly evolving and passing through changes, the rise of JavaScript over the years have flooded the web space with it's frameworks such as [React](https://react.dev/), [Angular](https://angular.dev/), [Svelte]() and many others.

And from that, JavaScript have started to spread on the backend as well, thus giving birth for full-stack frameworks like [Next.js](), [SvelteKit]() and others.

The JavaScript tooling improvements and increase in adoption have allowed us to write both interaction-heavy and content-rich web sites and applications with only a language.

However, that's not the only way to write web applications, Ruby, PHP and even Python have been used by many developers to write those same kind of applications. -->

<!-- Once considered a toy language with serious performance problem by some used only for islands of interactivity is now widely adopted on the web with all it's abstractions and tooling.

And we see an increasing usage of JavaScript on the server with runtimes such as [Node.js](), [Deno]() and [Bun()], that together with the client-side frameworks gave rise to full-stack frameworks such as [Next.js] -->
