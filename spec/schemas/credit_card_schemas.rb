module SpecSchemas
  class CreditCardIndexResponse
    include JSON::SchemaBuilder

    def schema
      array do
        items do
          object :credit_card do
            number :id, required: true
            number :user_id, required: true
            string :last_digits, null: true
            string :expiration_date, required: true
            string :holder_name, required: true
            string :created_at, required: true
            string :updated_at, required: true
          end
        end
      end
    end
  end

  class CreditCardCreateRequest
    include JSON::SchemaBuilder

    def schema
      object do
        object :credit_card do
          number :user_id, required: true
          string :last_digits, required: true
          string :holder_name, required: true
          string :expiration_date, required: true
        end
      end
    end
  end

  class CreditCardResponse
    include JSON::SchemaBuilder

    def schema
      object do
        number :id, required: true
            number :user_id, required: true
            string :last_digits, null: true
            string :expiration_date, required: true
            string :holder_name, required: true
            string :created_at, required: true
            string :updated_at, required: true
      end
    end
  end
end