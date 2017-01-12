# From Ruby to Elixir

I've been hearing about Elixir for all of 2016. It's performant, it's concurrent, it's magical. You can run 1 million processes at once on 1 server. It's the NEXT BIG THING. Blah blah blah. But I was already comfortable with Ruby, so I just ignored that propoganda.

I tried looking at Elixir after listening to a bunch of talks at RailsConf 2016 and hearing the buzz about it at DSC. Ruby, however, was already solving all of my problems. As 2016 progressed though, the monolith at work was growing, endpoints were getting slower, and code was becoming unmaintainable. Around the end of 2016 with more of the Rails community migrating to the popular Phoenix framework written in Elixir, (Ruby is to Rails as Elixir is to Phoenix) I decided I need to make the time to learn more about Elixir works.

For the last week or so, I've been delving into Elixir and decided to just build a small app to see how to work with it. I want to scrape flight data and I decided to do this the more "ethical" route by using an open API. I used the [Google Flights API](https://developers.google.com/qpx-express/). This app should also be able to hit the API at a scheduled interval (everyday). For starting my Phoenix app I decided to just open the [Phoenix docs](http://www.phoenixframework.org/docs/up-and-running) and just dive in.

A popular maxim of mine is "Nothing just works" and that turned out to be true with starting a simple Phoenix app by following the documentation. I followed the docs from top to bottom but ended up getting this error when trying to run `mix ecto.create`.

```
$ mix ecto.create
warning: could not find repositories for application :flights.

You can avoid this warning by passing the -r flag or by setting the
repositories managed by this application in your config/config.exs:

    config :flights, ecto_repos: [...]

The configuration may be an empty list if it does not define any repo.
```

Luckily the error messaging tells you what is wrong, and what you can do to fix it. This seems to be the standard procedure with Elixir and it's refreshingly helpful. Instead of the "Something went wrong", Elixir is actually telling me what I can do to fix it OR what I probably meant to type. The correct command for me was `mix ecto.create -r Flights.Repo`. Also in this process I had some "dep" install issues (analogous to bundle install issues) but answers like [this](http://stackoverflow.com/questions/38945993/why-is-phoenix-ecto-failing-to-compile-on-the-model-in-the-changeset) and [this](https://github.com/phoenixframework/phoenix/issues/1953) helped me pull through.

Going through the rest of the Phoenix documentation gave help when adding models, adding views/templates, and adding controller options. The experience was very similar to developing a Rails app and it seems straightforward to make the shift to becoming a Phoenix developer. Of course, Elixir is not the same as Ruby so I had to Google pretty much how to do anything.

Here were some other issues I ran into:

- For string concatenation, `'a' <> 'b'` is not the same as `"a" <> "b"`. The latter is what you should use when working with strings. The former are "character lists".
- A popular JSON library Poison needs this line `{:poison, "~> 3.0", override: true}` to be installed correctly. [reference](https://elixirforum.com/t/phoenix-does-not-support-poison-3-0/2256/3)
- You need to sometimes add libraries to your the application portion of the `mix.exs` file. [reference](https://github.com/myfreeweb/httpotion/issues/13)
```
def application do
    [mod: {Flights, []},
    applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext, :phoenix_ecto, :mariaex, :httpotion, :quantum]]
end
```
- There is an analogous for `binding.pry` from Ruby. It seems to be natively built into the language. Instead of `binding.pry` you would just use `IEx.pry`. [reference](http://stackoverflow.com/questions/29671156/pry-while-testing)
- You can recompile a project right from the interactive REPL with `recompile`. [reference](http://stackoverflow.com/questions/36490089/how-do-i-recompile-an-elixir-project-and-reload-it-from-within-iex)
- You can use the [Quantum](https://github.com/c-rack/quantum-elixir) gem for scheduling just like Cron. This is super useful for scraping data.

Let's end with a Haiku.

>Elixir piping

>Results in fancy coding

>And performant times
