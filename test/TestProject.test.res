open TestFramework

let client = EdgeDB.Client.make()

external spawnSync: array<string> => 'a = "Bun.spawnSync"

afterAllAsync(async () => {
  await client->EdgeDB.Client.close
})
let removeIds = (key, value) => {
  switch (key, value) {
  | ("id", Js.Json.String(_)) => Js.Json.String("<id>")
  | _ => value
  }
}

describe("fetching data", () => {
  testAsync("fetching answers", async () => {
    let answers = await client->Answers.allAnswers
    let answers =
      answers->JSON.stringifyAnyWithReplacerAndIndent(removeIds, 2)->Option.getWithDefault("")
    expect(answers)->Expect.toMatchSnapshot
  })

  testAsync("running in a transaction", async () => {
    let res = await client->EdgeDB.Client.transaction(
      async transaction => {
        await transaction->Accounts.addAccount({
          context_id: "0",
        })
      },
    )

    expect(
      switch res {
      | Ok({id}) =>
        let removed = await client->EdgeDB.Client.transaction(
          async transaction => {
            await transaction->Accounts.removeAccount({id: id})
          },
        )
        switch removed {
        | Some({id}) =>
          // Just for the unused CLI output
          let _id = id
        | None => ()
        }
        id->String.length > 2
      | Error(_) => false
      },
    )->Expect.toBe(true)
  })
})

// test("run unused selections CLI", () => {
//   let res = spawnSync(["npx", "rescript-edgedb", "unused-selections"])
//   expect(res["stdout"]["toString"]())->Expect.toMatchSnapshot
// })
