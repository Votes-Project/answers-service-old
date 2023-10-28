// @sourceHash 808b4106d3d83b8376753af4c1ce3923

module AddQuestion = {
  let queryText = `# @name AddQuestion
      insert Question {
        question := <str>$question
      }`
  
    type args = {
      question: string,
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

module RemoveQuestion = {
  let queryText = `# @name RemoveQuestion
      delete Question
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