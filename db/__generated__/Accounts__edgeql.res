// @sourceHash 1a02c03bfe07c02e7cd92f25b58a1ebf

module AddAccount = {
  let queryText = `# @name AddAccount
      insert Account {
        context_id := <str>$context_id,
      }`
  
    type args = {
      context_id: string,
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

module RemoveAccount = {
  let queryText = `# @name RemoveAccount
      delete Account
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