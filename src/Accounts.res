module AddAccount = %edgeql(`
    # @name AddAccount
    insert Account {
      context_id := <str>$context_id,
    }
`)

let addAccount = AddAccount.transaction

module RemoveAccount = %edgeql(`
    # @name RemoveAccount
    delete Account
    filter .id = <uuid>$id
`)

let removeAccount = RemoveAccount.transaction
