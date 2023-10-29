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
})

describe("add and remove", () => {
  testAsync("add and remove account transaction", async () => {
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

  testAsync("add and remove question", async () => {
    let res = await client->EdgeDB.Client.transaction(
      async transaction => {
        await transaction->Questions.addQuestion({
          question: "What is the meaning of life?",
        })
      },
    )

    expect(
      switch res {
      | Ok({id}) =>
        let removed = await client->EdgeDB.Client.transaction(
          async transaction => {
            await transaction->Questions.removeQuestion({id: id})
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

  testAsync("add and remove option", async () => {
    let questionId =
      (await client
      ->EdgeDB.Client.transaction(
        async transaction => {
          await transaction->Questions.addQuestion({
            question: "What is the meaning of life?",
          })
        },
      ))
      ->Result.mapWithDefault("", ({id}) => id)

    let res = await client->EdgeDB.Client.transaction(
      async transaction => {
        await transaction->Options.addOption({
          question_id: questionId,
          option: "42",
        })
      },
    )
    expect(
      switch res {
      | Ok({id}) =>
        let removed = await client->EdgeDB.Client.transaction(
          async transaction => {
            (
              await transaction->Options.removeOption({id: id}),
              await transaction->Questions.removeQuestion({id: questionId}),
            )
          },
        )
        switch removed {
        | (Some({id}), Some(_)) =>
          // Just for the unused CLI output
          let _id = id
        | _ => ()
        }
        id->String.length > 2
      | Error(_) => false
      },
    )->Expect.toBe(true)
  })
  testAsync("add and remove answer", async () => {
    let voterId =
      (await client
      ->EdgeDB.Client.transaction(
        async transaction => {
          await transaction->Accounts.addAccount({
            context_id: "0",
          })
        },
      ))
      ->Result.mapWithDefault("", ({id}) => id)

    let questionId =
      (await client
      ->EdgeDB.Client.transaction(
        async transaction => {
          await transaction->Questions.addQuestion({
            question: "What is the meaning of life?",
          })
        },
      ))
      ->Result.mapWithDefault("", ({id}) => id)

    let optionId =
      (await client
      ->EdgeDB.Client.transaction(
        async transaction => {
          await transaction->Options.addOption({
            question_id: questionId,
            option: "42",
          })
        },
      ))
      ->Result.mapWithDefault("", ({id}) => id)

    let res = await client->EdgeDB.Client.transaction(
      async transaction => {
        await transaction->Answers.addAnswer({
          answer_num_by_voter: 0,
          day: Date.now()->Date.fromTime,
          voter_id: voterId,
          option_id: optionId,
        })
      },
    )
    expect(
      switch res {
      | Ok({id}) =>
        let removed = await client->EdgeDB.Client.transaction(
          async transaction => {
            (
              await transaction->Answers.removeAnswer({id: id}),
              await transaction->Options.removeOption({id: optionId}),
              await transaction->Questions.removeQuestion({id: questionId}),
              await transaction->Accounts.removeAccount({id: voterId}),
            )
          },
        )
        switch removed {
        | (Some({id}), Some(_), Some(_), Some(_)) =>
          // Just for the unused CLI output
          let _id = id
        | _ => ()
        }
        id->String.length > 2
      | Error(_) => false
      },
    )->Expect.toBe(true)
  })
})

test("run unused selections CLI", () => {
  let res = spawnSync(["npx", "rescript-edgedb", "unused-selections"])
  expect(res["stdout"]["toString"]())->Expect.toMatchSnapshot
})
