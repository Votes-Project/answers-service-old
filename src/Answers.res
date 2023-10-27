let allAnswers = client => {
  let query = %edgeql(`
    # @name allAnswers
    select Answer {
      id,
      answer_num_by_user,
      user: {
        context_id
      }
    } order by .answer_num_by_user;
`)
  client->query
}

module AddAnswer = %edgeql(`
    # @name AddAnswer
    insert Answer {
        answer_num_by_user := <int16>$answer_num_by_user,
        day := <str>$day,
        user := (
            select Account filter .context_id = <str>$context_id
        ),
        option := (
            select Option filter .id = <uuid>$id
        )
    }
`)

let addAnswer = AddAnswer.transaction
