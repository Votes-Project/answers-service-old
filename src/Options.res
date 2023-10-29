module AddOptions = %edgeql(`
    # @name AddOptions
    insert Option {
        option := <str>$option,
        details := <optional str>$details,
        question := (
          select Question filter .id = <uuid>$question_id
        )
    }
`)

let addOption = AddOptions.transaction

module RemoveOption = %edgeql(`
    # @name RemoveOption
    delete Option
    filter .id = <uuid>$id
`)
let removeOption = RemoveOption.transaction
