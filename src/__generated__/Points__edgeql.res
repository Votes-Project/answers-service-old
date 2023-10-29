// @sourceHash 8c1e5196996ce5d46a50321836b42456

module AddPoints = {
  let queryText = `# @name AddPoints
    insert AddPoints {
      amount := <bigint>$amount,
      reason := <str>$reason
    }`
  
    type args = {
      amount: BigInt.t,
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