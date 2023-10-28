// @sourceHash bee7b205cb0376f770c9645321cbe07b

module AddOptions = {
  let queryText = `# @name AddOptions
      insert Option {
          option := <str>$option,
          details := <optional str>$details,
          question := (
            select Question filter .id = <uuid>$question_id
          )
      }`
  
    type args = {
      option: string,
      details?: Null.t<string>,
      question_id: string,
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

module RemoveOption = {
  let queryText = `# @name RemoveOption
      delete Option
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