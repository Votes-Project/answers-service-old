// @sourceHash 7bb992b978ebf540164a9a8b14c56f66

module AddFlashQueue = {
  let queryText = `# @name AddFlashQueue
    insert FlashQueue {
      flash_queue_id := <QueueId>$flash_queue_id,
      question := (
        select Question filter .id = <uuid>$question_id
      )
    }`
  
    type args = {
      flash_queue_id: float,
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

module RemoveFlashQueue = {
  let queryText = `# @name RemoveFlashQueue
    delete FlashQueue
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

module AddQuestionQueue = {
  let queryText = `# @name AddQuestionQueue
    insert QuestionQueue {
      question_queue_id := <QueueId>$question_queue_id,
      question := (
        select Question filter .id = <uuid>$question_id
      )
    }`
  
    type args = {
      question_queue_id: float,
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

module RemoveQuestionQueue = {
  let queryText = `# @name RemoveQuestionQueue
    delete QuestionQueue
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

module AddCommunityQueue = {
  let queryText = `# @name AddCommunityQueue
    insert CommunityQueue {
      community_queue_id := <QueueId>$community_queue_id,
      question := (
        select Question filter .id = <uuid>$question_id
      )
    }`
  
    type args = {
      community_queue_id: float,
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

module RemoveCommunityQueue = {
  let queryText = `# @name RemoveCommunityQueue
    delete CommunityQueue
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