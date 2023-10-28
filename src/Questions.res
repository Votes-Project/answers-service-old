module AddQuestion = %edgeql(`
    # @name AddQuestion
    insert Question {
      question := <str>$question
    }
`)

let addQuestion = AddQuestion.transaction

module RemoveQuestion = %edgeql(`
    # @name RemoveQuestion
    delete Question
    filter .id = <uuid>$id
`)

let removeQuestion = RemoveQuestion.transaction
