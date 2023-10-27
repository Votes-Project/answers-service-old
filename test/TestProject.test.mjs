// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Edgedb from "edgedb";
import * as Answers from "../src/Answers.mjs";
import * as Accounts from "../src/Accounts.mjs";
import * as Buntest from "bun:test";
import * as Core__Option from "@rescript/core/src/Core__Option.mjs";

var client = Edgedb.createClient(undefined);

Buntest.afterAll(async function () {
      return await client.close();
    });

function removeIds(key, value) {
  if (key === "id" && !(!Array.isArray(value) && (value === null || typeof value !== "object") && typeof value !== "number" && typeof value !== "string" && typeof value !== "boolean" || typeof value !== "string")) {
    return "<id>";
  } else {
    return value;
  }
}

Buntest.describe("fetching data", (function () {
        Buntest.test("fetching answers", (async function () {
                var answers = await Answers.allAnswers(client);
                var answers$1 = Core__Option.getWithDefault(JSON.stringify(answers, removeIds, 2), "");
                Buntest.expect(answers$1).toMatchSnapshot();
              }));
        Buntest.test("running in a transaction", (async function () {
                var res = await client.transaction(async function (transaction) {
                      return await Accounts.addAccount(transaction, {
                                  context_id: "0"
                                });
                    });
                var tmp;
                if (res.TAG === "Ok") {
                  var id = res._0.id;
                  await client.transaction(async function (transaction) {
                        return await Accounts.removeAccount(transaction, {
                                    id: id
                                  }, undefined);
                      });
                  tmp = id.length > 2;
                } else {
                  tmp = false;
                }
                Buntest.expect(tmp).toBe(true);
              }));
      }));

export {
  client ,
  removeIds ,
}
/* client Not a pure module */
