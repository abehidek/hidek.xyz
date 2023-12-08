# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HidekXyz.Repo.insert!(%HidekXyz.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

HidekXyz.Repo.insert!(%HidekXyz.Examples.User{
  name: "Guilherme Abe",
  age: 20,
})

HidekXyz.Repo.insert!(%HidekXyz.Examples.User{
  name: "Igor Oliveira",
  age: 21,
})

HidekXyz.Repo.insert!(%HidekXyz.Examples.User{
  name: "Viktor Marinho",
  age: 19,
})
