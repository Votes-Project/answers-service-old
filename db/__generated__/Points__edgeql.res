// @sourceHash c16639cd96e6cbc2b92894a846005d99

module AddPoints = {
  let queryText = `# @name AddPoints
    insert AddPoints {
      amount := <str>$amount,
      reason := <str>$reason
    }`
  
    type args = {
      amount: string,
      reason: string,
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