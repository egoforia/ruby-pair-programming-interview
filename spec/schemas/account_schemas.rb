module SpecSchemas
  class AccountIndexResponse
    include JSON::SchemaBuilder

    def schema
      array do
        items do
          object :account do
            number :id, required: true
            string :balance, required: true
            string :created_at, required: true
            string :updated_at, required: true
            number :user_id, required: true
            object :user do
              number :id, required: true
              string :first_name, required: true
              string :last_name, required: true 
              string :created_at, required: true
              string :updated_at, required: true
            end
          end
        end
      end
    end
  end

  class AccountCreateRequest
    include JSON::SchemaBuilder

    def schema
      object do
        object :account do
          number :user_id, required: true
        end
      end
    end
  end

  class AccountResponse
    include JSON::SchemaBuilder

    def schema
      object :account do
        number :id, required: true
        string :balance, required: true
        string :created_at, required: true
        string :updated_at, required: true
        number :user_id, required: true
        object :user do
          number :id, required: true
          string :first_name, required: true
          string :last_name, required: true 
          string :created_at, required: true
          string :updated_at, required: true
        end
      end
    end
  end

end