module SpecSchemas
  class TransactionIndexResponse
    include JSON::SchemaBuilder

    def schema
      array do
        items do
          object :transaction do
            number :id, required: true
            number :from_account_id, null: true
            number :to_account_id, required: true
            string :status, required: true
            string :transaction_type, required: true
            string :amount, required: true
            string :created_at, required: true
            string :updated_at, required: true
          end
        end
      end
    end
  end

  class TransactionCreateRequest
    include JSON::SchemaBuilder

    def schema
      object do
        object :transaction do
          number :from_account_id
          number :to_account_id, required: true
          string :amount, required: true
          string :transaction_type, required: true
        end
      end
    end
  end

  class TransactionResponse
    include JSON::SchemaBuilder

    def schema
      object do
        number :id, required: true
        number :from_account_id, null: true
        number :to_account_id, required: true
        string :status, required: true
        string :transaction_type, required: true
        string :amount, required: true
        string :created_at, required: true
        string :updated_at, required: true
      end
    end
  end
end