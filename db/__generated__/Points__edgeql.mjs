// Generated by ReScript, PLEASE EDIT WITH CARE

import * as EdgeDB from "rescript-edgedb/src/EdgeDB.mjs";

var queryText = "# @name AddPoints\n    insert AddPoints {\n      amount := <str>$amount,\n      reason := <str>$reason\n    }";

function query(client, args) {
  return EdgeDB.QueryHelpers.singleRequired(client, queryText, args);
}

function transaction(transaction$1, args) {
  return EdgeDB.TransactionHelpers.singleRequired(transaction$1, queryText, args);
}

var AddPoints = {
  queryText: queryText,
  query: query,
  transaction: transaction
};

export {
  AddPoints ,
}
/* EdgeDB Not a pure module */
