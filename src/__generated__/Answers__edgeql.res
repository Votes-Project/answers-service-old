// @sourceHash fd7d72e1550005e9e429a35626ef142f

module AllAnswers = {
  let queryText = `# @name allAnswers
      select Answer {
        id,
        answer_num_by_voter,
        voter: {
          context_id
        }
      } order by .answer_num_by_voter;`
  
    type response__voter = {
      context_id: string,
    }
  
    type response = {
      id: string,
      answer_num_by_voter: int,
      voter: response__voter,
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
          answer_num_by_voter := <int16>$answer_num_by_voter,
          day := <str>$day,
          voter := (
              select Account filter .id = <uuid>$voter_id
          ),
          option := (
              select Option filter .id = <uuid>$option_id
          )
      }`
  
    type args = {
      answer_num_by_voter: int,
      day: string,
      voter_id: string,
      option_id: string,
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

module RemoveAnswer = {
  let queryText = `# @name RemoveAnswer
      delete Answer
      filter .id = <uuid>$id`
  
    type args = {
      id: string,
    }
  
    type response = {
      id: string,
    }
  
  let query = (client: EdgeDB.Client.t, args: args, ~onError=?): promise<option<response>> => {
    client->EdgeDB.QueryHelpers.single(queryText, ~args, ~onError?)
  }
  
  let transaction = (transaction: EdgeDB.Transaction.t, args: args, ~onError=?): promise<option<response>> => {
    transaction->EdgeDB.TransactionHelpers.single(queryText, ~args, ~onError?)
  }
}