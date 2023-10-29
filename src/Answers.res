let allAnswers = client => {
  let query = %edgeql(`
    # @name allAnswers
    select Answer {
      id,
      answer_num_by_voter,
      voter: {
        context_id
      }
    } order by .answer_num_by_voter;
`)
  client->query
}

module AddAnswer = %edgeql(`
    # @name AddAnswer
    insert Answer {
        answer_num_by_voter := <int16>$answer_num_by_voter,
        day := <datetime>$day,
        voter := (
            select Account filter .id = <uuid>$voter_id
        ),
        option := (
            select Option filter .id = <uuid>$option_id
        )
    }
`)

let addAnswer = AddAnswer.transaction

module RemoveAnswer = %edgeql(`
    # @name RemoveAnswer
    delete Answer
    filter .id = <uuid>$id
`)

let removeAnswer = RemoveAnswer.transaction
