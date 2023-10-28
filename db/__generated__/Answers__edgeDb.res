// @sourceHash ae4f8596ef24630d0a8cbebcdc9b39da
module AllAnswers = {
  let queryText = `select Answer {
      id,
      answer_num_by_user,
      user: {
        context_id
      }
    } order by .answer_num_by_user;`

  type response__user = {
    context_id: string,
  }

  type response = {
    id: string,
    answer_num_by_user: int,
    user: response__user,
  }

  let query = (client: EdgeDB.Client.t): promise<array<response>> => {
    client->EdgeDB.QueryHelpers.many(queryText)
  }

  let transaction = (transaction: EdgeDB.Transaction.t): promise<array<response>> => {
    transaction->EdgeDB.TransactionHelpers.many(queryText)
  }
}

