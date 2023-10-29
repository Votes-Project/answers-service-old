// @sourceHash 9ad9ce8f09046e00ab87c9eb0366659f

module AllAnswers = {
  let queryText = `# @name allAnswers
      select Answer {
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

module AddAnswer = {
  let queryText = `# @name AddAnswer
      insert Answer {
          answer_num_by_user := <int16>$answer_num_by_user,
          day := <str>$day,
          user := (
              select Account filter .context_id = <str>$context_id
          ),
          option := (
              select Option filter .id = <uuid>$id
          )
      }`
  
    type args = {
      answer_num_by_user: int,
      day: string,
      context_id: string,
      id: string,
    }
  
    type response = {
      id: string,
    }
  
  let query = (client: EdgeDB.Client.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    client->EdgeDB.QueryHelpers.singleRequired(queryText, ~args)
  }
  
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    transaction->EdgeDB.TransactionHelpers.singleRequired(queryText, ~args)
  }
}